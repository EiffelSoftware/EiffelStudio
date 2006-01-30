indexing
	description: "[
					Object that represents a creation constrain triple:
						create Feature_list end
					It is used by roundtrip parser.
					]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_CONSTRAIN_TRIPLE

create
	make
	
feature{NONE} -- Initialization

	make (fl: like feature_list; c_as: like create_keyword; e_as: like end_keyword) is
			-- Initialize instance.
		do
			feature_list := fl
			create_keyword := c_as
			end_keyword := e_as
		ensure
			feature_list_set: feature_list = fl
			create_keyword_set: create_keyword = c_as
			end_keyword_set: end_keyword = e_as
		end

feature -- Roundtrip

	create_keyword: KEYWORD_AS
			-- Keyword "create"

	end_keyword: KEYWORD_AS
			-- Keyword "end"

	feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Feature name list
end
