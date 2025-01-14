$primes = @(0 .. (100 - 1))
$primesquares = @(0 .. (100 - 1))

Write-Host 2
$primes[0] = 2
$primesquares[0] = 4
Write-Host 3
$primes[1] = 3
$primesquares[1] = 9
$number = 3
For ($count = 2; $count -le 99; $count++) {
    Do {
        $number = 2 + $number
        $primepointer = 1
        $divisor = $primes[$primepointer]
        $divisorsquare = $primesquares[$primepointer]
        $isprime = 1
        While ($isprime -and $divisorsquare -le $number) {
            $remainder = $number % $divisor
            If ($remainder -eq 0) {
                $isprime = 0
            } Else {
                $primepointer = 1 + $primepointer
                $divisor = $primes[$primepointer]
                $divisorsquare = $primesquares[$primepointer]
            }
        }
        If ($isprime) {
            $primes[$count] = $number
            $primesquares[$count] = $number * $number
            Write-Host $number
        }
    } While (-not $isprime);
}
