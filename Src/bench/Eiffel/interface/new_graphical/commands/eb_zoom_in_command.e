indexing
	description: "Command to enlarge the diagram"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ZOOM_IN_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			initialize
		end

create
	make
	
feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_numpad_add),
				False, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			l_world: EIFFEL_WORLD
			new_scale_factor, l_scale_factor: DOUBLE
			l_zoom_selector: EB_ZOOM_SELECTOR
			new_scale, old_scale: INTEGER
			l_projector: EIFFEL_PROJECTOR
		do
			if is_sensitive then
				l_world := tool.world
				l_scale_factor := l_world.scale_factor
				new_scale_factor := (0.1 + l_scale_factor) / l_scale_factor
				old_scale := (l_world.scale_factor * 100).rounded
				l_world.scale (new_scale_factor)
				tool.crop_diagram
				l_projector := tool.projector
				l_projector.full_project
				new_scale := (l_world.scale_factor * 100).rounded
				l_zoom_selector := tool.zoom_selector
				l_zoom_selector.show_as_text (new_scale)
				history.register_named_undoable (
						Interface_names.t_Diagram_zoom_in_cmd,
						[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
						[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_zoom_in
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_zoom_in
		end

	name: STRING is "Zoom_in"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_ZOOM_IN_COMMAND
