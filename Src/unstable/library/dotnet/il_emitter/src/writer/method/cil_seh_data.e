note
	description: "Summary description for {CIL_SEH_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_SEH_DATA

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Access

	try_offset: NATURAL
	try_lengtH: NATURAL
	handler_offset: NATURAL
	handler_length: NATURAL

		-- Defined as a union
	filter_offset: NATURAL
	class_token: NATURAL

	flags: detachable CIL_SEH_DATA_ENUM
end
