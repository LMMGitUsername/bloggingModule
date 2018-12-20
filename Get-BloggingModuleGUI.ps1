<# COMMENT TEMPLATE FROM https://gallery.technet.microsoft.com/scriptcenter/PowerShell-Comment-Block-373a1d9b

A lot of web research went into this project! I should probably move this list out of here, but, for now, here are my references for this file.
Building Forms with PowerShell – Part 1 (The Form) https://blogs.technet.microsoft.com/stephap/2012/04/23/building-forms-with-powershell-part-1-the-form/ 
https://docs.microsoft.com/en-us/powershell/scripting/samples/creating-a-custom-input-box?view=powershell-6
https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.textbox?view=netframework-4.7.2
https://docs.microsoft.com/en-us/dotnet/framework/winforms/controls/how-to-anchor-controls-on-windows-forms
https://foxdeploy.com/series/learning-gui-toolmaking-series/
https://foxdeploy.com/2016/09/20/part-vi-in-depth-building-the-foxdeploy-dsc-designer/
https://social.msdn.microsoft.com/Forums/windows/en-US/df850ecc-ae99-45fb-9bb2-e58dffdcf148/autoresize-all-the-elements-when-form-resize?forum=winforms
https://powershelldevtools.wordpress.com/category/powershell/winforms/system-windows-forms-anchorstyles/

.SYNOPSIS experiment (for now, as of creation on 12/15/2018) to see how a GUI for my bloggingModule or bloggule might look and work. Neat! A dream come true, really!
 
 
.DESCRIPTION GUI for blogging module that I use to generate journal entries without having to write the same html over and over.
 
 
.NOTES 
+---------------------------------------------------------------------------------------------+ 
| ORIGIN STORY                                                                                | 
+---------------------------------------------------------------------------------------------+ 
|   DATE        : 2018.12.15 
|   AUTHOR      : lmmgitusername 
|   DESCRIPTION : Initial Draft 
+---------------------------------------------------------------------------------------------+  
 
#> 
Function Get-BloggingModuleGUI
{
    Add-Type -AssemblyName System.Windows.Forms

    $Form = New-Object System.Windows.Forms.Form
    $Form.Size = New-Object System.Drawing.Size(2000,1200)
    #"This is the size of the form, in pixels." wide, tall
    $Form.Text = "Bloggule 1.0"
    $Form.AutoSize = $True

    $Form.AutoSizeMode = "GrowAndShrink"
    # GrowAndShrink or GrowOnly
    $Form.Topmost = $true
    $Form.MinimizeBox = $true
    $Form.MaximizeBox = $false
    $Form.WindowState = "Normal"
    # Maximized, Minimized, Normal
    $Form.SizeGripStyle = "Show"
    # Auto, Hide, Show
    $Form.ShowInTaskbar = $True
    $Form.Opacity = 1.0
    # 1.0 is fully opaque; 0.0 is invisible
    $Form.StartPosition = "CenterScreen" 
    #"By setting the StartingPosition to CenterScreen, you’re automatically displaying the form in the middle of the screen each time it loads."
    # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent

    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "Type journal entry here:"
    $Label.AutoSize = $True

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Location = New-Object System.Drawing.Point(10,40)
    $textbox.Size = New-Object System.Drawing.Size(1000,400)
    #$textbox.AutoSize = $False
    $Font = New-Object System.Drawing.Font("Consolas",12,[System.Drawing.FontStyle]::Regular)
    $labelFont = New-Object System.Drawing.Font("Consolas",8,[System.Drawing.Fontstyle]::Regular)
    $textBoxFont = New-Object System.Drawing.Font("Consolas",20,[System.Drawing.FontStyle]::Regular)
    # Font styles are: Regular, Bold, Italic, Underline, Strikeout
    $Form.Font = $Font
    $Label.Font = $labelFont
    $textbox.Font = $textBoxFont
    $textbox.Multiline = $True #You must set the Multiline property to true to adjust the height of the TextBox control. You can adjust the height by setting the Size property.

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(800,500)
    $OKButton.Size = New-Object System.Drawing.Size(75,30)
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $OKButton.Font = $labelFont

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(875,500)
    $CancelButton.Size = New-Object System.Drawing.Size(100,30)
    $CancelButton.Text = 'Cancel'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $CancelButton.Font = $labelFont

    $Form.AcceptButton = $OKButton
    $Form.Controls.Add($OKButton)
    $Form.CancelButton = $CancelButton
    $Form.Controls.Add($CancelButton)
    $Form.Controls.Add($Label)
    $Form.Controls.Add($textbox)

    $Form.Add_Shown({$textBox.Select()})
    $Form.MinimizeBox = $True
    $Form.MaximizeBox = $True

    $OKButton.Anchor = [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Bottom #https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.anchorstyles?view=netframework-4.7.2
    $CancelButton.Anchor = [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Bottom
    $textbox.AcceptsReturn = $True
    #$textbox.Dock = [System.Windows.Forms.DockStyle]::Fill; #from https://powershelldevtools.wordpress.com/category/powershell/winforms/system-windows-forms-dockstyle/
    $textbox.Anchor = [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left

    #https://docs.microsoft.com/en-us/dotnet/framework/winforms/controls/margin-and-padding-in-windows-forms-controls

    $result = $Form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textbox.Text
        $x
    }
}
