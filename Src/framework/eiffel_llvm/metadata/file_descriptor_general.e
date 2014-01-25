note
	description: "Summary description for {NEW_13}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_DESCRIPTOR_GENERAL

create

	make_null

feature {NONE}

	make_null
		do
			create descriptor.make_null
		end

feature

	descriptor: MD_NODE
end
