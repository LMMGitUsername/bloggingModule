  <#
  .SYNOPSIS
  helper function to check the last h1 dateheader tag in my journal online at lmmportfolio.party
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