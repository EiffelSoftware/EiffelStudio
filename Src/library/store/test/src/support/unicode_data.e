note
	description: "To test storing/retrieval of Unicode data."
	date: "$Date: 2014-04-04 05:31:05 +0200 (Fri, 04 Apr 2014) $"
	revision: "$Revision: 94775 $"

class
	UNICODE_DATA

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER)
		do
			id := a_id
			create unicode.make_empty
			create ascii.make_empty
			create small_unicode.make_empty
			create small_ascii.make_empty
		end

feature -- Access

	id: INTEGER

	unicode, small_unicode: STRING_32
	ascii, small_ascii: STRING_8

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

	set_small_unicode (a_small_unicode: like small_unicode)
		do
			small_unicode := a_small_unicode
		ensure
			small_unicode_set: small_unicode = a_small_unicode
		end

	set_small_ascii (a_small_ascii: like small_ascii)
		do
			small_ascii := a_small_ascii
		ensure
			small_ascii_set: small_ascii = a_small_ascii
		end

end
