indexing
	description: "Objects that is a command to toggle between high and low quality diagrams."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOGGLE_QUALITY_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			description,
			initialize
		end
		
	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND

create
	make

feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_q),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			l_world: EIFFEL_WORLD
			l_projector: EIFFEL_PROJECTOR
		do
			if is_sensitive then
				l_world := tool.world
				l_projector := tool.projector
				if l_world.is_high_quality then
					l_world.disable_high_quality
					disable_select
					tool.history.register_named_undoable (
						interface_names.t_diagram_disable_high_quality,
						[<<agent l_world.disable_high_quality, agent l_projector.full_project, agent disable_select>>],
						[<<agent l_world.enable_high_quality, agent l_projector.full_project, agent enable_select>>])
				else
					l_world.enable_high_quality
					enable_select
					tool.history.register_named_undoable (
						interface_names.t_diagram_enable_high_quality,
						[<<agent l_world.enable_high_quality, agent l_projector.full_project, agent enable_select>>],
						[<<agent l_world.disable_high_quality, agent l_projector.full_project, agent disable_select>>])
				end
				l_projector.full_project
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
			if tool.world.is_high_quality then
				Result.toggle
			end
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			Result.select_actions.extend (agent execute)
		end
		
feature -- Access

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_low_quality
			else
				Result := Interface_names.f_diagram_high_quality
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := pixmaps.icon_toggle_quality
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_toggle_quality
		end

	name: STRING is "High_quality"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_TOGGLE_QUALITY_COMMAND
