note
	description: "Summary description for {DOTNET_METHOD_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_METHOD_INFO

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

end
