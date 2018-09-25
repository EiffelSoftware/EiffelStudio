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

	caption: detachable READABLE_STRING_32 assign set_caption

	link: detachable READABLE_STRING_8

	is_locked: BOOLEAN
			-- Is snippet locked?
			-- i.e prevent modification or removal.

feature -- Status

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	same_as (other: CODEBOARD_SNIPPET): BOOLEAN
		do
			if other = Current then
				Result := True
			else
				Result :=
					id = other.id and then
					text.same_string (other.text) and then
					same_strings (caption, other.caption) and then
					same_strings (link, other.link) and then
					is_locked = other.is_locked
			end
		end

feature {NONE} -- Implementation: helpers

	same_strings (s1, s2: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if s1 ~ s2 then
				Result := True
			elseif s1 = Void then
				Result := s2 = Void
			elseif s2 = Void then
				Result := False
			else
				Result := s1.same_string (s2)
			end
		end

feature -- Element change

	set_id (a_id: like id)
		do
			id := a_id
		end

	set_text (a_text: READABLE_STRING_GENERAL)
		local
			s32: STRING_32
		do
			create s32.make_from_string_general (a_text)
			s32.right_adjust
			create {IMMUTABLE_STRING_32} text.make_from_string (s32)
		end

	set_lang (a_lang: detachable READABLE_STRING_8)
		do
			lang := a_lang
		end

	set_caption  (a_caption: detachable READABLE_STRING_32)
		do
			caption := a_caption
		end

	set_link (a_link_url: detachable READABLE_STRING_8)
		do
			link := a_link_url
		end

	set_is_locked (b: BOOLEAN)
		do
			is_locked := b
		end

	lock
		do
			set_is_locked (True)
		end

	unlock
		do
			set_is_locked (False)
		end

end
