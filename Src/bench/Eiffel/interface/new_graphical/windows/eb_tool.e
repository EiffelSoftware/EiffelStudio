indexing
	description:
		"EiffelBench tool. Ancestor of all tools in the workbench, %
		%providing dragging capabilities (transport). A tool is %
		%composed of a container and manager"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL 

inherit
	SHARED_CONFIGURE_RESOURCES

	SHARED_PLATFORM_CONSTANTS

	NEW_EB_CONSTANTS

	EB_TOOL_DATA

	EB_RESOURCE_USER

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Create a new tool with `man' as manager.
			-- To ensure atomicity of make, and avoid some
			-- problems during linking with manager,
			-- this function does not call build_interface.
		require
			man_exists: man /= Void
		do
				-- Linking with manager
			manager := man
			parent := manager.tool_parent
			parent_window := manager.associated_window

			register
			init_commands
		ensure
			parent_set: parent /= Void
		end

	init_commands is
			-- Initialize commands.
		do
			create close_cmd.make (Current)
			create exit_app_cmd
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		deferred
		ensure
			exists: not destroyed
		end

feature -- Tool Properties

	parent: EV_CONTAINER
			-- Parent of Current

	parent_window: EV_WINDOW
			-- Window where Current is

	default_name: STRING is 
			-- Default name given to Current.
			-- It is meant to be a constant.
		deferred
		ensure
			valid_result: Result /= Void and then not Result.empty
		end

--	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.
			-- not implemented yet

feature -- Status report

	title: STRING is
			-- Title of the tool
		do
			Result := manager.tool_title (Current)
		end

	icon_name: STRING is
			-- Name of the tool in minimized state
		do
			Result := manager.tool_icon_name (Current)
		end

	destroyed: BOOLEAN is
			-- Is Current destroyed?
		do
			Result := (container = Void) or else container.destroyed
		end

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		require
			exists: not destroyed
		do
			Result := container.shown
		end


feature -- Status setting

	-- These features call the manager,
	-- who decides the way they are executed.

	show is
			-- Make tool visible.
		require
			exists: not destroyed
		do
			manager.show_tool (Current)
		ensure
			shown: shown
		end

	raise is
			-- Raise tool in front, bringing it into focus.
		require
			exists: not destroyed
		do
			manager.raise_tool (Current)
		ensure
			shown: shown
		end

	hide is
			-- Hide tool.
		require
			exists: not destroyed
		do
			manager.hide_tool (Current)
		ensure
			hidden: not shown
		end

	destroy is
			-- Destroy tool.
		require
			exists: not destroyed
		do
			manager.destroy_tool (Current)
		ensure
			destroyed: destroyed
		end

	set_title (s: STRING) is
			-- Set parent title to `s'.
		require
			s_valid: s /= Void and then not s.empty
		do
			manager.set_tool_title (Current, s)
		ensure
			title_set: title.is_equal (s)
		end

	set_icon_name (s: STRING) is
			-- Set icon name to `s'.
			-- Icon name is shown just below the icon.
		require
			s_valid: s /= Void and then not s.empty
		do
			manager.set_tool_icon_name (Current, s)
		ensure
			title_set: icon_name.is_equal (s)
		end

feature -- Resize

	set_size (new_width, new_height: INTEGER) is
			-- Resize tool to dimensions `new_width' and `new_height'.
		require
			exists: not destroyed
		do
			manager.set_tool_size (Current, new_width, new_height)
		end

	set_width (new_width: INTEGER) is
			-- Set tool width to `new_width'.
		require
			exists: not destroyed
		do
			manager.set_tool_width (Current, new_width)
		end

	set_height (new_height: INTEGER) is
			-- Set tool height to `new_height'.
		require
			exists: not destroyed
		do
			manager.set_tool_height (Current, new_height)
		end

feature {EB_TOOL_MANAGER} -- Widget Implementation

	-- Tool display utilities.
	-- These features can only be used by a tool manager

	show_imp is
			-- Show Current on the screen.
		do
			container.show
		ensure
			shown: shown
		end

	hide_imp is
			-- Hide Current.
		do
			container.hide
		ensure
			hidden: not shown
		end


	destroy_imp is
			-- Close Current.
		do
			unregister
			container.destroy
		ensure
			destroyed: destroyed
		end

feature {NONE} -- Implementation

	manager: EB_TOOL_MANAGER
			-- Object containing Current

	container: EV_CONTAINER is
			-- Form representing Current
			-- most of the time an EV_VERTICAL_BOX
		deferred
		end

	raise_grabbed_popup is
			-- Raise tool
		obsolete
			"Use `raise' instead"
		do
			raise
		end

feature {EB_TOOL_MANAGER} -- Commands

	close_cmd: EB_CLOSE_TOOL_CMD
		-- Command to close Current

	exit_app_cmd: EB_EXIT_APPLICATION_CMD
		-- Command to exit application.

invariant
	tool_has_manager: manager /= Void

end -- class EB_TOOL
