indexing
	description: "Objects that allow a user to view a component."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_VIEWER

inherit
	EV_DIALOG
		export
			{NONE} all
			{ANY} is_show_requested, show, hide
		redefine
			initialize
		end
	
	GB_COMMAND_HANDLER
		export {NONE}
			all
		undefine
			copy, default_create
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			copy, default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	EIFFEL_ENV
		export
			{NONE} all
		undefine
			copy, default_create
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			copy, default_create
		end
		
	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	initialize is
			-- Initialize `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			tool_bar: EV_TOOL_BAR
			component_button: EV_TOOL_BAR_BUTTON
			separator: EV_HORIZONTAL_SEPARATOR
			tool_bar_separator: EV_TOOL_BAR_SEPARATOR
			horizontal_box: EV_HORIZONTAL_BOX
		do
			Precursor {EV_DIALOG}
			set_title ("Component viewer ")
			set_icon_pixmap (icon)
				-- Set up cancel actions on `Current'.
			fake_cancel_button (Current, agent show_hide_component_viewer_command.execute)
			create vertical_box
			extend (vertical_box)
			
			create tool_bar
			create component_button
			component_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_component_viewer @ 1)
			component_button.drop_actions.extend (agent set_component (?))
			component_button.set_tooltip ("Target component into tool")
			component_button.select_actions.extend (agent show_usage_dialog)
			tool_bar.extend (component_button)
			create tool_bar_separator
			tool_bar.extend (tool_bar_separator)
			create display_button
			display_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_component_display_view)
			display_button.set_tooltip ("Display view")
			tool_bar.extend (display_button)
			display_button.enable_select
			display_button.select_actions.extend (agent set_display_view)
			
			create builder_button
			builder_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_component_build_view)
			builder_button.select_actions.extend (agent set_build_view)
			builder_button.set_tooltip ("Builder view")
			tool_bar.extend (builder_button)
			create tool_bar_separator
			tool_bar.extend (tool_bar_separator)
			
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create type_display
			type_display.align_text_left
			horizontal_box.extend (tool_bar)
			horizontal_box.extend (type_display)
			horizontal_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (horizontal_box)
			create separator
			vertical_box.extend (separator)
			vertical_box.disable_item_expand (separator)
			
			create component_holder
			vertical_box.extend (component_holder)
			set_minimum_size (300, 400)
			is_initialized := True
			display_view_enabled := True
		end

