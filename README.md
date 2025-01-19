[![Actions Status](https://github.com/lizmat/Promp-Expand/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Promp-Expand/actions) [![Actions Status](https://github.com/lizmat/Promp-Expand/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Promp-Expand/actions) [![Actions Status](https://github.com/lizmat/Promp-Expand/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Promp-Expand/actions)

NAME
====

Prompt::Expand - provide prompt expansion logic

SYNOPSIS
========

```raku
use Prompt::Expand;

say expand(":time: >");        # 19:24:11 >

say expand(":date: >", "NL");  # zon 19 jan 2025 >
```

DESCRIPTION
===========

The `Prompt::Expand` distribution provides the logic to expand a string (usually intended to be used as a prompt for user input) according to number of escape sequences (the format). As such it exports an `expand` subroutine that takes such a format, and returns the expanded string.

Expansion currently provided are:

  * ANSI color / formatting codes

  * strftime escape codes (if DateTime::strftime is installed)

  * emoji escape codes (if Text::Emoji is installed)

  * other generally useful escapes

Expansions involving date / time values, can be localized by specifying the language to be used, either as a string (e.g. `"NL"`) or as a custom [Locale::Dates](Locale::Dates) object.

EXPANSIONS
==========

ANSI color codes
----------------

Note that **not** all of these are supported everywhere!

<table class="pod-table">
<thead><tr>
<th>:text:</th> <th>function</th>
</tr></thead>
<tbody>
<tr> <td>normal</td> <td>reset to default</td> </tr> <tr> <td>bold</td> <td>switch on bold characters</td> </tr> <tr> <td>dim</td> <td>switch on dimmer characters</td> </tr> <tr> <td>italic</td> <td>switch on italic characters</td> </tr> <tr> <td>underline</td> <td>switch on underlined characters</td> </tr> <tr> <td>blink</td> <td>switch on blinking characters</td> </tr> <tr> <td>inverse</td> <td>switch on inverted characters</td> </tr> <tr> <td>hidden</td> <td>switch on showing spaces instead of characters</td> </tr> <tr> <td>strikethrough</td> <td>switch on strikethrough characters</td> </tr> <tr> <td>unbold</td> <td>switch off bold characters</td> </tr> <tr> <td>unitalic</td> <td>switch off italic characters</td> </tr> <tr> <td>ununderline</td> <td>switch off underlined characters</td> </tr> <tr> <td>uninverse</td> <td>switch off inverse characters</td> </tr> <tr> <td>black</td> <td>switch to black foreground</td> </tr> <tr> <td>red</td> <td>switch to red foreground</td> </tr> <tr> <td>green</td> <td>switch to green foreground</td> </tr> <tr> <td>yellow</td> <td>switch to yellow foreground</td> </tr> <tr> <td>blue</td> <td>switch to blue foreground</td> </tr> <tr> <td>magenta</td> <td>switch to magenta foreground</td> </tr> <tr> <td>cyan</td> <td>switch to cyan foreground</td> </tr> <tr> <td>white</td> <td>switch to white foreground</td> </tr> <tr> <td>default</td> <td>switch to default foreground</td> </tr> <tr> <td>BLACK</td> <td>switch to black background</td> </tr> <tr> <td>RED</td> <td>switch to red background</td> </tr> <tr> <td>GREEN</td> <td>switch to green background</td> </tr> <tr> <td>YELLOW</td> <td>switch to yellow background</td> </tr> <tr> <td>BLUE</td> <td>switch to blue background</td> </tr> <tr> <td>MAGENTA</td> <td>switch to magenta background</td> </tr> <tr> <td>CYAN</td> <td>switch to cyan background</td> </tr> <tr> <td>WHITE</td> <td>switch to white background</td> </tr> <tr> <td>DEFAULT</td> <td>switch to default background</td> </tr>
</tbody>
</table>

Raku escape sequences
---------------------

Besides most of the [standard Raku escape sequences](https://docs.raku.org/language/quoting#Interpolating_escape_codes) with an associated `:text:` equivalent, also some other more interactive prompt related `:text` sequences:

<table class="pod-table">
<thead><tr>
<th>escape</th> <th>:text:</th> <th>function</th>
</tr></thead>
<tbody>
<tr> <td>\a</td> <td>bell</td> <td>audible / visible alert</td> </tr> <tr> <td>\b</td> <td>bksp</td> <td>backspace</td> </tr> <tr> <td>\e</td> <td>escape</td> <td>initiate ANSI escape sequence</td> </tr> <tr> <td>\f</td> <td>formfeed</td> <td>form feed (FF)</td> </tr> <tr> <td>\c</td> <td>reset</td> <td>reset to all ANSI defaults</td> </tr> <tr> <td>\n</td> <td>lf</td> <td>line feed (LF, newline, $?NL)</td> </tr> <tr> <td>\r</td> <td>cr</td> <td>Carriage Return (CR)</td> </tr> <tr> <td>\t</td> <td>tab</td> <td>tab</td> </tr> <tr> <td>\\</td> <td>bslash</td> <td>backslash</td> </tr> <tr> <td>| index</td> <td>$*INDEX value</td> <td></td> </tr> <tr> <td>| symbol</td> <td>$*SYMBOL value</td> <td></td> </tr> <tr> <td>| language</td> <td>language version</td> <td></td> </tr> <tr> <td>| release</td> <td>compiler release</td> <td></td> </tr> <tr> <td>| compiler</td> <td>compiler version</td> <td></td> </tr>
</tbody>
</table>

If the [`DateTime::strftime`](https://raku.land/zef:lizmat/DateTime::strftime) is installed:

<table class="pod-table">
<thead><tr>
<th>Code</th> <th>:text:</th> <th>Value</th>
</tr></thead>
<tbody>
<tr> <td>%a</td> <td>wkdname</td> <td>abbreviated weekday name</td> </tr> <tr> <td>%A</td> <td>weekdayname</td> <td>full weekday name</td> </tr> <tr> <td>%b</td> <td>mnthname</td> <td>abbreviated month name</td> </tr> <tr> <td>%B</td> <td>monthname</td> <td>full month name</td> </tr> <tr> <td>%c</td> <td>datetime</td> <td>preferred date/time representation</td> </tr> <tr> <td>%C</td> <td>century</td> <td>century number (year div 100)</td> </tr> <tr> <td>%d</td> <td>0day</td> <td>day of month (&quot;01&quot; .. &quot;31&quot;)</td> </tr> <tr> <td>%D</td> <td>usadate</td> <td>short for: %m/%d/%y</td> </tr> <tr> <td>%e</td> <td>day</td> <td>day of month (&quot; 1&quot; .. &quot;31&quot;)</td> </tr> <tr> <td>%f</td> <td></td> <td>same as %M</td> </tr> <tr> <td>%F</td> <td>isodate</td> <td>short for: %Y/%m/%d</td> </tr> <tr> <td>%g</td> <td>weekYY</td> <td>YY of this week (&quot;00&quot; .. &quot;99&quot;)</td> </tr> <tr> <td>%G</td> <td>weekYYYY</td> <td>full year of this week</td> </tr> <tr> <td>%h</td> <td></td> <td>same as %b</td> </tr> <tr> <td>%H</td> <td>0hour</td> <td>24-hour hour (&quot;00&quot; .. &quot;23&quot;)</td> </tr> <tr> <td>%I</td> <td>0amhour</td> <td>12-hour hour (&quot;01&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%j</td> <td>yearday</td> <td>day of the year (&quot;001&quot; .. &quot;366&quot;)</td> </tr> <tr> <td>%k</td> <td>hour</td> <td>24-hour hour (&quot; 1&quot; .. &quot;23&quot;)</td> </tr> <tr> <td>%l</td> <td>amhour</td> <td>12-hour hour (&quot; 1&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%L</td> <td></td> <td>same as %Y</td> </tr> <tr> <td>%m</td> <td>month</td> <td>month (&quot;01&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%M</td> <td>minute</td> <td>minute (&quot;00&quot; .. &quot;59&quot;)</td> </tr> <tr> <td>%n</td> <td>newline</td> <td>&quot;\n&quot;</td> </tr> <tr> <td>%p</td> <td>AMPM</td> <td>&quot;AM&quot; | &quot;PM&quot;</td> </tr> <tr> <td>%P</td> <td>ampm</td> <td>&quot;am&quot; | &quot;pm&quot;</td> </tr> <tr> <td>%r</td> <td>amtime</td> <td>short for: %I:%M:%S %p</td> </tr> <tr> <td>%R</td> <td>HHMM</td> <td>short for: %H:%M</td> </tr> <tr> <td>%s</td> <td>epoch</td> <td>seconds since epoch (midnight 1970-01-01 UTC)</td> </tr> <tr> <td>%S</td> <td>second</td> <td>second (&quot;00&quot; .. &quot;59&quot;)</td> </tr> <tr> <td>%t</td> <td>tab</td> <td>&quot;\t&quot;</td> </tr> <tr> <td>%T</td> <td>HHMMSS</td> <td>short for: %H:%M:%S</td> </tr> <tr> <td>%u</td> <td>weekday</td> <td>weekday (1 .. 7)</td> </tr> <tr> <td>%U</td> <td>weekSun</td> <td>week number (first Sunday) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%v</td> <td>DD-MON-YYYY</td> <td>short for: %e-%b-%Y</td> </tr> <tr> <td>%V</td> <td>weekISO</td> <td>week number (ISO 8601) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%w</td> <td>0weekday</td> <td>weekday (0 .. 6)</td> </tr> <tr> <td>%W</td> <td>weekMon</td> <td>week number (first Monday) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%x</td> <td>date</td> <td>preferred date representation</td> </tr> <tr> <td>%X</td> <td>time</td> <td>preferred time representation</td> </tr> <tr> <td>%y</td> <td>YY</td> <td>year without century (&quot;00&quot; .. &quot;99&quot;)</td> </tr> <tr> <td>%Y</td> <td>year</td> <td>year (yyyy)</td> </tr> <tr> <td>%z</td> <td>tzoffset</td> <td>numeric timezone (±HHMM)</td> </tr> <tr> <td>%Z</td> <td>timezone</td> <td>timezone (no name: %z)</td> </tr> <tr> <td>%+</td> <td>unixdate</td> <td>short for: %a %b %e %T %Z %G</td> </tr> <tr> <td>%%</td> <td>percent</td> <td>&quot;%&quot;</td> </tr>
</tbody>
</table>

If the [`Text::Emoji`](https://raku.land/zef:lizmat/Text::Emoji), all of the *1870* conversions are supported.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Prompt-Expand . Comments and Pull Requests are welcome.

If you like this module, or what I'm doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

