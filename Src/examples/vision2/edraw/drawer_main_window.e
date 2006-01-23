indexing
	description: "Objects that is the main window for the Eiffel Draw example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWER_MAIN_WINDOW

inherit
	MAIN_WINDOW
		redefine
			build_main_container,
			build_standard_toolbar
		end
		
	EV_FIGURE_MATH
		export
			{NONE} all
		undefine
			default_create,
			copy
		end
		
	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end
		
create
	default_create

feature {NONE} -- Implementation

	build_main_container is
			-- Create and populate `main_container'.
		local
			hbox: EV_HORIZONTAL_BOX
			fixed: EV_FIXED
			
		do
			create main_container

			create hbox

				create settings_bar
				
					create fixed
						create fg_color_chooser.make_with_text ("foreground")
						fg_color_chooser.color_change_actions.extend (agent fg_color_changed)
						fg_color_chooser.disable_none_color_selectable
						
					fixed.extend (fg_color_chooser)
					fixed.set_item_size (fg_color_chooser, 80, 130)
					
				settings_bar.extend (fixed)
				
					create fixed
						create bg_color_chooser.make_with_text ("background")
						bg_color_chooser.color_change_actions.extend (agent bg_color_changed)
						
					fixed.extend (bg_color_chooser)
					fixed.set_item_size (bg_color_chooser, 80, 130)
					
				settings_bar.extend (fixed)
				
					create fixed
						create line_style_chooser.make
						line_style_chooser.select_actions.extend (agent line_style_selected)
						
					fixed.extend (line_style_chooser)
					fixed.set_item_width (line_style_chooser, 80)
					
				settings_bar.extend (fixed)

				create fixed
				fixed.extend (settings_bar)
				fixed.set_item_width (settings_bar, 82)
			
			hbox.extend (fixed)
			hbox.disable_item_expand (fixed)
			
			create world
			
			create world_cell.make_with_world (world)
			
			projector := world_cell.projector
			
			world_cell.set_new_figure_line_width (1)
			world_cell.set_new_figure_foreground_color (create {EV_COLOR}.make_with_rgb (0, 0, 0))
			
			hbox.extend (world_cell)
			
			main_container.extend (hbox)
		end
		
	world_cell: DRAWING_AREA_CELL
			-- Cell containing the drawing part.
			
	settings_bar: EV_VERTICAL_BOX
			-- The bar on the left side with the color choosers.
			
	projector: EV_MODEL_BUFFER_PROJECTOR
			-- The projector
			
	world: MULTI_SELECTION_WORLD
			-- The world.
	
feature {NONE} -- ToolBar Implementation

	build_standard_toolbar is
			-- Create and populate the standard toolbar.
		local
			toolbar_button: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
			Precursor {MAIN_WINDOW}
			
			standard_toolbar.extend (create {EV_TOOL_BAR_SEPARATOR})
			
			create radio_buttons.make (17)
			
			add_radio_button ("select")
			
			add_radio_button ("line")
			
			add_radio_button ("rect")
			add_radio_button ("rounded_rect")
			add_radio_button ("parallelogram")
			add_radio_button ("rounded_parallelogram")
			add_radio_button ("polygon")
			add_radio_button ("polyline")
			add_radio_button ("equilateral")
			
			add_radio_button ("ellipse")
			add_radio_button ("arc")
			add_radio_button ("pie")
			
			add_radio_button ("dot")
			add_radio_button ("star")
			
			add_radio_button ("text")
			
			add_radio_button ("picture")

			
			standard_toolbar.extend (create {EV_TOOL_BAR_SEPARATOR})
			
			create toolbar_button
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/group.png")
			toolbar_button.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_button)
			toolbar_button.select_actions.extend (agent on_group)
			
			create toolbar_button
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/ungroup.png")
			toolbar_button.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_button)
			toolbar_button.select_actions.extend (agent on_ungroup)
			
			create toolbar_button
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/tofront.png")
			toolbar_button.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_button)
			toolbar_button.select_actions.extend (agent on_tofront)
			
			create toolbar_button
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/toback.png")
			toolbar_button.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_button)
			toolbar_button.select_actions.extend (agent on_toback)
			
			standard_toolbar.extend (create {EV_TOOL_BAR_SEPARATOR})
			
			create grid_enabled
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/magnet.png")
			grid_enabled.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (grid_enabled)
			grid_enabled.select_actions.extend (agent on_grid_enable_select)
			world.disable_grid
			
			create grid_visible
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/grid.png")
			grid_visible.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (grid_visible)
			grid_visible.select_actions.extend (agent on_grid_visible_select)
			world.hide_grid
			world.set_grid_x (10)
			world.set_grid_y (10)
			
			fg_color_chooser.set_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			
			is_dashed_line_style := False
			line_width := 1
		end
		
	radio_buttons: HASH_TABLE [EV_TOOL_BAR_RADIO_BUTTON, STRING]
			-- All radio buttons to draw or manipulate figures.

	add_radio_button (name: STRING) is
			-- Add a radio button to `radio_buttons' with `name'
		require
			radio_buttons_exitst: radio_buttons /= Void
		local
			toolbar_item: EV_TOOL_BAR_RADIO_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./toolbar/" + name + ".png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)
			radio_buttons.extend (toolbar_item, name)
			toolbar_item.select_actions.extend (agent on_radio_button_select)
		ensure
			added: old radio_buttons.count + 1 = radio_buttons.count
		end

	on_radio_button_select is 
			-- Called after a radio button in `radio_buttons' was selected.
		do
			standard_status_label.set_text ("")
			if is_select_mode then
				world.enable_selection
			else
				world.disable_selection
			end
			from
				radio_buttons.start
			until
				radio_buttons.after
			loop
				if radio_buttons.item_for_iteration.is_selected then
					world_cell.set_drawing_mode (radio_buttons.key_for_iteration)
				end
				radio_buttons.forth
			end
			world_cell.stop_drawing
		end
		
	grid_enabled: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Grid enable button.
	
	on_grid_enable_select is
			-- Grid enabled was pressed.
		do
			if is_grid_enabled then
				world.enable_grid
			else
				world.disable_grid
			end	
			world.full_redraw
			projector.project
		end
		
	grid_visible: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Grid visible button.
	
	on_grid_visible_select is
			-- Grid visible was pressed.
		do
			if is_grid_visible then
				world.show_grid
			else
				world.hide_grid
			end
			world.full_redraw
			projector.project
		end

feature {NONE} -- Menu Implementation

	build_extended_menu_bar is
			-- Build menus other then file and help.
		do
			standard_menu_bar.extend (edit_menu)
		end
		
	edit_menu: EV_MENU is
			-- Build edit menu.
		local
			menu_item: EV_MENU_ITEM
		do
			create Result.make_with_text (menu_edit)

			create menu_item.make_with_text (menu_edit_select_all)
			menu_item.select_actions.extend (agent on_select_all)
			Result.extend (menu_item)
			
			create menu_item.make_with_text (menu_edit_deselect_all)
			menu_item.select_actions.extend (agent on_deselect_all)
			Result.extend (menu_item)
			
			create menu_item.make_with_text (menu_edit_invert_selection)
			menu_item.select_actions.extend (agent on_invert_selection)
			Result.extend (menu_item)

			Result.extend (create {EV_MENU_SEPARATOR})
			
			create menu_item.make_with_text (menu_edit_delete_selected)
			menu_item.select_actions.extend (agent on_delete_selected)
			Result.extend (menu_item)
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

feature {NONE} -- Application state

	is_grid_enabled: BOOLEAN is
			-- Is snapp to grid enabled?
		do
			Result := grid_enabled.is_selected
		end
	
	is_grid_visible: BOOLEAN is
			-- Is grid visible?
		do
			Result := grid_visible.is_selected
		end
		
	is_select_mode: BOOLEAN is
			-- Is current mode select?
		do
			Result := radio_buttons.item ("select").is_selected
		end

feature {NONE} -- Order and group change
		
	on_group is
			-- Group button was pressed.
		do
			standard_status_label.set_text ("")
			if world.selected_figures.count > 1 then
				world.group_selection
				projector.project
			else
				if world.selected_figures.is_empty then
					standard_status_label.set_text (select_a_figure_text)
				else
					standard_status_label.set_text (select_more_then_one_figure_text)
				end
			end
		end
		
	on_ungroup is
			-- Ungroup button was pressed.
		do
			standard_status_label.set_text ("")
			if world.selected_figures.count = 1 then
				world.ungroup_selection
				projector.project
			else
				if world.selected_figures.is_empty then
					standard_status_label.set_text (select_a_figure_text)
				else
					standard_status_label.set_text (select_only_one_figure_text)
				end
			end
		end
		
	on_tofront is
			-- tofront button was pressed.
		do
			standard_status_label.set_text ("")
			if world.selected_figures.count = 1 then
				world.bring_to_front (world.selected_figures.first.group)
				projector.project
			else
				if world.selected_figures.is_empty then
					standard_status_label.set_text (select_a_figure_text)
				else
					standard_status_label.set_text (select_only_one_figure_text)
				end
			end
		end
		
	on_toback is
			-- toback button was pressed.
		do
			standard_status_label.set_text ("")
			if world.selected_figures.count = 1 then
				world.send_to_back (world.selected_figures.first.group)
				projector.project
			else
				if world.selected_figures.is_empty then
					standard_status_label.set_text (select_a_figure_text)
				else
					standard_status_label.set_text (select_only_one_figure_text)
				end
			end
		end
		
feature {NONE} -- Color

	bg_color_chooser: COLOR_CHOOSER
			-- Color chooser for background color.
			
	bg_color_changed is
			-- Background color was changed to `color'
		local
			color: EV_COLOR
		do
			color := bg_color_chooser.color
			world_cell.set_new_figure_background_color (color)
			from
				world.selected_figures.start
			until
				world.selected_figures.after
			loop
				set_bg_color (world.selected_figures.item)
				
				world.selected_figures.forth
			end
			projector.project
		end
		
	fg_color_chooser: COLOR_CHOOSER
			-- Color chooser for forground color.
			
	fg_color_changed is
			-- Forground color was changed to `color'
		local
			color: EV_COLOR
		do
			color := fg_color_chooser.color
			world_cell.set_new_figure_foreground_color (color)
			from
				world.selected_figures.start
			until
				world.selected_figures.after
			loop
				set_fg_color (world.selected_figures.item)
				world.selected_figures.forth
			end
			projector.project
		end
		
feature {NONE} -- Line Style

	line_style_chooser: LINE_STYLE_CHOOSER
			-- The box to choose the line style from.
		
	line_style_selected is
			-- A line style was selected
		do
			line_width := line_style_chooser.line_width
			is_dashed_line_style := line_style_chooser.is_dashed_line_style
			world_cell.set_new_figure_line_width (line_width)
			if is_dashed_line_style then
				world_cell.new_figure_enable_dashed_line_style
			else
				world_cell.new_figure_disable_dashed_line_style
			end
			
			from
				world.selected_figures.start
			until
				world.selected_figures.after
			loop
				set_line_style (world.selected_figures.item)
				world.selected_figures.forth
			end
			projector.project
		end
		
	is_dashed_line_style: BOOLEAN
			-- Is current line style dashed?
			-- Default: False
			
	line_width: INTEGER
			-- Current line width.
			-- Default: 1

feature {NONE} -- File menu Events 

	on_save_as is
			-- Save as was selected.
		local
			dialog: EV_FILE_SAVE_DIALOG
			file_name, ext: STRING
		do
			create dialog
			dialog.filters.extend (["*.png", "PNG File"])
			dialog.filters.extend (["*.ps", "Postscript File"])
			dialog.show_modal_to_window (Current)
			
			file_name := dialog.file_name
			if file_name.count > 4 then
				ext := file_name.substring (file_name.count - 3, file_name.count)
				ext.to_lower
				if dialog.selected_filter_index = 1 and not ext.is_equal (".png") then
					file_name := file_name + ".png"
				end
				if dialog.selected_filter_index = 2 and not ext.substring (2, ext.count).is_equal (".ps") then
					file_name := file_name + ".ps"
				end
			elseif file_name.count > 0 then
				if dialog.selected_filter_index = 1 then
					file_name := file_name + ".png"
				else
					file_name := file_name + ".ps"
				end	
			end
			if file_name.count > 0 then
				if dialog.selected_filter_index = 1 then
					last_file_type := 1
				else
					last_file_type := 2
				end
				last_file_name := file_name
				save (create {FILE_NAME}.make_from_string (last_file_name), last_file_type)
			end
		end
		
	last_file_name: STRING
			-- last used file name.
			
	last_file_type: INTEGER
			-- 1 png, 2 ps
			
	on_save is
			-- Save using last_file_name or call save_as if last_file_name is void.
		do
			if last_file_name = Void then
				on_save_as
			else
				save (create {FILE_NAME}.make_from_string (last_file_name), last_file_type)
			end
		end
		
	save (file: FILE_NAME; type: INTEGER) is
			-- Save `buffer' to `file'.
			-- type = 1 -> png
			-- type = 2 -> ps
		require
			file_exists: file /= Void
		local	
			postscript_projector: EV_MODEL_POSTSCRIPT_PROJECTOR
			l_selected_figures: LIST [EV_MODEL]
			pixmap: EV_PIXMAP
			dialog: EV_WARNING_DIALOG
		do
			l_selected_figures := world.selected_figures.twin
			world.deselect_all
			
			if type = 1 then
				pixmap := projector.world_as_pixmap (5)
				if projector.is_world_too_large then
					create dialog.make_with_text ("Image is too large, not enough video memory")
					dialog.show_modal_to_window (Current)
				else
					pixmap.save_to_named_file (create {EV_PNG_FORMAT}, file)
				end
			elseif type = 2 then
				create postscript_projector.make_with_filename (world, file)
				world.full_redraw
				postscript_projector.project
			end
			
			from
				l_selected_figures.start
			until
				l_selected_figures.after
			loop
				world.select_figure (l_selected_figures.item)
				l_selected_figures.forth
			end
		end
		
	on_new is
			-- New was selected.
		do
			world.wipe_out
			projector.project
		end
		
