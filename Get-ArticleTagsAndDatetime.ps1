 <#
  .SYNOPSIS
  function to wrap raw blog entry input in the correct html article tags for my journal.
  .DESCRIPTION
  this function not only wraps my text entries in the necessary outer html tags but also should be looking at all of the h1 dateHeader class members to know whether it should be announcing the beginning of a new day's worth of journal entries.
  .EXAMPLE
  Get-ArticleTagsAndDatetime $journalEntryText
  .PARAMETER journalEntryText
  the blog entry thad needs preparation for publishing online
  #
  #>
  Function Get-ArticleTagsAndDatetime
  {
    [CmdletBinding()]
    Param(
	    [Parameter(Mandatory=$true)][String]$journalEntryText
	)
	
	$currentDate = Get-Date
    $currentEntryHeader = $currentDate.toLongDateString()
	."$PSScriptRoot\Get-LastTimeHeadingInLmmportfolioJournal.ps1"
	
	$lastTimeHeader = Get-LastTimeHeadingInLmmportfolioJournal

	if($lastTimeHeader -match $currentEntryHeader)
	{
	    $wrapperStart = '<hr><section><h2 class="dateHeader"><time datetime="' + $currentDate.GetDateTimeFormats()[93] + '">'+ $currentDate.GetDateTimeFormats()[30] + '</time></h2><p>' + $journalEntryText + '</p></section>'
	}
	else
	{
	    $wrapperStart = '<hr><article><h1 class="dateHeader"><time datetime="' + $currentDate.GetDateTimeFormats()[93] + '">' + $currentDate.GetDateTimeFormats()[30] + '</time></h1><p>' + $journalEntryText + '</p></article>'
	}
	
	$wrapperStart 
	
  }
  
  <#
  .SYNOPSIS
  adds article and time tags to a blog entry #readhostinput
  .DESCRIPTION
  writes the <article> tags and makes sure the entry is sandwiched inside. also adds the <time> tag with datetime stamp!
  .EXAMPLE
  Get-ArticleTagsAndDatetime($blogEntry)
  .EXAMPLE
  Get-ArticleTagsAndDatetime(Read-Host)
  .PARAMETER readhostinput
  the blog entry that needs preparation for publishing online
  #
  #This comment template is from https://technet.microsoft.com/en-us/magazine/hh360993.aspx
  #
  #>
<#OLD VERSION NOT FROM PSM1 FILE: Function Get-ArticleTagsAndDatetime
{
    [CmdletBinding()] #https://www.itprotoday.com/powershell/what-does-powershells-cmdletbinding-do
    Param( 
        [Parameter(Mandatory=$true)][String]$readhostinput 
    ) 
	
    $articleTemplate = '<article>`n<h1><time datetime="' + $(Get-Date -Format "yyyy-MM-dd hh:mm:ss") + '">' + (get-date).toLongDateString() + '</time></h1>`n<p>' + $readhostinput + '</p></article>'
	
	$articleTemplate
}
#>


