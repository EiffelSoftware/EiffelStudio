note
	description: "[
		The Error object, contains aditional information on the latest error reported by the SERVER.
		It's an optional object, if it exist, there is only one object of this type.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
		  "error": {
		 	"title" : STRING,
		 	"code"  : STRING,
		 	"message" : STRING
		  }
		}
	]"

class
	CJ_ERROR

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			make ("", "", "")
		end

	make (a_title: like title; a_code: like code; a_message: like message)
		do
			title := a_title
			code := a_code
			message := a_message
		end

feature -- Access

	title: STRING_32

	code: STRING_32

	message: STRING_32

feature -- Element Change

	set_title (a_title: like title)
		do
			title := a_title
		ensure
			title_set: title ~ a_title
		end

	set_code (a_code: like code)
		do
			code := a_code
		ensure
			code_set: code ~ a_code
		end

	set_message (a_message: like message)
		do
			message := a_message
		ensure
			message_set: message ~ a_message
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
