indexing
	description: "Objects that represent a visible representation of an%
		%invisible container in the display window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_OBJECT

inherit
	EV_FRAME
	
create
	
	make_with_name_and_child

feature -- Initialization
		
	make_with_name_and_child (a_name: STRING; a_child: EV_CONTAINER) is
			-- Create `Current' and assign `a_name' to `text' and `a_child'
			-- to `child'.
		require
			a_child_not_void: a_child /= Void
		do
			default_create
			set_text (a_name)
			child := a_child
			extend (child)
		ensure
			child_assigned_correctly: child = a_child
			text_assigned_correctly: text.is_equal (a_name)
			count_now_one: count = 1
		end

feature -- Access

	child: EV_CONTAINER
		-- Real container contained in and
		-- made visible by `Current'.

end -- class GB_DISPLAY_OBJECT
