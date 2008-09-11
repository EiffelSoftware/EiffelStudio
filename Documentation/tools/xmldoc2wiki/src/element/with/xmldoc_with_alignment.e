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
			alignment := 0
		end

feature -- Access

	alignment: INTEGER
			-- Associated url

	has_alignment: BOOLEAN
		do
			Result := alignment > 0
		end

	is_align_center: BOOLEAN
		do
			Result := alignment = align_center
		end

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
			elseif v.is_case_insensitive_equal (once "left") then
				alignment := align_left
			else
				alignment := 0
			end
		end

feature {NONE} -- Constants

	align_left: INTEGER = 1
	align_center: INTEGER = 2
	align_right: INTEGER = 3


end
