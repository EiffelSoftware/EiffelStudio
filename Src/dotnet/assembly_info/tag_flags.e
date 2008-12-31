note
	description: "Tag flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_FLAGS

feature -- Access

	doc: INTEGER = 0
	assembly: INTEGER = 1
	name: INTEGER = 2
	members: INTEGER = 3
	member: INTEGER = 4
	summary: INTEGER = 5
	param: INTEGER = 6
	returns: INTEGER = 7
	para: INTEGER = 8
	see: INTEGER = 9
	param_ref: INTEGER = 10
	unknow: INTEGER = 15

		-- Elements
	doc_str: STRING = "doc"
	assembly_str: STRING = "assembly"
	members_str: STRING = "members"
	member_str: STRING = "member"

	c_str: STRING = "c"
	code_str: STRING = "code"
	example_str: STRING = "example"
	exception_str: STRING = "exception"
	include_str: STRING = "include"
	list_str: STRING = "list"
	param_str: STRING = "param"
	para_str: STRING = "para"
	param_ref_str: STRING = "paramref"
	permission_str: STRING = "permission"
	ipermission_str: STRING = "ipermission"
	remarks_str: STRING = "remarks"
	returns_str: STRING = "returns"
	see_str: STRING = "see"
	see_also_str: STRING = "seealso"
	summary_str: STRING = "summary"
	value_str: STRING = "value"

		-- Attributes
	name_str: STRING = "name"
	class_str: STRING = "class"
	cref_str: STRING = "cref"
	file_str: STRING = "file"
	path_str: STRING = "path"
	type_str: STRING = "type"
	lang_str: STRING = "langword";

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


end -- class TAG_FLAGS
