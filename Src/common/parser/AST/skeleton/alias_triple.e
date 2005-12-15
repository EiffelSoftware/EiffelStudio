indexing
	description: "Object that stores 3 AST nodes for alias"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALIAS_TRIPLE

create
	make

feature{NONE} -- Initialization

	make (k_as: like alias_keyword; n_as: like alias_name; c_as: like convert_keyword) is
			-- Create new ALIAS_TRIPLE sturcture.
		do
			alias_keyword := k_as
			alias_name := n_as
			convert_keyword := c_as
		ensure
			alias_keyword_set: alias_keyword = k_as
			alias_name_set: alias_name = n_as
			convert_keyword_set: convert_keyword = c_as
		end

feature -- Access

	alias_keyword: KEYWORD_AS
			-- Keyword "alias"

	convert_keyword: KEYWORD_AS
			-- Keyword "convert"

	alias_name: STRING_AS

end
