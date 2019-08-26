note
	description: "Text field or text area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TEXT_FIELD

inherit
	EV_TEXT_FIELD

	DV_SENSITIVE_STRING
		undefine
			default_create,
			copy
		end

feature -- Access

	value: STRING_32
			-- Text area value.
		do
			Result := text
		end

feature -- Basic operations

	set_value (a_text: READABLE_STRING_GENERAL)
			-- Set display string to `a_text'.
		local
			s32: STRING_32
		do
			if a_text /= Void and then not a_text.is_empty then
				if a_text.has ('%R') then
					create s32.make_from_string_general (a_text)
					s32.prune_all ('%R')
					set_text (s32)
				else
					set_text (a_text)
				end
			else
				remove_text
			end
		end

	request_sensitive
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end

feature -- Status report

	is_locked: BOOLEAN;
			-- Is label sensitiveness locked?

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DV_TEXT_FIELD


