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