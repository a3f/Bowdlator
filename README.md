# THIS IS WIP.
# Bowdlator

Bowdlator is an extensible [InputMethod](https://developer.apple.com/reference/inputmethodkit) for Mac OS X.

>**bowd**lerize _/bōd-lə-ˌrīz/_ <br>
>&emsp;&emsp; The omission or removal of material considered vulgar or indecent.

>trans**lator** _/ˈtɹænzleɪtɚ/_ <br>
>&emsp;&emsp; One that makes a new version of a source material in a different language or format.

## What is it?
Everything typed in, while the Bowdlator InputMethod is selected, is written into a unix domain socket at `/usr/local/var/run/bowdlator.sock`.

You can write scripts (called filters) that connect to the socket and transform the input.

## What could I use that for?
Check out the [`examples/`](https://github.com/a3f/Bowdlator/blob/master/examples) for sample filters. Following are currently included:
* [Bowdlerize.py](https://github.com/a3f/Bowdlator/blob/master/examples/Bowdlerize.py): automatically censors a select number of English cuss words
* [Vulgarize.rb](https://github.com/a3f/Bowdlator/blob/master/examples/Vulgarize.rb): automatically decensors a select number of English cuss words
* [caseFilter.c](): suggests the uppercase, lowercase and normal version while typing. Your pinky will thank you for it
* [Encode.pl](): Allows using an arbitary Perl [Encode]() module for filtering all entered words. 
* [TeX-Encode](https://github.com/a3f/Bowdlator/blob/master/examples/TeX-Encode): Translates a good chunk of `\texnotation` into Unicode. You enter `tex`-mode by `\` and leave it by pressing a non-printable key
* [Encode-Arabic-Franco](https://github.com/a3f/Bowdlator/blob/master/examples/Encode-Arabic-Franco): Translates Franco-Arabic/Arabizy/Chat-Arabic (a transliteration using Latin and numbers) into actual Arabic script using the [Encode::Arabic::Franco]() CPAN module

## Why? and How?
Microsoft's Cairo Research Lab wrote a fine piece of software called [Maren](https://www.microsoft.com/en-us/download/details.aspx?id=20530), offering JIT transliteration to actual Arabic:

Unfortunately, such a program doesn't exist for OS X, so I wrote this one. Prime goal was making it maximally extensible by allowing arbitary filter scripts.

After connecting to the `AF_UNIX` socket, a nul-terminated string corresponding to the character typed will be sent. The filter then replies with the text to display and optionally a suggestions list and/or a commit instruction (`\4` ASCII `ETX`).

Sample filters in C, Perl, Python and Ruby are provided in `examples/`. If no filter is running, typed text is posted to the active process as is.

## Install
1. Download binary release [HERE](https://github.com/a3f/bowdlator/downloads)
1. Extract it
1. Copy it to `~/Library/Input Methods` or `/Library/Input Methods`
1. Logout and Login (<kbd>shift</kbd>+<kbd>command</kbd>+<kbd>Q</kbd>)
1. Open Keyboard Preferences ❯ Input Sources ❯ ＋ ❯ Search `Bowdlator`
1. Start appropriate filter

## Building from source
```
git clone http://github.com/a3f/bowdlator
cd bowdlator
make
make install
osascript -e 'tell app "System Events" to  «event aevtrlgo»'
```
* Open Keyboard Preferences ❯ Input Sources ❯ ＋ ❯ Search `Bowdlator`
* Start appropriate filter

## Copyright and License

Copyright (C) 2016 Ahmad Fatoum

The InputMethod is free software; you can redistribute it and/or modify
it under the terms of the GNU GPL3+. See [LICENSE]() for the full terms. Additionally, the [`examples/`]() are in the public domain.

Logo by [Islam Negm](https://www.linkedin.com/in/islamnegm).
