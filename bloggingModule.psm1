  <#
  .SYNOPSIS
  writes #readhostinput to a temp file for better copy/paste/format experience
  .DESCRIPTION
  solves the problem of an ugly mess of text being output for copy/paste by the get-articletagsanddatetime function!
  .EXAMPLE
  Copy-BlogEntryHtml $blogEntry
  .EXAMPLE
  Copy-BlogEntryHtml Read-Host
  .PARAMETER readhostinput
  the blog entry that needs preparation for publishing online
  #
  #>
  Function Copy-BlogEntryHtml
  {
      [CmdletBinding()]
      Param(
          [Parameter(Mandatory=$true)][String]$readhostinput
      )
      $readhostinput | clip
  }
  
  <#
  .SYNOPSIS
  public function to create blog entry #readhostinput with just one action for user to take
  .DESCRIPTION
  allows you to get a blog post more easily, using all other functions in module so far
  .EXAMPLE
  Get-BlogEntryOneStep
  #
  #>
Function Get-BlogEntryOneStep
{
    [CmdletBinding()]
    Param(
        [switch]$inGUI
    )

	."$PSScriptRoot\Get-ArticleTagsAndDatetime.ps1"
    if($inGUI.IsPresent) {
	    ."$PSScriptRoot\Get-BloggingModuleGUI.ps1"
        $stepOne = Get-BloggingModuleGUI
		$stepTwo = Get-ArticleTagsAndDatetime $stepOne
		Copy-BlogEntryHtml $stepTwo
		[System.Windows.MessageBox]::Show('Paste (Ctrl+v) in the editor of your choice.')
    }
    else {
	    ."$PSScriptRoot\Get-BlogEntry.ps1"
        $stepOne = Get-BlogEntry
		$stepTwo = Get-ArticleTagsAndDatetime $stepOne
		Copy-BlogEntryHtml $stepTwo
		Write-Host "Paste (Ctrl+v) in the editor of your choice."
    }
	 
}

Export-ModuleMember -Function Get-BlogEntryOneStep

