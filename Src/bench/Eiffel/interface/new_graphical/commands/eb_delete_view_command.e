indexing
	description	: "Command to delete diagram views."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DELETE_VIEW_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name,
			initialize
		end

create
	make
	
feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_x),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Display `confirmation' and remove current view if OK pressed.
		local
			dial: EV_CONFIRMATION_DIALOG
		do
			if is_sensitive then
				dial := confirmation
				dial.disable_user_resize
				dial.show_modal_to_window (tool.development_window.window)
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_delete_view
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_delete_view
		end

	menu_name: STRING is
			-- Name for the menu entry.
		do
			Result := Interface_names.m_diagram_delete_view
		end

	name: STRING is "Delete_view"
			-- Name of the command. Used to store the command in the
			-- preferences.

	confirmation: EV_CONFIRMATION_DIALOG is
			-- Associated widget.
		do
			create Result.make_with_text_and_actions (
				Interface_names.l_Diagram_delete_view_cmd,
				<<agent ok_pressed>>)
		end

feature {NONE} -- Events

	ok_pressed is
			-- The user really wants to delete current view.
		local
			ew: EIFFEL_WORLD
		do
			ew := tool.world
			if not ew.current_view.has_substring ("DEFAULT") then
				tool.remove_view (ew.current_view)
			end
		end

end -- class EB_DELETE_VIEW_COMMAND
