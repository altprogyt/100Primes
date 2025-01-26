try {
    $maxPrimes = [int]$args[0]
} catch {
    $maxPrimes = 100
} finally {
    if ($maxPrimes -lt 1) {
        $maxPrimes = 100
    }
}
try {
    $outputFile = [string]$args[1]
} catch {
    $outputFile = ""
}

$primes = @(0 .. ($maxPrimes - 1))
$primesquares = @(0 .. ($maxPrimes - 1))
$firstLine = $true

$primes[0] = 2
$primesquares[0] = 4

if ($maxPrimes -gt 1) {
    $primes[1] = 3
    $primesquares[1] = 9
    $number = 3

    For ($count = 2; $count -lt $maxPrimes; $count++) {
        Do {
            $number = 2 + $number
            $primepointer = 1
            $divisor = $primes[$primepointer]
            $divisorsquare = $primesquares[$primepointer]
            $isprime = $true
            While ($isprime -and $divisorsquare -le $number) {
                $remainder = $number % $divisor
                If ($remainder -eq 0) {
                    $isprime = $false
                } Else {
                    $primepointer = 1 + $primepointer
                    $divisor = $primes[$primepointer]
                    $divisorsquare = $primesquares[$primepointer]
                }
            }
            If ($isprime) {
                $primes[$count] = $number
                $primesquares[$count] = $number * $number
            }
        } While (-not $isprime);
    }
}
for ($count = 0; $count -lt $maxPrimes; $count++) {
    $printLine = [System.String]::Format("{0,20}: {1,20}", 1 + $count, $primes[$count])
    if ($outputFile -eq "") {
        Write-Host $printLine
    } else {
        if ($firstLine) {
            Write-Output $printLine > $outputFile
            $firstLine = $false
        } else {
            Write-Output $printLine >> $outputFile
        }
    }
}
