note
	description: "Summary description for {TEST3}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RECYCLABLE

inherit
	USABLE

feature

	is_interface_usable: BOOLEAN
		do
			Result := is_done
		end


	is_done: BOOLEAN

end
