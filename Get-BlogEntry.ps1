  <#
  .SYNOPSIS
  function to create blog entry #readhostinput
  .DESCRIPTION
  allows you to get a blog post
  .EXAMPLE
  Get-BlogEntry()
  #
  #This comment template is from https://technet.microsoft.com/en-us/magazine/hh360993.aspx
  #
  #>
Function Get-BlogEntry
{
    Write-Host "Start typing."
	$readhostinput = Read-Host
	
	$readhostinput
}

