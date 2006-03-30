indexing
	description: "Header item that is used to group clusters, assemblies, libraries, overrides."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_HEADER_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			data,
			set_data
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like data) is
			-- Create a header for `a_name'.
		do
			default_create
			set_data (a_name)
		end

feature -- Access

	data: STRING

feature -- Status setting

	set_data (a_name: like data) is
			-- Affect `a_cluster' to `data'.
		local
			l_cluster: CLUSTER_I
			l_group: CONF_GROUP
			l_name: STRING
			l_pos: INTEGER
		do
			set_text (a_name)
			set_tooltip (a_name)
			set_accept_cursor (cursors.cur_cluster)
			set_deny_cursor (cursors.cur_x_cluster)
			set_pixmap (pixmaps.icon_cluster_symbol)
		ensure then
			data = a_name
		end

end
