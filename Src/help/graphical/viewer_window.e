indexing
	description: "Text Viewer"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER_WINDOW

inherit
	EV_WINDOW

creation
	make_viewer

feature -- Initialization

	make_viewer(caller: VIEWER) is
		do
			viewer := caller
			make_top_level
			set_title("Viewer by ISE")
			set_size(600,350)
			build
			viewer.update("d:\help_tool\structure\example2.xml")
			show
		end

	build is
		local
			left,right: EV_VERTICAL_BOX
			split: EV_HORIZONTAL_SPLIT_AREA
			tabs: EV_NOTEBOOK
			v1,v2: EV_VERTICAL_BOX
		do
			!! status_bar.make(Current)
			!! split.make(Current)
			!! left.make(split)
			!! right.make(split)
			split.set_position(220)

			!! tabs.make(left)
			!! v1.make(tabs)
			!! tree_area.make(v1)
			tabs.append_page(v1,"Tree")
			!! v2.make(tabs)
			!! list_area.make(v2)
			tabs.append_page(v2,"Index")
			
			!! view_area.make(right)
		end

	update(struct:E_DOCUMENT) is
		local
			scom: E_TOPIC_SELECT_COMMAND
			link_com: E_DISPLAY_CLICK_COMMAND
			ccom: E_DISPLAY_CLICK_COMMAND
			tree: EV_TREE
			list: EV_LIST
		do
			create scom.make(status_bar, view_area)
			create tree.make(tree_area)
			struct.create_tree(tree, scom)
			create list.make(list_area)
			struct.create_sorted_indexes(list, scom)
			
			create ccom.make(view_area, struct.topic_lookup)
			view_area.add_button_press_command(1, ccom, Void)
		end

feature -- Access

	viewer: VIEWER

feature -- Widgets

	status_bar: EV_STATUS_BAR

	tree_area: EV_SCROLLABLE_AREA

	list_area: EV_SCROLLABLE_AREA

	view_area: E_TOPIC_DISPLAY

end -- class VIEWER_WINDOW
