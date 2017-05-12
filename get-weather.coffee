command: " 
weather=$(curl --silent 'http://wxdata.weather.com/wxdata/weather/local/NZXX0738?unit=m&dayf=10&cc=*');
echo $weather;
";

refreshFrequency: '30m';

style: """
  width: 100%;
  color: #fff; 
  font-family: Helvetica Neue;
  top: 300px;
  .weather
    margin-left: auto;
    margin-right: auto;
  .center
    text-align: center;
  .icon
    background-position: right top;
    background-repeat: no-repeat;
    background-size: 140px;
    width: 200px;
    height: 180px;
    display: inline-block;
    margin-left: -300px;
  .current-weather
    display: inline-block;
    position: absolute;
    height: 180px;
    top: 20px;
    padding-left: 10px;
  .current-temp
    font-size: 7em;
  .current-high
    position: relative;
    bottom: 61px;
    left: 7px;
    font-size: 1.5em;
  .current-low
    position: relative;
    bottom: 38px;
    left: -28px;
    font-size: 1.5em;
    color: rgba(#fff, .5); 
  .current-text
    display: block;
    font-size: 3em;
    color: rgba(#fff, .8); 
    font-weight: bold;
    text-align: center;
  .current-feelslike
    display: block;
    font-size: 2em;
    color: rgba(#fff, .6);
    text-align: center;
    padding: 10px 0 45px;
  table
    color: rgba(#fff, .8); 
    font-size: .9em;
    margin: 0 auto;
"""

render: (output) -> """
<div class="weather">
<div class="center">
<div class="icon"></div>
<div class="current-weather">
  <span class='current-temp'></span><span class='current-high'></span><span class='current-low'></span>
</div>
</div>
<span class='current-text'></span><span class='current-feelslike'></span>
<table> 
<tr> 
  <td width=62px>Sunrise</td><td width=0px>:</td><td width=175px class='sunrise'></td><td width=140px class='day-1'></td><td width=10px>:</td><td class='low-1'></td><td width=30px class='high-1'></td><td class='text-1'></td> 
</tr> 
<tr> 
  <td>Sunset</td><td>:</td><td class='sunset'></td><td class='day-2'></td><td>:</td><td class='low-2'></td><td class='high-2'></td><td class='text-2'></td> 
</tr> 
<tr> 
  <td>Wind</td><td>:</td><td class='wind'></td><td class='day-3'></td><td>:</td><td class='low-3'></td><td class='high-3'></td><td class='text-3'></td> 
</tr> 
<tr> 
  <td>Pressure</td><td>:</td><td class='pressure'></td><td class='day-4'></td><td>:</td><td class='low-4'></td><td class='high-4'></td><td class='text-4'></td> 
</tr> 
<tr> 
  <td>Humidity</td><td>:</td><td class='humidity'></td><td class='day-5'></td><td>:</td><td class='low-5'></td><td class='high-5'></td><td class='text-5'></td> 
</tr> 
<tr> 
  <td>Visibility</td><td>:</td><td class='visibility'></td><td class='day-6'></td><td>:</td><td class='low-6'></td><td class='high-6'></td><td class='text-6'></td> 
</tr>
<tr> 
  <td>Precipitation</td><td>:</td><td class='precipitation'></td><td class='day-7'></td><td>:</td><td class='low-7'></td><td class='high-7'></td><td class='text-7'></td> 
</tr>
<tr> 
  <td>UV Index</td><td>:</td><td class='uv'></td><td class='day-8'></td><td>:</td><td class='low-8'></td><td class='high-8'></td><td class='text-8'></td> 
</tr>
</table>
</div>
"""

afterRender: ->

