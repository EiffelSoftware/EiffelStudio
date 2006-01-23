indexing
	description: "Objects that provide a graphical means to view instance referers of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INSTANCE_VIEWER

create
	make_with_object_and_parent,
	make_with_object

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_object_and_parent (an_object: GB_OBJECT; a_parent: EV_CONTAINER; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create instance viewer for object `an_object' parented in `a_parent'.
		require
			an_object_not_void: an_object /= Void
			parent_not_void: a_parent /= Void
			parent_not_full: not a_parent.full
		do
			components := a_components
			object := an_object
			initialize
			a_parent.extend (drawing_area)
		end

	make_with_object (an_object: GB_OBJECT) is
			-- Create instance viewer for object `an_object' shown modally to `main_window'.
		require
			an_object_not_void: an_object /= Void
		local
			dialog: EV_DIALOG
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			close_button: EV_BUTTON
		do
			object := an_object
			initialize
			create dialog
			create vertical_box
			dialog.extend (vertical_box)
			vertical_box.extend (drawing_area)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			horizontal_box.extend (create {EV_CELL})
			create close_button.make_with_text ("Close")
			close_button.select_actions.extend (agent dialog.destroy)
			horizontal_box.extend (close_button)
			horizontal_box.disable_item_expand (close_button)
			dialog.set_default_cancel_button (close_button)
			dialog.set_minimum_size (640, 480)
			dialog.show_modal_to_window (components.tools.main_window)
		end

feature {NONE} -- Implementation

	all_objects: HASH_TABLE [INTEGER, INTEGER]

	object: GB_OBJECT
		-- Object which is the subject of `Current'.

	drawing_area: EV_DRAWING_AREA
		-- Canvas for all drawing operations

	world: EV_FIGURE_WORLD
		-- World containing all figures.

	rectangle_width: INTEGER is 40
	spacing: INTEGER is 30
		-- Default sizing for the  figures.

	initialize is
			-- Initialize the drawing area.
		do
			create world
			create drawing_area
			create all_objects.make (20)
			create projector.make (world, drawing_area)
			fill_world
			drawing_area.expose_actions.force_extend (agent projector.project)
		end

	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector for drawing.

	fill_world is
			-- Fill all figures into `world'.
		local
			rectangle: EV_FIGURE_RECTANGLE
			move_handle: EV_MOVE_HANDLE
			coor1, coor2: EV_RELATIVE_POINT
			text: EV_FIGURE_TEXT
			list: ARRAYED_LIST [INTEGER]
		do
			create move_handle
			create rectangle
			create coor1.make_with_position (20, (rectangle_width + spacing))
			create coor2.make_with_position (20 + rectangle_width, (rectangle_width + spacing) + rectangle_width)
			rectangle.set_point_a (coor1)
			rectangle.set_point_b (coor2)
			create text.make_with_text (object.id.out)
			create coor1.make_with_position (20 + (rectangle_width - text.height) // 2, (rectangle_width + spacing) + (rectangle_width - text.width) // 2)
			text.set_point (coor1)

			world.extend (move_handle)
			move_handle.extend (rectangle)
			all_objects.force (object.id, object.id)
			move_handle.move_actions.force_extend (agent drawing_area.clear)
			move_handle.move_actions.force_extend (agent projector.full_project)

			move_handle.extend (text)
			create list.make (20)
			list.extend (1)
			fill_world_internal (object, 2, list, rectangle)
		end

	fill_world_internal (an_object: GB_OBJECT; depth: INTEGER; counts: ARRAYED_LIST [INTEGER]; parent_rect: EV_FIGURE_RECTANGLE) is
			-- Add `instance_referers' for `an_object' to `world' with a depth of `depth', a horizontal position given by `counts'
			-- and a parent rectangle to associate a line with given by `parent_rect'.
		require
			an_object_not_void: an_object /= Void
			depth_positive: depth >= 1
			counts_not_void: counts /= Void
			parent_rect_not_void: parent_rect /= Void
		local
			current_object: GB_OBJECT
			rectangle: EV_FIGURE_RECTANGLE
			move_handle: EV_MOVE_HANDLE
			coor1, coor2: EV_RELATIVE_POINT
			text: EV_FIGURE_TEXT
			figure_line: EV_FIGURE_LINE
			do_not_recurse: BOOLEAN
		do
			if counts.count < depth then
				counts.extend (0)
			end
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				current_object := components.object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				all_objects.search (current_object.id)
				do_not_recurse := all_objects.found

				create move_handle
				create rectangle
				create coor1.make_with_position (20 + (counts.i_th (depth) * (rectangle_width + spacing)), depth * (rectangle_width + spacing))
				create coor2.make_with_position (20 + (counts.i_th (depth) * (rectangle_width + spacing) + rectangle_width), depth * (rectangle_width + spacing) + rectangle_width)
				rectangle.set_point_a (coor1)
				rectangle.set_point_b (coor2)
				create text.make_with_text (current_object.id.out)
				create coor1.make_with_position (20 + (rectangle_width - text.height) // 2 + (counts.i_th (depth) * (rectangle_width + spacing)), (depth *  (rectangle_width + spacing)) + (rectangle_width - text.width) // 2)
				text.set_point (coor1)

				world.extend (move_handle)
				move_handle.extend (rectangle)
				move_handle.extend (text)
				move_handle.move_actions.force_extend (agent drawing_area.clear)
				move_handle.move_actions.force_extend (agent projector.full_project)

				if parent_rect /= Void then
					create figure_line.make_with_points (parent_rect.point_b, rectangle.point_a)
					figure_line.set_line_width (3)
					world.extend (figure_line)
				end

				counts.put_i_th (counts.i_th (depth) + 1, depth)
				if not do_not_recurse then
					fill_world_internal (current_object, depth + 1, counts, rectangle)
				end
				an_object.instance_referers.forth
			end
		end

invariant
	is_in_debug_mode: components.system_status.is_in_debug_mode

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


end -- class GB_INSTANCE_VIEWER
