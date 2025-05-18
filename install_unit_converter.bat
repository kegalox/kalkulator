
@echo off
echo Установка зависимостей для Unit Converter...
cd /d "%~dp0"
npm install
echo.
echo === УСТАНОВКА ЗАВЕРШЕНА ===
echo Запусти `npm run dev` чтобы запустить сайт.
pause
