indexing
	description: "$EiffelGraphicalCompiler$ help context sent to help engine%
				%Made of a URL and a base address.%
				%The URL is relative to the base address."

class
	EB_HELP_CONTEXT

inherit
	EV_HELP_CONTEXT

	EB_HELP_CONTEXTS_BASES
		export
			{NONE} all
		end

create
	make,
	make_absolute

feature {NONE} -- Initialization

	make (a_base_id: INTEGER; a_url: STRING) is
			-- Set `url' with concatenation of base URL identified by `a_base_id' and `a_url'.
			-- See `EB_HELP_CONTEXTS_BASES' for valid `a_base_id' values.
		require
			valid_url: is_valid_url (a_url)
			valid_base: is_valid_base_id (a_base_id)
		do
			url := base_url (a_base_id) + a_url
		end
			
	make_absolute (a_url: STRING) is
			-- Set `url' with `a_url'.
		require
			valid_url: is_valid_url (a_url)
		do
			url := a_url
		ensure
			url_set: url.is_equal (a_url)
		end

feature -- Access

	url: STRING
			-- URL of corresponding HTML file

invariant

	valid_url: is_valid_url (url)

end -- class EB_HELP_CONTEXT