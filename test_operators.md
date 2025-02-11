# BASH TEST OPERATORS

| FILE OPERATORS | DETAILS                                                   |
|----------------|-----------------------------------------------------------|
| `-e "$FILE"`   | Returns true if the file exists.                          |
| `-d "$FILE"`   | Returns true if the file exists and is a directory        |
| `-f "$FILE"`   | Returns true if the file exists and is a regular file     |
| `-h "$FILE"`   | Returns true if the file exists and is a symbolic link    |


| STRING COMPARISONS  | DETAILS                                                                                                    |
|---------------------|------------------------------------------------------------------------------------------------------------|
| `-z "$STR"`         | True if length of string is zero                                                                           |
| `-n "$STR"`         | True if length of string is non-zero                                                                       |
| `"$STR" = "$STR2"`  | True if string $str is equal to string $str2. Not best for integers. It may work but will be inconsistent. | 
| `"$STR" != "$STR2"` | True if the strings are not equal                                                                          |

| INTEGER COMPARISONS   | DETAILS                                       |
|-----------------------|-----------------------------------------------|
| `"$int1" -eq "$int2"` | True if the integers are equal                |
| `"$int1" -ne "$int2"` | True if the integers are not equal            |
| `"$int1" -gt "$int2"` | True if int1 is greater than int 2            |
| `"$int1" -ge "$int2"` | True if int1 is greater than or equal to int2 |
| `"$int1" -lt "$int2"` | True if int1 is less than int 2               |
| `"$int1" -le "$int2"` |  True if int1 is less than or equal to int    |
