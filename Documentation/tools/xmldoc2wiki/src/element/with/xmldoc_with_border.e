indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_BORDER

feature {NONE} -- Initialization

	make
		do
			border := - 1
		end

feature -- Access

	border: INTEGER
			-- Associated border

feature -- Status Report

	has_border: BOOLEAN
		do
			Result := border >= 0
		end

feature -- Element change

	set_border (v: like border)
			-- Set `border' to `v'
		require
			v_positive_or_zero: v >= 0
		do
			border := v
		end

end
