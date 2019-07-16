FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

RUN apt-get update

# �\������Ɠ��͌������{������ɐݒ�
RUN apt-get install -y locales 
RUN apt-get install -y language-pack-ja-base language-pack-ja 
RUN locale-gen ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8

# �^�C���]�[����Asia/Tokyo�ɕύX
ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# bash�֌W�̊�{�R�}���h���C���X�g�[��
RUN apt-get install -y bash-completion
RUN apt-get install -y less
RUN apt-get install -y vim
RUN apt-get install -y iputils-ping

# SQL Server�C���X�g�[���p�̐ݒ�
#   �G�f�B�V�����FDeveloper
#   �f�t�H���g�p�X���[�h�FP@ss1234
#   �f�t�H���g�Ŏg�p����|�[�g�F1433
#   ����F���{��
ENV ACCEPT_EULA Y
ENV MSSQL_PID=Developer
ENV MSSQL_SA_PASSWORD=P@ss1234
ENV MSSQL_TCP_PORT=1433
ENV MSSQL_LCID=1041

# SQL Server�̃R�}���h���C���c�[���Ƀp�X��ʂ�
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile