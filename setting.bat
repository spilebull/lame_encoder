@ECHO OFF
::***************************
:: �t�@�C���p�X�ݒ�
::***************************
:: �J�����g�f�B���N�g���擾
CD %~dp0

:: ���s�t�@�C���p�X
SET DIRECTORY_EXE=%CD%\bin\lame.exe

:: WAV�t�@�C���i�[��
SET DIRECTORY_WAV=%CD%\encode\wav\

:: MP3�t�@�C���o�͐�
SET DIRECTORY_MP3=%CD%\encode\mp3\

:: LOG�t�@�C���i�[��
SET DIRECTORY_LOG=%CD%\log\


::***************************
:: �G���R�[�h�ݒ�
:: ABR �c --abr
:: CBR �c -b
:: VER �c -V
::***************************
SET OPTIONS=-b

::***************************
:: �N�I���e�B�ݒ�
:: ABR �c 64,128,256�ikbps�j
:: CBR �c 64,128,256�ikbps�j
:: VER �c 0�`9�i���`��j
::***************************
SET QUALITY=64

::***************************
:: ���[�h�ݒ�
:: s �c �X�e���I
:: m �c ���m����
:: j �c M/S�W���C���g�X�e���I
:: f �c ����M/S�X�e���I
:: d �c ��d����
::***************************
SET MODE=m

::***************************
:: ���̑�
::***************************
:: ���b�Z�[�W
SET MESSEAGE=�펞�G���R�[�h���{��

:: �`�F�b�N�������Ԋu[�b]
SET CHECKINTERVAL=3