indexing 
	description: "Eiffel type member code snippet"
	date: "$$"
	revision: "$$"	
	
class
	CODE_SNIPPET_FEATURE

inherit
	CODE_FEATURE
		redefine
			make,
			ready
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `value' with empty string.
		do
			Precursor {CODE_FEATURE}
			set_type_feature ("Snippet Features")
			set_name ("Snippet Features")
		ensure then
			non_void_value: value /= Void
		end
		
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet feature
		do
			create Result.make (value.count + 1)
			Result.append (value)
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is snippet compile unit ready to be generated?
		do
			Result := Precursor {CODE_FEATURE} and value /= Void
		end

feature -- Status Setting

	set_value (a_value: like value) is
			-- Set `value' with `a_value'.
			-- `a_value' must be formatted
		require
			non_void_value: a_value /= Void
			not_empty_value: not a_value.is_empty
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
	
end -- class CODE_SNIPPET_FEATURE

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