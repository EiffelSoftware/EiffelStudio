indexing
	description: "Snippet inheritance export clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SNIPPET_EXPORT_CLAUSE

inherit
	CODE_SNIPPET_INHERITANCE_CLAUSE
		rename
			make as make_inheritance_clause
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine_name: STRING; a_type_list: LIST [STRING]) is
			-- Set `routine_name' with `a_routine_name' and `type_list' with `a_type_list'.
		require
			non_void_routine_name: a_routine_name /= Void
			non_void_type_list: a_type_list /= Void
		do
			make_inheritance_clause (a_routine_name)
			type_list := a_type_list
		ensure
			routine_name_set: routine_name = a_routine_name
			type_list_set: type_list = a_type_list
		end

feature -- Access

	type_list: LIST [STRING];
				-- Types to which feature with eiffel name `feature_name' is exported

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


end -- class CODE_SNIPPET_EXPORT_CLAUSE

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
