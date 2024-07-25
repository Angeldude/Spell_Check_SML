(* input: string *)
(* match string with path to file; read its contents and store in var *)
(* issues: use a while mechanism to print individual lines?; punctuation; hyphenation *)

val contents: string = "Flower";
(* The dictionary part is being re-written to use a Trie *)
fun words (str: string): string list = String.tokens Char.isSpace str;
fun lower (str: string): string = implode(map Char.toLower (explode str));
fun typo (x: string) = List.exists (fn word => (lower x) = (lower word)) dictionary;

fun typos (x: string) = if typo(x) then "" else x;
fun errors (content: string list) = map typos content;
fun get_typos (ls: string list): string list = 
	if List.all (fn x => x = "") ls 
	then []
	else List.filter (fn x => not (x = "")) ls;

(* get_typos(errors (words contents)) *)