indexing
	description: "Toolbar for Class Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW_TOOLBAR

inherit

	BUTTON_SELECTION_MANAGEMENT

creation
	make

feature -- Initialization

	make (cont: EV_HORIZONTAL_BOX;par: EV_WINDOW) is
			-- Initialization.
		require
			parent_exists: par /= Void
			container_exists: cont /= Void
		do
			horiz := cont
			parent ?= par
			!! tool_bar.make (cont)
			fill_with_buttons
			tool_bar.set_vertical_resize ( FALSE )
			tool_bar.set_expand(FALSE)
		end

feature {NONE} -- GRaphical Implementation

	horiz: EV_HORIZONTAL_BOX
		-- Horizonal Container of Current.

	tool_bar: EV_TOOL_BAR
		-- Toolbar in which we put the colored buttons.

feature -- Settings

	fill_with_buttons is 
			-- Fill the toolbar with buttons and their associated commands.
		local
			undo_b: EV_TOOL_BAR_BUTTON
			redo_b: EV_TOOL_BAR_BUTTON
			color_b: EV_TOOL_BAR_BUTTON
			iconify_hole_b: EV_TOOL_BAR_BUTTON
			compress_hole_b: EV_TOOL_BAR_BUTTON
			retarget_b: EV_TOOL_BAR_BUTTON
			pixmap: EV_PIXMAP
			undo_command: UNDO_HISTORY
			redo_command: REDO_HISTORY
			color_command: COLORING_COMMAND
			com1,com2: EV_ROUTINE_COMMAND
		do

			!! undo_b.make (tool_bar)
			!! undo_command
			undo_b.add_click_command (undo_command, Void)
			undo_b.set_pixmap (pixmaps.undo_pixmap)

			!! redo_b.make (tool_bar)
			!! redo_command
			redo_b.add_click_command (redo_command, Void)
			redo_b.set_pixmap (pixmaps.redo_pixmap)

			!! cluster_hole_b.make (tool_bar)
			cluster_hole_b.set_pixmap (pixmaps.cluster_pixmap)
			!! com1.make(~drag_cluster)
			cluster_hole_b.activate_pick_and_drop(com1, Void) 

			!! class_hole_b.make (tool_bar)
			pixmap := pixmaps.class_pixmap
			class_hole_b.set_pixmap (pixmap)
			!! com1.make(~drag_class)
			class_hole_b.activate_pick_and_drop (com1,Void)

			!! com1.make(~select_cluster)
			!! cluster_selected_b.make(tool_bar, pixmaps.selected_cluster_pixmap, com1, com2)

			!! com1.make(~select_class)
			!! class_selected_b.make (tool_bar, pixmaps.selected_class_pixmap, com1, com2)

			!! com1.make(~select_cli_creation)
			!! com2.make(~select_cli_creation)
			!! client_link_selected_b.make (tool_bar, pixmaps.show_client_pixmap, com1, com2)

			!! com1.make(~select_agg_creation)
			!! com2.make(~select_agg_creation)
			!! aggregation_selected_b.make (tool_bar, pixmaps.show_aggreg_pixmap, com1, com2)

			!! com1.make(~select_inh_creation)
			!! com2.make(~select_inh_creation)
			!! inheritance_selected_b.make (tool_bar, pixmaps.show_inherit_pixmap, com1, com2)

			!! com1.make(~select_client)
			!! com2.make(~unselect_client)
			!! client_link_visibility_b.make (tool_bar,pixmaps.show_client_pixmap, com1,com2)

			!! com1.make(~select_aggreg)
			!! com2.make(~unselect_aggreg)
			!! aggregation_visibility_b.make (tool_bar, pixmaps.show_aggreg_pixmap, com1,com2)

			!! com1.make(~select_inherit)
			!! com2.make(~unselect_inherit)
			!! inheritance_visibility_b.make(tool_bar, pixmaps.show_inherit_pixmap, com1,com2)
		
			!! com1.make(~select_label)
			!! com2.make(~unselect_label)
			!! label_visibility_b.make (tool_bar, pixmaps.label_pixmap, com1, com2)

			!! com1.make(~select_imp)
			!! com2.make(~unselect_imp)
			!! all_visibility_b.make(tool_bar,pixmaps.comp_inherit_pixmap, com1, com2)


			!! color_b.make(tool_bar)
			!! color_command.make(parent)
			color_b.set_pixmap (pixmaps.color_pixmap)
			color_b.add_click_command(color_command, Void)

			!! cluster_window_name.make (widget_names.target_name_tool, horiz, parent)
		end

feature -- Properties

	update is
			-- Update text within the namer. Will be removed.
		local
			entity: CLUSTER_DATA
		do
			if cluster_window_name /= Void then
		
				entity := parent.entity
				if entity /= Void then
					cluster_window_name.set_text (entity.name)
				end
			end
		end

feature -- Settings

	set_workarea(new_workarea: WORKAREA) is
			-- Set the workarea.
		do
			workarea := new_workarea
		end

feature -- Implementation

	parent: MAIN_WINDOW
		-- Parent Window.

	cluster_window_name: CLUSTER_WINDOW_NAME
		-- Namer, has to be removed.

	workarea: WORKAREA 
		-- Associated Workarea.

invariant
		parent_exists: parent /= Void
		container_exists: horiz /= Void

end -- class CLASS_WINDOW_TOOLBAR
