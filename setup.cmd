@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM n8ro release setup
REM Sets N8RO_RELEASE to this script's directory
REM ============================================================

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR%"=="" (
    echo [Error] Failed to resolve script directory.
    exit /b 1
)

if "%SCRIPT_DIR:~-1%"=="\" (
    set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
)

endlocal & (
    set "N8RO_RELEASE=%SCRIPT_DIR%"
    REM Compatibility fallback for legacy runtime code paths that still read N8RO_DEV.
    set "N8RO_DEV=%SCRIPT_DIR%"
    set "N8RO_SETUP_DONE=1"
)

if not defined N8RO_RELEASE (
    echo [Error] Failed to set N8RO_RELEASE.
    exit /b 1
)

if not defined N8RO_RELEASE_TERRAIN_DB (
    set "N8RO_RELEASE_TERRAIN_DB=%N8RO_RELEASE%\data\terrain"
)

if not defined N8RO_RELEASE_AI_DB (
    set "N8RO_RELEASE_AI_DB=%N8RO_RELEASE%\data\ai"
)

if not defined N8RO_RELEASE_USER_SIM_PLUGINS (
    set "N8RO_RELEASE_USER_SIM_PLUGINS=%N8RO_RELEASE%\userPlugins\sim"
)

if not defined N8RO_RELEASE_USER_UI_PLUGINS (
    set "N8RO_RELEASE_USER_UI_PLUGINS=%N8RO_RELEASE%\userPlugins\ui"
)

if exist "%N8RO_RELEASE%\bin" (
    set "PATH=%N8RO_RELEASE%\bin;%PATH%"
    echo [OK] Added to PATH: %N8RO_RELEASE%\bin
) else (
    echo [Warning] Release bin directory not found: %N8RO_RELEASE%\bin
)

REM Ensure Qt runtime can resolve plugins and QML modules in portable dist layout.
if exist "%N8RO_RELEASE%\bin\qml" (
    if defined QML2_IMPORT_PATH (
        set "QML2_IMPORT_PATH=%N8RO_RELEASE%\bin\qml;%QML2_IMPORT_PATH%"
    ) else (
        set "QML2_IMPORT_PATH=%N8RO_RELEASE%\bin\qml"
    )
    if defined QML_IMPORT_PATH (
        set "QML_IMPORT_PATH=%N8RO_RELEASE%\bin\qml;%QML_IMPORT_PATH%"
    ) else (
        set "QML_IMPORT_PATH=%N8RO_RELEASE%\bin\qml"
    )
    echo [OK] QML2_IMPORT_PATH set to: %QML2_IMPORT_PATH%
    echo [OK] QML_IMPORT_PATH set to: %QML_IMPORT_PATH%
) else (
    echo [Warning] QML import directory not found: %N8RO_RELEASE%\bin\qml
)

if exist "%N8RO_RELEASE%\bin" (
    if defined QT_PLUGIN_PATH (
        set "QT_PLUGIN_PATH=%N8RO_RELEASE%\bin;%QT_PLUGIN_PATH%"
    ) else (
        set "QT_PLUGIN_PATH=%N8RO_RELEASE%\bin"
    )
    set "QT_QPA_PLATFORM_PLUGIN_PATH=%N8RO_RELEASE%\bin\platforms"
    echo [OK] QT_PLUGIN_PATH set to: %QT_PLUGIN_PATH%
    echo [OK] QT_QPA_PLATFORM_PLUGIN_PATH set to: %QT_QPA_PLATFORM_PLUGIN_PATH%
)

if exist "%N8RO_RELEASE_USER_SIM_PLUGINS%" (
    echo [OK] N8RO_RELEASE_USER_SIM_PLUGINS set to: %N8RO_RELEASE_USER_SIM_PLUGINS%
) else (
    echo [Warning] N8RO_RELEASE_USER_SIM_PLUGINS path does not exist yet: %N8RO_RELEASE_USER_SIM_PLUGINS%
)

if exist "%N8RO_RELEASE_USER_UI_PLUGINS%" (
    echo [OK] N8RO_RELEASE_USER_UI_PLUGINS set to: %N8RO_RELEASE_USER_UI_PLUGINS%
) else (
    echo [Warning] N8RO_RELEASE_USER_UI_PLUGINS path does not exist yet: %N8RO_RELEASE_USER_UI_PLUGINS%
)

echo [SUCCESS] N8RO_RELEASE set to: %N8RO_RELEASE%
echo [OK] N8RO_RELEASE_TERRAIN_DB set to: %N8RO_RELEASE_TERRAIN_DB%
echo [OK] N8RO_RELEASE_AI_DB set to: %N8RO_RELEASE_AI_DB%
echo [OK] AI model path: %N8RO_RELEASE_AI_DB%\model
echo [OK] AI context path: %N8RO_RELEASE_AI_DB%\context
echo [OK] N8RO_RELEASE_USER_UI_PLUGINS set to: %N8RO_RELEASE_USER_UI_PLUGINS%
echo [OK] N8RO_DEV (compat) set to: %N8RO_DEV%
exit /b 0
