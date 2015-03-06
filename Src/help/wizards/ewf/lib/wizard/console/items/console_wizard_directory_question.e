note
	description: "Summary description for {CONSOLE_WIZARD_DIRECTORY_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_DIRECTORY_QUESTION

inherit
	WIZARD_DIRECTORY_QUESTION
		undefine
			make
		end

	CONSOLE_WIZARD_QUESTION

create
	make

convert
	text: {STRING_32}

feature -- Conversion

	text: STRING_32
		do
			if attached value as v then
				Result := v.name
			else
				create Result.make_empty
			end
		end

	value: detachable PATH

feature -- Element change

	set_title (t: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (t)
		end

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (Void)
			else
				set_value (create {PATH}.make_from_string (t))
			end
		end

	set_value (v: detachable PATH)
		do
			value := v
		end


end
