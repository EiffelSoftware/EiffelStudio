indexing
	description: "XML formatter which deals with escaping."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_ESCAPED_FORMATTER

inherit
	XM_FORMATTER
		redefine
--			process_element,
			process_character_data
		end
		
	XML_ROUTINES

create
	make

feature -- Access

--	element_processed: BOOLEAN
--			-- Is it data part on an element?		
--
--	is_code_block: ARRAYED_LIST [BOOLEAN] is
--			-- Is it a code block?
--		once
--			create Result.make (5)
--		end
		
	process_character_data (c: XM_CHARACTER_DATA) is
			-- Process character data `c'
		local
			l_content: STRING
		do	
			l_content := output_escaped (c.content)	
			append (l_content)
		end	

--	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
--		do	
--			if e.name.is_equal ("code_block") or (not Is_code_block.is_empty and then Is_code_block.last) then
--				is_code_block.extend (True)
--			else
--				is_code_block.extend (False)
--			end
--			element_processed := True
--			Precursor {XM_FORMATTER} (e)
--			element_processed := False
--			is_code_block.go_i_th (Is_code_block.index_of (is_code_block.last, 1))
--			is_code_block.remove
--		end

end -- class XM_ESCAPED_FORMATTER
