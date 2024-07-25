class TrieNode
    attr_accessor :data, :child, :end_string

    def initialize(character)
        @end_string = false
        @data = character
        @child = []
    end

    def sub_node(character)
        @child.each{ |c| return c if c.data == character  } if !@child.empty?
        nil
    end
end

class Trie
    def initialize
        @root = TrieNode.new ''
    end

    def search str
        current = @root
        count = 0
        while count < str.size
            tmp = current.sub_node(str[count])
            return false unless tmp
            current = tmp
            count += 1
        end
        current.end_string
    end

    def insert str
        current = @root
        if str.size == 0
            current.end_string = true
        else
            str.chars.each do |c| 
                child_node = current.sub_node(c)
                if child_node
                    current = child_node
                else
                    tmp  = TrieNode.new(c)
                    current.child << tmp
                    current = tmp
                end
            end
            current.end_string = true
        end
    end
end

dict = Trie.new

def get_dictionary(file,trie)
    File.foreach(file).each do |word|
        trie.insert word.tr("\n", "").downcase
    end
end

def typos(words, trie)
    words.split.reject{|word| trie.search(word.downcase)}
end

sample = "Here is some test material still not going to try with punctuation though"
sample_2 = "Here is aone with a typo or two to fi see it"