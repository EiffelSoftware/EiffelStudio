indexing
	description: "Objects that allow a user to view a component."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_VIEWER

inherit
	EV_TITLED_WINDOW
		redefine
			initialize
		end
	
	GB_COMMAND_HANDLER
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
		do
			set_title ("Component viewer ")
			create vertical_box
			extend (vertical_box)
			
			create tool_bar
			create component_button
			component_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_delete_small @ 1)
			component_button.drop_actions.extend (agent set_component (?))
			tool_bar.extend (component_button)
			create tool_bar_separator
			tool_bar.extend (tool_bar_separator)
			create display_button
			display_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_delete_small @ 1)
			tool_bar.extend (display_button)
			display_button.enable_select
			display_button.select_actions.extend (agent set_display_view)
			
			create builder_button
			builder_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_delete_small @ 1)
			builder_button.select_actions.extend (agent set_build_view)
			tool_bar.extend (builder_button)
			
			vertical_box.extend (tool_bar)
			vertical_box.disable_item_expand (tool_bar)
			create separator
			vertical_box.extend (separator)
			vertical_box.disable_item_expand (separator)
			
			create component_holder
			vertical_box.extend (component_holder)
			set_minimum_size (300, 400)
			is_initialized := True
			display_view := True
			close_request_actions.extend (agent (show_hide_component_viewer_command).execute)
		end

feature -- Access

	component: GB_COMPONENT
		-- Component in `Current'.
		
feature -- Basic operation
		
	set_component (a_component: GB_COMPONENT) is
			-- Assign `a_component' to `Current'
		do
				-- Rest our previous widgets, as `component'
				-- has now changed.
			display_widget := Void
			builder_widget := Void
				-- Assign `a_component' to `component'.
			component := a_component
				-- Update the title of `Current'.
			set_title ("Component viewer - " + component.name)
			lock_update
				-- Remove any exisiting displayed component.
			component_holder.wipe_out
			if display_view then
				component_holder.extend (component.object)
				display_widget := component_holder.item
			else
				component_holder.extend (component.display_object)
				builder_widget := component_holder.item
			end
			unlock_update
		end
	
feature {NONE} -- Implementation

	set_display_view is
			-- Set `display_view' to `True' and reflect in `Current'.
		do
			if not display_view then
				display_view := True
				if component /= Void then
					lock_update
					component_holder.wipe_out
					if display_widget = Void then
						component_holder.extend (component.object)
						display_widget := component_holder.item
					else
						component_holder.extend (display_widget)
					end
					unlock_update
				end
			end
		ensure
			display_view_set: display_view
		end
		
	set_build_view is
			-- Set `display_view' to `False' and reflect in `Current'.
		do
			if display_view then
				display_view := False
				if component /= Void then
					lock_update
					component_holder.wipe_out
					if builder_widget = Void then
						component_holder.extend (component.display_object)
						builder_widget := component_holder.item
					else
						component_holder.extend (builder_widget)
					end
					unlock_update
				end
			end
		ensure
			build_view_set: display_view = False
		end
		

	display_view: BOOLEAN
		-- Current display mode for component.
		-- If `Result' `True' then display mode.
		-- If `Result' `False' then build mode.

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

end -- class GB_COMPONENT_VIEWER
