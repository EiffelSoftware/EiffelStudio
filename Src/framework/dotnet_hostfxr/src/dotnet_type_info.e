note
	description: "Summary description for {DOTNET_TYPE_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_TYPE_INFO

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
			create methods.make (0)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	methods: ARRAYED_LIST [DOTNET_METHOD_INFO]


end
