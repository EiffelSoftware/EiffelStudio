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

feature -- Conversion

	all_messages_as_string: STRING_32
		do
			create Result.make_empty
			append_all_messages_to (Result)
		end

	append_all_messages_to (s: STRING_32)
		do
			s.append (message)
			if attached previous as prev then
				prev.append_all_messages_to (s)
			end
		end

feature -- Element change

	set_previous (e: like previous)
		do
			previous := e
		end

;note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
