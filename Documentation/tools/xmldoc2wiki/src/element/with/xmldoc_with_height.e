indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_HEIGHT

feature -- Access

	height: STRING
			-- Associated height

feature -- Element change

	set_height (v: like height)
			-- Set `height' to `v'
		require
			v_attached: v /= Void
		do
			--| check integer or percentage
			height := v
		end

end
