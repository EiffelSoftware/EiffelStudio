indexing
	description	: "Command to switch to `create inheritance links' mode."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_INHERIT_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			tool.on_new_inherit_click
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_RADIO_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		local
			tt: STRING
		do
				-- Add it to the managed toolbar items
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
			create Result.make (Current)
			if display_text and pixmap.count >= 2 then
				Result.set_pixmap (pixmap @ 2)
			else
				Result.set_pixmap (pixmap @ 1)
			end
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			current_button := Result
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.select_actions.extend (~execute)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_inherit
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Create new inheritance links"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Create new inheritance links"
		end

	name: STRING is "New inheritance links"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_RADIO_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_CREATE_INHERIT_COMMAND
