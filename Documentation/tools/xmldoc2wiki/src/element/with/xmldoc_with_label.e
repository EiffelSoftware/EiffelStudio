indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_LABEL

feature -- Access

	label: STRING
			-- Associated label

feature -- Element change

	set_label (v: like label)
			-- Set `label' to `v'
		require
			v_attached: v /= Void
		do
			create label.make_from_string (v)
			label.left_adjust
			label.right_adjust
		end

end
