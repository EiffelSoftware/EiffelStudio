indexing
	description: "Wizard help context sent to help engine%
				%Made of a URL and a base address.%
				%The URL is relative to the base address."

class
	WIZARD_HELP_CONTEXT

inherit
	EV_HELP_CONTEXT

	WIZARD_HELP_CONTEXT_BASES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_url: STRING) is
			-- Set `url' with concatenation of back slash and `a_url'.
		require
			valid_url: is_valid_url (a_url)
		do
			url := "\" + a_url
		end

feature -- Access

	url: STRING
			-- URL of corresponding HTML file

invariant

	valid_url: is_valid_url (url)

end -- class WIZARD_HELP_CONTEXT

--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

