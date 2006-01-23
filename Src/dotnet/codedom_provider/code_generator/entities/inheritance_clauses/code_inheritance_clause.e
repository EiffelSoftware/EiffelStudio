indexing
	description: "Common ancestor to all Eiffel inheritance clauses"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	

deferred class
	CODE_INHERITANCE_CLAUSE

inherit
	CODE_ENTITY

feature {NONE} -- Initialization

	make (a_routine: like routine; a_parent: like parent) is
			-- Set `routine' with `a_routine' and `parent' with `a_parent'.
		require
			non_void_routine: a_routine /= Void
			non_void_parent: a_parent /= Void
		do
			parent := a_parent
			routine := a_routine
		ensure
			routine_set: routine = a_routine
			parent_set: parent = a_parent
		end

feature	-- Access
	
	routine: CODE_MEMBER_REFERENCE
			-- Clause target routine

	parent: CODE_TYPE_REFERENCE
			-- Clause target type
		
	keyword: STRING is
			-- Associated Eiffel keyword
		deferred
		end

	code: STRING is
			-- Generated line in inheritance clause
		do
			Result := routine.eiffel_name
		end

invariant
	non_void_parent: parent /= Void
	non_void_routine: routine /= Void

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


end -- class CODE_INHERITANCE_CLAUSE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------	