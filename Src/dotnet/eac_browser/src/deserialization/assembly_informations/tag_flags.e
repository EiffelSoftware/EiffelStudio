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

	doc_str: STRING is "doc"
	assembly_str: STRING is "assembly"
	name_str: STRING is "name"
	members_str: STRING is "members"
	member_str: STRING is "member"
	summary_str: STRING is "summary"
	param_str: STRING is "param"
	returns_str: STRING is "returns"
	para_str: STRING is "para"
	see_str: STRING is "see"
	param_ref_str: STRING is "paramref"
--	list_str: STRING is "list"
--	list_header_str: STRING is "listheader"
--	item_str: STRING is "item"
--	term_str: STRING is "term"
--	description_str: STRING is "description"
		

end -- class TAG_FLAGS
