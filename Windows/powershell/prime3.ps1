Write-Host 2
$number = 1
For ($count = 1; $count -le 99; $count++) {
    Do {
        $number = 2 + $number
        $divisor = 3
        $divisorsquare = $divisor * $divisor
        $isprime = 1
        While ($isprime -and $divisorsquare -le $number) {
            $remainder = $number % $divisor
            If ($remainder -eq 0) {
                $isprime = 0
            } Else {
                $divisor = 2 + $divisor
                $divisorsquare = $divisor * $divisor
            }
        }
        If ($isprime) {
            Write-Host $number
        }
    } While (-not $isprime);
}
