indexing
	description: "External AST node factories"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_FACTORY

feature -- Low level factories

	new_external_type_as (id: ID_AS; type_prefix: STRING; is_struct: BOOLEAN; nb_pointer: INTEGER;
			is_byref: BOOLEAN): EXTERNAL_TYPE_AS
		is
			-- New EXTERNAL_TYPE_AS node.
		require
			id_not_void: id /= Void
		do
			create Result
			if type_prefix /= Void then
				id.prepend (type_prefix)
			end
			Result.initialize (id, is_struct, nb_pointer, is_byref)
		ensure
			Result_not_void: Result /= Void
		end

	new_double_quote_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('%"')
			s.append_character ('%"')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

	new_system_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('<')
			s.append_character ('>')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

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

end -- class EXTERNAL_FACTORY

