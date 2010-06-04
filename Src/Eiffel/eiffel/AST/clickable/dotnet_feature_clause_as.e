note
	description: "[
		Abstraction of a dotnet feature clause.  Used for formatting .NET type information.
		Is actually just a list of consumed_entities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_FEATURE_CLAUSE_AS [G -> CONSUMED_ENTITY]

inherit
	LINKED_LIST [G]
		rename
			make as make_list
		end

	SHARED_ENCODING_CONVERTER
		undefine
			is_equal, copy
		end

create
	make_32

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make

create {DOTNET_FEATURE_CLAUSE_AS}
	make_list

feature {NONE} -- Initialization

	make (a_name: STRING; a_flag: BOOLEAN)
			-- Create with name as 'a_name' and with features 'a_features'.
			-- UTF-8 name.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name
			is_exported := a_flag
		ensure
			name_set: name = a_name
			exported_set: is_exported = a_flag
		end

	make_32 (a_name: STRING_32; a_flag: BOOLEAN)
			-- Create with name as 'a_name' and with features 'a_features'.
			-- UTF-32 name.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			make (encoding_converter.utf32_to_utf8 (a_name), a_flag)
		ensure
			name_set: name_32 ~ a_name
			exported_set: is_exported = a_flag
		end

feature -- Properties

	name_32: STRING_32
			-- Category name of clause (i.e. 'Access')
		do
			Result := encoding_converter.utf8_to_utf32 (name)
		end

	is_exported: BOOLEAN
			-- Are items exported?  Yes by default.

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	name: STRING
			-- Category name of clause (i.e. 'Access')

invariant
	name_not_void: name /= Void
	name_not_empty: not name.is_empty

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DOTNET_FEATURE_CLAUSE_AS
