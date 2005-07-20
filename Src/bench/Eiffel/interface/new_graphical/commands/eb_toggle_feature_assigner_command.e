indexing
	description	: "Command to toggle display of feature assigner name."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_FEATURE_ASSIGNER_COMMAND

inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			mini_pixmap, new_mini_toolbar_item
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	SHARED_WORKBENCH

create
	make

feature -- Basic operations

	execute is
			-- show/hide assigner name
		do
			target.features_tool.tree.toggle_assigner
		end

feature -- Access

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := pixmaps.small_pixmaps.icon_toggle_assigner
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if target.features_tool.tree.is_assigner_enabled then
				Result := Interface_names.f_hide_assigner
			else
				Result := Interface_names.f_show_assigner
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_toggle_assigner
		end

	name: STRING is "Toggle_feature_assigner"
			-- Name of the command. Used to store the command in the
			-- preferences.

	update_tooltip (toggle: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON) is
			-- Update tooltip of `toggle'.
		do
			toggle.set_tooltip (tooltip)
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap @ 1)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent update_tooltip (Result))
		end

end
