indexing
	description: "Eiffel feature parameter used for language service"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_DESCRIPTOR

inherit
	IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_STUB
		redefine
			name,
			type,
			display
		end

create
	make

feature {NONE} -- Initialization

	make (a_name, a_type: STRING) is
			-- Initialize parameter with name `name' and type name `type'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_type: a_type /= Void
			valid_type: not a_type.is_empty
		local
			l_display: STRING
		do
			name := a_name
			create l_display.make (a_name.count + 2 + a_type.count)
			l_display.append (a_name)
			l_display.append (": ")
			l_display.append (a_type)
			display := l_display
			type := a_type
		ensure
			name_set: name = a_name
			type_set: type = a_type
			display_set: display /= Void
		end
		
feature -- Access

	name: STRING
			-- Argument name
			
	type: STRING
			-- Argument type

	display: STRING;
			-- Argument display (i.e. "a: ANY")

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
end -- class PARAMETER_DESCRIPTOR
