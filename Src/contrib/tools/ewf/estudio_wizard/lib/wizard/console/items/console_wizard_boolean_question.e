note
	description: "Summary description for {CONSOLE_WIZARD_BOOLEAN_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_BOOLEAN_QUESTION

inherit
	WIZARD_BOOLEAN_QUESTION
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
			if value then
				Result := "yes"
			else
				Result := "no"
			end
		end

	value: BOOLEAN

feature -- Element change

	set_title (t: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (t)
		end

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (False)
			else
				set_value (t.is_case_insensitive_equal ("yes"))
			end
		end

	set_value (v: BOOLEAN)
		do
			value := v
		end


end
