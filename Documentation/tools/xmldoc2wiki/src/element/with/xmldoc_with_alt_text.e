indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_ALT_TEXT

feature -- Access

	alt_text: STRING
			-- Associated text

feature -- Element change

	set_alt_text (t: like alt_text)
			-- Set `alt_text' to `t'
		require
			t_attached: t /= Void
		do
			alt_text := t
		end

end
