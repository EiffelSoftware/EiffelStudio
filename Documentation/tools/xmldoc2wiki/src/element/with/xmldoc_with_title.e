indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_TITLE

feature -- Access

	title: STRING
			-- Associated title

feature -- Element change

	set_title (v: like title)
			-- Set `title' to `v'
		require
			v_attached: v /= Void
		do
			create title.make_from_string (v)
			title.left_adjust
			title.right_adjust
		end

end
