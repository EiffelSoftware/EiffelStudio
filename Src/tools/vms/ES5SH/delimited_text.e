indexing
	description: "Simple class for parsing a delimited string, from ROSE_DELIMITED_TEXT"
	author: "Cammie Howard"
	date: "$Date$"
	revision: "$Revision$"

class DELIMITED_TEXT

inherit
	LINEAR_ARRAY [STRING]
	    rename
	    	make as extendable_bounded_make
		end

create
   make, make_ignoring_repeats, make_removing_quotes, make_removing_spaces, make_ignoring_quotes
   --extendable_bounded_make, make_empty, make_from_array

feature -- Creation

	make (a_text: STRING; a_delimiter: CHARACTER) is
			-- Create `Current' from text `a_text' and delimiter `a_delimiter'.
		require
			a_text_not_void: a_text /= Void
		do
			make_empty
			create text.make_from_string (a_text)
			delimiter := a_delimiter
			parse
		end

	make_ignoring_repeats (a_text : STRING; a_delimiter : CHARACTER) is
		require
			a_text_not_void: a_text /= Void
		do
			repeated_delimiters_ignored := true
			make (a_text,a_delimiter)
		end

	make_ignoring_quotes (a_text : STRING; a_delimiter : CHARACTER) is
		require
			a_text_not_void: a_text /= Void
		do
			ignore_quotes := true
			make (a_text, a_delimiter)
		end

	make_removing_quotes (a_text : STRING; a_delimiter : CHARACTER) is
		require
			a_text_not_void: a_text /= Void
		do
			remove_quotes := true
			make (a_text, a_delimiter)
		end

	make_removing_spaces (a_text : STRING; a_delimiter : CHARACTER) is
		require
			a_text_not_void: a_text /= Void
		do
			remove_spaces := true
			make (a_text, a_delimiter)
		end

--feature -- Moose

--	count: INTEGER
--			-- number of elements in parsed string
--		do
--			Result := array.count
--		end
--	first: STRING
--			-- item at first position, if any
--		do
--			if array.valid_index (array.lower) then
--				Result := array [array.lower]
--			end
--		end
--	is_empty: BOOLEAN
--			-- is parsed text empty?
--		do
--			Result := array.is_empty
--		end
--	item alias "[]", at alias "@", entry (i: INTEGER): STRING
--			-- Entry at index `i', if in index interval
--		do
--			Result := array[i]
--		end
--	valid_index (i: INTEGER): BOOLEAN
--			-- Is `i' within the bounds of the array?
--		do
--			Result := (array.lower <= i) and then (i <= array.upper)
--		end

feature -- Basic operations

	parse is
		--
		--	This should correctly handle the following cases:
		--
		--	Case		Result
		--
		--	""		0 items
		--	"hi"		1 item
		--	"hi,there"	2 items
		--	"hi,,there,"	4 items
		--
		local
			i, l_start : INTEGER
			l_in_quote : BOOLEAN
			l_text, l_token : STRING
		do
			l_text := text
			l_start := 1
			from i := 1 until i > l_text.count
			loop
				if l_text.item(i) = delimiter and not l_in_quote then
					if l_start = i then -- empty token
						if not repeated_delimiters_ignored then extend("") end
					else
						l_token := prune_token(l_text.substring(l_start, i - 1))
						extend(l_token)
					end
					l_start := i + 1
				elseif not ignore_quotes and then l_text.item(i) = '"' then
					l_in_quote := not l_in_quote
				end
				i := i+1
			end
			if l_text.count/=0 then
				extend(prune_token(l_text.substring(l_start,l_text.count)))
			end
		end

	prune_token (a_token: STRING): STRING is
			-- apply pruning to token
		do
			if (remove_quotes) then
				a_token.prune_all_leading('"');
				a_token.prune_all_trailing('"');
			end
			if (remove_spaces) then
				a_token.prune_all_leading(' ');
				a_token.prune_all_trailing(' ');
			end
			Result := a_token
		end


	delimiter : CHARACTER
	repeated_delimiters_ignored : BOOLEAN
	remove_quotes : BOOLEAN
	ignore_quotes : BOOLEAN
	remove_spaces : BOOLEAN
	text : STRING

	ignore_spaces is
			-- ignore spaces
		do
			remove_spaces := true
		end
	ignore_repeated_delimiters is
			-- ignore repeated delimiters
		do
			repeated_delimiters_ignored := true
		end
	count_repeated_delimiters is
			-- count repeated delimiters
		do
			repeated_delimiters_ignored := false
		end

	delimited_string (a_delimiter: CHARACTER) : STRING is
			-- delimited string in canonical form
		local
			i : INTEGER
		do
			Result := Current[lower]
			from i := lower + 1 until i > upper loop
				Result := Result + a_delimiter.out + Current[i]
				i := i + 1
			end
		end


end -- class DELIMITED_TEXT
