indexing
	description: "Line pragma"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	CODE_LINE_PRAGMA

inherit
	CODE_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA) is
			-- Initialize with `a_pragma'.
		require
			attached_pragma: a_pragma /= Void
		do
			pragma := a_pragma
		ensure
			set: pragma = a_pragma
		end

feature -- Access

	code: STRING is
			-- Eiffel code of the entity
		do
			if (pragma.file_name = Void) or else (pragma.file_name.length = 0) then
				Result := "--#line default"
			else
				create Result.make (260)
				Result.append ("--#line ")
				Result.append (pragma.line_number.out)
				Result.append (" %"")
				Result.append (pragma.file_name)
				Result.append ("%"")
				Result.append (Line_return)
			end
		end

feature {NONE} -- Implementation

	pragma: SYSTEM_DLL_CODE_LINE_PRAGMA;
			-- Pragam

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
end -- class CODE_LINE_PRAGMA

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