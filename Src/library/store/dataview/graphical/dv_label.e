indexing
	description: "Label."
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

	value: STRING is
			-- Text area value.
		do
			Result := text
		end

feature -- Basic operations

	set_value (a_text: STRING) is
			-- Set display string to `a_text'.
		do
			set_text (a_text)
		end

	request_sensitive is
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive is
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness is
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness is
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end

feature -- Status report

	is_locked: BOOLEAN;
			-- Is label sensitiveness locked?

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_LABEL
