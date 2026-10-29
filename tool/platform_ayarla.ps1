# flutter create sonrasi Android/iOS dosyalarina gereken ayarlari ekler.
# Tekrar calistirmak guvenlidir: yapilmis ayarlari atlar.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

function Edit-TextFile([string]$path, [scriptblock]$transform) {
    $text = [IO.File]::ReadAllText($path)
    $updated = & $transform $text
    if ($updated -ne $text) {
        [IO.File]::WriteAllText($path, $updated)
        Write-Host "  guncellendi: $($path.Substring($root.Length + 1))"
    }
}

# 1) RevenueCat paywall ekrani FlutterFragmentActivity ister.
$activity = Get-ChildItem -Path "$root\android\app\src\main" -Recurse -Include MainActivity.kt, MainActivity.java |
    Select-Object -First 1
if (-not $activity) { throw 'MainActivity bulunamadi. Once flutter create calismali.' }
Edit-TextFile $activity.FullName { param($t) $t -replace '\bFlutterActivity\b', 'FlutterFragmentActivity' }

# 2) minSdk 24 (RevenueCat Paywall icin gerekli).
$gradle = @("$root\android\app\build.gradle.kts", "$root\android\app\build.gradle") |
    Where-Object { Test-Path $_ } | Select-Object -First 1
Edit-TextFile $gradle { param($t) $t -replace 'flutter\.minSdkVersion', '24' }

# 3) Uygulama adi ve Android 9 ve alti icin galeri kaydetme izni.
$manifest = "$root\android\app\src\main\AndroidManifest.xml"
Edit-TextFile $manifest {
    param($t)
    $t = $t -replace 'android:label="vitrin"', 'android:label="Shootly"'
    if ($t -notmatch 'WRITE_EXTERNAL_STORAGE') {
        $permission = '<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="29" />'
        $t = ([regex]'<application').Replace($t, "$permission`r`n    <application android:requestLegacyExternalStorage=`"true`"", 1)
    }
    $t
}

# 4) iOS izin metinleri (iOS derlemesi icin Mac gerekir).
$plist = "$root\ios\Runner\Info.plist"
if (Test-Path $plist) {
    Edit-TextFile $plist {
        param($t)
        if ($t -match 'NSCameraUsageDescription') { return $t }
        $keys = @'
	<key>NSCameraUsageDescription</key>
	<string>Ürününün fotoğrafını çekebilmen için Shootly kameraya erişmek istiyor. Fotoğraflar yalnızca cihazında işlenir.</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Galeriden urun fotografi secmek icin erisim gerekiyor.</string>
	<key>NSPhotoLibraryAddUsageDescription</key>
	<string>Hazirlanan fotograflari galerine kaydetmek icin erisim gerekiyor.</string>
'@
        $index = $t.LastIndexOf('</dict>')
        $t.Insert($index, $keys)
    }
}

Write-Host '  platform ayarlari tamam.'
