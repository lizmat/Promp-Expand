use DateTime::strftime:ver<0.0.2+>:auth<zef:lizmat>;
use Text::Emoji:ver<0.0.7+>:auth<zef:lizmat>;

# These don't change over the lifetime of a process
my $release  = $*RAKU.compiler.version.Str.substr(0,7);
my $compiler = $*RAKU.compiler.version.gist;

my %dispatch =
  # ANSI color codes
  ':normal:',        "\x[1B][0m",
  ':bold:',          "\x[1B][1m",
  ':dim:',           "\x[1B][2m",
  ':italic:',        "\x[1B][3m",
  ':underline:',     "\x[1B][4m",
  ':blink:',         "\x[1B][5m",
  ':inverse:',       "\x[1B][7m",
  ':hidden:',        "\x[1B][8m",
  ':strikethrough:', "\x[1B][9m",
  ':unbold:',        "\x[1B][22m",
  ':unitalic:',      "\x[1B][23m",
  ':ununderline:',   "\x[1B][24m",
  ':uninverse:',     "\x[1B][27m",
  ':black:',         "\x[1B][30m",
  ':red:',           "\x[1B][31m",
  ':green:',         "\x[1B][32m",
  ':yellow:',        "\x[1B][33m",
  ':blue:',          "\x[1B][34m",
  ':magenta:',       "\x[1B][35m",
  ':cyan:',          "\x[1B][36m",
  ':white:',         "\x[1B][37m",
  ':default:',       "\x[1B][39m",
  ':BLACK:',         "\x[1B][40m",
  ':RED:',           "\x[1B][41m",
  ':GREEN:',         "\x[1B][42m",
  ':YELLOW:',        "\x[1B][43m",
  ':BLUE:',          "\x[1B][44m",
  ':MAGENTA:',       "\x[1B][45m",
  ':CYAN:',          "\x[1B][46m",
  ':WHITE:',         "\x[1B][47m",
  ':DEFAULT:',       "\x[1B][49m",

  # Raku escape sequences
  '\a',         "\a", 
  ':bell:',     "\a",
  '\b',         "\b", 
  ':bksp:',     "\b",
  '\e',         "\x[1B]",
  ':escape:',   "\x[1B]",
  '\f',         "\f",
  ':formfeed:', "\f",
  '\c',         "\x[1B][0m",
  ':reset:',    "\x[1B][0m",
  '\n',         "\n",
  ':lf:',       "\n",
  '\r',         "\r",
  ':cr:',       "\r",
  '\t',         "\t",
  ':tab:',      "\t",
  '\\\\',       "\\",
  ':bslash:',   "\\",
  ':release:',  $release,
  ':compiler:', $compiler,

  # other useful expansions
  ':index:',    -> { $*INDEX  // 0      },
  ':symbol:',   -> { $*SYMBOL // '> '   },
  ':language:', -> { $*RAKU.version.Str },
;

# Perform the actual expansion
my sub expand(
  Str:D  $format is copy,
        :$now,
        :$index  = CLIENT::<$*INDEX>  // 0,
        :$symbol = CLIENT::<$*SYMBOL> // '>',
        :$locale = 'EN',
--> Str:D) is export {

    my $*INDEX  := $index;
    my $*SYMBOL := $symbol;
    $format = $format.subst(/ [ '\\' \w ] | [ ':' <[\w-]>+ ':' ] /, {
        if %dispatch{$_} -> $to {
            $to ~~ Callable ?? $to() !! $to
        }
        else {
            .Str
        }
    }, :global);

    $format = strftime(($now // DateTime.now), $format, $locale)
      if &strftime;

    &to-emoji ?? to-emoji($format) !! $format
}

# vim: expandtab shiftwidth=4
