indexing
	description	: "$EiffelGraphicalCompiler$ tool. Ancestor of all tools in the workbench, %
				  %providing dragging capabilities (transport). A tool is %
				  %composed of a container and manager"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_TOOL 

inherit
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

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar) is
			-- Create a new tool with `a_manager' as manager.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)

				-- Register and initialize
			build_interface
			build_explorer_bar
		ensure
			explorer_bar_item_created: explorer_bar_item /= Void
		end

	build_interface is
			-- Build all the tool's widgets.
		deferred
		ensure
			widget_created: widget /= Void
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		deferred
		ensure
			explorer_bar_item_created: explorer_bar_item /= Void
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		deferred
		end

	explorer_bar: EB_EXPLORER_BAR
			-- Associated explorer bar.

	explorer_bar_item: EB_EXPLORER_BAR_ITEM
			-- Associated explorer bar item.

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
			if explorer_bar_item /= Void and then explorer_bar_item.is_closeable then
				explorer_bar_item.close
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

	set_explorer_bar (a_bar: like explorer_bar) is
			-- Set `explorer_bar' to `a_bar'.
		do
			explorer_bar := a_bar
		end

feature -- Obsolete

	icon_name: STRING is
			-- Name of the tool in minimized state
		obsolete "Use `minimized_title' instead"
		do
		end

end -- class EB_TOOL
