indexing
	description	: "Command to create a new feature."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_CLASS_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	SHARED_WORKBENCH

create
	make

feature -- Basic operations

	execute is
			-- Pop up class wizard.
		local
			dial: EB_CREATE_CLASS_DIALOG
			wd: EV_WARNING_DIALOG
		do
			if Workbench.is_already_compiled then
				if
					not Workbench.is_compiling or else
					Workbench.last_reached_degree <= 5
				then
					create dial.make_default (target)
					dial.set_stone_when_finished
					dial.call ("New_class")
				else
					create wd.make_with_text (Warning_messages.w_Unsufficient_compilation (3))
					wd.show_modal_to_window (target.window)
				end
			else
				create wd.make_with_text (Warning_messages.w_Project_not_compiled)
				wd.show_modal_to_window (target.window)
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_class
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_class
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_new_class_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_class
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.f_Create_new_class
		end

	name: STRING is "New_class"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_NEW_CLASS_COMMAND

