indexing
	description: "Page on which is displayed the EiffelCode of a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH_PAGE

inherit
	EDITOR_WINDOW_PAGE
		rename
			entity as entity_editor_window_page,
			make as make_editor_window_page
		end

	CONSTANTS

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY; caller: like caller_window) is
			-- Initialize
		local
			edit_text_command: EDIT_TEXT_COMMAND
			apply_text_command: APPLY_TEXT_COMMAND
			find_stone_text_command: FIND_STONE_TEXT_COMMAND

			edit_box: EV_HORIZONTAL_BOX
		do
			make_editor_window_page (noteb, ent)

			caller_window := caller

			notebook.append_page(page, "Graph")
		
			create_widgets

		--	update
		end

	create_widgets is
		local
			h1: EV_HORIZONTAL_SPLIT_AREA
			h0: EV_HORIZONTAL_BOX
			v1,v2,v3: EV_VERTICAL_BOX
		do
			!! v3.make(page)
			v3.set_homogeneous(FALSE)
			!! h0.make(v3)
			!! toolbar.make(h0, caller_window)
			h0.set_expand(FALSE)
			!! h1.make(v3)
			h1.set_position(200)
			!! v1.make (h1)
			!! v2.make (h1)

			!! tree_component.make (v1 ,caller_window)
			!! misc_component.make (v1, caller_window)
			!! drawing_area.make (v2, caller_window)
			toolbar.set_workarea(drawing_area.drawing_Area)
		end


feature -- Access

	reset, do_page is do end

	clear is 
		-- Clear all fields/buttons of Current
		do
		end

	update is
		do
			if tree_component /= Void then
				tree_component.update
			end

			if misc_component /= Void then
				misc_component.update
			end

			if drawing_area /= Void then
				drawing_area.update
			end
		end

	Update_from (ent: ANY) is
			-- Update from 'ent' 
		do
		end

feature -- Implementation

	caller_window: MAIN_WINDOW

	drawing_area: DRAWING_COMPONENT

	tree_component: TREE_COMPONENT

	misc_component: MISC_COMPONENT

	toolbar: MAIN_WINDOW_TOOLBAR

end -- class CLASS_CODE_PAGE
