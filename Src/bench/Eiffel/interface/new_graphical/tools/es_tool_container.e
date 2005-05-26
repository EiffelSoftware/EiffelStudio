indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TOOL_CONTAINER
	
inherit
	EB_EXPLORER_BAR_ATTACHABLE
	ES_NOTEBOOK_ATTACHABLE

create
	make

feature

	make (a_name: STRING; a_manager: EB_TOOL_MANAGER) is
			-- Initialize `Current'.
		do
			manager := a_manager
			title := a_name

				-- Register and initialize
			build_interface
		end

feature -- Interface

	build_interface is
		local
			vb: EV_VERTICAL_BOX
			t: EV_LABEL
		do
			create vb
			create t.make_with_text ("fake tool")
			vb.extend (t)
			widget := vb
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make (explorer_bar, widget, title, False)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

	build_notebook_item (nb: ES_NOTEBOOK) is
		do
			create notebook_item.make (nb, widget, title)
--			notebook_item.drop_actions.extend (agent on_element_drop)
			nb.extend (notebook_item)
		end

feature -- Access

	manager: EB_TOOL_MANAGER

	widget: EV_WIDGET
	
	title: STRING 

	menu_name: STRING is
		do
			Result := "ES Tool Container"
		end

	pixmap: ARRAY [EV_PIXMAP] is
		do
		end

feature -- change

	change_manager_and_explorer (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature {NONE} -- Implementation

end
