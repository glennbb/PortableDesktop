#include <Array.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>

OnAutoItExitRegister ( 'OnAutoItExit' )

$HostDrive = StringLeft(@AutoItExe, 2)

$hProgressSplash = _SplashTextProgress("Portable Desktop",$HostDrive&"work_portal.jpg","... Opening Portal ...","O")

;CONFIGURE THESE PATHS!!!

;These files should be on the non-encrypted drive

; Truecrypt volumes to mount
$WorkVolume = "\Drives\PortableApps.vc"
$WorkDrive = "P"

;$DocsVolume = "\Profiles\Drives\Documents.tc"
;$MailVolume = "\Profiles\Drives\mail-profiles.tc"


;$Work2Volume = "\Profiles\Drives\FilingCabinet.tc"

$TrueCrpytExe = "\Tools\VeraCrypt\VeraCrypt.exe"
$CoffeeExe = ":\Utility\Coffee\Coffee.exe"
$JungleDisk = ":\Utility\jungledisk-usb\JungleDiskMonitor.exe"

;These files should be on the encrypted drive
;$MainSandboxieFolder = ":\PortableApps\SandboxiePortable\"

$NimiExe = ":\Utility\Nimi Places\Nimi Places.exe"
$My_Nimi_Places = ":\Utility\Nimi Places\Places\"

$PStartExe = ":\Start.exe"
;$MojoStartExe = "P:\Start.exe"
;$KeepassExe = ":\Utility\keepass\KeePass.exe"

;END OF CONFIGURATION

; in this case, instead of searching for free drive letters
; we want to mount as M:
;$alphabet = StringSplit("abcdefghijklmnopqrstuvwxyz","")
;$drives = DriveGetDrive("ALL")
;$drives = _ArrayToString($drives,"",1)
;$drives = StringRegExpReplace($drives, "[ :]", "")&"b"
;For $i = 1 to 26
;   If StringInStr($drives,$alphabet[$i])=0 Then
;      $FDL = $alphabet[$i]
;      ExitLoop
;   EndIf
;Next
;If StringLen($FDL)<>1 Then
;   MsgBox(0,"Drive Launcher","There are no free drive letters!")
;   Exit
;EndIf


$volumefile = $HostDrive&$WorkVolume
$password = InputBox("Password", "Please input the unlock code","","*",225,110)
$TCPID = RunWait($TrueCrpytExe&" /v "&$volumefile&" /l P /p "&$password&" /q")

;If StringLen($TCPID)<3 Then
;   MsgBox(0,"Drive Launcher","Problem encountered while launching TrueCrypt.exe ["&$TCPID&"]"&@error)
;   Exit
;EndIf
;If ProcessWaitClose($TCPID,60)=0 Then
;   MsgBox(0,"Drive Launcher","TrueCrypt did not close after 60 seconds")
;   Exit
;EndIf

; Wait a tad... VeraCrypt takes a little longer than TC did to mount
Sleep(8000)

; main W: drive now mounted
; mount our two supplemental volumes

;$volumefile = $HostDrive&$DocsVolume
;RunWait($TrueCrpytExe&" /v "&$volumefile&" /lp /p "&$password&" /q")

;$volumefile = $HostDrive&$WorkVolume
;RunWait($TrueCrpytExe&" /v "&$volumefile&" /lr /p "&$password&" /q")

; Mail Profiles
;$volumefile = $HostDrive&$MailVolume
;RunWait($TrueCrpytExe&" /v "&$volumefile&" /lm /p "&$password&" /q")

;$volumefile = $HostDrive&"\Profiles\Drives\BackupBrain.tc"
;RunWait($TrueCrpytExe&" /v "&$volumefile&" /lw /p "&$password&" /q")

; Run KeePass...
;Run($WorkDrive&$KeepassExe&' "H:\Documents - Glenn\gr_database.kdb" '&"-pw:"&$password)
;Sleep(1500)

; ...start the PortableApps menu...
Run($WorkDrive&$PStartExe)
Sleep(1000)

; ... start JungleDisk ...
;Run($WorkDrive&$JungleDisk)
;Sleep(500)

; ... start Nimi ...
Run($WorkDrive&$NimiExe)
Sleep(500)

; ... start Dexpot - multiple desktops ...
Run($WorkDrive&":\Utility\dexpot_portable\dexpot.exe")
Sleep(2500)

; Now start Coffee for portable file associations...
Run($WorkDrive&$CoffeeExe)
Sleep(500)

; setup some desktop icons

;$FileName = "P:\Start.exe"
;$LinkFileName = @DesktopDir & "\Start Personal Desktop.lnk"
;$WorkingDirectory = "P:\"
;$Description = "This starts my mobile personal MojoPac desktop"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $drive&"\mobile-backup.exe"
;$LinkFileName = @DesktopDir & "\Mobile Backup.lnk"
;$WorkingDirectory = "F:\"
;$Description = "This starts my mobile backup utility"
;$icon = @SystemDir & "\shell32.dll"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description,$icon,"","47",$State)


;$FileName = $WorkDrive&":\Utility\mremoteNG\mRemoteNG.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Quick Links\mRemote.lnk"
;$WorkingDirectory = $WorkDrive&":\Utility\mremoteNG\"
;$Description = "mRemoteNG - remote server access tool"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $WorkDrive&":\Utility\jungledisk-usb\junglediskmonitor.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Tools\jungledisk-usb.lnk"
;$WorkingDirectory = $WorkDrive&":\Utility\jungledisk-usb\"
;$Description = "JungleDisk"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $HostDrive&"\Profiles\Tools\truecrypt\truecrypt.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Tools\Truecrypt Portable.lnk"
;$WorkingDirectory = $HostDrive&"\Profiles\Drives\"
;$Description = "TrueCrypt - encryption tool"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)


