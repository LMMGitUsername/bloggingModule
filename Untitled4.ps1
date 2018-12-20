<#
 .Synopsis
  One of two functions used for testing purposes, the other being Untitled3.ps1

 .Description
  Used with Untitled3.ps1 for testing purposes, Untitled4 is called by use of dot notation by Untitled3.ps1 to receive its mandatory string parameter in the form of a hardcoded string sent by Untitled3; this was used for testing version 1.0 of the bloggingModule in order to ensure that the new GUI function could be called successfully from within bloggingModule.psm1.

 .Parameter $OptionalParam
  A mandatory string parameter lol

 .Example
   # Display the input string $OptionalParam along with other predetermined text.
   > Untitled4 -OptionalParam "blah"
   blah
   woohoo, I say! What did you say?: blah
#>
Function Untitled4
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$OptionalParam
    )
    write-host $optionalParam
    "woohoo, I say! What did you say?: " + $OptionalParam
}