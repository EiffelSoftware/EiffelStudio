indexing
	description	: "Command to change visibility of inheritance layer."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_INHERIT_COMMAND

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
		local
			world: CONTEXT_DIAGRAM
		do
			if tool.class_view /= Void then
				world := tool.class_view
			elseif tool.cluster_view /= Void then
				world := tool.cluster_view
			end
			if world /= Void then
				if world.inheritance_layer.is_show_requested then
					world.inheritance_layer.hide
					world.inheritance_layer.disable_sensitive
					world.inheritance_mover_layer.hide
					world.inheritance_mover_layer.disable_sensitive
					world.disable_inheritance_links_displayed
				else
					world.inheritance_layer.show
					world.inheritance_layer.enable_sensitive
					world.inheritance_mover_layer.show
					world.inheritance_mover_layer.enable_sensitive
					world.enable_inheritance_links_displayed
				end
				current_button.set_tooltip (tooltip)
				tool.projector.project
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
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			Result.toggle
			Result.select_actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_inherit
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_hide_inheritance
			else
				Result := Interface_names.f_diagram_show_inheritance
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_inheritance_visibility
		end

	name: STRING is "Inherit_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_TOGGLE_INHERIT_COMMAND


