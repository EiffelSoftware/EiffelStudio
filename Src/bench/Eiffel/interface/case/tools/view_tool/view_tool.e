indexing
	description: "View Tool"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEW_TOOL

inherit
	ECASE_WINDOW

creation
	make_viewer,make_selector

feature -- Initialization

	make_viewer (par: EV_WINDOW) is
			-- Initialize
		do
			make(par)
			set_title("View Tool")
			set_minimum_height(250)
			set_minimum_width(200)
			!! view_component.make(Current, 2)
			show
		end

	make_selector(par: EV_WINDOW;retriev: RETRIEVE_PROJECT;system_view: SYSTEM_VIEW_LIST) is
		require
			retrieve_class_exists: retriev /= Void
		do
			make(par)
			set_title("View Selector")
			set_minimum_height(250)
			set_minimum_width(200)
			!! view_component.make(Current, 3)
			view_component.set_mode3(retriev,system_view)
			update
			show
		end 

feature -- Access

	view_component: VIEW_PAGE

feature -- Update

	update is 	
		do
			view_component.ev_list.clear_items
			view_component.fill_list
		end

feature -- Size
	get_height_name : STRING is "view_tool_height"
	get_width_name : STRING is "view_tool_width"


end -- class VIEW_TOOL
