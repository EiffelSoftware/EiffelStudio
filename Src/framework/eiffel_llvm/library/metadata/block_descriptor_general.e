note
	description: "Summary description for {BLOCK_DESCRIPTOR_GENERAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BLOCK_DESCRIPTOR_GENERAL

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
