indexing 
	description: "Eiffel type member code snippet"
	date: "$$"
	revision: "$$"	
	
class
	CODE_SNIPPET_FEATURE

inherit
	CODE_FEATURE
		rename
			make as feature_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_eiffel_name: like eiffel_name; a_value: like value) is
			-- Initialize `value' with `a_value'.
		do
			set_feature_kind ("Snippet Features")
			value := a_value
			create {LINKED_LIST [CODE_COMMENT]} comments.make
			create {LINKED_LIST [CODE_ATTRIBUTE_DECLARATION]} custom_attributes.make
			create {LINKED_LIST [CODE_TYPE_REFERENCE]} feature_clauses.make
			eiffel_name := a_eiffel_name
			name := a_eiffel_name
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet feature
		do
			create Result.make (value.count + 1)
			Result.append (value)
			Result.append_character ('%N')
		end

invariant
	non_void_value: value /= Void

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