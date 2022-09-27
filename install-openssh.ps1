function IsAdmin {
    (
        New-Object Security.Principal.WindowsPrincipal(
            [Security.Principal.WindowsIdentity]::GetCurrent()
        )
    ).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
}

if (-not (IsAdmin)) 
{
    Write-Host "Please run script as administrator"
    Exit
}

$ps_version = $PSVersionTable.PSVersion
$major = $ps_version.Major
$minor = $ps_version.Minor

if (($major -lt 5) -or ($minor -lt 1)) 
{
    Write-Host "
    Please update your powershell.
    Powershell version must be at least 5.1
    Your version is $ps_version
    "
    Exit
}

Get-WindowsCapability -Online | 
Where-Object {
    ($_.Name -like 'OpenSSH*') -and ($_.State -like 'NotPresent')
} | 
Foreach-Object {
    Add-WindowsCapability -Online -Name $_.Name
}

Start-Service sshd
Set-Service -Name sshd -StartupType Automatic

if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled))
{
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} 
else 
{
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

Write-Host "OpenSSH has configured successfully"

# SIG # Begin signature block
# MIIFgwYJKoZIhvcNAQcCoIIFdDCCBXACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCgjA+/GGYkQzV/
# hqiZmTIl/X+mWdsNfDEbHGrkB45fzKCCAv4wggL6MIIB4qADAgECAhAqrRqIXKhZ
# rEaOSJEUCwo4MA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMMCnNrYXNodGFub3Yw
# HhcNMjIwOTI3MDc1OTA2WhcNMjMwOTI3MDgxOTA2WjAVMRMwEQYDVQQDDApza2Fz
# aHRhbm92MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1lz3QlJjOamQ
# ZpsEnfFkLw7N3oEeo3Q5MLH0sD19rHVgcUYrTx/JvG7kic3OyjF5SzYxHjlkOFQK
# gHHQazRXXnE3OJvmqQgUHpnijf3dJZEgWsSELQEYlynkoedbQ0nnpOKLdotIAeUW
# qCxs+aI3ICwlDFyR1ilh+GAh+q5Qp1oheyYdzpWZ3g+IAFvyCmrH0ob/W824bdbc
# IcQdlLtHw+MyjYenLfe2+4QyR3SRDfa2dVNXCYeShFCUvn+SoSIUG7aM2JkeFYMk
# LsGyUZGGWB8ndf5K7Fv8E6Eurt8aJdyjQx5EDy6w+Iy2Ey7c/ArPAsN58dI0Obbp
# /K9ZdMPSUQIDAQABo0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwHQYDVR0OBBYEFCyykAM473Lj8Sb25PDNeuXEEwAXMA0GCSqGSIb3DQEB
# CwUAA4IBAQAEHrXSjNuVXqRk84t1bCsMPz2hF2/xLOMBE6KHs7bwIDbTCLEvMFbP
# q6RWPuqrs3lZbqAH/n7Y4q4zFq2sl+l4Kqqx/X1PIEx7PZsOVMR6VHThmnoJvcgQ
# Jl/AZKXybZAM1cBnG0aY5GFZIlKcqnut6G/XpR3WHbmEwIKUOPsYUIQQS3PcPTzK
# AHcLrwpIBFo3ZVLHiPUI7SXFkkbA1NrdECtmcCXebpmOz9pAT74bwtxbjo5pPXv7
# e7kTRB5ysobnHgWUZ5Ipf8FlwG22Gshn47Eho921JEQ2dG/5VlVPZEj4cwOTOyB8
# yyKXaf38NOAHeZ9Ec0zF1z5vDJW1nzWYMYIB2zCCAdcCAQEwKTAVMRMwEQYDVQQD
# DApza2FzaHRhbm92AhAqrRqIXKhZrEaOSJEUCwo4MA0GCWCGSAFlAwQCAQUAoIGE
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkE
# MSIEIACRoPKTVBUsIXQ4DJvXeO8AKN2WzhkrlB0Y2JhnCpJJMA0GCSqGSIb3DQEB
# AQUABIIBAJxy0gZ0+B11mF9uLryhjldkRdOz0I7oaquXVuTPsX/bf9dt7RlLGeC1
# zARMZ5UaiYEN28Eb2gqIinWz1DObvE+JghpGde7P4BvTkjYvfWyj77wASWt9Ub/s
# TryRK3myLCdqbM09ypoIwdcWFJLYrJSLpuTndv1MBQV+eh7mzkIU50za3ZmMi+04
# de/RbRmwMFoMRh84aL1vfSW9VO6/iBQmCFMGuB0CD17bErI9Ieenu83J+TfCjNx4
# IUtnRLRzqvqeBzrJccF5jg4lPj10tjkR6jMefmZ+EC6NXdtx9Z3giveHgd3gsuBl
# 1b1WvQqfLdtmHm4yMV6nnE6kR07f31I=
# SIG # End signature block
