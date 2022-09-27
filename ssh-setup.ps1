Get-Service ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent

$path = Read-Host "Enter path to folder where keys will be stored"
$name = Read-Host "Enter desired cert name"

Set-Variable CertPath -Option ReadOnly -Value "$path\$name"

$email = Read-Host "Enter your email"
#New-Item -Path $path -Name $name -ItemType "file"

ssh-keygen -t rsa -b 4096 -f "$path\$name" -C $email
ssh-add $CertPath

# SIG # Begin signature block
# MIIFgwYJKoZIhvcNAQcCoIIFdDCCBXACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAjR55Ss3Ij4lWd
# ZiX2KdDb9dcKBsVFDYZQrRwzqAr8fqCCAv4wggL6MIIB4qADAgECAhBJlpO/zgZZ
# r0B45sj2ArBcMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMMCnNrYXNodGFub3Yw
# HhcNMjIwOTI3MDgwMDQxWhcNMjMwOTI3MDgyMDQxWjAVMRMwEQYDVQQDDApza2Fz
# aHRhbm92MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2YmqOiRGtPVV
# J++CZvEOVGmUVvo72XTyYgnJKI74IjFNsT9A0TJaV/gxvX+gLdTLtVEUb8lbpppJ
# wcxzWbHmzZNgpAzg9kqUg7hCNHC4VaaM+Ju8WwQOI+8KvzWnwk9LGyNGOudqIrh9
# tyecqUUE/r9o0e1neAWKs7N+nwbHlns23av0gZDpNAQ8Bb7yU/HGofNivV2/SRVM
# lojgHuT2cu7gaqru1sqdvZJn60UEXzW2SwDZoXBgj2lt/I/ckJrjuFm6bKnnyKtc
# hTb9eHL3IOWAles12MNd7cMIIV+oAcvqH0xdQHa2eY3lQDK111DNkjvfEvPCgFXK
# fMXZTIjZmQIDAQABo0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwHQYDVR0OBBYEFIGloANlGNt9ZDf6t5usiS1PB1KDMA0GCSqGSIb3DQEB
# CwUAA4IBAQCuDwiPogv1jkXiUDerrngjfiw2HtOdwO82VSOPqP9x/m55Pf610EW4
# HBV95TsbPhBZyhg6yfhiccCOmxBBvN7fI/j9VFRpN6JNJME8AwcGZAnYQ3dWF1St
# 1jmrWrwzMgmxAV259nm0qn3qbYa6/yWk65gMlciqJFNmaJDTTNf74uhA+daSigE2
# eK63mI5IW3RJoVklY7hv1010uo2bBfplcP+QPVMs+y01KpwwbX8aK7vQPlEaAu9B
# WpYIWSHqaaXXQjo7uAVGTk9gCq7f4eiMiOIrE1imH1GOEnkXb3jDC3AHpy2V07ir
# PBFXXSxL9SQOzMeOSrmfbfZRc/tkcswMMYIB2zCCAdcCAQEwKTAVMRMwEQYDVQQD
# DApza2FzaHRhbm92AhBJlpO/zgZZr0B45sj2ArBcMA0GCWCGSAFlAwQCAQUAoIGE
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkE
# MSIEIODzF2DIaEZkhkZtRJA800BgsCgN7hKcqklte9epE1DdMA0GCSqGSIb3DQEB
# AQUABIIBAIH/pm9SgiHkU6/+uqekx0nSC01/ceF88RRhOJjulLCVdQyXCDK5NtZc
# Qc/B4miGXKlQwN/e7NloFbCRHaSvo46hDQEljhfCkzWDd97oGLdAXsXXLu2GC2xA
# yctDzZnLWBoCXvst2t8eBOXOzGWC9Fye1cCiZl5ku2HMlmFPz7qvcqlJ5RBrYO2y
# mawtJxSPb/jhkIULFLUj458qkjmiZXwQhtCU2By1GNTRPl7BbebwJWxWWoEjYuZs
# 4rFjJFiRtq9iJJ7VgCaWv8rwSZ64Rxtqydps/mmqq09DKtA+5oXeIioPOfAnvz7w
# QuSEAJihblE2uNa7CDUxfzwypfHFjRs=
# SIG # End signature block
