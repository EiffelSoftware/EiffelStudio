indexing
	description: "Wizard help context sent to help engine%
				%Made of a URL and a base address.%
				%The URL is relative to the base address."
	legal: "See notice at end of class."
	status: "See notice at end of class."

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WIZARD_HELP_CONTEXT

