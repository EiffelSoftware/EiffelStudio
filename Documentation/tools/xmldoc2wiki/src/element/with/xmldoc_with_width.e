indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_WIDTH

feature -- Access

	width: STRING
			-- Associated width

feature -- Element change

	set_width (v: like width)
			-- Set `width' to `v'
		require
			v_attached: v /= Void
		do
			--| check: integer or percentage!

			width := v
		end

end
