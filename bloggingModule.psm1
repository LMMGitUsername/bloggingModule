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
  helper function to know whether $readhostinput is empty or not. This fixes the bug that occurs currently when closing without having typed anything into the get-blogentryonenpost
  .DESCRIPTION
  asks for confirmation that blog entry is ready to be copied for pasting; fixes problem caused by accidentally entering an incomplete entry by maybe accidentally hitting the Return key too soon? It has happened to me and has been frustrating so I thought I'd include a final confirmtaion request, ya know? here is a reference that helped, too! https://stackoverflow.com/questions/24649019/how-to-use-confirm-in-powershell
  .EXAMPLE
  Get-Confirmation $aString
  "Are you sure you are done with the blog entry? Type y(es) for yes, you are done, or, type n(o) for no." 
  #
  #>  
  Function Get-Confirmation
  {
      [CmdletBinding()]
	  Param(
	      [string]$blogEntry
	  )
	  
	  Write-Host "Are you sure you are done with the blog entry? Type y(es) for yes, you are done, or, type n(o) for no."
	  
	  
	    
  }	  
  
  <#
  .SYNOPSIS
  helper function to know whether $readhostinput is empty or not. This fixes the bug that occurs currently when closing without having typed anything into the get-blogentryonenpost
  .DESCRIPTION
  allows you to get a blog post more easily, using all other functions in module so far
  .EXAMPLE
  Check-ForBlankBlogEntry $aString
  
  #
  #>  
  Function Check-ForBlankBlogEntry
  {
      [CmdletBinding()]
	  Param(
	      [string]$blogEntry
	  )
	  
	  if(!$blogEntry) #then string is null; learned this trick from https://www.thomasmaurer.ch/2010/07/powershell-check-variable-for-null/ and also https://stackoverflow.com/questions/24649019/how-to-use-confirm-in-powershell
	  {
	      Write-Host "Blog entry is empty. Would you like to "
	  }
	  
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
		Add-Type -AssemblyName PresentationFramework #https://social.technet.microsoft.com/Forums/en-US/5388624d-73d1-46d5-9944-d9143af50ca2/unable-to-find-type-systemwindowsmessagebox-runs-in-ise-but-not-from-powershell?forum=winserverpowershell
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

