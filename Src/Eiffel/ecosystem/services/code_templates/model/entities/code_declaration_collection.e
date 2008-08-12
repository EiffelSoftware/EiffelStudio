indexing
	description: "[
		A collection of code declarations for a given code template definition.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_DECLARATION_COLLECTION

inherit
	CODE_COLLECTION [CODE_DECLARATION]

create
	make

feature -- Query

	declaration (a_id: !STRING_8): CODE_DECLARATION
			-- Retrieve a code declaration via an identifier
			--
			-- `a_id': A case-insensitive declaration identifier to retrieve a code declaration.
			-- `Result': A code declaration or Void if the code declaration matches the supplied id.
		require
			not_a_id_is_empty: not a_id.is_empty
		local
			l_items: like items
			l_decl: !CODE_DECLARATION
		do
			l_items := items
			if not l_items.is_empty and then {l_cursor: !DS_BILINEAR_CURSOR [!CODE_DECLARATION]} l_items.new_cursor then
				from l_cursor.start until l_cursor.after loop
					l_decl := l_cursor.item
					if l_decl.id.is_case_insensitive_equal (a_id) then
						Result := l_decl
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
				check gobo_cursor_cleaned_up: l_cursor.off end
			end
		ensure
			matching_result_id: Result /= Void implies Result.id.is_case_insensitive_equal (a_id)
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_declaration_collection (({!CODE_DECLARATION_COLLECTION}) #? Current)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
