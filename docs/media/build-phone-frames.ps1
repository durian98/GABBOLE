# Requires Python with PyMuPDF for exporting the vector frame to PNG.
$ErrorActionPreference = 'Stop'
$mediaPath = $PSScriptRoot
$screenNames = @('trip-create', 'course-candidates', 'trip-timeline', 'assistant', 'travel-tools', 'feed')
Add-Type -AssemblyName System.Drawing
foreach ($screenName in $screenNames) {
    $sourcePath = Join-Path $mediaPath "$screenName.jpg"
    $sourceImage = [System.Drawing.Image]::FromFile($sourcePath)
    $sourceWidth = $sourceImage.Width
    $sourceHeight = $sourceImage.Height
    $sourceImage.Dispose()
    # The three presentation crops already include part of a device bezel.
    $inset = if ($screenName -in @('trip-create', 'course-candidates', 'trip-timeline')) { 14 } else { 0 }
    $contentWidth = $sourceWidth - 2 * $inset
    $contentHeight = $sourceHeight - 2 * $inset
    $scaleX = 560 / $contentWidth
    $scaleY = 1214 / $contentHeight
    $imageX = (24 - $inset * $scaleX).ToString([Globalization.CultureInfo]::InvariantCulture)
    $imageY = (24 - $inset * $scaleY).ToString([Globalization.CultureInfo]::InvariantCulture)
    $imageWidth = ($sourceWidth * $scaleX).ToString([Globalization.CultureInfo]::InvariantCulture)
    $imageHeight = ($sourceHeight * $scaleY).ToString([Globalization.CultureInfo]::InvariantCulture)
    $embeddedImage = [Convert]::ToBase64String([IO.File]::ReadAllBytes($sourcePath))
    $frameSvg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="608" height="1262" viewBox="0 0 608 1262">
  <title>GABOLLE — $screenName</title>
  <defs><clipPath id="screen"><path d="M82 24H526A58 58 0 0 1 584 82V1180A58 58 0 0 1 526 1238H82A58 58 0 0 1 24 1180V82A58 58 0 0 1 82 24Z"/></clipPath></defs>
  <rect width="608" height="1262" fill="#ffffff"/>
  <rect x="12" y="12" width="584" height="1238" rx="70" fill="#202124"/>
  <g>
    <image x="$imageX" y="$imageY" width="$imageWidth" height="$imageHeight" preserveAspectRatio="none" xlink:href="data:image/jpeg;base64,$embeddedImage"/>
  </g>
  <path fill="#202124" fill-rule="evenodd" d="M82 12H526A70 70 0 0 1 596 82V1180A70 70 0 0 1 526 1250H82A70 70 0 0 1 12 1180V82A70 70 0 0 1 82 12Z M82 24H526A58 58 0 0 1 584 82V1180A58 58 0 0 1 526 1238H82A58 58 0 0 1 24 1180V82A58 58 0 0 1 82 24Z"/>
  <path fill="#ffffff" fill-rule="evenodd" d="M0 0H608V1262H0Z M82 12H526A70 70 0 0 1 596 82V1180A70 70 0 0 1 526 1250H82A70 70 0 0 1 12 1180V82A70 70 0 0 1 82 12Z"/>
</svg>
"@
    $svgPath = Join-Path $mediaPath "$screenName-phone.svg"
    $pngPath = Join-Path $mediaPath "$screenName-phone.png"
    [IO.File]::WriteAllText($svgPath, $frameSvg, [Text.UTF8Encoding]::new($false))
    python -c 'import sys, pymupdf; doc = pymupdf.open(sys.argv[1]); doc[0].get_pixmap().save(sys.argv[2])' $svgPath $pngPath
    if ($LASTEXITCODE -ne 0) { throw "PNG export failed: $screenName" }
    Remove-Item -LiteralPath $svgPath
}
