(* issues: use a while mechanism to print individual lines?; hyphenation *)

use "./src/trie.sml";
(* lower : string -> string *)
fun lower str = implode(map Char.toLower (explode str));

(* createTrie : string list -> bool dict *)
fun createTrie [] = Trie.empty
 | createTrie (x::xs) = Trie.insert(createTrie(xs) , (x, true)) 

fun checkPunct (word: string) = 
  let 
    val worded = explode word
    val punctuation = List.nth(worded, (length worded)-1)
  in 
    Char.isPunct punctuation
  end;

fun openFile (file:string) = 
    let
	  val file = TextIO.openIn file
	  val words = String.tokens Char.isSpace (TextIO.inputAll file)
	in
	  words before TextIO.closeIn file
	end;

fun removePunct word = 
  let
    val chars = explode word
    val fixedWord = 
      if checkPunct word 
      then implode(List.take(chars, (length chars)-1))
      else word
  in
    fixedWord
  end;

fun typo dict word = let
  val normal = Trie.lookup dict word
  val lowered = Trie.lookup dict (lower word)
  fun caseCheck temp : bool = 
    case temp of 
      SOME x => x
    | NONE => false
  val result = caseCheck(normal) orelse caseCheck(lowered)
  in
    if not result then word else ""
  end;
  

(* we should handle if the input file doesn't exist before loading the dictionary *)
val words = openFile "./src/test.txt";
val dictionary = createTrie(openFile "./dict/words.txt");

val final = List.filter (fn x => not (x = "") ) (map (typo dictionary) (map removePunct words));