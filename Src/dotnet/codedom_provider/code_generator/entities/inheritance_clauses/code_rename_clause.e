indexing
	description: "Eiffel rename inheritance clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	

class
	CODE_RENAME_CLAUSE

inherit
	CODE_INHERITANCE_CLAUSE
		rename
			make as inheritance_clause_make
		redefine
			code
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_parent: like parent; a_new_name: like target_name) is
			-- Set `routine' with `a_routine', `parent' with `a_parent' and `target_name' with `a_new_name'.
		require
			non_void_routine: a_routine /= Void
			non_void_parent: a_parent /= Void
			non_void_new_name: a_new_name /= Void
		do
			inheritance_clause_make (a_routine, a_parent)
			target_name := a_new_name
		ensure
			routine_set: routine = a_routine
			parent_set: parent = a_parent
			target_name_set: target_name = a_new_name
		end

feature -- Access

	keyword: STRING is "rename"
			-- Associated Eiffel keyword

	target_name: STRING
			-- Name of rename clause target

	code: STRING is
			-- Generated line in inheritance clause
		do
			check
				target_name_set: target_name /= Void
			end
			create Result.make (routine.eiffel_name.count + 4 + target_name.count)
			Result.append (routine.eiffel_name)
			Result.append (" as ")
			Result.append (target_name)
		end

feature -- Element Settings

	set_target_name (a_name: STRING) is
			-- Set `target_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			in_code_analysis: current_state = Code_analysis
		do
			target_name := a_name
		ensure
			name_set: target_name = a_name
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


end -- class CODE_RENAME_CLAUSE

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