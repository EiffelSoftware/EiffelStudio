indexing
	description: "Command to reduce the diagram"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ZOOM_OUT_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND


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
			if world /= Void and world.scale_x >= 0.5 then
				history.do_named_undoable (
					Interface_names.t_Diagram_zoom_out_cmd,
					[<<~change_scale (world, world.scale_x - 0.1),
						~project>>],
					[<<~change_scale (world, world.scale_x),
						~project>>])
			end
		end

feature {NONE} -- Implementation

	project is
			-- Call the projector.
		do
			tool.projector.project
		end

	change_scale (cd: CONTEXT_DIAGRAM; new_scale: DOUBLE) is
			-- Change scaling factor of world origin.
		require
			cd_not_void: cd /= Void
		local
			old_grid_x, old_grid_y: INTEGER
		do
			old_grid_x := cd.grid_x
			old_grid_y := cd.grid_y
			cd.set_scale_x (new_scale)
			cd.set_scale_y (new_scale)
			cd.point.set_scale_x (new_scale)
			cd.point.set_scale_y (new_scale)
			cd.set_grid_x ((cd.Default_grid_x * new_scale).rounded)
			cd.set_grid_y ((cd.Default_grid_y * new_scale).rounded)
			cd.point.set_position (
				(cd.point.x // old_grid_x) * cd.grid_x,
				(cd.point.y // old_grid_y) * cd.grid_y)
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_zoom_out
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_zoom_out
		end

	name: STRING is "Zoom_out"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_ZOOM_OUT_COMMAND