;$FileName = $WorkDrive&":\Utility\KeePass\keepass.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Tools\KeePass Portable.lnk"
;$WorkingDirectory = "P:\Documents\"
;$Description = "KeePass"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $WorkDrive&":\Utility\UltraRecall\UltraRecall.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Quick Links\UltraRecall Portable.lnk"
;$WorkingDirectory = "P:\Documents\"
;$Description = "UltraRecall PIM"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $WorkDrive&":\Utility\EPIM\EssentialPIM.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Quick Links\EssentialPIM Pro Portable.lnk"
;$WorkingDirectory = "P:\Documents\"
;$Description = "EssentialPIM Pro"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)

;$FileName = $WorkDrive&":\Utility\fossil\fossil.exe"
;$LinkFileName = $WorkDrive & $My_Nimi_Places & "Quick Links\Fossil.lnk"
;$WorkingDirectory = "P:\PrimeTech\Projects\"
;$Description = "Fossil SCM"
;$State = @SW_SHOWNORMAL ;Can also be @SW_SHOWNORMAL or @SW_SHOWMINNOACTIVE

;FileCreateShortcut($FileName,$LinkFileName,$WorkingDirectory,"",$Description)


GUIDelete($hProgressSplash)

; wait until it finishes
Sleep(16000)
ProcessWaitClose("PortableAppsPlatform.exe")

$hProgressSplash = _SplashTextProgress("Portable Desktop",$HostDrive&"close_portal.jpg","... Locking Vault ...","C")


; --------------- Functions --------------------

Func _SplashTextProgress($sText,$sPic,$sDesc,$sWhich) ;Creates a Splash Text Screen with a progress bar.
    SplashOff() ;Turn previous splash text screens off.
    Select
      Case $sWhich = "O"
         $WinPos = 1
      Case $sWhich = "C"
         $WinPos = -1        
    EndSelect
    $hSplash = GUICreate("", 300, 460, $WinPos, $WinPos, BitOR($WS_POPUP, $WS_BORDER), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE, $WS_EX_TOOLWINDOW))
    GUICtrlCreatePic($sPic, 1, 50, 300, 360)
;~  $iProgressBar = GUICtrlCreateProgress(100, 325, 305, 25, $PBS_SMOOTH) ;A standard progress bar.
    $iProgressBar = GUICtrlCreateProgress(0, 435, 300, 25, $PBS_MARQUEE) ;A marquee progress bar.
    GUICtrlSendMsg(-1, $PBM_SETMARQUEE, True, 80) ;last parameter is update time in ms. Sends message to run the marquee progress bar.
    $iMessage = GUICtrlCreateLabel($sText, 0, 0, 300, 50, $SS_CENTER)
    GUICtrlSetFont(-1, 22, 700, 0, "Arial")

    $iMessage = GUICtrlCreateLabel($sDesc, 0, 412, 300, 20, $SS_CENTER)
    GUICtrlSetFont(-1, 12, 400, 2, "Arial")

    GUISetState(@SW_SHOW)

    Return SetExtended($iProgressBar, $hSplash)
EndFunc   ; end _SplashTextProgress

Func OnAutoItExit()
   Sleep(5000)

   if ProcessExists("Coffee.exe") then
      ProcessClose("Coffee.exe")
   endif

   if ProcessExists("thunderbird.exe") then
      ProcessClose ( "thunderbird.exe")
   endif

   if ProcessExists ( "firefox.exe" ) then
      ProcessClose ("firefox.exe")
   endif
   
   if ProcessExists ( "SkypePortable.exe" ) then
      ProcessClose ("Skype.exe")
      ProcessClose ("SkypePortable.exe")
      Sleep(1000)
   endif

   if ProcessExists ( "JungleDiskMonitor.exe" ) then
      ProcessClose ("JungleDiskMonitor.exe")
      Sleep(1000)
   endif
   
   if ProcessExists ( "KeePass.exe" ) then
      ProcessClose ("KeePass.exe")
      Sleep(1000)
   endif   
   
   if ProcessExists("Dropbox.exe") then
      ProcessClose ( "Dropbox.exe")
   endif
   if ProcessExists("DropboxPortableAHK.exe") then
      ProcessClose ( "DropboxPortableAHK.exe")
   endif
      
   ; remove some desktop icons
;   FileDelete(@DesktopDir & "\Start Personal Desktop.lnk")
;   FileDelete(@DesktopDir & "\Mobile Backup.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Tools\mRemote.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Tools\jungledisk-usb.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Tools\KeePass Portable.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Tools\Truecrypt Portable.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Quick Links\UltraRecall Portable.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Quick Links\EssentialPIM Pro Portable.lnk")
;   FileDelete($WorkDrive & $My_Nimi_Places & "Quick Links\Fossil.lnk")

   if ProcessExists("Nimi Places.exe") then
      ProcessClose ( "Nimi Places.exe" )
      Sleep(1000)
   endif

   if ProcessExists("dexpot.exe") then
      ProcessClose ( "dexpot.exe")
      Sleep(1000)
   endif

   Sleep(2000)

   ShellExecuteWait($HostDrive&$TrueCrpytExe,"/d /q")

   Sleep(2000)

   GUIDelete($hProgressSplash)
   
;   ShellExecute($HostDrive&"\psshutdown.exe","-k -c")
EndFunc      ; end OnAutoItExit()
