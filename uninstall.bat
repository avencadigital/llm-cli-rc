@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: No admin elevation required - HKCU registry removal is user-scoped

cls
echo.
echo   ================================================================
echo.
echo       _      _      __  __        ____  _      ___     ____   ____ 
echo      ^| ^|    ^| ^|    ^|  \/  ^|_____ / ___^|^| ^|    ^|_ _^|   ^|  _ \ / ___^|
echo      ^| ^|    ^| ^|    ^| ^|\/^| ^|_____^| ^|    ^| ^|     ^| ^|    ^| ^|_) ^| ^|    
echo      ^| ^|___ ^| ^|___ ^| ^|  ^| ^|     ^| ^|___ ^| ^|___  ^| ^|    ^|  _ ^<^| ^|___ 
echo      ^|_____^|^|_____^|^|_^|  ^|_^|      \____^|^|_____^|^|___^|   ^|_^| \_\\____^|
echo.
echo           Context Menu Uninstaller for Windows
echo.
echo   ================================================================
echo.

echo   UNINSTALL
echo   ----------------------------------------------------------------
echo.
echo   ^! Warning: This will remove the LLM-CLI RC context menu
echo     and all associated files from your system.
echo.

choice /C YN /N /M "   Are you sure you want to uninstall? [Y/N]: "
if errorlevel 2 (
    echo.
    echo   Uninstallation cancelled.
    echo.
    pause
    exit /b 0
)

echo.
echo   ----------------------------------------------------------------
echo.
echo   REMOVING
echo.

echo   [Step 1/2] Removing registry entries...
regedit /s "%~dp0registry\LLM_CLI_REMOVER.reg"
echo              ^> Registry entries removed
echo.

echo   [Step 2/2] Removing files...
if exist "%USERPROFILE%\.llm-cli" rd /s /q "%USERPROFILE%\.llm-cli"
echo              ^> Files removed
echo.

echo   ================================================================
echo.
echo                  UNINSTALLATION COMPLETE!
echo.
echo   ================================================================
echo.
echo   The LLM-CLI RC context menu has been removed from your system.
echo   To reinstall, run: install.bat
echo.
pause
