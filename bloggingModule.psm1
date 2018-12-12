  <#
  .SYNOPSIS
  adds article and time tags to a blog entry #readhostinput
  .DESCRIPTION
  writes the <article> tags and makes sure the entry is sandwiched inside. also adds the <time> tag with datetime stamp!
  .EXAMPLE
  Get-BlogEntryHtml $blogEntry
  .EXAMPLE
  Get-BlogEntryHtml Read-Host
  .PARAMETER readhostinput
  the blog entry that needs preparation for publishing online
  #
  #This comment template is from https://technet.microsoft.com/en-us/magazine/hh360993.aspx
  #
  #>
Function Get-BlogEntryHtml( [String]$readhostinput )
{	
    $currentEntryHeader = (get-date).toLongDateString()
	
    if(Get-LastTimeHeadingInLmmportfolioJournal -eq $currentEntryHeader)
	{
	    $articleTemplate = '<hr><article><time datetime="' + $(Get-Date -Format "yyyy-MM-dd hh:mm:ss") + '"></time><p>' + $readhostinput + '</p></article>'
	}
	else
	{
	    $articleTemplate = '<article><h1><time datetime="' + $(Get-Date -Format "yyyy-MM-dd hh:mm:ss") + '">' + $currentEntryHeader + '</time></h1><p>' + $readhostinput + '</p></article>'
	}
	
	$articleTemplate
}

  <#
  .SYNOPSIS
  function to create blog entry #readhostinput
  .DESCRIPTION
  allows you to get a blog post
  .EXAMPLE
  Get-BlogEntryPlaintext
  #
  #>
Function Get-BlogEntryPlaintext
{
    Write-Host "Start typing."
	$readhostinput = Read-Host
	
	$readhostinput
}

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
  Function Copy-BlogEntryHtml( [String]$readhostinput )
  {
      $readhostinput | clip
	  Write-Host "Paste (Ctrl+v) in the editor of your choice."
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
    $stepOne = Get-BlogEntryPlaintext
	$stepTwo = Get-BlogEntryHtml $stepOne
	Copy-BlogEntryHtml $stepTwo
}

  <#
  .SYNOPSIS
  function to check the last h1 dateheader tag in my journal online at lmmportfolio.party
  .DESCRIPTION
  helper function to prevent multiples of the same day heading for different entries on same day in my journal
  .EXAMPLE
  Get-LastTimeHeadingInLmmportfolioJournal
  #
  #>
Function Get-LastTimeHeadingInLmmportfolioJournal
{
    $url = "http://lmmportfolio.party/otherPages/journal.php"
	$html = Invoke-WebRequest -Uri $url
	($html.ParsedHtml.getElementsByTagName("h1") | Where{$_.className -eq 'dateHeader'}).innerText | select -Last 1
}


Export-ModuleMember -Function Get-BlogEntryOneStep

