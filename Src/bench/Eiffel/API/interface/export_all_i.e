indexing
	description: "Representation of an export to any clients"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_ALL_I 

inherit
	EXPORT_I
		redefine
			is_all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end
	
feature -- Properties

	is_all: BOOLEAN is True
			-- Is the current object an instance of EXPORT_ALL_I?

feature -- Access

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current?
		do
			Result := other.is_all
		end

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		do
			Result := not other.is_all
		end

feature -- Output

	append_to (st: TEXT_FORMATTER) is
			-- Append a representation of `Current' to `st'.
		do
			
		end

feature {COMPILER_EXPORTER}

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status)]
		do
			Result := other.is_all
		end

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with
			-- `other' clients?
		do
			if other.is_all then
				Result := True
			elseif other.is_set then
				Result := other.valid_for (System.any_class.compiled_class)
			end
		end

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export  clause valid for client `client'?
		do
			Result := True
		end

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		do
			Result := Current
		end

	trace is
			-- Debug purpose
		do
			io.error.put_string ("ALL")
		end

	format (ctxt: TEXT_FORMATTER_DECORATOR) is
		do
		end

indexing
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

end
