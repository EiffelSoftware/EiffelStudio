indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_STYLE

feature -- Access

	style: STRING
			-- Associated style

feature -- Element change

	set_style (v: like style)
			-- Set `style' to `v'
		require
			v_attached: v /= Void
		do
			create style.make_from_string (v)
			style.left_adjust
			style.right_adjust
		end

end
