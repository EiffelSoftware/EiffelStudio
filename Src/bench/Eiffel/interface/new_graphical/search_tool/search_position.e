indexing
	description: "Objects that designate the position of a searched word or expression in a file"
	date: "$Date$"

class
	SEARCH_POSITION

create
	make

feature {NONE} -- Initialization

	make (char_cnt: INTEGER; lgth: INTEGER) is
			-- creates an object with `line_nb' as `line_number' and
			-- `character_cnt' as `character_count'
		require
			valid_character_cnt: char_cnt > 0
			valid_length: lgth > 0 	
		do
			character_count := char_cnt
			length := lgth			
		end

feature -- Access

	character_count : INTEGER
		-- position of the word or expression in the file

	length : INTEGER
		-- length of the word or expression

feature -- Element change

	add_offset (an_offset: INTEGER) is
			-- add `an_offset' to character_count
		do
			character_count := character_count + an_offset
		end
	
	set_character_count (n: INTEGER) is
			-- set `character_count' to 'n'
		require
			valid_character_cnt: n > 0
		do
			character_count := n
		ensure
			character_count = n
		end

	set_length (n: INTEGER) is
			-- set `line_number' to 'n'
		require
			valid_length: n > 0
		do
			length := n
		ensure
			length = n
		end

invariant
		valid_character_cnt: character_count > 0		
		valid_length: length > 0 	

end -- class SEARCH_POSITION
