indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_URL

feature -- Access

	url: STRING
			-- Associated url

	is_external: BOOLEAN

feature -- Element change

	set_url (v: like url)
			-- Set `url' to `v'
		require
			v_attached: v /= Void
		do
			create url.make_from_string (v)
			url.left_adjust
			url.right_adjust
			is_external := url.substring_index ("://", 1) > 0
		ensure
			url_valid: url /= Void and then url.occurrences ('%N') = 0
		end

invariant
	valid_url: url /= Void implies url.occurrences ('%N') = 0

end
