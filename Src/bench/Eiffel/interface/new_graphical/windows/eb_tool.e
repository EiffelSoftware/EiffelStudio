indexing
	description:
		"EiffelBench tool. Ancestor of all tools in the workbench, %
		%providing dragging capabilities (transport). A tool is %
		%composed of a panel and a tool bar"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL 

inherit
--	HELPABLE

	SHARED_CONFIGURE_RESOURCES

	SHARED_PLATFORM_CONSTANTS

	NEW_EB_CONSTANTS

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
		require
			man_exists: man /= Void
		do
				-- Linking with manager
			manager := man
			parent := manager.tool_parent
			parent_window := manager.associated_window

			init_commands
			build_interface
		ensure
			exists: not destroyed
			parent_set: parent /= Void
		end

	build_interface is
			-- build all the tool's widgets
		deferred
		ensure
			contains_something: not container.destroyed
		end

	init_commands is
			--
		do
			create close_cmd.make (Current)
			create exit_app_cmd
		end

feature -- Tool Properties

	parent: EV_CONTAINER
			-- parent of Current.

	parent_window: EV_WINDOW
			-- window where Current is.

	empty_tool_name: STRING is 
			-- Name given to the tool when it is empty
		do
		end

--	save_cmd_holder: TWO_STATE_CMD_HOLDER is
			-- The command to save the contents of Current.
--		do
--		end

	menu_bar: EV_STATIC_MENU_BAR
			-- Menu bar

--	edit_bar, format_bar: TOOLBAR
			-- Main and format button bars
			-- not implemented yet

--	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.
			-- not implemented yet

	icon_id: INTEGER is
			-- Icon id for window (for windows)
		do
		end

feature -- Access

--	resources: EB_PARAMETERS is
			-- Resources for current tool
--		deferred
--		end

--	help_index: INTEGER is
--			-- Index of help file nmae
--		do
--		end

--	help_file_name: FILE_NAME is
--			-- Help file name
--		do
--		end

--	associated_help_widget: EV_CONTAINER is
--			-- Associated parent widget for help window
--		do
--			Result := parent
--		end

feature -- Status report

	title: STRING is
			-- The title of the tool.
		do
			Result := manager.tool_title
		end

	icon_name: STRING is
			-- The title of the tool.
		do
			Result := manager.tool_icon_name
		end

	destroyed: BOOLEAN is
			-- is Current destroyed?
		do
			Result := container.destroyed
		end

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		do
			Result := container.shown
		end


feature -- Status setting

	show is
			-- makes tool visible
		do
			manager.show_tool (Current)
		ensure
			shown: shown
		end

	raise is
		do
			manager.raise_tool (Current)
		ensure
			shown: shown
		end

	hide is
			-- hides tool
		do
			manager.hide_tool (Current)
		ensure
			hidden: not shown
		end

	destroy is
			-- Destroys tool
		do
			manager.destroy_tool (Current)
		ensure
			destroyed: destroyed
		end

	set_title (s: STRING) is
			-- Set parent title to `s'.
		do
			manager.set_tool_title (Current, s)
		ensure
			title_set: title.is_equal (s)
		end

	set_icon_name (s: STRING) is
			-- Set icon name to `s'.
			-- icon name is shown just below the icon.
		do
			manager.set_tool_icon_name (Current, s)
		ensure
			title_set: icon_name.is_equal (s)
		end

feature -- Resize

	set_size (min_x, min_y: INTEGER) is
		do
			manager.set_tool_size (Current, min_x, min_y)
		end

	set_width (new_width: INTEGER) is
		do
			manager.set_tool_width (Current, new_width)
		end

	set_height (new_height: INTEGER) is
		do
			manager.set_tool_height (Current, new_height)
		end

feature {EB_TOOL_MANAGER} -- Widget Implementation

	-- tool display utilities.
	-- these features can only be used by a tool manager

	show_imp is
			-- Show Current on the screen.
		do
			container.show
		ensure
			shown: shown
		end

	hide_imp is
			-- Show Current on the screen.
		do
			container.hide
		ensure
			hidden: not shown
		end


	destroy_imp is
			-- Close Current.
		do
			container.destroy
		ensure
			destroyed: destroyed
		end

feature {NONE} -- Implementation

	manager: EB_TOOL_MANAGER
			-- object containing Current

	container: EV_CONTAINER is
			-- Form representing Current
			-- most of the time an EV_VERTICAL_BOX
		deferred
		end

	raise_grabbed_popup is
		obsolete
			"Use `raise' instead"
		do
			raise
		end

feature {EB_TOOL_MANAGER} -- Commands

	close_cmd: EB_CLOSE_TOOL_CMD
	exit_app_cmd: EB_EXIT_APPLICATION_CMD

invariant
	tool_has_manager: manager /= Void

end -- class EB_TOOL
