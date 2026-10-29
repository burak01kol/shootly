@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter bulunamadi. Flutter'i PATH'e ekleyip tekrar dene.
  pause
  exit /b 1
)

echo.
echo [1/6] Android ve iOS klasorleri olusturuluyor...
call flutter create --org com.vitrinapp --project-name vitrin --platforms android,ios . || goto :hata

echo.
echo [2/6] Paketler ekleniyor...
call flutter pub add gal image image_picker native_cutout path_provider purchases_flutter purchases_ui_flutter share_plus shared_preferences || goto :hata
call flutter pub add dev:flutter_lints || goto :hata

echo.
echo [3/6] Platform ayarlari yapiliyor...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tool\platform_ayarla.ps1" || goto :hata

echo.
echo [4/6] Kod kontrol ediliyor...
call flutter analyze

echo.
echo [5/6] Testler calistiriliyor...
call flutter test || goto :hata

echo.
echo [6/6] Kurulum tamam!
echo Telefonunu USB ile bagla (Gelistirici secenekleri ve USB hata ayiklama acik)
echo ve bu klasorde su komutu calistir:
echo     flutter run
echo.
pause
exit /b 0

:hata
echo.
echo Bir adim basarisiz oldu. Yukaridaki hata mesajini kopyalayip Claude'a gonder.
pause
exit /b 1
