indexing
	description: "Tag flags"
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
	lang_str: STRING is "langword"

end -- class TAG_FLAGS
