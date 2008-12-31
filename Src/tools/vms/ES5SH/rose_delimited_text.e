note
	description: "string seen as array separated by a delimiter character"
	author: "Cammie Howard"
	date: "$Date$"
	revision: "$Revision$"

class
	ROSE_DELIMITED_TEXT

inherit
	ROSE_LINEAR_ARRAY [STRING]
	    rename 
	    	make as extendable_bounded_make
		end

create
   make, make_ignoring_repeats, make_removing_quotes, make_removing_spaces,
   make_ignoring_quotes,extendable_bounded_make,make_empty,make_from_array

feature 

	make (a_text: STRING; a_delimiter: CHARACTER)
		do
			make_empty
			text := clone(a_text)
			delimiter := a_delimiter
			-- ensure there is at least one delimiter in text for parse
			--text.append_character (delimiter)
			parse
		end

	make_ignoring_repeats (a_text : STRING; a_delimiter : CHARACTER)
		do
			repeated_delimiters_ignored := true
			make (a_text,a_delimiter)
		end

	make_ignoring_quotes (a_text : STRING; a_delimiter : CHARACTER)
		do
			ignore_quotes := true
			make (a_text, a_delimiter)
		end

	make_removing_quotes (a_text : STRING; a_delimiter : CHARACTER)
		do
			remove_quotes := true
			make (a_text, a_delimiter)
		end

	make_removing_spaces (a_text : STRING; a_delimiter : CHARACTER)
		do
			remove_spaces := true
			make (a_text, a_delimiter)
		end


	parse
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
--			l_text := clone(text)	-- We only needed to clone if we must modify 'text'.
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
					--if repeated_delimiters_ignored then
					--	from until i > l_text.count or else l_text.item(i+1) /= delimiter loop i := i+1 end
					--end
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

	prune_token (a_token: STRING): STRING
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


	text : STRING
		-- the text to be parsed
	delimiter : CHARACTER
		-- the delimiter character
	repeated_delimiters_ignored : BOOLEAN
	remove_quotes : BOOLEAN
	ignore_quotes : BOOLEAN
	remove_spaces : BOOLEAN

	ignore_spaces
		do
			remove_spaces := true
		end

	ignore_repeated_delimiters
		do
			repeated_delimiters_ignored := true
		end

	count_repeated_delimiters
		do
			repeated_delimiters_ignored := false
		end
	
feature {NONE} -- Implementation



end -- class ROSE_DELIMITED_TEXT
