@echo off
cd /d "C:\SafeZone\unit_converter_full_project\unit-converter"

set "targetFile=app\page.tsx"
set "tempFile=app\temp_page.tsx"
setlocal EnableDelayedExpansion

set "foundOnce=false"

(
  for /f "usebackq delims=" %%a in ("%targetFile%") do (
    set "line=%%a"
    echo !line! | findstr /C:"import { useEffect, useState } from 'react';" >nul
    if errorlevel 1 (
      echo !line!
    ) else (
      if "!foundOnce!"=="false" (
        echo !line!
        set "foundOnce=true"
      )
    )
  )
) > "%tempFile%"

move /Y "%tempFile%" "%targetFile%" >nul

echo Дублирующий импорт удален (если был).
pause
