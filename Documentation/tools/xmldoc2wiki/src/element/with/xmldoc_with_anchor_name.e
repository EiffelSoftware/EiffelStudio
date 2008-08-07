indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_ANCHOR_NAME

feature -- Access

	anchor_name: STRING
			-- Associated anchor_name

feature -- Element change

	set_anchor_name (v: like anchor_name)
			-- Set `anchor_name' to `v'
		require
			v_attached: v /= Void
		do
			create anchor_name.make_from_string (v)
			anchor_name.left_adjust
			anchor_name.right_adjust
		end

end
