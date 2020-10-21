note
	description: "Summary description for {CONSOLE_WIZARD_STRING_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_STRING_QUESTION

inherit
	WIZARD_STRING_QUESTION
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
				Result := v
			else
				create Result.make_empty
			end
		end

	value: detachable STRING_32

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
				set_value (create {STRING_32}.make_from_string_general (t))
			end
		end

	set_value (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				value := Void
			else
				create value.make_from_string_general (v)
			end
		end


end