feature {NONE} -- Edit menu events

	on_select_all is
			-- Select all figures.
		do
			world.select_all
			world.full_redraw
			projector.project
		end
		
	on_deselect_all is
			-- Deselect all figures.
		do
			world.deselect_all
			world.full_redraw
			projector.project
		end
		
	on_delete_selected is
			-- Delete all selected figures.
		do
			world.delete_selected
			world.full_redraw
			projector.project
		end
		
	on_invert_selection is
			-- Invert the selection.
		do
			world.invert_selection
			world.full_redraw
			projector.project
		end
		
feature {NONE} -- Implementation

	set_bg_color (figure: EV_MODEL) is
			-- Set background color.
		local
			group: EV_MODEL_GROUP
			cf: EV_MODEL_CLOSED
		do
			group ?= figure
			if group /= Void then
				from 
					group.start
				until
					group.after
				loop
					set_bg_color (group.item)
					group.forth
				end
			else
				cf ?= figure
				if cf /= Void then
					if bg_color_chooser.color /= Void then
						cf.set_background_color (bg_color_chooser.color)
					else
						cf.remove_background_color
					end
				end
			end
		end
		
	set_fg_color (figure: EV_MODEL) is
			-- Set foreground color.
		local
			group: EV_MODEL_GROUP
			af: EV_MODEL_ATOMIC
		do
			group ?= figure
			if group /= Void then
				from 
					group.start
				until
					group.after
				loop
					set_fg_color (group.item)
					group.forth
				end
			else
				af ?= figure
				if af /= Void then
					af.set_foreground_color (fg_color_chooser.color)
				end
			end
		end
		
	set_line_style (figure: EV_MODEL) is
			-- Set line width, is_dashed and color for all figures in figure.
		local
			group: EV_MODEL_GROUP
			af: EV_MODEL_ATOMIC
		do
			group ?= figure
			if group /= Void then
				from 
					group.start
				until
					group.after
				loop
					set_line_style (group.item)
					group.forth
				end
			else
				af ?= figure
				if af /= Void then
					af.set_line_width (line_width)
					if is_dashed_line_style then
						af.enable_dashed_line_style
					else
						af.disable_dashed_line_style
					end
				end
			end
		end
		
	snapped_x (ax: INTEGER): INTEGER is
			-- Nearest point on horizontal grid to `ax'.
		do
			if ax \\ world.grid_x < world.grid_x // 2 then
				Result := ax - ax \\ world.grid_x
			else
				Result := ax - ax \\ world.grid_x + world.grid_x
			end
		end

	snapped_y (ay: INTEGER): INTEGER is
			-- Nearest point on vertical grid to `ay'.
		do			
			if ay \\ world.grid_y < world.grid_y // 2 then
				Result := ay - ay \\ world.grid_y
			else
				Result := ay - ay \\ world.grid_y + world.grid_y
			end
		end
		
