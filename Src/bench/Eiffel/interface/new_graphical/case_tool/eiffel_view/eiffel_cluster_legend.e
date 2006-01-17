indexing
	description: "Objects that shows a legend with all cluster names in diagram and allows to colorize all classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLUSTER_LEGEND

inherit
	EV_MODEL_MOVE_HANDLE
		redefine
			default_create
		end

	SHARED_WORKBENCH
		undefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	BON_CONSTANTS
		undefine
			default_create
		end

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create
	make_with_world

create {EIFFEL_CLUSTER_LEGEND}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a EIFFEL_CLUSTER_LEGEND
		local
			id_pixmap: EV_IDENTIFIED_PIXMAP
		do
			Precursor {EV_MODEL_MOVE_HANDLE}
			create border
			border.set_background_color (default_colors.white)
			border.set_line_width (2)

			id_pixmap := pixmap_factory.registered_pixmap (pixmaps.icon_pin_legend_open)
			create open_pin
			open_pin.set_identified_pixmap (id_pixmap)

			id_pixmap := pixmap_factory.registered_pixmap (pixmaps.icon_pin_legend_closed)
			create closed_pin
			closed_pin.set_identified_pixmap (id_pixmap)

			create pin_button
			open_pin.set_point_position (pin_button.point_x, pin_button.point_y)
			pin_button.extend (closed_pin)

			extend (border)
			pin_button.pointer_button_press_actions.extend (agent on_pin)
			pin_button.set_pointer_style (default_pixmaps.standard_cursor)
			create pin_actions
		end

	make_with_world (a_world: like display_world) is
			-- Create an EIFFEL_CLUSTER_LEGEND displaying clusters in `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			default_create
			display_world := a_world
			create cluster_color_table.make (a_world.flat_clusters.count)
			set_pointer_style (default_pixmaps.sizeall_cursor)
			disable_rotating
			disable_scaling
			start_actions.extend (agent on_start_move)

			build_table
			build_legend
			update_position
			extend (colorize_button)
			extend (pin_button)
			is_pined := True
		ensure
			set: display_world = a_world
		end

feature -- Status report

	is_pined: BOOLEAN
			-- Is `Current' pined.

