indexing
	description	: "Command to delete diagram views."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DELETE_VIEW_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
			-- Display `confirmation' and remove current view if OK pressed.
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
			Result := Pixmaps.Icon_delete_view
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Delete current view"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Delete diagram views"
		end

	name: STRING is "Delete_view"
			-- Name of the command. Used to store the command in the
			-- preferences.

	confirmation: EV_CONFIRMATION_DIALOG is
			-- Associated widget.
		do
			create Result.make_with_text_and_actions (
				Interface_names.l_Diagram_delete_view_cmd,
				<<~ok_pressed>>)
		end

feature {NONE} -- Events

	ok_pressed is
			-- The user really wants to delete current view.
		local
			cd: CONTEXT_DIAGRAM
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd_not_void: cd /= Void end
			if not cd.current_view.is_equal ("DEFAULT") then
				cd.available_views.prune_all (cd.current_view)
				cd.remove_view (cd.current_view)
				tool.view_selector.select_actions.block
				tool.view_selector.set_strings (cd.available_views)
				tool.view_selector.set_text ("DEFAULT")
				tool.view_selector.select_actions.resume
			end
		end

end -- class EB_DELETE_VIEW_COMMAND
