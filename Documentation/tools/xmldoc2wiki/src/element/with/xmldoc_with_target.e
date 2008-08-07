indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_TARGET

feature -- Access

	target: STRING
			-- Associated target

feature -- Element change

	set_target (v: like target)
			-- Set `target' to `v'
		require
			v_attached: v /= Void
		do
			create target.make_from_string (v)
			target.left_adjust
			target.right_adjust
		end

end
