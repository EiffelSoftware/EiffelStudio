indexing 
	description: "Eiffel property getter"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_PROPERTY_GETTER

inherit
	ECDP_FUNCTION
		redefine
			code
		end
create 
	make
	
feature -- Access

	code: STRING is
			-- | Result := "feature -- Get Property
			-- |				get_`name': `returned_type' is do `statements' end"
			-- Eiffel code of property
		local
			parent_type_name: STRING
		do
			check
				not_empty_type: not returned_type.is_empty
			end
			create Result.make (600)

			add_tab_to_indent_string
			Result.append (signature)
			Result.append (Dictionary.Space)
			Result.append ("is")
			Result.append (Dictionary.New_line)
			add_tab_to_indent_string
			Result.append (body)
			sub_tab_to_indent_string
			Result.append (indent_string)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.New_line)
			sub_tab_to_indent_string

			Result.append (Dictionary.New_line)
			sub_tab_to_indent_string
		end

end -- class ECDP_PROPERTY_GETTER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------