update: (output) ->
  if !output
    $('#weather').hide()
  else
    xmlDoc = $.parseXML(output);
    $xml = $( xmlDoc );

    # Fine
    if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "33" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "34" )
      $('.icon').css('background-image', 'url(get-weather/icons/2.svg)');
    # Partly Cloudy
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "29" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "30")
      $('.icon').css('background-image', 'url(get-weather/icons/8.svg)');
    # Mostly Cloudy
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "27" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "28" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "26")
      $('.icon').css('background-image', 'url(get-weather/icons/25.svg)');
    # Light Rain
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "11" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "45" || $xml.find( "cc" ).find( "icon" ).eq(0).text() == "9")
      $('.icon').css('background-image', 'url(get-weather/icons/17.svg)');
    # Heavy Rain
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "12")
      $('.icon').css('background-image', 'url(get-weather/icons/18.svg)');
    # Thunder Storm
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "")
      $('.icon').css('background-image', 'url(get-weather/icons/27.svg)');
    # Windy
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "")
      $('.icon').css('background-image', 'url(get-weather/icons/6.svg)');
    # Fog, Smoke, Haze
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "")
      $('.icon').css('background-image', 'url(get-weather/icons/5.svg)');
    # Hail, Snow
    else if ($xml.find( "cc" ).find( "icon" ).eq(0).text() == "")
      $('.icon').css('background-image', 'url(get-weather/icons/24.svg)');
    else
      $('.icon').html('Update Icon');

    $( ".current-temp" ).html($xml.find( "cc" ).find( "tmp" ).text()).append("\xB0");
    $( ".current-high" ).html($xml.find( "day" ).eq(0).find( "hi" ).text()).append("\xB0");
    $( ".current-low" ).html($xml.find( "day" ).eq(0).find( "low" ).text()).append("\xB0");
    $( ".current-text" ).html($xml.find( "cc" ).find( "t" ).eq(0).text());
    $( ".current-feelslike" ).html("Feels like ").append($xml.find( "cc" ).find( "flik" ).eq(0).text()).append("\xB0");

    $( ".sunrise" ).html($xml.find( "loc" ).find( "sunr" ).text());
    $( ".day-1" ).html($xml.find( "day" ).eq(1).attr("t")).append(", ").append($xml.find( "day" ).eq(1).attr("dt"));
    $( ".low-1" ).html($xml.find( "day" ).eq(1).find( "low" ).text()).append("\xB0 - ");
    $( ".high-1" ).html($xml.find( "day" ).eq(1).find( "hi" ).text()).append("\xB0");
    $( ".text-1" ).html($xml.find( "day" ).eq(1).find( "part" ).find( "t" ).eq(0).text());

    $( ".sunset" ).html($xml.find( "loc" ).find( "suns" ).text());
    $( ".day-2" ).html($xml.find( "day" ).eq(2).attr("t")).append(", ").append($xml.find( "day" ).eq(2).attr("dt"));
    $( ".low-2" ).html($xml.find( "day" ).eq(2).find( "low" ).text()).append("\xB0 - ");
    $( ".high-2" ).html($xml.find( "day" ).eq(2).find( "hi" ).text()).append("\xB0");
    $( ".text-2" ).html($xml.find( "day" ).eq(2).find( "part" ).find( "t" ).eq(0).text());

    $( ".wind" ).html($xml.find( "cc" ).find( "wind" ).find( "s" ).text()).append(" km/h (").append($xml.find( "cc" ).find( "wind" ).find( "t" ).text()).append(")");
    $( ".day-3" ).html($xml.find( "day" ).eq(3).attr("t")).append(", ").append($xml.find( "day" ).eq(3).attr("dt"));
    $( ".low-3" ).html($xml.find( "day" ).eq(3).find( "low" ).text()).append("\xB0 - ");
    $( ".high-3" ).html($xml.find( "day" ).eq(3).find( "hi" ).text()).append("\xB0");
    $( ".text-3" ).html($xml.find( "day" ).eq(3).find( "part" ).find( "t" ).eq(0).text());

    $( ".pressure" ).html($xml.find( "cc" ).find( "bar" ).find( "r" ).text()).append(" mb");
    $( ".day-4" ).html($xml.find( "day" ).eq(4).attr("t")).append(", ").append($xml.find( "day" ).eq(4).attr("dt"));
    $( ".low-4" ).html($xml.find( "day" ).eq(4).find( "low" ).text()).append("\xB0 - ");
    $( ".high-4" ).html($xml.find( "day" ).eq(4).find( "hi" ).text()).append("\xB0");
    $( ".text-4" ).html($xml.find( "day" ).eq(4).find( "part" ).find( "t" ).eq(0).text());

    $( ".humidity" ).html($xml.find( "cc" ).find( "hmid" ).text()).append("%");
    $( ".day-5" ).html($xml.find( "day" ).eq(5).attr("t")).append(", ").append($xml.find( "day" ).eq(5).attr("dt"));
    $( ".low-5" ).html($xml.find( "day" ).eq(5).find( "low" ).text()).append("\xB0 - ");
    $( ".high-5" ).html($xml.find( "day" ).eq(5).find( "hi" ).text()).append("\xB0");
    $( ".text-5" ).html($xml.find( "day" ).eq(5).find( "part" ).find( "t" ).eq(0).text());

    $( ".visibility" ).html($xml.find( "cc" ).find( "vis" ).text()).append(" km");
    $( ".day-6" ).html($xml.find( "day" ).eq(6).attr("t")).append(", ").append($xml.find( "day" ).eq(6).attr("dt"));
    $( ".low-6" ).html($xml.find( "day" ).eq(6).find( "low" ).text()).append("\xB0 - ");
    $( ".high-6" ).html($xml.find( "day" ).eq(6).find( "hi" ).text()).append("\xB0");
    $( ".text-6" ).html($xml.find( "day" ).eq(6).find( "part" ).find( "t" ).eq(0).text());

    $today = new Date().getHours();

    if ($today >= 6 && $today <= 15)
      $( ".precipitation" ).html($xml.find( "day" ).eq(0).find( "part" ).eq(0).find( "ppcp" ).text()).append("%");
    else 
      $( ".precipitation" ).html($xml.find( "day" ).eq(0).find( "part" ).eq(1).find( "ppcp" ).text()).append("%");
    $( ".day-7" ).html($xml.find( "day" ).eq(7).attr("t")).append(", ").append($xml.find( "day" ).eq(7).attr("dt"));
    $( ".low-7" ).html($xml.find( "day" ).eq(7).find( "low" ).text()).append("\xB0 - ");
    $( ".high-7" ).html($xml.find( "day" ).eq(7).find( "hi" ).text()).append("\xB0");
    $( ".text-7" ).html($xml.find( "day" ).eq(7).find( "part" ).find( "t" ).eq(0).text());

    $( ".uv" ).html($xml.find( "cc" ).find( "uv" ).find( "i" ).text()).append(" (").append($xml.find( "cc" ).find( "uv" ).find( "t" ).text()).append(")");
    $( ".day-8" ).html($xml.find( "day" ).eq(8).attr("t")).append(", ").append($xml.find( "day" ).eq(8).attr("dt"));
    $( ".low-8" ).html($xml.find( "day" ).eq(8).find( "low" ).text()).append("\xB0 - ");
    $( ".high-8" ).html($xml.find( "day" ).eq(8).find( "hi" ).text()).append("\xB0");
    $( ".text-8" ).html($xml.find( "day" ).eq(8).find( "part" ).find( "t" ).eq(0).text());

