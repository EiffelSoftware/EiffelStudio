indexing
	description	: "Command to create a new feature."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_FEATURE_SIGNATURE_COMMAND

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
			-- show/hide signature
		do
			target.features_tool.tree.toggle_signatures		
		end

	reset_signature_status is
			-- Reset status of signature command
		do
			target.features_tool.tree.disable_signature_status
		end		

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Showhide_signature
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_feature
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_toggle_signature_vsmall
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.m_Showhide_signature
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.m_Showhide_signature
		end

	name: STRING is "Toggle_feature_signature"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_TOGGLE_FEATURE_SIGNATURE_COMMAND
