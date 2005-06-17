indexing
	description	: "$EiffelGraphicalCompiler$ tool. Ancestor of all tools in the workbench, %
				  %providing dragging capabilities (transport). A tool is %
				  %composed of a container and manager"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "$Author$"

deferred class
	EB_TOOL 

inherit

	EB_EXPLORER_BAR_ATTACHABLE

	EB_RECYCLABLE

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_PLATFORM_CONSTANTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_manager: like manager) is
			-- Create a new tool with `a_manager' as manager.
		require
			a_manager_exists: a_manager /= Void
		do
				-- Link with the manager and the explorer.
			manager := a_manager

				-- Register and initialize
			build_interface
		end

	build_interface is
			-- Build all the tool's widgets.
		deferred
		ensure
			widget_created: widget /= Void
		end

feature -- Change

	set_manager (m: like manager) is
			-- set value `m' to `manager'
		require
			m /= Void
		do
			manager := m
		end
		
feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		deferred
		end

	title: STRING is
			-- Title of the tool
		deferred
		ensure
			valid_title: title /= Void and then not title.is_empty
		end

	minimized_title: STRING is
			-- Title of the tool when minimized.
			--
			-- By default this name is the same as `title', redefine this
			-- feature to have a different minimized title.
		do
			Result := title
		ensure
			valid_minimized_title: minimized_title /= Void and then not minimized_title.is_empty
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
			--
			-- By default this name is the same as `title', redefine this
			-- feature to have a different name.
		do
			Result := title
		ensure
			valid_menu_name: menu_name /= Void and then not menu_name.is_empty
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it appears in toolbars and menu, there is no pixmap by default.
		do
		end

feature -- Status report

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		do
			if explorer_bar_item /= Void then
				Result := explorer_bar_item.is_visible
			end
		end

feature -- Status setting

	close is
			-- Close the tool (if possible)
		do
			if explorer_bar_item /= Void then
				unattach_from_explorer_bar
			end
		end

	show is
			-- Show the tool (if possible)
		do
			if explorer_bar_item /= Void and then (not explorer_bar_item.is_visible) then
				explorer_bar_item.show
			end
		end

feature {NONE} -- Implementation

	manager: EB_TOOL_MANAGER
			-- Manager for Current

	on_bar_item_shown is
			-- The explorer bar item is now displayed.
			-- Call `on_shown' if necessary.
		do
			on_shown
		end
		

	on_shown is
			-- Perform update actions when the tool is displayed.
		do
		end

feature -- Obsolete

	icon_name: STRING is
			-- Name of the tool in minimized state
		obsolete "Use `minimized_title' instead"
		do
		end

end -- class EB_TOOL
