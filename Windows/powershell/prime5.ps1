class Prime {
    [int]$Value
    [long]$Square
    [int]$Seq
    [Prime]$Next

    Prime([int]$value, [int]$seq) {
        $this.Seq = $seq
        $this.Value = $value
        $this.Square = $value * $value
        $this.Next = $null
    }
    [string]Print() {
        $returnText = [System.String]::Format("{0,20}: {1,20}", $this.Seq, $this.Value)
        return $returnText
    }
}
class PrimeList {
    [Prime]$Head
    [int]$Seq
    [bool]$FirstLine

    PrimeList() {
        $this.Head = $null
        $this.Seq = 0
        $this.FirstLine = $true
    }
    [void]Add([object]$value) {
        $this.Seq += 1
        # Write-Host $value
        $newNode = [Prime]::new($value, $this.Seq)
        if ($null -eq $this.Head) {
            $this.Head = $newNode
        } else {
            $current = $this.Head
            while ($null -ne $current.Next) {
                $current = $current.Next
            }
            $current.Next = $newNode
        }
    }
    [void]Print([string] $outputFile) {
        $current = $this.Head
        while ($null -ne $current) {
            if ($outputFile -eq "") {
                Write-Host $current.Print()
            } else {
                if ($this.FirstLine) {
                    Write-Output $current.Print() > $outputFile
                    $this.FirstLine = $false
                } else {
                    Write-Output $current.Print() >> $outputFile
                }
            }
            $current = $current.Next
        }
        $this.FirstLine = $true
    }
}

# Main Procedure

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
$primeList = [PrimeList]::new()
$primeList.Add(2)

if ($maxPrimes -gt 1) {
    $primeList.Add(3)
    $number = 3
    For ($count = 2; $count -lt $maxPrimes; $count++) {
        Do {
            $number = 2 + $number
            $prime = $primeList.Head.Next
            $divisor = $prime.Value
            $divisorsquare = $prime.Square
            $isprime = $true
            While ($divisorsquare -le $number) {
                $remainder = $number % $divisor
                If ($remainder -eq 0) {
                    $isprime = $false
                    break
                } Else {
                    $prime = $prime.Next
                    if ($null -eq $prime) {
                        break
                    }
                    $divisor = $prime.Value
                    $divisorsquare = $prime.Square
                }
            }
            If ($isprime) {
                $primeList.Add($number)
            }
        } While (-not $isprime);
    }
}
$primeList.Print($outputFile)
