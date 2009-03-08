note
	description: ".NET type name to be mapped to an Eiffel class name"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	TYPE_NAME_SOLVER

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (t: SYSTEM_TYPE)
			-- Initialize from .NET type `t'.
		require
			non_void_type: t /= Void
		local
			l_str: detachable SYSTEM_STRING
		do
			internal_type := t
			create simple_name.make_from_cil (internal_type.name)
			create eiffel_name.make_empty
			l_str := t.full_name
			if l_str /= Void and then attached l_str.split (dot_array) as l_split then
				weight := l_split.count - 1
			else
				weight := 0
			end
		ensure
			non_void_internal_type: internal_type /= Void
			non_void_simple_name: simple_name /= Void
		end

feature -- Access

	weight: INTEGER
			-- Weight used to compare instances

	dot_array: NATIVE_ARRAY [CHARACTER]
			-- <<.>>
		once
			create Result.make (1)
			Result.put (0, '.')
		end

	simple_name: STRING
			-- Simple type name (without namespace)

	eiffel_name: STRING
			-- Eiffel class name

feature -- Element Settings

	set_eiffel_name (name: like eiffel_name)
			-- Set `eiffel_name' with `name'.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			eiffel_name := name
		ensure
			name_set: eiffel_name = name
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := weight < other.weight
		end

feature {TYPE_NAME_SOLVER, ASSEMBLY_CONSUMER} -- Implementation

	internal_type: SYSTEM_TYPE;
			-- Type whose name is consumed

note
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

end -- class TYPE_NAME_SOLVER
