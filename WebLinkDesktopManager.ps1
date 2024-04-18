﻿$StartMenuUrls = Get-ChildItem "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Filter *.url

$RemoveNonExisting = $true

Write-Host ("Found {0} urls in startmenu" -f $StartMenuUrls.count) -ForegroundColor Cyan
#TEST $url = $urls[0]
Foreach($url in $StartMenuUrls){
    Write-Host ("Checking to see if [{0}] web link exists on [{1}] desktop..." -f $url.BaseName,$env:USERNAME) -ForegroundColor White -NoNewline
}

$url = $null
Write-host ''

$DesktopUrls = Get-ChildItem "$env:USERPROFILE\Desktop" -Filter *.url

If($RemoveNonExisting){
    Write-Host ("Found {0} urls on desktop" -f $DesktopUrls.count) -ForegroundColor Cyan
    Foreach($url in $DesktopUrls)
    {
        Write-Host ("Checking to see if [{0}] web link exists in [{1}] start menu..." -f $url.BaseName,$env:USERNAME) -ForegroundColor White -NoNewline
        $urlname = $url.Name
        If(Test-Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\$urlname")
            Write-Host "Exists!" -ForegroundColor Green
            #do nothing
        }Else{
            Write-Host "Does not exist. Removing..." -ForegroundColor Red
            Remove-Item $url.FullName -Force | Out-Null
        }
    }
}
