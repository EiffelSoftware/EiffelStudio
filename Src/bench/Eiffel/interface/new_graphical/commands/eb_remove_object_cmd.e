indexing
	description: "Command in the object tool to remove an object from it."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_REMOVE_OBJECT_CMD

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

create
	make

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
		end

feature -- Access

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version at least).
			-- Items at position 3 and 4 contain text.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_delete_very_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_Remove_object
		end

feature -- Measurement

feature -- Status report

	tool: EB_OBJECT_TOOL
			-- Object tool `Current' is associated with.

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Remove_object
		end

	description: STRING is
			-- Description of the command.
		do
			Result := Interface_names.l_Remove_object_desc
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Execution

	execute is
			-- Remove an object from `tool'.
		local
			wd: EV_WARNING_DIALOG
		do
			if tool.is_selected_removable then
				tool.remove_selected_object
			else
				create wd.make_with_text (Warning_messages.w_Select_object_to_remove)
				wd.show_modal_to_window (tool.debugger_manager.debugging_window.window)
			end
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (~drop_object_stone)
			Result.drop_actions.set_veto_pebble_function (~is_removable (?))
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	drop_object_stone (st: OBJECT_STONE) is
			-- Remove the object represented by `st' from the object tool managed objects.
		do
			tool.remove_object (st.object_address)
		end

	is_removable (s: ANY): BOOLEAN is
			-- Can the object represented by `st' be removed from the object tool managed objects?
		local
			st: OBJECT_STONE
		do
			st ?= s
			if st /= Void then
				Result := tool.is_removable (st.object_address)
			end
		end

invariant
	invariant_clause: -- Your invariant here

end -- class EB_REMOVE_OBJECT_CMD
