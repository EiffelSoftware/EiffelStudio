note
	description: "[
			Request path info ends with one of the specified extensions.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_EXTENSION_CONDITION

inherit
	WSF_ROUTING_CONDITION

create
	make

feature {NONE} -- Creation

	make (a_extension_list: ITERABLE [READABLE_STRING_GENERAL])
		do
			extension_list := a_extension_list
		end

feature -- Access

	extension_list: ITERABLE [READABLE_STRING_GENERAL]

feature -- Status report

	accepted (req: WSF_REQUEST): BOOLEAN
			-- Does `req` satisfy Current condition?
		local
			l_path: READABLE_STRING_GENERAL
			i: INTEGER
		do
			l_path := req.percent_encoded_path_info
			i := l_path.last_index_of ('.', l_path.count)
			if i > 0 then
				i := i + 1
				Result := across extension_list as ic some ic.item.same_caseless_characters (l_path, i, l_path.count, 1) end
			end
		end

end
