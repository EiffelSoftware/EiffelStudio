indexing
	description	: "Objects that can be contained in an EB_TOOLBAR"
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE

feature -- Access

	name: STRING is
			-- Name of the command. Use to store the command in the
			-- preferences.
		deferred
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EV_TOOL_BAR_ITEM is
			-- Create a new toolbar item for Current
		deferred
		end

feature {EB_CUSTOMIZABLE_LIST_ITEM, EB_CUSTOM_TOOLBAR_LIST} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the item (one for the
			-- gray version, one for the color version).
		deferred
		end

	description: STRING is
			-- Description of the command as it appears in the
			-- "customize" dialog.
		deferred
		ensure
			description_set: Result /= Void and then not Result.is_empty
		end

end -- class EB_TOOLBARABLE
