indexing
	description: "Tag flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_FLAGS

feature -- Access

	doc: INTEGER is 0
	assembly: INTEGER is 1
	name: INTEGER is 2
	members: INTEGER is 3
	member: INTEGER is 4
	summary: INTEGER is 5
	param: INTEGER is 6
	returns: INTEGER is 7
	para: INTEGER is 8
	see: INTEGER is 9
	param_ref: INTEGER is 10
	unknow: INTEGER is 15

		-- Elements
	doc_str: STRING is "doc"
	assembly_str: STRING is "assembly"
	members_str: STRING is "members"
	member_str: STRING is "member"
	
	c_str: STRING is "c"
	code_str: STRING is "code"
	example_str: STRING is "example"
	exception_str: STRING is "exception"
	include_str: STRING is "include"
	list_str: STRING is "list"
	param_str: STRING is "param"
	para_str: STRING is "para"
	param_ref_str: STRING is "paramref"
	permission_str: STRING is "permission"
	remarks_str: STRING is "remarks"
	returns_str: STRING is "returns"
	see_str: STRING is "see"
	see_also_str: STRING is "seealso"
	summary_str: STRING is "summary"
	value_str: STRING is "value"
	
		-- Attributes
	name_str: STRING is "name"
	cref_str: STRING is "cref"
	file_str: STRING is "file"
	path_str: STRING is "path"
	type_str: STRING is "type"
	lang_str: STRING is "langword";

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


end -- class TAG_FLAGS
