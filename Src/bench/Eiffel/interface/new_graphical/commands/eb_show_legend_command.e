indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_LEGEND_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			description
		end
	
create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			if not current_button.is_selected then
				tool.world.hide_legend
				current_button.set_tooltip (tooltip)
				tool.projector.full_project
			elseif current_button.is_selected then
				tool.world.show_legend
				current_button.set_tooltip (tooltip)
				tool.projector.full_project
			end	
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			current_button := Result
			if tool.world.is_cluster_shown then
				current_button.toggle
			end
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			Result.select_actions.extend (agent execute)
		end
		
feature -- Access

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_hide_legend
			else
				Result := Interface_names.f_diagram_show_legend
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.icon_display_legend
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_legend_visibility
		end

	name: STRING is "Display_legend"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_SHOW_LEGEND_COMMAND
