indexing
	description: "Window for configuring EiffelBuild projects"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_WINDOW

inherit
	
	EV_DIALOG
		redefine
			initialize
		end
	
	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			build_interface
		end
		

feature -- Tab access

	general_tab: GB_SYSTEM_GENERAL_TAB 
			-- Widget describing General tab.
			
	build_tab: GB_SYSTEM_BUILD_TAB
			-- Widget describing build tab.
			
	generation_tab: GB_SYSTEM_GENERATION_TAB
			-- Widget describing code generation tab.

feature -- Actions

	ok_action is
			-- Action performed when clicking `Ok' button.
		do
			validate_tabs
			if last_validation_successful then
					-- Store the settings into the current project
					-- settings.
				store_project_information
					-- Save the current project settings to disk.
				system_status.current_project_settings.save
				hide
			end
			command_handler.update
		end

	cancel_action is
			-- Action performed when clicking `Cancel' button.
		do
			hide
			command_handler.update
		end
		
feature -- Basic operation

	display_project_information is
			-- Update all members of `tab_list' to display
			-- details held in project currently being developed
			-- in the system.
		require
			project_open: system_status.project_open
		do
			from
				tab_list.start
			until
				tab_list.off
			loop
				tab_list.item.update_attributes (system_status.current_project_settings)
				tab_list.forth
			end
		end
		
	store_project_information is
			-- Update project settings to reflect information
			-- entered into `Current'.
		require
			project_open: system_status.project_open
		do
			from
				tab_list.start
			until
				tab_list.off
			loop
				tab_list.item.save_attributes (system_status.current_project_settings)
				tab_list.forth
			end
		end

feature {NONE} -- Initialization

	build_interface is
			-- Build window interface.
		local
			notebook: EV_NOTEBOOK
			vbox: EV_VERTICAL_BOX
			button: EV_BUTTON
			hbox: EV_HORIZONTAL_BOX
		do
			set_title ("Project configuration")

			create hbox
			hbox.set_padding (Small_padding_size)
			hbox.set_border_width (Default_border_size)
			create notebook
			create general_tab
			notebook.extend (general_tab)
			notebook.set_item_text (general_tab, general_tab.name)
			
			create build_tab
			notebook.extend (build_tab)
			notebook.set_item_text (build_tab, build_tab.name)
			
			create generation_tab
			notebook.extend (generation_tab)
			notebook.set_item_text (generation_tab, generation_tab.name)

			hbox.extend (notebook)
			
				-- All tabs have been created.
			is_initialized := True

			create vbox
			vbox.set_padding (Small_padding_size)
			vbox.set_border_width (Default_border_size)

				-- Create Ok button
			create button.make_with_text_and_action (b_OK, agent ok_action)
			extend_no_expand (vbox, button)

				-- Create Cancel button
			create button.make_with_text_and_action (b_Cancel, agent cancel_action)
			extend_no_expand (vbox, button)

				-- Cosmetics
			vbox.extend (create {EV_CELL})

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			extend (hbox)
			
				-- Set up default buttons.
			set_default_cancel_button (button)
			
				-- Closing window
			close_request_actions.wipe_out
			close_request_actions.put_front (agent cancel_action)
			
				-- Minimum size of notebook.
				-- We must only set it if it is not smaller than the current minimum
				-- size, as this is affected by the size of the fonts used. If we
				-- do set it to smaller, then this allows the contents to become bigger
				-- than it is, and with large fonts, this cuts off some texts.
			if notebook.minimum_width < 200 and notebook.minimum_height < 200 then
				notebook.set_minimum_size (200, 200)	
			end
				-- Every time the dialog is displayed, update the information from
				-- the project into all tabs.
			show_actions.extend (agent display_project_information)
		end

feature {NONE} -- Implementation

	tab_list: ARRAYED_LIST [GB_SYSTEM_TAB] is
			-- List of available tab in Current.
		require
			window_initialized: is_initialized
		once
			create Result.make (2)
			Result.extend (general_tab)
			Result.extend (build_tab)
			Result.extend (generation_tab)
		end
		
		
	validate_tabs is
			-- For all members of `tab_list', check
			-- that their settings are valid.
		local
			one_error_found: BOOLEAN
		do
			last_validation_successful := True
			from
				tab_list.start
			until
				tab_list.off or one_error_found
			loop
				tab_list.item.validate
				if not tab_list.item.validate_successful then
					one_error_found := True
					last_validation_successful := False
				end
				tab_list.forth
			end
		end
		
	last_validation_successful: BOOLEAN
		-- Was the last call to `validate_tabs'
		-- successful?
		
end -- class GB_SYSTEM_WINDOW
