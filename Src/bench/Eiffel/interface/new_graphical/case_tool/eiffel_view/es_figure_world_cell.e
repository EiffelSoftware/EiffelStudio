indexing
	description: "Objects that casts the projector in EV_MODEL_WORLD_CELL to EIFFEL_PROJECTOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FIGURE_WORLD_CELL

inherit
	EV_MODEL_WORLD_CELL
		redefine
			projector,
			on_pointer_button_press_on_drawing_area,
			on_pointer_button_release_on_drawing_area,
			initialize,
			on_mouse_wheel_on_drawing_area,
			world,
			set_world
		end
		
	EB_RECYCLABLE
		undefine
			copy,
			default_create
		end

	EB_CONSTANTS
		undefine
			copy,
			default_create
		end
		
	OBSERVER
		rename
			update as retrieve_preferences
		undefine
			default_create,
			copy
		end
		
	EB_SHARED_PREFERENCES
		undefine
			default_create,
			copy
		end

create
	make_with_world,
	make_with_world_and_tool
	
feature {NONE} -- Initialization

	make_with_world_and_tool (a_world: like world; a_tool: like tool) is
			-- Make an EIFFEL_FIGURE_WORLD_CELL displaying `a_world' inside `a_tool'.
		require
			a_world_not_void: a_world /= Void
			a_tool_not_void: a_tool /= Void
		do
			make_with_world (a_world)
			tool := a_tool
		ensure
			set: tool = a_tool
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MODEL_WORLD_CELL}
			drawing_area.set_pointer_style (cursors.open_hand_cursor)
			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences
		end

feature -- Access

	projector: EIFFEL_PROJECTOR
			-- The projector used to project the `world'.
			
	tool: EB_CONTEXT_EDITOR
			-- Tool the `world' is displayed in.

	world: EIFFEL_WORLD
			-- World shown in Current.

feature -- Element change

	set_world (a_world: like world) is
			-- Set `world' to `a_world'.
		do
			if world /= Void then
					-- `recycle' former world to avoid memory leak.
				world.recycle
			end
			world := a_world
			projector.set_world (a_world)
		end

feature -- Recycling

	recycle is
			-- Recycle `Current' and leave `Current' in an unstable state.
		do
			preferences.diagram_tool_data.remove_observer (Current)
			world.recycle
		end
		
feature {NONE} -- Implementation

	on_pointer_button_press_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was pressed in `drawing_area'.
		do
			if button = 1 then
				if projector.is_figure_selected then
					is_scroll := True	
				elseif not ev_application.ctrl_pressed then
					drawing_area.set_pointer_style (cursors.closed_hand_cursor)
					is_hand := True
					start_x := ax
					start_y := ay
					start_horizontal_value := horizontal_scrollbar.value
					start_vertical_value := vertical_scrollbar.value
					drawing_area.enable_capture
				else
					is_scroll := True
				end
			end
		end
		
	on_pointer_button_release_on_drawing_area (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- Pointer button was released over `drawing_area'.
		do
			if is_scroll then
				is_scroll := False
			end
			if is_hand then
				is_hand := False
				drawing_area.set_pointer_style (cursors.open_hand_cursor)
				drawing_area.disable_capture
			end
		end
		
	on_mouse_wheel_on_drawing_area (i: INTEGER) is
			-- User moved mouse wheel.
		local
			l_world: EIFFEL_WORLD
			new_scale_factor, l_scale_factor: DOUBLE
			l_zoom_selector: EB_ZOOM_SELECTOR
			new_scale, old_scale: INTEGER
			l_projector: EIFFEL_PROJECTOR
			step: INTEGER
		do
			if ev_application.ctrl_pressed then
				if tool /= Void then
					if i <= -1 then
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
						tool.history.register_named_undoable (
								Interface_names.t_Diagram_zoom_in_cmd,
								[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
								[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
					else
						l_world := tool.world
						l_scale_factor := l_world.scale_factor
						new_scale_factor := (0.1 - l_scale_factor) / -l_scale_factor
						if l_world.scale_factor * new_scale_factor > 0.1 then
							old_scale := (l_world.scale_factor * 100).rounded
							l_world.scale (new_scale_factor)
							tool.crop_diagram
							l_projector := tool.projector
							l_projector.full_project
							new_scale := (l_world.scale_factor * 100).rounded
							l_zoom_selector := tool.zoom_selector
							l_zoom_selector.show_as_text (new_scale)
							tool.history.register_named_undoable (
									Interface_names.t_Diagram_zoom_out_cmd,
									[<<agent l_world.scale (new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (new_scale), agent l_projector.full_project>>],
									[<<agent l_world.scale (1/new_scale_factor), agent tool.crop_diagram, agent l_zoom_selector.show_as_text (old_scale), agent l_projector.full_project>>])
						end
					end
				end
			else
				if ev_application.shift_pressed then
					step := (horizontal_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value - step).max (horizontal_scrollbar.value_range.lower))
					else
						horizontal_scrollbar.set_value ((horizontal_scrollbar.value + step).min (horizontal_scrollbar.value_range.upper))
					end
				else
					step := (vertical_scrollbar.value_range.count * 0.1).truncated_to_integer
					if i >= 1 then
						vertical_scrollbar.set_value ((vertical_scrollbar.value - step).max (vertical_scrollbar.value_range.lower))
					else
						vertical_scrollbar.set_value ((vertical_scrollbar.value + step).min (vertical_scrollbar.value_range.upper))
					end
				end
			end
		end
		
	retrieve_preferences is
			-- Retrieve `scroll_speed' from preferences.
		local
			val: INTEGER
		do
			val := preferences.diagram_tool_data.diagram_auto_scroll_speed
			val := val.min(100).max(0)
			scroll_speed := val / 100
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_FIGURE_WORLD_CELL
