indexing
	description: "Objects that is a command to reset current view in diagram tool."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RESET_VIEW_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name
		end

create
	make

feature -- Basic operations

	execute is
			-- Display `confirmation' and reset current view if OK pressed.
		local
			dial: EV_CONFIRMATION_DIALOG
		do
			dial := confirmation
			dial.disable_user_resize
			dial.show_modal_to_window (tool.development_window.window)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_reset_view
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_reset_view
		end

	menu_name: STRING is
			-- Name for the menu entry.
		do
			Result := Interface_names.m_diagram_reset_view
		end

	name: STRING is "Reset_view"
			-- Name of the command. Used to store the command in the
			-- preferences.

	confirmation: EV_CONFIRMATION_DIALOG is
			-- Associated widget.
		do
			create Result.make_with_text_and_actions (
				Interface_names.l_Diagram_reset_view_cmd,
				<<agent ok_pressed>>)
		end

feature {NONE} -- Events

	ok_pressed is
			-- The user really wants to reset current view.
		do
			tool.reset_current_view
		end

end -- class EB_RESET_VIEW_COMMAND
