indexing
	description: "Conversion failure from the internal implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERSION_FAILURE

inherit
	DEVELOPER_EXCEPTION

create
	make_message

feature {NONE} -- Initialization

	make_message (a_message: like message)
		do
			set_message (a_message)
		end

end
