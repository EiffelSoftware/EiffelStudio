indexing
	description: "Check button."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_CHECK_BUTTON

inherit
	EV_CHECK_BUTTON

	DV_SENSITIVE_CHECK
		rename
			enable_checked as enable_select,
			disable_checked as disable_select
		undefine
			default_create,
			copy
		end

create
	make_with_text

feature -- Access

	checked: BOOLEAN is
			-- Boolean value held.
		do
			Result := is_selected
		end

feature -- Basic operations

	request_sensitive is
			-- Request display sensitive.
		do
			enable_sensitive
		end

	request_insensitive is
			-- Request display insensitive.
		do
			disable_sensitive
		end

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
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_CHECK_BUTTON
