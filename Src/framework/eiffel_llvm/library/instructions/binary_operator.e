note
	description: "Summary description for {BINARY_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_OPERATOR

inherit
	INSTRUCTION

feature {NONE}

	make (v1: VALUE; v2: VALUE)
		do
			item := make_external (v1.item, v2.item)
		end

	make_name (v1: VALUE; v2: VALUE; name: TWINE)
		do
			item := make_name_external (v1.item, v2.item, name.item)
		end

feature {NONE}

	make_external (v1: POINTER; v2: POINTER): POINTER
		deferred
		end

	make_name_external (v1: POINTER; v2: POINTER; name: POINTER): POINTER
		deferred
		end

end
