(* issues: use a while mechanism to print individual lines?; hyphenation *)

use "./src/trie.sml";

(* lower : string -> string *)
fun lower str = implode(map Char.toLower (explode str));
fun stringList str = String.tokens Char.isSpace str

(* createTrie : string list -> bool dict *)
fun createTrie [] = Trie.empty
 | createTrie (x::xs) = Trie.insert(createTrie(xs), (x, true)) 

fun checkPunct (word: string) = 
  let 
    val worded = explode word
    val punctuation = List.nth(worded, (length worded)-1)
  in 
    Char.isPunct punctuation
  end;

fun openFile (file:string) = 
  let
	  val filed = TextIO.openIn file
	  val words = stringList (TextIO.inputAll filed)
	in
	  words before TextIO.closeIn filed
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
  
fun typos dict words =  map (typo dict) (map removePunct words);
fun getErrors dict words = List.filter (fn x => not (x = "") ) (typos dict words);

(* we should handle if the input file doesn't exist before loading the dictionary *)
val dictionary = createTrie(openFile "./dict/words.txt");

val final = getErrors dictionary (openFile "./src/test.txt");

fun printTypos wordList : unit = let
  val len = (length wordList)
  val counter = ref 0
  in
    while (!counter < len ) do (
      print(List.nth(wordList, !counter)^"\n");
      counter := !counter + 1)
  end;