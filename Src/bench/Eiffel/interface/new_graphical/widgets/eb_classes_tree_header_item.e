indexing
	description: "Header item that is used to group clusters, assemblies, libraries, overrides."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_HEADER_ITEM

inherit
	EB_CLASSES_TREE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; an_icon: EV_PIXMAP) is
			-- Create a header with `a_name' and `an_icon'.
		do
			default_create
			set_text (a_name)
			set_tooltip (a_name)
			set_accept_cursor (cursors.cur_cluster)
			set_deny_cursor (cursors.cur_x_cluster)
			set_pixmap (an_icon)
		end

end
