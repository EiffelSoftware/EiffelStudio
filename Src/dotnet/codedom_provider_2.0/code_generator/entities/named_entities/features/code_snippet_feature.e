indexing 
	description: "Eiffel type member code snippet"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create Result.make (value.count + 250)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (value)
			Result.append (Line_return)
		end

invariant
	non_void_value: value /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_SNIPPET_FEATURE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------