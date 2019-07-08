@ECHO OFF

:: 設定ファイル読込
CALL setting.bat

SETLOCAL

:: lame.exe 存在判定
IF NOT EXIST "%DIRECTORY_EXE%" (
    ECHO [%DIRECTORY_EXE%]ファイルが存在していません。処理を終了します。
    ECHO [%DATE% %TIME%] [%DIRECTORY_EXE%]ファイルが存在していません。処理を終了します。 >>%DIRECTORY_LOG%lame.log
    PAUSE
    EXIT
) ELSE (
    GOTO CHECK
)

:CHECK
FOR %%F IN (%DIRECTORY_WAV%*.wav) DO GOTO ENCODE
GOTO SKIP

:ENCODE
FOR /F %%I IN ('dir /b %DIRECTORY_WAV%\*.wav') DO (
    :: LAME エンコード実行処理
    START /WAIT /MIN "Encode" %DIRECTORY_EXE% %OPTIONS% %QUALITY% -m %MODE% %DIRECTORY_WAV%%%~nI.wav  %DIRECTORY_MP3%%%~nI.mp3
    IF %ERRORLEVEL%.==0. (
        ECHO [%DATE% %TIME%] %%I はエンコードが完了しました。 >>%DIRECTORY_LOG%lame.log
        DEL %DIRECTORY_WAV%%%~nI.wav
    ) ELSE (
        ECHO [%DATE% %TIME%] %%I はエンコードに失敗しました。 >>%DIRECTORY_LOG%lame.log
    )
)

IF %ERRORLEVEL%.==1. (
    ECHO [%DATE% %TIME%] 予期せぬエラーが発生しました。処理を再実行して下さい。 >>%DIRECTORY_LOG%lame.log
    GOTO PRWAIT
)

:SKIP
:: 変化がない場合
ECHO %MESSEAGE%

:: スリープ代わり
PING -n %CHECKINTERVAL% 127.0.0.1 > NUL

:PRWAIT
GOTO CHECK

ENDLOCAL

:: エラー終了
rem :NOTFOUND
rem ECHO [%DATE% %TIME%] %DIRECTORY_EXE%" が存在しません。EXEファイルを再度確認して下さい。 >>%DIRECTORY_LOG%lame.log
rem EXIT /B