note
	description: "Summary description for {TYPE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_DESCRIPTOR

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
