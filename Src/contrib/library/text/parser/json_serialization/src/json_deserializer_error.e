note
	description: "Summary description for {JSON_DESERIALIZER_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_DESERIALIZER_ERROR

inherit
	ANY
		redefine
			default_create
		end

create
	make,
	default_create

convert
	make ({READABLE_STRING_GENERAL, READABLE_STRING_8, READABLE_STRING_32, STRING_8, STRING_32})

feature {NONE} -- Initialization

	default_create
		do
			make ("Deserialization error!")
		end

	make (a_message: READABLE_STRING_GENERAL)
		do
			create message.make_from_string_general (a_message)
		end

feature -- Access

	message: IMMUTABLE_STRING_32

	previous: detachable JSON_DESERIALIZER_ERROR

feature -- Element change

	set_previous (e: like previous)
		do
			previous := e
		end

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
