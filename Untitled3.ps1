<#
 .Synopsis
  One of two functions used for testing purposes

 .Description
  Used with Untitled4.ps1 for testing purposes, Untitled3 uses dot notation to call Untitled4 and sends a string to satisfy a mandatory parameter requirement; this was used for testing version 1.0 of the bloggingModule in order to ensure that the new GUI function could be called successfully from within bloggingModule.psm1.
  
 .Example
   # Display the input string $OptionalParam along with other predetermined text, as well as what the current $PSScriptRoot value is.
   > . .\Untitled3.ps1
   PS C:\Users\lmartinez\Documents\lmmportfolioparty\powershell\bloggingModule> . .\Untitled3.ps1
   psscriptroot is C:\Users\lmartinez\Documents\lmmportfolioparty\powershell\bloggingModule
   optionalParam already set to blah
   testing how a string comes out with the psscriptroot var: C:\Users\lmartinez\Documents\lmmportfolioparty\powershell\bloggi
   experimenting with adding something to the psscriptroot path so that I can use it to get to another file in the same dir:
   blah
   woohoo, I say! What did you say?: blah
#>
"psscriptroot is " + $PSScriptRoot

$theOptionalParam = "blah"
"optionalParam already set to " + $theOptionalParam

"testing how a string comes out with the psscriptroot var: " + "$PSScriptRoot\Untitled.ps1"

write-host "experimenting with adding something to the psscriptroot path so that I can use it to get to another file in the same dir: "
. .\Untitled4.ps1
Untitled4 -OptionalParam $theOptionalParam