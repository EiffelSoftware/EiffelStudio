note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_STRUCTURE_VISITOR

inherit
	AST_ROUNDTRIP_PRINTER_VISITOR
		redefine
			make_with_default_context,
			process_feature_clause_as,
			process_class_as
		end

create
	make_with_default_context

feature -- Make

	make_with_default_context
			-- <Precursor>
		do
			Precursor
--			create structure.make
		end

feature -- Process

	structure: EIFFEL_LIST [FEATURE_CLAUSE_AS]
				--LINKED_LIST [FEATURE_CLAUSE_AS]
			-- visited structure

	process_class_as (l_as: CLASS_AS)
			-- Process `l_as'.
		do
			Precursor (l_as)
			structure := l_as.features
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
			-- Process `l_as'.
		do
			Precursor (l_as)
--			structure.extend (l_as)
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
