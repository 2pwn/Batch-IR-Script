@ECHO OFF
echo Enter your choice process, network, host_info, Winaudit_Log, Schedule_Task, Reg, Autoruns,Rootkit, SSSS_File, All, Done
SET /P uname=Please enter your choice
2>NUL CALL :CASE_%uname%

:CASE_process
	Tasklist /v > Tasklist.txt
	GOTO END_CASE

:CASE_network
	Net Start > networkservices.txt
	Net view \\127.0.0.1 > openshares.txt
	Net Session > sessions.txt
	nbtstat -s > nbtstat1.txt
	nbtstat -S > nbtstat2.txt
	netstat -na > netstat.txt
	netstat -ab > netstatwithprocess.txt
	GOTO END_CASE

:CASE_host_info
	Whoami > user_detail.txt
	ver > user_detail.txt
	Hostname >> user_detail.txt
	Wmic bios get serialnumber >> user_detail.txt
	Wmic CSPRODUCT GET NAME >> user_detail.txt
	Ipconfig >> user_detail.txt
	Getmac -v >> user_detail.txt
	GOTO END_CASE

:CASE_Winaudit_Log
	WinAudit.exe /r=gsoPxuTUeERNtzDaIbMpmidcSArCO
	GOTO END_CASE

:CASE_Schedule_Task
	schtasks /query /FO LIST > Schedule_Task.csv
	GOTO END_CASE

:CASE_Reg
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\Run Run.reg
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce RunOnce.reg
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx RunOnceEx.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Run UserRun.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Run UserRunOnce.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnceEx UserRunOnceEX.reg
	GOTO END_CASE

:CASE_Autoruns
	autorunsc -nobanner -a * -h -s -t -vt -u * -x > autoruns_cmd.xml
	GOTO END_CASE

:CASE_Rootkit
	rootkitrevealer.exe -a rootkit.log
	GOTO END_CASE

:CASE_System
    	reg save hklm\sam c:\IR\sam
	reg save hklm\system c:\IR\system
	reg save hklm\system c:\IR\software
	reg save hklm\system c:\IR\security
	GOTO END_CASE

:CASE_ALL
	Tasklist /v > Tasklist.txt
	Net Start >networkservices.txt
	Net view \\127.0.0.1 >openshares.txt
	Net Session > sessions.txt
	nbtstat -s > nbtstat1.txt
	nbtstat -S > nbtstat2.txt
	netstat -na > netstat.txt
	netstat -ab > netstatwithprocess.txt
	Whoami > user_detail.txt
	ver > user_detail.txt
	Hostname >> user_detail.txt
	Wmic bios get serialnumber >> user_detail.txt
	Wmic CSPRODUCT GET NAME >> user_detail.txt
	Ipconfig >> user_detail.txt
	Getmac -v >> user_detail.txt
	WinAudit.exe /r=gsoPxuTUeERNtzDaIbMpmidcSArCO
	schtasks /query /FO LIST > Schedule_Task.csv
	autorunsc -nobanner -a * -h -s -t -vt -u * -x >autoruns_cmd.xml
	rootkitrevealer.exe -a rootkit.log
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\Run Run.reg
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce RunOnce.reg
	Reg export HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx RunOnceEx.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Run UserRun.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Run UserRunOnce.reg
	Reg export HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnceEx UserRunOnceEX.reg
    	reg save hklm\sam c:\IR\sam
	reg save hklm\system c:\IR\system
	reg save hklm\system c:\IR\software
	reg save hklm\system c:\IR\security
	GOTO END_CASE

:CASE_Done
	7z a -t7z evidence.7z *.txt
	7z a -t7z evidence.7z *.html
	7z a -t7z evidence.7z *.csv
	7z a -t7z evidence.7z *.xml
	7z a -t7z evidence.7z sam
	7z a -t7z evidence.7z system
	7z a -t7z evidence.7z security
	7z a -t7z evidence.7z software
	7z a -t7z evidence.7z *.reg
	del *.exe, *.bat, *.txt, *.reg, *.csv, *.xml, sam, system, security, software
	GOTO END_CASE

:DEFAULT_CASE
  echo It's none of process, network, host_info, etc
  GOTO END_CASE

:END_CASE
  VER > NUL # reset ERRORLEVEL
  GOTO :EOF # return from CALL
