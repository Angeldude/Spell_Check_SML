# CLI Spell Check

Welcome! This is an attempt to write a command line spell checker in SML (Standard ML).

In this repository, you will not find much. There is a `dict` directory with a file that contains dictionary words. This file was found in `/usr/share/dict/words` on Ubuntu 20.04.

You will also find a ruby file. I implemented a very basic trie to play around with it and understand its use. I wrote a blog post about it [here.](https://angeldude.github.io/data%20structures/programming/software%20design/learning/2024/07/25/spell-check-in-sml.html)

The `src` directory contains my first try at writing the logic for the spell checker in SML. It checks the words in a dictionary by loading them as a `string list` and the input text is also made into a `string list` and we iterate through both. As you can probably tell, this is very inefficient.

Finally, I will not be implementing my own trie in SML, instead I will be using an already existing implementation found [here.](https://github.com/jlao/sml-trie) I included the file in this repository as well.