feature -- Access

	component: GB_COMPONENT
		-- Component in `Current'.
		
	display_view_enabled: BOOLEAN
		-- Is `Current' in display view?
		
	build_view_enabled: BOOLEAN is
			-- Is `Current' in build view?
		do
			Result := not display_view_enabled
		end
		
	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := ((create {GB_SHARED_PIXMAPS}).Icon_component_viewer @ 1)
		end
		
feature -- Basic operation
		
	set_component (a_component: GB_COMPONENT) is
			-- Assign `a_component' to `Current'
		local
			new_object: GB_OBJECT
			widget: EV_WIDGET
			an_item: EV_ITEM
			tool_bar_item: EV_TOOL_BAR_ITEM
			tool_bar: EV_TOOL_BAR
			tree_item: EV_TREE_ITEM
			tree: EV_TREE
			list_item: EV_LIST_ITEM
			list: EV_LIST
			menu: EV_MENU
			temp_menu: EV_MENU
			label: EV_LABEL
			menu_item: EV_MENU_ITEM
			a_menu_bar: EV_MENU_BAR
			keep_menu_bar: BOOLEAN
		do
			-- We have to handle all items seperately. There may be a better
			-- way to do this at some point.
			
				-- Reset our previous widgets, as `component'
				-- has now changed.
			display_widget := Void
			builder_widget := Void
				-- Assign `a_component' to `component'.
			component := a_component
				-- Update the title of `Current'.
			set_title ("Component viewer - " + component.name)
				-- Display type
			type_display.set_text ("Type : " + component.root_element_type)
			lock_update
				-- Remove any existing displayed component.
			component_holder.wipe_out

			new_object ?= component.object
			an_item ?= new_object.object
			a_menu_bar ?= new_object.object
			if an_item /= Void then
				display_button.disable_sensitive
				builder_button.disable_sensitive
				tool_bar_item ?= an_item
				if tool_bar_item /= Void then
					create tool_bar
					component_holder.extend (tool_bar)
					tool_bar.extend (tool_bar_item)	
				end
				tree_item ?= an_item
				if tree_item /= Void then
					create tree
					component_holder.extend (tree)
					tree.extend (tree_item)
				end
				list_item ?= an_item
				if list_item /= Void then
					create list
					component_holder.extend (list)
					list.extend (list_item)
				end
				menu ?= an_item
				if menu /= Void then
					create label.make_with_text ("Component is an EV_MENU. Click to display.")
					component_holder.extend (label)
						-- When we call `show' on a menu, the contents only are shown.
						-- To combat this, the menu is added into a temporary menu item.
						-- This ensures that the top level of the menu is actually shown.
						-- This only needs to be done on Windows, as on Gtk, the top menu item
						-- is actually shown.
					if Eiffel_platform.is_equal ("windows") then
						create temp_menu
						temp_menu.extend (menu)
						label.pointer_button_press_actions.force_extend (agent temp_menu.show)
					else
						label.pointer_button_press_actions.force_extend (agent menu.show)
					end
				else
					menu_item ?= an_item
					if menu_item /= Void then
						create label.make_with_text ("Component is a menu item. Click to display.")
						component_holder.extend (label)
						create temp_menu.make_with_text ("Component is child.")
						temp_menu.extend (menu_item)
						label.pointer_button_press_actions.force_extend (agent temp_menu.show)
					end
				end
					-- A menu bar is not a widget or an item, so we must handle it specially.
			elseif a_menu_bar /= Void then
					-- We may already have another menu bar being displayed in `Current',
					-- so remove it.
				if menu_bar /= Void then
					remove_menu_bar
				end
				create label.make_with_text ("Component is a menu bar and is displayed in this window.")
				component_holder.extend (label)
				set_menu_bar (a_menu_bar)
				keep_menu_bar := True
			else
				display_button.enable_sensitive
				builder_button.enable_sensitive	
				object_handler.recursive_do_all (new_object, agent force_object_to_component)
				if display_view_enabled then
					widget ?= new_object.object	
				else
					widget ?= new_object.display_object
				end
				check
					widget_not_void: widget /= Void
				end
				component_holder.extend (widget)
				if display_view_enabled then
					display_widget := component_holder.item
				else
					builder_widget := component_holder.item
				end
			end
				-- As if we are displaying a menu bar component, we add it to `Current',
				-- we need to remove the menu bar if `a_component' is not representing a
				-- menu bar.
			if not keep_menu_bar then
				remove_menu_bar
			end
			system_status.disable_project_modified
			update
			unlock_update
		end
		
feature -- Status setting
	
	set_display_view is
			-- Set `display_view' to `True' and reflect in `Current'.
		local
			widget: EV_WIDGET
		do
			if not display_view_enabled then
				display_view_enabled := True
				if component /= Void then
					lock_update
					component_holder.wipe_out
					if display_widget = Void then
						widget ?= component.object.object
						check
							widget_not_void: widget /= Void
						end
						component_holder.extend (widget)
						display_widget := component_holder.item
					else
						component_holder.extend (display_widget)
					end
					unlock_update
				end
			end
		ensure
			display_view_set: display_view_enabled
		end
		
	set_build_view is
			-- Set `display_view' to `False' and reflect in `Current'.
		local
			widget: EV_WIDGET
			new_object: GB_OBJECT
		do
			if display_view_enabled then
				display_view_enabled := False
				if component /= Void then
					lock_update
					component_holder.wipe_out
					if builder_widget = Void then
							new_object := component.object
							object_handler.recursive_do_all (new_object, agent force_object_to_component)
							widget ?= new_object.display_object
						check
							widget_not_void: widget /= Void
						end
						component_holder.extend (widget)
						builder_widget := component_holder.item
					else
						component_holder.extend (builder_widget)
					end
					unlock_update
				end
			end
		ensure
			build_view_set: not display_view_enabled
		end
		
feature {NONE} -- Implementation
		
	force_object_to_component (an_object: GB_OBJECT) is
			-- Remove `an_object' from the object list,
			-- and remove the pebbles from current
			-- representations.
			--| FIXME, in the next release, we should not do this
			--| a component should be built as a component
			--| from the start. The current method is most
			--| certainly a hack of sorts.
		local
			display_object: GB_DISPLAY_OBJECT
			pick_and_dropable: EV_PICK_AND_DROPABLE
			widget: EV_WIDGET
		do
			object_handler.objects.prune_all (an_object)
			display_object ?= an_object.display_object
	
			if display_object /= Void then
				pick_and_dropable ?= display_object.child
				pick_and_dropable.remove_pebble
			end
			pick_and_dropable ?= an_object.display_object
				-- We need this as menu bars are not pick and dropable.
			if pick_and_dropable /= Void then
				pick_and_dropable.remove_pebble
			end
			widget ?= an_object.display_object
		end
		
	show_usage_dialog is
				-- Show an information dialog explaining usage
				-- of the component button.
			local
				dialog: EV_INFORMATION_DIALOG
			do
				create dialog.make_with_text (Component_tool_button_warning)
				dialog.show_modal_to_window (Current)
			end

	component_holder: EV_CELL
		-- The current component representation is
		-- placed in here.
		
	display_button, builder_button: EV_TOOL_BAR_RADIO_BUTTON
		-- Buttons used to modify the current display.
		
	display_widget: EV_WIDGET
		-- Display widget of `component'. Used so that if a user
		-- keeps toggling between the display and builder views, we only
		-- have to build the display widget once as it is slow.
		
	builder_widget: EV_WIDGET
		-- Builder widget of `component'. Used so that if a user
		-- keeps toggling between the display and builder views, we only
		-- have to build the builder widget once as it is slow.
		
	type_display: EV_LABEL
		-- Displays root type of `component'.

end -- class GB_COMPONENT_VIEWER