feature -- Access

	display_world: EIFFEL_WORLD
			-- World of wich clusters are displayed.

	pin_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `Current' is pined.

feature -- Element change

	update is
			-- Actualize cluster legend.
		do
			wipe_out
			cluster_color_table.wipe_out

			extend (border)

			border.set_point_a_position (point_x, point_y)
			border.set_point_b_position (point_x, point_y)

			build_table
			build_legend

			update_position

			extend (colorize_button)
			extend (pin_button)
		end


feature {NONE} -- Implementation

	build_table is
			-- Build `cluster_color_table'.
		local
			l_nodes: LIST [EG_LINKABLE_FIGURE]
			bcf: BON_CLASS_FIGURE
		do
			from
				l_nodes := display_world.flat_classes
				l_nodes.start
			until
				l_nodes.after
			loop
				bcf ?= l_nodes.item
				if bcf /= Void and then bcf.is_show_requested then
					include_bon_class (bcf)
				end
				l_nodes.forth
			end
		end

	build_legend is
			-- Build legend from `cluster_color_table'.
		local
			colors: ARRAYED_LIST [TUPLE [EV_COLOR, INTEGER]]
			l_color: EV_COLOR
			i, max: INTEGER
			l_cluster_entry: EV_MODEL_GROUP
			rec: EV_MODEL_RECTANGLE
			txt: EV_MODEL_TEXT
		do
			from
				cluster_color_table.start
				i := 0
			until
				cluster_color_table.after
			loop
				colors := cluster_color_table.item_for_iteration

				if colors.count = 1 then
					l_color ?= colors.first.item (1)
				else
					from
						max := 0
						colors.start
					until
						colors.after
					loop
						if colors.item.integer_item (2) > max then
							max := colors.item.integer_item (2)
							l_color ?= colors.item.item (1)
						end
						colors.forth
					end
				end

				create l_cluster_entry
					create rec.make_with_positions (0, 2, 30, 18)
					rec.set_background_color (l_color)
				l_cluster_entry.extend (rec)
					create txt.make_with_text (cluster_color_table.key_for_iteration)
					txt.set_point_position (35, 2)
				l_cluster_entry.extend (txt)
				l_cluster_entry.set_point_position (point_x, point_y + i * 20)
				l_cluster_entry.set_pebble_function (agent cluster_pebble (cluster_color_table.key_for_iteration))
				l_cluster_entry.set_accept_cursor (cursors.cur_cluster)
				l_cluster_entry.set_deny_cursor (cursors.cur_x_cluster)
				extend (l_cluster_entry)

				cluster_color_table.forth
				i := i + 1
			end
		end

	include_bon_class (a_class: BON_CLASS_FIGURE) is
			-- Include color of `a_class' into `cluster_color_table'.
		require
			a_class_not_void: a_class /= Void
		local
			cluster_name: STRING
			colors: ARRAYED_LIST [TUPLE [EV_COLOR, INTEGER]]
		do
			cluster_name := a_class.model.class_i.cluster.cluster_name
			colors := cluster_color_table.item (cluster_name)
			if colors = Void then
				create colors.make (1)
				colors.extend ([a_class.background_color, 1])
				cluster_color_table.put (colors, cluster_name)
			else
				add_color (colors, a_class.background_color)
			end
		end

	add_color (a_colors: ARRAYED_LIST [TUPLE [EV_COLOR, INTEGER]]; a_color: EV_COLOR) is
			-- Add `a_color' to `a_colors'.
		require
			a_colors_not_void: a_colors /= Void
			a_color_not_void: a_color /= Void
		local
			l_item: TUPLE [EV_COLOR, INTEGER]
			l_color: EV_COLOR
			found: BOOLEAN
		do
			from
				a_colors.start
			until
				a_colors.after or else found
			loop
				l_item := a_colors.item
				l_color ?= l_item.item (1)
				check
					is_color: l_color /= Void
				end
				if
					l_color.red = a_color.red and then
					l_color.green = a_color.green and then
					l_color.blue = a_color.blue
				then
					found := True
					l_item.put_integer (l_item.integer_item (2) + 1, 2)
				end
				a_colors.forth
			end
			if not found then
				a_colors.extend ([a_color, 1])
			end
		end

	update_position is
			-- Update position of `border' and `colorize_button'.
		local
			bbox: like bounding_box
		do
			bbox := bounding_box
			border.set_point_a_position (bbox.left - 10, bbox.top - 10)
			border.set_point_b_position (bbox.right + 50, bbox.bottom + 10)
			colorize_button.set_point_position (border.point_b_x - 23, border.point_a_y + 1)
			pin_button.set_point_position (border.point_b_x - 43, border.point_a_y + 1)
		end

	cluster_pebble (cluster_name: STRING): CLUSTER_STONE is
			-- Return stone for cluster with `cluster_name' if any.
		local
			cluster_i: CLUSTER_I
		do
			cluster_i := universe.cluster_of_name (cluster_name)
			if cluster_i /= Void then
				create Result.make (cluster_i)
			end
		end

	on_start_move is
			-- User started to move `Current'.
		do
			display_world.bring_to_front (Current)
		end

	on_colorize (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- User pressed `colorize_button'.
		local
			class_list: ARRAYED_LIST [BON_CLASS_FIGURE]
			old_color_table, new_color_table: HASH_TABLE [EV_COLOR, STRING]
			l_nodes: LIST [EG_LINKABLE_FIGURE]
			bcf: BON_CLASS_FIGURE
			colors: ARRAYED_LIST [TUPLE [EV_COLOR, INTEGER]]
			new_color: EV_COLOR
			color_nr: INTEGER
		do
			if button = 1 then
				from
					cluster_color_table.start
					color_nr := 1
				until
					cluster_color_table.after
				loop
					colors := cluster_color_table.item_for_iteration
					colors.first.put (color_with_number (color_nr), 1)
					cluster_color_table.forth
					color_nr := color_nr + 1
				end
				from
					l_nodes := display_world.flat_classes
					create class_list.make (l_nodes.count)
					create old_color_table.make (l_nodes.count)
					create new_color_table.make (l_nodes.count)
					l_nodes.start
				until
					l_nodes.after
				loop
					bcf ?= l_nodes.item
					if bcf /= Void then
						colors := cluster_color_table.item (bcf.model.class_i.cluster.cluster_name)
						if colors = Void then
							new_color := color_with_number (color_nr)
							create colors.make (1)
							colors.extend ([new_color, 1])
							cluster_color_table.put (colors, bcf.model.class_i.cluster.cluster_name)
							color_nr := color_nr + 1
						else
							new_color ?= colors.first.item (1)
						end
						check
							new_color_not_void: new_color /= Void
						end
						new_color_table.put (new_color, bcf.model.name)
						old_color_table.put (bcf.background_color, bcf.model.name)
						class_list.extend (bcf)
					end
					l_nodes.forth
				end
				display_world.context_editor.history.do_named_undoable (
					Interface_names.t_Diagram_change_color_cmd,
					agent change_color_all (class_list, new_color_table),
					agent change_color_all (class_list, old_color_table))
			end
		end

	change_color_all (classes: LIST [BON_CLASS_FIGURE]; color_table: HASH_TABLE [EV_COLOR, STRING]) is
			-- Change color of `classes' according to `color_table'.
		require
			classes_exist: classes /= Void
			color_table_exist: color_table /= Void
		local
			cf: BON_CLASS_FIGURE
			c: EV_COLOR
		do
			from
				classes.start
			until
				classes.after
			loop
				cf := classes.item
				c := color_table.item (classes.item.model.name)
				if c /= Void then
					change_font (classes.item, c)
					cf.set_background_color (c)
				end
				classes.forth
			end

			update
			display_world.context_editor.projector.project
		end

	change_font (cf: BON_CLASS_FIGURE; a_color: EV_COLOR) is
			-- Change color of class figure names in order to
			-- keep them readable.
		require
			cf_not_void: cf /= Void
			a_color_not_void: a_color /= Void
		local
			diff: DOUBLE
		do
			diff := a_color.lightness - bon_class_name_color.lightness
			if diff.abs > 0.3 then
				cf.set_class_name_color (bon_class_name_color)
			elseif (a_color.blue > 0.8 and (a_color.green + a_color.red) < 0.5) or a_color.lightness < 0.4 then
				cf.set_class_name_color (default_colors.white)
			else
				cf.set_class_name_color (default_colors.black)
			end
			diff := a_color.lightness - bon_generics_color.lightness
			if diff.abs > 0.3 then
				cf.set_generics_color (bon_generics_color)
			elseif (a_color.blue > 0.8 and (a_color.green + a_color.red) < 0.5) or a_color.lightness < 0.4 then
				cf.set_generics_color (default_colors.white)
			else
				cf.set_generics_color (default_colors.black)
			end
		end

	color_with_number (a_nb: INTEGER): EV_COLOR is
			-- Return color with `a_nb'.
		require
			a_nb_larger_zero: a_nb > 0
		do
			inspect a_nb
			when 1 then
				Result := default_colors.blue
			when 2 then
				Result := default_colors.red
			when 3 then
				Result := default_colors.green
			when 4 then
				Result := default_colors.magenta
			when 5 then
				Result := default_colors.yellow
			when 6 then
				Result := default_colors.cyan
			when 7 then
				Result := default_colors.grey
			when 8 then
				Result := default_colors.dark_blue
			when 9 then
				Result := default_colors.dark_red
			when 10 then
				Result := default_colors.dark_green
			when 11 then
				Result := default_colors.dark_magenta
			when 12 then
				Result := default_colors.dark_yellow
			when 13 then
				Result := default_colors.dark_cyan
			when 14 then
				Result := default_colors.dark_grey
			else
				Result := random_color_table.item (a_nb)
				if Result = Void then
					create Result.make_with_8_bit_rgb (random.next_item_in_range (0, 255), random.next_item_in_range (0, 255), random.next_item_in_range (0, 255))
					random_color_table.put (Result, a_nb)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	random: RANGED_RANDOM is
		once
			create Result.make
		end

	random_color_table: HASH_TABLE [EV_COLOR, INTEGER] is
			-- Table of numbers and colors.
		once
			create Result.make (10)
		end

	colorize_button: EV_MODEL_GROUP is
			-- Button to colorize all classes at once.
		local
			colorize_border: EV_MODEL_RECTANGLE
			color_rec: EV_MODEL_RECTANGLE
			i, j, nb: INTEGER
		do
			if internal_colorize_button = Void then
				create Result
				create colorize_border.make_with_positions (0, 0, 22, 22)
				Result.extend (colorize_border)
				from
					i := 0
					nb := 1
				until
					i > 3
				loop
					from
						j := 0
					until
						j > 3
					loop
						create color_rec.make_with_positions (1 + i * 5, 1 + j * 5, 1 + (i + 1) * 5, 1 + (j + 1) * 5)
						color_rec.set_line_width (0)
						color_rec.set_background_color (color_with_number (nb))

						Result.extend (color_rec)
						nb := nb + 1
						j := j + 1
					end
					i := i + 1
				end
				Result.set_pointer_style (default_pixmaps.standard_cursor)
				Result.pointer_button_press_actions.extend (agent on_colorize)
				internal_colorize_button := Result
			else
				Result := internal_colorize_button
			end
		ensure
			Result_not_Void: Result /= Void
			Result_equal_implementation: internal_colorize_button = Result
		end

	internal_colorize_button: like colorize_button
			-- Implementation of `colorize_button'.

	cluster_color_table: HASH_TABLE [ARRAYED_LIST [TUPLE [EV_COLOR, INTEGER]], STRING]
			-- Table of cluster names and list of colors of classes of cluster with cluster
			-- name and how many classes in the cluster have this color.

	border: EV_MODEL_RECTANGLE
			-- Border of the legend

feature {NONE} -- Implementation pin

	pin_button: EV_MODEL_GROUP
			-- Button to select if `Current' is pined.

	open_pin: EV_MODEL_PICTURE

	closed_pin: EV_MODEL_PICTURE

	on_pin (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- User pressed `pin_button'.
		do
			pin_button.wipe_out
			if is_pined then
				open_pin.set_point_position (pin_button.point_x, pin_button.point_y)
				pin_button.extend (open_pin)
			else
				closed_pin.set_point_position (pin_button.point_x, pin_button.point_y)
				pin_button.extend (closed_pin)
			end
			is_pined := not is_pined
			pin_actions.call (Void)
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

end -- class EIFFEL_CLUSTER_LEGEND
