note
	description: "Visitor pattern interface for visiting parsed INI Abstract Syntax Trees (AST)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_NODE_VISITOR

feature -- Processing

	process_document (a_document: INI_DOCUMENT_NODE)
			-- Process document node `a_document'.
		require
			a_document_attached: a_document /= Void
		deferred
		end

	process_section (a_section: INI_SECTION_NODE)
			-- Process document section node `a_section'.
		require
			a_section_attached: a_section /= Void
		deferred
		end

	process_property (a_property: INI_PROPERTY_NODE)
			-- Process property node `a_property'.
		require
			a_property_attached: a_property /= Void
		deferred
		end

	process_literal (a_literal: INI_LITERAL_NODE)
			-- Process literal `a_literal'.
		require
			a_literal_attached: a_literal /= Void
		deferred
		end

	process_id (a_id: INI_ID_NODE)
			-- Process identifier `a_id'.
		require
			a_id_attached: a_id /= Void
		deferred
		end

	process_symbol (a_symbol: INI_SYMBOL_NODE)
			-- Process syntax symbol `a_symbol'.
		require
			a_symbol_attached: a_symbol /= Void
		deferred
		end

	process_value (a_value: INI_VALUE_NODE)
			-- Process value `a_value'.
		require
			a_value_attached: a_value /= Void
		deferred
		end

feature {NONE} -- Implementation

	process_list (a_list: LIST [INI_NODE])
			-- Process a list of nodes.
		require
			a_list_attached: a_list /= Void
		local
			l_cursor: CURSOR
		do
			l_cursor := a_list.cursor
			from
				a_list.start
			until
				a_list.after
			loop
				a_list.item.visit (Current)
				a_list.forth
			end
			a_list.go_to (l_cursor)
		ensure
			a_list_unmoved: a_list.cursor.is_equal (old a_list.cursor)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_AST_VISITOR}
