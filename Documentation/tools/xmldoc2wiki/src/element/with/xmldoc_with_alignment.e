indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_ALIGNMENT

feature {NONE} -- Initialization

	make
		do
			alignment := align_left
		end

feature -- Access

	alignment: INTEGER
			-- Associated url

feature -- Element change

	set_alignment (v: STRING) is
			-- Set `alignment' to value related to `v'
		require
			v_attached: v /= Void
		do
			if v.is_case_insensitive_equal (once "center") then
				alignment := align_center
			elseif v.is_case_insensitive_equal (once "right") then
				alignment := align_right
--			elseif v.is_case_insensitive_equal (once "left") then				
			else
				alignment := align_left
			end
		end

feature -- Constants

	align_left: INTEGER = 1
	align_center: INTEGER = 2
	align_right: INTEGER = 3


end
