@ECHO OFF

:: �ݒ�t�@�C���Ǎ�
CALL setting.bat

SETLOCAL

:: lame.exe ���ݔ���
IF NOT EXIST "%DIRECTORY_EXE%" (
    ECHO [%DIRECTORY_EXE%]�t�@�C�������݂��Ă��܂���B�������I�����܂��B
    ECHO [%DATE% %TIME%] [%DIRECTORY_EXE%]�t�@�C�������݂��Ă��܂���B�������I�����܂��B >>%DIRECTORY_LOG%lame.log
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
    :: LAME �G���R�[�h���s����
    START /WAIT /MIN "Encode" %DIRECTORY_EXE% %OPTIONS% %QUALITY% -m %MODE% %DIRECTORY_WAV%%%~nI.wav  %DIRECTORY_MP3%%%~nI.mp3
    IF %ERRORLEVEL%.==0. (
        ECHO [%DATE% %TIME%] %%I �̓G���R�[�h���������܂����B >>%DIRECTORY_LOG%lame.log
        DEL %DIRECTORY_WAV%%%~nI.wav
    ) ELSE (
        ECHO [%DATE% %TIME%] %%I �̓G���R�[�h�Ɏ��s���܂����B >>%DIRECTORY_LOG%lame.log
    )
)

IF %ERRORLEVEL%.==1. (
    ECHO [%DATE% %TIME%] �\�����ʃG���[���������܂����B�������Ď��s���ĉ������B >>%DIRECTORY_LOG%lame.log
    GOTO PRWAIT
)

:SKIP
:: �ω����Ȃ��ꍇ
ECHO %MESSEAGE%

:: �X���[�v����
PING -n %CHECKINTERVAL% 127.0.0.1 > NUL

:PRWAIT
GOTO CHECK

ENDLOCAL

:: �G���[�I��
rem :NOTFOUND
rem ECHO [%DATE% %TIME%] %DIRECTORY_EXE%" �����݂��܂���BEXE�t�@�C�����ēx�m�F���ĉ������B >>%DIRECTORY_LOG%lame.log
rem EXIT /B