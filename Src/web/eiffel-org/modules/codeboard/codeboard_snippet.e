note
	description: "Summary description for {CODEBOARD_SNIPPET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_SNIPPET

create
	make

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_GENERAL)
		do
			set_text (a_text)
		end

feature -- Access

	id: INTEGER

	text: READABLE_STRING_32

	lang: detachable READABLE_STRING_8 assign set_lang

	description: detachable READABLE_STRING_32 assign set_description

feature -- Status

	has_id: BOOLEAN
		do
			Result := id > 0
		end

feature -- Element change

	set_id (a_id: like id)
		do
			id := a_id
		end

	set_text (a_text: READABLE_STRING_GENERAL)
		do
			create {IMMUTABLE_STRING_32} text.make_from_string_general (a_text)
		end

	set_lang (a_lang: detachable READABLE_STRING_8)
		do
			lang := a_lang
		end

	set_description  (a_desc: detachable READABLE_STRING_32)
		do
			description := a_desc
		end


end
