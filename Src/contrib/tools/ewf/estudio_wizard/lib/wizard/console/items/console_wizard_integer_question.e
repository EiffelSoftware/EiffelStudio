note
	description: "Summary description for {CONSOLE_WIZARD_INTEGER_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_INTEGER_QUESTION

inherit
	WIZARD_INTEGER_QUESTION
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
			create Result.make_empty
			Result.append_integer (value)
		end

	value: INTEGER

feature -- Element change

	set_title (t: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (t)
		end

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (0)
			elseif t.is_integer then
				set_value (t.to_integer)
			else
				-- Ignore !
			end
		end

	set_value (v: INTEGER)
		do
			value := v
		end


end
