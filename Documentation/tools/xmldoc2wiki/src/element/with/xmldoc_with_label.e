indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_LABEL

feature -- Access

	label: XMLDOC_LABEL
			-- Associated label

feature -- Element change

	set_label (v: like label)
			-- Set `label' to `v'
		require
			v_attached: v /= Void
		do
			label := v
		end

end
