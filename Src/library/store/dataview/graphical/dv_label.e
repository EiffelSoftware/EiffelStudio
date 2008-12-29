note
	description: "Label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_LABEL

inherit
	EV_LABEL

	DV_SENSITIVE_STRING
		undefine
			default_create,
			copy
		end

create 
	default_create,
	make_with_text

feature -- Access

	value: STRING
			-- Text area value.
		do
			Result := text
		end

feature -- Basic operations

	set_value (a_text: STRING)
			-- Set display string to `a_text'.
		do
			set_text (a_text)
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_LABEL


