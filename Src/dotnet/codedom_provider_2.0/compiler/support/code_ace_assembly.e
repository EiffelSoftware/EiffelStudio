indexing
	description: "ACE assembly declaration"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ACE_ASSEMBLY

inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_path: like path; a_prefix: like assembly_prefix) is
			-- Initialize instance
		require
			non_void_name: a_name /= Void
			non_void_path: a_path /= Void
		do
			name := a_name
			path := a_path
			assembly_prefix := a_prefix
		ensure
			name_set: name = a_name
			path_set: path = a_path
			prefix_set: assembly_prefix = a_prefix
		end

feature -- Access

	assembly_prefix: STRING
			-- Assembly prefix

	path: STRING
			-- Assembly path

	code: STRING is
			-- LACE code
		do
			create Result.make (256)
			Result.append_character ('"')
			Result.append (name)
			Result.append ("%":%T%"")
			Result.append (path)
			Result.append_character ('"')
			if assembly_prefix /= Void and then not assembly_prefix.is_empty then
				Result.append (Line_return)
				Result.append ("%T%Tprefix")
				Result.append (Line_return)
				Result.append ("%T%T%T")
				Result.append (assembly_prefix)
				Result.append (Line_return)
				Result.append ("%T%Tend")
			end
		end
		
invariant
	non_void_path: path /= Void

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
end -- class CODE_ACE_ASSEMBLY

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