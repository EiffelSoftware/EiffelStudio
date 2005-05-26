indexing
	description: "Tool that displays the top of the call stack and an object during a debugging session."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEBUGGING_TOOL

inherit
	EB_EXPLORER_BAR_ATTACHABLE

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

	EB_RECYCLABLE
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Initialize `Current'.
		do
			manager := a_manager
			build_interface
			create_update_on_idle_agent
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			vb: EV_VERTICAL_BOX
			nb: ES_NOTEBOOK
		do
			create vb
			create nb.make
			vb.extend (nb.widget)
			widget := vb
			notebook := nb
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			pretty_print_cmd: EB_PRETTY_PRINT_CMD
		do
			create mini_toolbar
			create pretty_print_cmd.make
			pretty_print_cmd.enable_sensitive
			mini_toolbar.extend (pretty_print_cmd.new_mini_toolbar_item)
		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end

			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (
				explorer_bar, widget, title, False, mini_toolbar
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	manager: EB_TOOL_MANAGER

	debugger_manager: EB_DEBUGGER_MANAGER

	mini_toolbar: EV_TOOL_BAR

	widget: EV_WIDGET
			-- Widget representing Current.

	notebook: ES_NOTEBOOK

	title: STRING is 
			-- Title of the tool.
		do
			Result := Interface_names.t_Object_tool
--			Result := Interface_names.t_Debugging_tool
			fixme ("uncomment when we decide to use the Grid debugging tools")
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := "&Debugging tools"
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_debugging_tool
		end

feature -- change

	change_manager_and_explorer (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
		end

feature {NONE} -- Implementation

	real_update (arg_is_stopped: BOOLEAN) is
			-- Display current execution status.
		do
		end

end
