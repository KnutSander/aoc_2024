<#
--- Day 4: Ceres Search ---

"Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the 
only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; 
she'd like to know if you could help her with her word search (your puzzle input). She only has to 
find one word: XMAS.

This word search allows words to be horizontal, vertical, diagonal, written backwards, or even
overlapping other words. It's a little unusual, though, as you don't merely need to find one 
instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where 
irrelevant characters have been replaced with .:

..X...
.SAMX.
.A..A.
XMAS.S
.X....

The actual word search will be full of letters instead. For example:

MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX

In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where 
letters not involved in any XMAS have been replaced with .:

....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX

Take a look at the little Elf's word search. How many times does XMAS appear?
#>

# Read the input file
$lines = Get-Content -Path .\day_4\input.txt

# Initialize the counter
$xmasCount = 0

# Loop through each line
foreach ($lineIndex in 0..($lines.Length - 1)) {
    $line = $lines[$lineIndex]
    $characters = $line.ToCharArray()

    for ($i = 0; $i -lt $characters.Length; $i++) {
        # Look for forwards spellings
        if($characters[$i] -eq 'X') {
            
            # Horizontal
            if($i + 3 -lt $characters.Length -and $characters[$i + 1] -eq 'M' -and $characters[$i + 2] -eq 'A' -and $characters[$i + 3] -eq 'S') {
                $xmasCount++ # 3
            }

            # Vertical
            if($lineIndex + 3 -lt $lines.Length -and $lines[$lineIndex + 1][$i] -eq 'M' -and $lines[$lineIndex + 2][$i] -eq 'A' -and $lines[$lineIndex + 3][$i] -eq 'S') {
                $xmasCount++ # 1
            }

            # Diagonal up and to the right
            if($lineIndex -3 -ge 0 -and $i + 3 -lt $characters.Length -and $lines[$lineIndex - 1][$i + 1] -eq 'M' -and $lines[$lineIndex - 2][$i + 2] -eq 'A' -and $lines[$lineIndex - 3][$i + 3] -eq 'S') {
                $xmasCount++ # 4
            }

            # Diagonal down and to the right
            if($lineIndex + 3 -lt $lines.Length -and $i + 3 -lt $characters.Length -and $lines[$lineIndex + 1][$i + 1] -eq 'M' -and $lines[$lineIndex + 2][$i + 2] -eq 'A' -and $lines[$lineIndex + 3][$i + 3] -eq 'S') {
                $xmasCount++ # 1
            }

            # Dioagonal down and to the left
            if($lineIndex + 3 -lt $lines.Length -and $i - 3 -ge 0 -and $lines[$lineIndex + 1][$i - 1] -eq 'M' -and $lines[$lineIndex + 2][$i - 2] -eq 'A' -and $lines[$lineIndex + 3][$i - 3] -eq 'S') {
                $xmasCount++ # 1
            }

            # Diagonal up and to the left
            if($lineIndex - 3 -ge 0 -and $i - 3 -ge 0 -and $lines[$lineIndex - 1][$i - 1] -eq 'M' -and $lines[$lineIndex - 2][$i - 2] -eq 'A' -and $lines[$lineIndex - 3][$i - 3] -eq 'S') {
                $xmasCount++ # 4
            }

        # Look for backwards spellings
        } elseif ($characters[$i] -eq 'S') {
            # Horizontal
            if($i + 3 -lt $characters.Length -and $characters[$i + 1] -eq 'A' -and $characters[$i + 2] -eq 'M' -and $characters[$i + 3] -eq 'X') {
                $xmasCount++ # 2
            }

            # Vertical
            if($lineIndex + 3 -lt $lines.Length -and $lines[$lineIndex + 1][$i] -eq 'A' -and $lines[$lineIndex + 2][$i] -eq 'M' -and $lines[$lineIndex + 3][$i] -eq 'X') {
                $xmasCount++ # 2
            }
        }
    }
}

# Output the result
$xmasCount

<#
--- Part Two ---

The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this isn't actually an 
XMAS puzzle; it's an X-MAS puzzle in which you're supposed to find two MAS in the shape of an X. 
One way to achieve that is like this:

M.S
.A.
M.S

Irrelevant characters have again been replaced with . in the above diagram. Within the X, each MAS 
can be written forwards or backwards.

Here's the same example from before, but this time all of the X-MASes have been kept instead:

.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........

In this example, an X-MAS appears 9 times.

Flip the word search from the instructions back over to the word search side and try again. How 
many times does an X-MAS appear?
#>

# Initialize the counter
$xmasCount = 0

# Only looking for MAS or SAM, dioagonally and as an X
foreach ($lineIndex in 0..($lines.Length - 1)) {
    $line = $lines[$lineIndex]
    $characters = $line.ToCharArray()

    for ($i = 0; $i -lt $characters.Length; $i++) {
        # Look for A's as they are at the center of the X
        if($characters[$i] -eq 'A' -and $lineIndex - 1 -ge 0 -and $i - 1 -ge 0 -and $lineIndex + 1 -lt $lines.Length -and $i + 1 -lt $characters.Length) {
            # M M 
            #  A
            # S S
            if($lines[$lineIndex - 1][$i - 1] -eq 'M' -and $lines[$lineIndex - 1][$i + 1] -eq 'M' -and $lines[$lineIndex + 1][$i - 1] -eq 'S' -and $lines[$lineIndex + 1][$i + 1] -eq 'S') {
                $xmasCount++
            }

            # M S
            #  A
            # M S
            if($lines[$lineIndex - 1][$i - 1] -eq 'M' -and $lines[$lineIndex - 1][$i + 1] -eq 'S' -and $lines[$lineIndex + 1][$i - 1] -eq 'M' -and $lines[$lineIndex + 1][$i + 1] -eq 'S') {
                $xmasCount++
            }
            
            # S S
            #  A
            # M M
            if($lines[$lineIndex - 1][$i - 1] -eq 'S' -and $lines[$lineIndex - 1][$i + 1] -eq 'S' -and $lines[$lineIndex + 1][$i - 1] -eq 'M' -and $lines[$lineIndex + 1][$i + 1] -eq 'M') {
                $xmasCount++
            }

            # S M
            #  A
            # S M
            if($lines[$lineIndex - 1][$i - 1] -eq 'S' -and $lines[$lineIndex - 1][$i + 1] -eq 'M' -and $lines[$lineIndex + 1][$i - 1] -eq 'S' -and $lines[$lineIndex + 1][$i + 1] -eq 'M') {
                $xmasCount++
            }
        }
    }
}

# Output the result
$xmasCount