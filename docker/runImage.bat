@ECHO OFF

@REM We wish to use a set of Bash functions that are defined in the 
@REM ../scripts directory for both this container and the 
@REM ../.github/antora-generate.yml GitHub workflow, to keep things DRY.
@REM 
@REM To cope with the need to relatively reference the ../scripts directory
@REM in a Windows .bat file setting, where the docker run -v option does not
@REM allow for a relative path as the source directory, we employ
@REM a bit of trickery here that leverages the "cd" environment variable; the
@REM SCRIPTS_DIR is set to the absolute path of the scripts directory.

SET DOCKER_DIR=%cd%
cd ..\scripts
SET SCRIPTS_DIR=%cd%
cd %DOCKER_DIR%

@REM This is the image that we need (see the Dockerfile)
SET IMAGE=ubuntu-antora

@REM This is actually the Git repository which houses this docker directory, as well
@REM as the required antora-playbook.yml file and the supporting ui-bundle and supplemental-ui 
@REM directories
SET REPO_URL=https://github.com/M50505/engDocMethod.git

@REM We need to set the GitHub user credentials (<user-name>:<personal-access-token>)
@REM in order to be able to fetch/checkout the required repositories from within the 
@REM container.
SET GIT_TOKEN=%1

@REM Depending upon Heaven Knows What variations are in place in the Windows environment that
@REM is running this .bat file, some permutation of these options are set for the docker run
@REM command. Having the following settings appears to work conistently across several different
@REM installations of Windows 11 Home Edition Version 10.0.2xxx Build 19xxx :
@REM  SET IPRIV=--cap-add=NET_ADMIN
@REM  SET PPRIV=--privileged
@REM  SET PORT_MAP=-p 80:80
@REM  SET NET= 

SET NET=
SET IPRIV=--cap-add=NET_ADMIN
SET PPRIV=--privileged
SET PORT_MAP=-p 80:80

SET command=docker run ^
--rm ^
-it ^
-v "%SCRIPTS_DIR%":/scripts ^
%IPRIV% ^
%PPRIV% ^
%NET% ^
%PORT_MAP% ^
--env REPO_URL=%REPO_URL% ^
--env GIT_TOKEN=%GIT_TOKEN% %IMAGE%

echo %command%
%command%