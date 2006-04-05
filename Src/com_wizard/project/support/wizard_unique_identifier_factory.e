indexing
	description: "Allows creating identifiers from given base that are unique in given set"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_UNIQUE_IDENTIFIER_FACTORY

feature -- Access

	unique_identifier (a_base: STRING; a_comparer: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]): STRING is
			-- Unique identifier in `a_list' from `a_base'
			--| An identifier is considered unique if applying `a_comparer' to it returns `False'
		require
			non_void_base: a_base /= Void
			non_void_comparer: a_comparer /= Void
			valid_comparer: a_comparer.valid_operands ([a_base]) and a_comparer.callable
		local
			i: INTEGER
		do
			if a_comparer.item ([a_base]) then
				create Result.make (a_base.count + 2)
				Result.append (a_base)
				Result.append ("_2")
				from
					i := 3
				until
					not a_comparer.item ([Result])
				loop
					Result.keep_head (Result.last_index_of ('_', Result.count))
					Result.append_integer (i)
					i := i + 1
				end
			else
				Result := a_base.twin
			end
		ensure
			is_unique: not a_comparer.item ([Result])
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
end -- class WIZARD_UNIQUE_IDENTIFIER_FACTORY

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
