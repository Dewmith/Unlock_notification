# UnlockEmailSMTP.ps1
# Sends an email notification when the computer is unlocked

# --- Gmail SMTP configuration ---
$smtpServer = 'smtp.gmail.com'
$smtpPort   = 587
$smtpUser   = 'your.email@gmail.com'          # your own Gmail
$smtpPass   = 'YOUR_APP_PASSWORD'             # generated App Password (see below)

# --- Message details ---
$from    = $smtpUser
$to      = 'email_to_recieve_the_notification@gmail.com'  # recipient
$subject = "PC unlocked: $env:COMPUTERNAME by $env:USERNAME"
$body    = "Computer: $env:COMPUTERNAME`nUser: $env:USERNAME`nTime: $((Get-Date).ToString('u'))"

# --- Send email ---
$message = New-Object System.Net.Mail.MailMessage $from, $to, $subject, $body
$smtp    = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)

try {
    $smtp.Send($message)
} catch {
    "$((Get-Date).ToString('u')) - SMTP send failed: $_" |
        Out-File -FilePath "$env:USERPROFILE\unlock_notify.log" -Append
}
