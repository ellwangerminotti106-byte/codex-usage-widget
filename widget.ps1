[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
Add-Type -AssemblyName PresentationFramework
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Codex Usage Widget" Width="395" SizeToContent="Height"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Topmost="True" ResizeMode="NoResize"
        WindowStartupLocation="Manual" Left="80" Top="80">
  <Border CornerRadius="18" BorderBrush="#E67E22" BorderThickness="2" Padding="22,16,18,10">
    <Border.Background>
      <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
        <GradientStop Color="#FFFDF3D0" Offset="0"/>
        <GradientStop Color="#FFFFD54F" Offset="0.55"/>
        <GradientStop Color="#FFFFB300" Offset="1"/>
      </LinearGradientBrush>
    </Border.Background>
    <StackPanel>
      <Grid>
        <TextBlock Text="⚡ CODEX 用量监控" Foreground="#7B3F00"
                   FontSize="12" FontWeight="Bold" VerticalAlignment="Center"/>
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
          <Button x:Name="BtnRefresh" Content="⟳" FontSize="14" Cursor="Hand"
                  Background="Transparent" BorderThickness="0" Foreground="#7B3F00" Padding="6,0"/>
          <Button x:Name="BtnClose" Content="✕" FontSize="12" Cursor="Hand"
                  Background="Transparent" BorderThickness="0" Foreground="#7B3F00" Padding="6,0"/>
        </StackPanel>
      </Grid>
      <Grid Margin="0,4,0,0">
        <Grid.ColumnDefinitions>
          <ColumnDefinition Width="*"/>
          <ColumnDefinition Width="112"/>
        </Grid.ColumnDefinitions>
        <StackPanel Grid.Column="0" Margin="0,0,10,0">
          <TextBlock x:Name="TxtCost" Text="--" Foreground="#D84315"
                     FontSize="40" FontWeight="Bold" Margin="0,4,0,0"/>
          <TextBlock x:Name="TxtTotal" Text="加载中..." Foreground="#5D4037"
                     FontSize="14" Margin="0,2,0,12"/>
          <Border Height="1" Background="#88FFFFFF" Margin="0,0,0,12"/>
          <Grid Margin="0,0,0,10">
            <Grid.ColumnDefinitions>
              <ColumnDefinition/><ColumnDefinition/><ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <StackPanel Grid.Column="0">
              <TextBlock Text="输入" Foreground="#8D6E63" FontSize="11"/>
              <TextBlock x:Name="TxtIn" Text="--" Foreground="#1565C0" FontSize="16" FontWeight="SemiBold"/>
            </StackPanel>
            <StackPanel Grid.Column="1">
              <TextBlock Text="输出" Foreground="#8D6E63" FontSize="11"/>
              <TextBlock x:Name="TxtOut" Text="--" Foreground="#8E24AA" FontSize="16" FontWeight="SemiBold"/>
            </StackPanel>
            <StackPanel Grid.Column="2">
              <TextBlock Text="缓存" Foreground="#8D6E63" FontSize="11"/>
              <TextBlock x:Name="TxtCache" Text="--" Foreground="#2E7D32" FontSize="16" FontWeight="SemiBold"/>
            </StackPanel>
          </Grid>
          <TextBlock x:Name="TxtModel" Text="" Foreground="#7B3F00" FontSize="11"
                     Margin="0,0,0,2" Visibility="Collapsed"/>
          <TextBlock x:Name="TxtTime" Text="" Foreground="#8D6E63" FontSize="11"/>
        </StackPanel>
        <Image x:Name="IconBolt" Grid.Column="1" Height="115"
               VerticalAlignment="Center" HorizontalAlignment="Center"
               Margin="0,8,0,0" IsHitTestVisible="False"/>
      </Grid>
      <Border Height="1" Background="#88FFFFFF" Margin="0,8,0,8"/>
      <Grid>
        <TextBlock Text="最近 7 天（有记录）" Foreground="#8D6E63" FontSize="11"/>
        <TextBlock x:Name="TxtMonth" Text="" Foreground="#7B3F00" FontSize="12"
                   FontWeight="SemiBold" HorizontalAlignment="Right"/>
      </Grid>
      <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,6,0,2">
        <Rectangle Width="8" Height="8" Fill="#1565C0" RadiusX="2" RadiusY="2" VerticalAlignment="Center"/>
        <TextBlock Text=" 输入   " FontSize="9" Foreground="#5D4037" VerticalAlignment="Center"/>
        <Rectangle Width="8" Height="8" Fill="#8E24AA" RadiusX="2" RadiusY="2" VerticalAlignment="Center"/>
        <TextBlock Text=" 输出   " FontSize="9" Foreground="#5D4037" VerticalAlignment="Center"/>
        <Rectangle Width="8" Height="8" Fill="#2E7D32" RadiusX="2" RadiusY="2" VerticalAlignment="Center"/>
        <TextBlock Text=" 缓存" FontSize="9" Foreground="#5D4037" VerticalAlignment="Center"/>
      </StackPanel>
      <StackPanel x:Name="PnlChart" Orientation="Horizontal"
                  HorizontalAlignment="Center" Margin="0,6,0,2"/>
      <TextBlock Text="本地用量统计 · 按日汇总" Foreground="#A0522D" FontSize="10"
                 FontStyle="Italic" Margin="0,4,0,4"/>
      <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,2,0,0">
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
        <Polygon Points="0,0 26,0 13,16" Fill="#E8FFFFFF" Margin="2,0"/>
      </StackPanel>
    </StackPanel>
  </Border>
</Window>
'@
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$TxtCost  = $window.FindName("TxtCost")
$TxtTotal = $window.FindName("TxtTotal")
$TxtIn    = $window.FindName("TxtIn")
$TxtOut   = $window.FindName("TxtOut")
$TxtCache = $window.FindName("TxtCache")
$TxtModel = $window.FindName("TxtModel")
$TxtTime  = $window.FindName("TxtTime")
$TxtMonth = $window.FindName("TxtMonth")
$PnlChart = $window.FindName("PnlChart")
$BtnClose   = $window.FindName("BtnClose")
$BtnRefresh = $window.FindName("BtnRefresh")
$IconBolt = $window.FindName("IconBolt")
$bc = New-Object System.Windows.Media.BrushConverter
$tt = New-Object System.Windows.Media.TranslateTransform
$IconBolt.RenderTransform = $tt
$anim = New-Object System.Windows.Media.Animation.DoubleAnimation(0, -8, [TimeSpan]::FromSeconds(1.2))
$anim.AutoReverse = $true
$anim.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
$anim.EasingFunction = New-Object System.Windows.Media.Animation.SineEase
$tt.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $anim)
function Get-Field($obj, $names) {
    foreach ($n in $names) {
        $p = $obj.PSObject.Properties[$n]
        if ($p -and $null -ne $p.Value) { return $p.Value }
    }
    return 0
}
function Get-CacheTokens($row) {
    return [double](Get-Field $row @("cachedInputTokens", "cacheReadTokens", "cacheReadInputTokens")) +
           [double](Get-Field $row @("cacheCreationTokens"))
}
function Format-Num($n) {
    $n = [double]$n
    if ($n -ge 1000000) { return ("{0:N1}M" -f ($n/1000000)) }
    if ($n -ge 1000)    { return ("{0:N1}K" -f ($n/1000)) }
    return ("{0:N0}" -f $n)
}
function New-SmallText($text, $color, $bold) {
    $t = New-Object System.Windows.Controls.TextBlock
    $t.Text = $text
    $t.FontSize = 9
    $t.HorizontalAlignment = "Center"
    $t.Foreground = $bc.ConvertFromString($color)
    if ($bold) { $t.FontWeight = "SemiBold" }
    return $t
}
function Refresh-Usage {
    try {
        $today = (Get-Date).Date
        $d7 = $today.AddDays(-6)
        $m1 = $today.AddDays(1 - $today.Day)
        $since = if ($d7 -lt $m1) { $d7 } else { $m1 }
        $raw = (& ccusage codex daily --since $since.ToString("yyyyMMdd") --json 2>$null) -join "`n"
        $data = $raw | ConvertFrom-Json
        $rows = @($data.daily)
        $tRow = $rows | Where-Object { (Get-Date $_.date).Date -eq $today } | Select-Object -First 1
        if ($tRow) {
            $TxtCost.Text  = "$" + ("{0:N2}" -f [double](Get-Field $tRow @("costUSD","cost","totalCost")))
            $TxtTotal.Text = ("{0:N0}" -f [double](Get-Field $tRow @("totalTokens"))) + " tokens"
            $TxtIn.Text    = Format-Num (Get-Field $tRow @("inputTokens"))
            $TxtOut.Text   = Format-Num (Get-Field $tRow @("outputTokens"))
            $TxtCache.Text = Format-Num (Get-CacheTokens $tRow)
            $models = @($tRow.modelsUsed) | Where-Object { $_ }
            if ($models.Count -eq 0) {
                $models = @($tRow.models | ForEach-Object { if ($_ -is [string]) { $_ } else { $_.model } }) | Where-Object { $_ }
            }
            if ($models.Count -gt 0) {
                $TxtModel.Text = "模型: " + ($models -join ", ")
                $TxtModel.Visibility = "Visible"
            } else { $TxtModel.Visibility = "Collapsed" }
        } else {
            $TxtCost.Text  = "$0.00"
            $TxtTotal.Text = "今天还没有使用记录"
            $TxtIn.Text = "0"; $TxtOut.Text = "0"; $TxtCache.Text = "0"
            $TxtModel.Visibility = "Collapsed"
        }
        $monthCost = 0.0
        foreach ($r in $rows) {
            if ((Get-Date $r.date).Date -ge $m1) {
                $monthCost += [double](Get-Field $r @("costUSD","cost","totalCost"))
            }
        }
        $TxtMonth.Text = "本月累计 $" + ("{0:N2}" -f $monthCost)
        $PnlChart.Children.Clear()
        $chartRows = @($rows | Where-Object { (Get-Date $_.date).Date -ge $d7 })
        $maxTok = 0.0
        foreach ($r in $chartRows) {
            $s = [double](Get-Field $r @("inputTokens")) +
                 [double](Get-Field $r @("outputTokens")) +
                 [double](Get-CacheTokens $r)
            if ($s -gt $maxTok) { $maxTok = $s }
        }
        if ($maxTok -le 0) { $maxTok = 1 }
        foreach ($r in $chartRows) {
            $c      = [double](Get-Field $r @("costUSD","cost","totalCost"))
            $tin    = [double](Get-Field $r @("inputTokens"))
            $tout   = [double](Get-Field $r @("outputTokens"))
            $tcache = [double](Get-CacheTokens $r)
            $sum    = $tin + $tout + $tcache
            $isToday = ((Get-Date $r.date).Date -eq $today)
            $col = New-Object System.Windows.Controls.StackPanel
            $col.Margin = New-Object System.Windows.Thickness(5,0,5,0)
            $col.VerticalAlignment = "Bottom"
            $hTot = [Math]::Max(4, [Math]::Round($sum / $maxTok * 60))
            $bar = New-Object System.Windows.Controls.StackPanel
            $bar.Width = 26
            $bar.HorizontalAlignment = "Center"
            if ($sum -gt 0) {
                foreach ($seg in @(
                    @{ v = $tout;   color = "#8E24AA" },
                    @{ v = $tin;    color = "#1565C0" },
                    @{ v = $tcache; color = "#2E7D32" })) {
                    if ($seg.v -gt 0) {
                        $rc = New-Object System.Windows.Shapes.Rectangle
                        $rc.Width = 26
                        $rc.Height = [Math]::Max(1, $seg.v / $sum * $hTot)
                        $rc.Fill = $bc.ConvertFromString($seg.color)
                        [void]$bar.Children.Add($rc)
                    }
                }
            }
            $bar.ToolTip = (Get-Date $r.date).ToString("yyyy-MM-dd") +
                "`n花费: $" + ("{0:N2}" -f $c) +
                "`n输入: " + ("{0:N0}" -f $tin) +
                "`n输出: " + ("{0:N0}" -f $tout) +
                "`n缓存: " + ("{0:N0}" -f $tcache)
            $dayLbl = New-SmallText ((Get-Date $r.date).ToString("M/d")) "#8D6E63" $isToday
            [void]$col.Children.Add((New-SmallText ("$" + ("{0:N0}" -f $c)) "#A0522D" $false))
            [void]$col.Children.Add($bar)
            [void]$col.Children.Add($dayLbl)
            [void]$col.Children.Add((New-SmallText (Format-Num $tin) "#1565C0" $false))
            [void]$col.Children.Add((New-SmallText (Format-Num $tout) "#8E24AA" $false))
            [void]$col.Children.Add((New-SmallText (Format-Num $tcache) "#2E7D32" $false))
            [void]$PnlChart.Children.Add($col)
        }
        $TxtTime.Text = "更新于 " + (Get-Date -Format "HH:mm:ss") + " · 每60秒自动刷新"
    } catch {
        $TxtCost.Text = "--"
        $TxtTotal.Text = "获取数据失败，请检查 ccusage 是否可用"
        $TxtIn.Text = "--"; $TxtOut.Text = "--"; $TxtCache.Text = "--"
        $TxtModel.Visibility = "Collapsed"
        $TxtMonth.Text = ""
        $PnlChart.Children.Clear()
    }
}
$BtnClose.Add_Click({ $window.Close() })
$BtnRefresh.Add_Click({ Refresh-Usage })
$window.Add_MouseLeftButtonDown({ try { $window.DragMove() } catch {} })
$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(60)
$timer.Add_Tick({ Refresh-Usage })
$timer.Start()
$window.Add_ContentRendered({ Refresh-Usage })
[void]$window.ShowDialog()
