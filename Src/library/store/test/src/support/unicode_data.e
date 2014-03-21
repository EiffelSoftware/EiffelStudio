note
	description: "To test storing/retrieval of Unicode data."
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_DATA

create
	make

feature {NONE} -- Initialization

	make
		do
			create unicode.make_empty
			create ascii.make_empty
		end

feature -- Access

	unicode: STRING_32
	ascii: STRING_8

feature -- Settings

	set_unicode (a_unicode: like unicode)
		do
			unicode := a_unicode
		ensure
			unicode_set: unicode = a_unicode
		end

	set_ascii (a_ascii: like ascii)
		do
			ascii := a_ascii
		ensure
			ascii_set: ascii = a_ascii
		end

end
