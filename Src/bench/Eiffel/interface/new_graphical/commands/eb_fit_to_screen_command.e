indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FIT_TO_SCREEN_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			l_world: EIFFEL_WORLD
			new_scale_factor, l_scale_factor: DOUBLE
			l_zoom_selector: EB_ZOOM_SELECTOR
			new_scale, old_scale: INTEGER
			l_projector: EIFFEL_PROJECTOR
			wc: EV_MODEL_WORLD_CELL
		do
			l_world := tool.world
			l_scale_factor := l_world.scale_factor
			old_scale := (l_world.scale_factor * 100).rounded
			wc := tool.world_cell
			wc.fit_to_screen
			new_scale_factor := l_world.scale_factor
			new_scale := (new_scale_factor * 100).rounded.max (1)
			l_zoom_selector := tool.zoom_selector
			l_zoom_selector.show_as_text (new_scale)
			l_projector := tool.projector
			history.register_named_undoable (
					Interface_names.t_Diagram_zoom_out_cmd,
					[<<agent wc.fit_to_screen, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
					[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_fit_to_screen
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_fit_to_screen
		end

	name: STRING is "Fit_to_screen"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_FIT_TO_SCREEN_COMMAND
