indexing 
	description: "Eiffel property setter"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_PROPERTY_SETTER

inherit
	ECDP_ROUTINE
		redefine
			code,
			ready
		end
create 
	make
	
feature -- Access

	property_type_name: STRING
			-- type of argument

	code: STRING is
			-- | Result := "feature -- Set Property
			-- |				set_`name' (value: `type') is do `statements' end"
			-- Eiffel code of property
		local
			type_name: STRING
		do
			check
				not_empty_type: not property_type_name.is_empty
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

feature -- Status Report

	ready: BOOLEAN is
			-- Is named entity ready to be generated?
		do
			Result := Precursor {ECDP_ROUTINE} and property_type_name /= Void and then not property_type_name.is_empty
		end
	
feature -- Status Setting

	set_property_type_name (a_type: like property_type_name) is
			-- Set `type' with `a_type'.
		require
			non_void_type: a_type /= Void
			valid_type: not a_type.is_empty
		do
			property_type_name := a_type
		ensure
			property_type_name_set: property_type_name = a_type
		end
		
end -- class ECDP_PROPERTY_SETTER

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