feature {NONE} -- Implementation print

	print_dialog: EV_PRINT_DIALOG

	on_print is
			-- Print was selected.
		do
			create print_dialog.make_with_title ("Print")
			print_dialog.print_actions.extend (agent do_print)
			print_dialog.show_modal_to_window (Current)

		
		end
		
	do_print is
			-- Print
		local
			pc: EV_PRINT_CONTEXT
			pp: EV_MODEL_PRINT_PROJECTOR
			l_selected_figures: LIST [EV_MODEL]
		do
			pc := print_dialog.print_context
			create pp.make_with_context (world, pc)
		
			l_selected_figures := world.selected_figures.twin
			world.deselect_all

			pp.project
			
			from
				l_selected_figures.start
			until
				l_selected_figures.after
			loop
				world.select_figure (l_selected_figures.item)
				l_selected_figures.forth
			end
		end
		
feature {NONE} -- Text constants

	select_a_figure_text: STRING is "Select a figure first."
	select_only_one_figure_text: STRING is "Select only one figure."
	select_more_then_one_figure_text: STRING is "Select more then one figure."
	press_two_times_return: STRING is "To end text enter mode press two times return."
	menu_edit: STRING is "&Edit"
	menu_edit_select_all: STRING is "&Select all"
	menu_edit_deselect_all: STRING is "&Deselect all"
	menu_edit_invert_selection: STRING is "&Invert selection"
	menu_edit_delete_selected: STRING is "Del&ete selected";
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DRAWER_MAIN_WINDOW
