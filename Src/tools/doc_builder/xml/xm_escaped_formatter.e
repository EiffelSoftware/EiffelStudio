indexing
	description: "XML formatter which deals with escaping."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_ESCAPED_FORMATTER

inherit
	XM_FORMATTER
		redefine
			process_element,
			process_character_data
		end

create
	make

feature -- Access

	element_processed: BOOLEAN
			-- Is it data part on an element?		

	is_code_block: ARRAYED_LIST [BOOLEAN] is
			-- Is it a code block?
		once
			create Result.make (5)
		end

	is_escaped (a_char: INTEGER): BOOLEAN is
			-- Is this an escapable character? (<, >, &)
		do
			Result := a_char = Lt_char.code
				or a_char = Gt_char.code
				or a_char = Amp_char.code
		end

	output_escaped (a_string: STRING): STRING is
			-- Escape and output content string.  The string "<>&" will become
			-- "&gt;&lt;&amp;"
		require
			a_string_not_void: a_string /= Void
		local
			last_escaped: INTEGER
			i: INTEGER
			cnt: INTEGER
			a_char: INTEGER
		do
			create Result.make_empty
			from
				last_escaped := 0
				i := 1
				cnt := a_string.count
			invariant
				last_escaped <= i
			until
				i > cnt
			loop
				a_char := a_string.item_code (i)
				if is_escaped (a_char) then
					if last_escaped < i - 1 then
						Result := Result + (a_string.substring (last_escaped + 1, i - 1))
					end
					Result := Result + (escaped_char (a_char))
					last_escaped := i
				end
				i := i + 1
			end
				-- At exit.
			if last_escaped = 0 then
				Result := Result + (a_string)
			elseif last_escaped < i - 1 then
				Result := Result + (a_string.substring (last_escaped + 1, i - 1))
			end
		end

	escaped_char (a_char: INTEGER): STRING is
			-- Escape char.
		require
			is_escaped: is_escaped (a_char)
		do
			if a_char = lt_char.code then
				Result := lt_entity
			elseif a_char = gt_char.code then
				Result := gt_entity
			elseif a_char = amp_char.code then
				Result := amp_entity
			elseif a_char = quot_char.code then
				Result := quot_entity
			else
				Result := "&#" + a_char.out + ";"
			end
		end
		
	process_character_data (c: XM_CHARACTER_DATA) is
			-- Process character data `c'
		local
			l_content: STRING
		do	
			l_content := output_escaped (c.content)	
			append (l_content)
		end	

	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
		do	
			if e.name.is_equal ("code_block") or (not Is_code_block.is_empty and then Is_code_block.last) then
				is_code_block.extend (True)
			else
				is_code_block.extend (False)
			end
			element_processed := True
			Precursor {XM_FORMATTER} (e)
			element_processed := False
			is_code_block.go_i_th (Is_code_block.index_of (is_code_block.last, 1))
			is_code_block.remove
		end

end -- class XM_ESCAPED_FORMATTER
