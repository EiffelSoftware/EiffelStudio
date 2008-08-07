indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_LEGEND

feature -- Access

	legend: STRING
			-- Associated legend

feature -- Element change

	set_legend (v: like legend)
			-- Set `legend' to `v'
		require
			v_attached: v /= Void
		do
			create legend.make_from_string (v)
			legend.left_adjust
			legend.right_adjust
		end

end
