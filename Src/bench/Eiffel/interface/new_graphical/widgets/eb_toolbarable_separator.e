indexing
	description	: "Abstract representation of a separator in a tool bar"
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOOLBARABLE_SEPARATOR

inherit
	EB_TOOLBARABLE

	EB_CONSTANTS

create
	default_create

feature -- Status setting

	-- Contrary to EB_TOOLBARABLE_COMMAND's, a separator
	-- 		* is displayed by default (otherwise it wouldn't exist at all)
	-- 		* is necessarily not sensitive

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EV_TOOL_BAR_ITEM is
			-- Create a new toolbar item for Current
			-- display_text currently has only a compatibility role
		do
			create {EV_TOOL_BAR_SEPARATOR} Result
		end

feature -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Picture representing a button in the customize toolbar dialog box
		once
			Result := Pixmaps.Icon_toolbar_separator
		end

	description: STRING is "Separator"
			-- Identifier of a separator in the customize toolbar dialog box

	name: STRING is "Separator"
			-- Name of the command. Use to store the command in the
			-- preferences.

end -- class EB_TOOLBARABLE_SEPARATOR
