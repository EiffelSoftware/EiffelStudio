indexing
	description:
		"EiffelBench tool. Ancestor of all tools in the workbench, %
		%providing dragging capabilities (transport). A tool is %
		%composed of a panel and a tool bar"
	date: "$Date$"
	revision: "$Revision$"

deferred class EB_TOOL 

inherit
	NAMER

--	HOLE

--	HELPABLE

	SHARED_CONFIGURE_RESOURCES

	SHARED_PLATFORM_CONSTANTS

--	EB_CONSTANTS

	INTERFACE_NAMES
		-- ?

feature -- Tool Properties

	parent: EV_WINDOW
			-- window where Current is.

	tool_name: STRING is 
			-- Name of the tool
		do
		end

	history: STONE_HISTORY
			-- History list for Current.

	stone: STONE
			-- Stone in tool

--	title: STRING is
			-- The title of the tool.
--		deferred
--		end

	save_cmd_holder: TWO_STATE_CMD_HOLDER is
			-- The command to save the contents of Current.
		do
		end

	reset_stone is
			-- Reset the stone to Void.
		do
			stone := Void
		ensure
			stone = Void
		end


	menu_bar: EV_STATIC_MENU_BAR
			-- Menu bar
			-- can be void

	edit_menu: EV_MENU
			-- Edit menu
			-- Only used during debugging
			-- can be void

	file_menu: EV_MENU
			-- File menu
			-- can be void

	help_menu: EV_MENU
			-- Help menu
			-- can be void


--	toolbar_parent: ROW_COLUMN
			-- Toolbar parent
			-- Not implemented yet

--	edit_bar, format_bar: TOOLBAR
			-- Main and format button bars
			-- not implemented yet

--	hole_button: EB_BUTTON_HOLE
			-- Button to represent Current's default hole.
			-- not implemented yet

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := t_Empty
				-- ? Elimination de EB_CONST
		end

	icon_id: INTEGER is
			-- Icon id for window (for windows)
		do
		end

feature -- Access

--	resources: RESOURCE_CATEGORY is
			-- Resources for current tool
--		deferred
--		end

	help_index: INTEGER is
			-- Index of help file nmae
		do
		end

	help_file_name: FILE_NAME is
			-- Help file name
		do
		end

--	associated_help_widget: EV_CONTAINER is
--			-- Associated parent widget for help window
--		do
--			Result := popup_parent
--		end

feature -- Status report

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

	destroy is
			-- Destroys tool
		do
			manager.destroy_tool
		end

	show is
			-- makes tool visible
		do
			manager.show_tool
		end

	hide is
			-- hides tool
		do
			manager.hide_tool
		end

	set_title (s: STRING) is
			-- Set parent title to `s'.
		do
			manager.set_title (s)
		end

feature -- Update


feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			reset_stone
			history.wipe_out
		end

	unregister_holes is
			-- Unregister holes.
		do
--			unregister
--		ensure
--			current_unregistered: not registered
		end

feature -- Element change

	add_to_history (a_stone: like stone) is
			-- Add `a_stone' to `history'
		require
			valid_history: history /= Void
		do
			history.extend (a_stone)
		ensure
			has_history: history.has (a_stone)
		end

feature {EB_TOOL_CONTAINER} -- Widget Implementation

	-- tool display utilities.
	-- these features can only be used by a tool container

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

	manager: EB_TOOL_CONTAINER
			-- object containing Current

	container: EV_CONTAINER is
			-- Form representing Current
			-- most of the time a VERTICAL_BOX
		deferred
		end

--	raise_grabbed_popup is
--			-- Raise popup windows with exclusive grab set.
--		do
--			if 
--				last_warner /= Void and then
--				not last_warner.destroyed and then
--				last_warner.is_popped_up and then
--				last_warner.is_exclusive_grab 
--			then
--				last_warner.raise
--			elseif 
--				last_confirmer /= Void and then 
--				last_confirmer.is_popped_up 
--			then
--				last_confirmer.raise
--			elseif
--				last_name_chooser /= Void and then
--				last_name_chooser.is_popped_up
--			then
--				last_name_chooser.raise
--			else
--				window_manager.class_win_mgr.raise_shell_popup
--			end
--		end


end -- class EB_TOOL
