indexing
	description: "Command that allows the user to have a nicer display for his object value %
				%especially strings."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRETTY_PRINT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end
	
	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_tool: EB_OBJECT_TOOL) is
			-- Initialize `Current' and associate it with `a_tool'.
		do
			tool := a_tool
			create opened_dialogs.make (5)
		end

feature -- Access

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- 8*8 pixmaps representing `Current'.
		do
			Result := Pixmaps.Icon_pretty_print_vsmall
		end

	tooltip: STRING is
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Pretty_print
		end

	description: STRING is
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Pretty_print
		end

	name: STRING is
			-- Tooltip for Current.
		do
			Result := "Pretty_print"
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- No big pixmap is necessary.
		do
			
		end

	menu_name: STRING is
			-- Menu name for `Current'.
		do
			Result := Interface_names.m_Pretty_print
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (~on_stone_dropped)
			Result.drop_actions.set_veto_pebble_function (~accepts_stone)
		end

feature -- Measurement

feature -- Status report

	associated_window: EV_WINDOW is
			-- Window to which the child dialogs will be modeless to.
		do
			Result := tool.debugger_manager.debugging_window.window
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	execute is
			-- Launch `Current' as a command.
			-- Pop up a new empty dialog.
		do
			pop_up_new_dialog
		end

	refresh is
			-- Update the state of all dialogs.
		do
			from
				opened_dialogs.start
			until
				opened_dialogs.after
			loop
				opened_dialogs.item.refresh
				opened_dialogs.forth
			end
		end

	end_debug is
			-- A debug session ended. We free the resources.
		do
			from
				opened_dialogs.start
			until
				opened_dialogs.after
			loop
					--| No need to call `forth', `destroy' removes the items automatically.
				opened_dialogs.item.destroy
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRETTY_PRINT_DIALOG} -- Dialog

	remove_dialog (d: EB_PRETTY_PRINT_DIALOG) is
			-- Remove `d' from the list of displayed dialogs.
		require
			is_now_destroyed: d.is_destroyed
		do
			opened_dialogs.start
			opened_dialogs.prune_all (d)
		ensure
			is_no_longer_known: not opened_dialogs.has (d)
		end

feature {EB_PRETTY_PRINT_DIALOG} -- Implementation

	tool: EB_OBJECT_TOOL
			-- Object tool `Current' is linked with.

feature {NONE} -- Implementation

	on_stone_dropped (st: OBJECT_STONE) is
			-- An object was dropped on the button, display it.
		do
			pop_up_new_dialog
			last_opened_dialog.set_stone (st)
		end

	accepts_stone (st: OBJECT_STONE): BOOLEAN is
			-- Can the user drop `st'?
		do
			Result := (create {DUMP_VALUE}.make_object (st.object_address, st.dynamic_class)).has_formatted_output
		end

	opened_dialogs: ARRAYED_LIST [EB_PRETTY_PRINT_DIALOG]
			-- All pretty print dialogs that are appear on the screen (linked to `Current').

	pop_up_new_dialog is
			-- Create and display a new pretty print dialog.
		local
			nd: EB_PRETTY_PRINT_DIALOG
		do
			create nd.make (Current)
			opened_dialogs.extend (nd)
			last_opened_dialog := nd
			nd.raise
		ensure
			added_a_dialog: opened_dialogs.count = (old opened_dialogs.count) + 1
		end

	last_opened_dialog: EB_PRETTY_PRINT_DIALOG
			-- The last dialog that `Current' opened.

end -- class EB_PRETTY_PRINT_CMD
