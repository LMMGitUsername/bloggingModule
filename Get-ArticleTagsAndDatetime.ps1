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
Function Get-ArticleTagsAndDatetime( [String]$readhostinput )
{
    Param( [String]$readhostinput ) 
	
    $articleTemplate = '<article>`n<h1><time datetime="' + $(Get-Date -Format "yyyy-MM-dd hh:mm:ss") + '">' + (get-date).toLongDateString() + '</time></h1>`n<p>' + $readhostinput + '</p></article>'
	
	$articleTemplate
}

