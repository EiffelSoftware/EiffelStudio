note
	description: "Objects that represent a BON view for an EIFFEL_CLASS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLASS_FIGURE

inherit
	EIFFEL_CLASS_FIGURE
		undefine
			is_storable
		redefine
			default_create,
			set_name_label_text,
			recursive_transform,
			world,
			xml_node_name,
			xml_element,
			set_with_xml_element,
			set_is_fixed,
			recycle
		end

	BON_FIGURE
		undefine
			default_create
		end

	DEBUG_OUTPUT
		undefine
			default_create
		end

	OBSERVER
		rename
			update as preferences_changed
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create
	default_create,
	make_with_model

create {BON_CLASS_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create a BON_CLASS_FIGURE
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			prune_all (name_label)

			create ellipse
			extend (ellipse)

			create name_labels
			extend (name_labels)

			create icon_figures
			extend (icon_figures)

			create generics_label
			extend (generics_label)

			is_high_quality := True
			disable_rotating
			disable_scaling

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences

			is_default_background_color_used := True
		end

	make_with_model (a_model: ES_CLASS)
			-- Create a BON_CLASS_FIGURE using the `model' `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize

			set_bon_icons
			model.properties_changed_actions.extend (agent set_bon_icons)

			set_generics
			model.generics_changed_actions.extend (agent set_generics)

			request_update
		end

feature -- Status report

	is_anchor_shown: BOOLEAN
			-- Is anchor indicating `is_fixed' shown?

feature -- Access

	world: EIFFEL_WORLD
			-- World `Current' is part of.
		do
			Result ?= Precursor {EIFFEL_CLASS_FIGURE}
		end

	port_x: INTEGER
			-- x position where links are starting.
		do
			Result := point_x
		end

	port_y: INTEGER
			-- y position where links are starting.
		do
			Result := point_y
		end

	size: EV_RECTANGLE
			-- Size of `Current'.
		local
			pax, pay: INTEGER
		do
			pax := ellipse.point_a_x
			pay := ellipse.point_a_y
			create Result.make (pax, pay, ellipse.point_b_x - pax, ellipse.point_b_y - pay)
		end

	height: INTEGER
			-- Height in pixels.
		do
			Result := ellipse.radius2 * 2
		end

	width: INTEGER
			-- Width in pixels.
		do
			Result := ellipse.radius1 * 2
		end

	background_color: EV_COLOR
			-- Background color for the ellipse.

	class_name_color: EV_COLOR
			-- Color for the class name.

	generics_color: EV_COLOR
			-- Color for generics.

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := model.name_32
		end

	xml_node_name: STRING
			-- Name of the xml node returned by `xml_element'.
		do
			Result := {BON_FACTORY}.xml_class_figure_node_name
		end

	is_default_bg_color_used_string: STRING = "IS_DEFAULT_BG_COLOR_USED"
	cluster_name_string: STRING = "CLUSTER_NAME"
	background_color_string: STRING = "BACKGROUND_COLOR"
	generics_color_string: STRING = "GENERICS_COLOR"
	class_name_color_string: STRING = "CLASS_NAME_COLOR"

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml element representing `Current's state.
		local
			colon_string: STRING
			l_color: EV_COLOR
			l_xml_routines: like xml_routines
			l_model: like model
		do
			l_xml_routines := xml_routines
			l_model := model
			Result := Precursor {EIFFEL_CLASS_FIGURE} (node)
			Result.add_attribute (cluster_name_string, xml_namespace, l_model.class_i.group.name)
			Result.put_last (l_xml_routines.xml_node (Result, is_default_bg_color_used_string, boolean_representation (is_default_background_color_used)))
			if not is_default_background_color_used then
				colon_string := ";"
				l_color := background_color
				Result.put_last (l_xml_routines.xml_node (Result, background_color_string,
					l_color.red_8_bit.out + colon_string +
					l_color.green_8_bit.out + colon_string +
					l_color.blue_8_bit.out))
				l_color := generics_color
				Result.put_last (l_xml_routines.xml_node (Result, generics_color_string,
					l_color.red_8_bit.out + colon_string +
					l_color.green_8_bit.out + colon_string +
					l_color.blue_8_bit.out))
				l_color := class_name_color
				Result.put_last (l_xml_routines.xml_node (Result, class_name_color_string,
					l_color.red_8_bit.out + colon_string +
					l_color.green_8_bit.out + colon_string +
					l_color.blue_8_bit.out))
			end
			Result.put_last (l_xml_routines.xml_node (Result, is_needed_on_diagram_string, boolean_representation (l_model.is_needed_on_diagram)))
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			l_xml_routines: like xml_routines
		do
			l_xml_routines := xml_routines
			node.forth
			Precursor {EIFFEL_CLASS_FIGURE} (node)
			if not l_xml_routines.xml_boolean (node, is_default_bg_color_used_string) then
				set_background_color (l_xml_routines.xml_color (node, background_color_string))
				set_generics_color (l_xml_routines.xml_color (node, generics_color_string))
				set_class_name_color (l_xml_routines.xml_color (node, class_name_color_string))
			else
				if is_high_quality then
					if background_color /= Void then
						ellipse.set_background_color (background_color)
					end
				else
					ellipse.set_background_color (low_quality_fill_color)
				end
				set_generics_properties
				set_class_name_properties
				is_default_background_color_used := True
			end
			if l_xml_routines.xml_boolean (node, is_needed_on_diagram_string) then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
		end

feature -- Status settings

	show_anchor
			-- Show anchor, if `is_fixed'.
		do
			if is_fixed then
				if anchor = Void then
					create_anchor
				end
				anchor.show
				anchor.set_x_y (ellipse.point_a_x + 3, ellipse.point_a_y + 3)
				is_anchor_shown := True
				request_update
			end
		ensure
			fixed_implies_show: is_fixed implies is_anchor_shown
		end

	hide_anchor
			-- Hide anchor.
		do
			if anchor /= Void and then anchor.is_show_requested then
				anchor.hide
				is_anchor_shown := False
				request_update
			end
		ensure
			anchor_hidden: not is_anchor_shown
		end

	set_is_fixed (b: BOOLEAN)
			-- Set `is_fixed' to `b'.
		do
			Precursor {EIFFEL_CLASS_FIGURE} (b)
			if not is_fixed then
				hide_anchor
			elseif world.context_editor.is_force_directed_used then
				show_anchor
			end
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			if model /= Void then
				model.properties_changed_actions.prune_all (agent set_bon_icons)
				model.generics_changed_actions.prune_all (agent set_generics)
			end
			preferences.diagram_tool_data.remove_observer (Current)
		end

	set_background_color (a_color: EV_COLOR)
			-- Set `background_color' to `a_color'.
		do
			is_default_background_color_used := False
			background_color := a_color
			set_ellipse_properties
		ensure
			set: background_color = a_color
		end

	set_generics_color (a_color: EV_COLOR)
			-- Set `generics_color' to `a_color'.
		require
			a_color_not_void: a_color /= Void
		local
			txt: EV_MODEL_TEXT
		do
			generics_color := a_color
			from
				generics_label.start
			until
				generics_label.after
			loop
				txt ?= generics_label.item
				txt.set_foreground_color (a_color)
				generics_label.forth
			end
		ensure
			set: generics_color = a_color
		end

	set_class_name_color (a_color: EV_COLOR)
			-- Set `class_name_color' to `a_color'.
		require
			a_color_not_void: a_color /= Void
		local
			txt: EV_MODEL_TEXT
		do
			class_name_color := a_color
			from
				name_labels.start
			until
				name_labels.after
			loop
				txt ?= name_labels.item
				txt.set_foreground_color (a_color)
				name_labels.forth
			end
		ensure
			set: class_name_color = a_color
		end

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE)
			-- Move `p', which is relative to `Current', to a point on the
			-- edge where the outline intersects a line from the center point
			-- in direction `an_angle'.
		local
			ax, ay, l: DOUBLE
			a, b: DOUBLE
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1: EV_COORDINATE
			cx, cy, val1, val2: DOUBLE
		do
				-- Some explanation for those you have forgotten about their math classes.
				-- We have two equations:
				-- 1 - the ellipse: x^2/a^2 + y^2/b^2 = 1
				-- 2 - the line which has an angle `an_angle': y = tan(an_angle) * x
				--
				-- The solution of the problem is to find the point (x, y) which is
				-- common to both equations (1) and (2). Because `tangent' only applies for
				-- angle values between ]-pi / 2, pi / 2 [, we have to get the result
				-- for the other quadrant of the ellipse by mirroring the value of x
				-- and of y.
				-- With `l = tan(an_angle)', we can write the following equivalences:
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2/a^2 + (l^2*x^2)/b^2 = 1
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2*b^2 + l^2*x^2*a^2 = a^2*b^2
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2*(b^2 + l^2*a^2) = a^2*b^2
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2 = a^2*b^2 / (b^2 + l^2*a^2)
				-- x^2/a^2 + y^2/b^2 = 1 <=> x = a*b / sqrt(b^2 + l^2*a^2)
			l := tangent (an_angle)
			l_point_array := ellipse.point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			val1 := p0.x_precise
			val2 := p1.x_precise
			a := (val1 - val2) / 2
			cx := (val1 + val2) / 2

			val1 := p0.y_precise
			val2 := p1.y_precise
			b := (val1 - val2) / 2
			cy := (val1 + val2) / 2
			if a * l = 0 and b = 0 then
				ax := 0
				ay := 0
			else
				ax := (a * b) / sqrt (b^2 + l^2 * a^2)
				ay := l * ax

				if cosine (an_angle) < 0 then
						-- When we are in ]pi/2, 3*pi/2[, then we need to reverse
						-- the coordinates. It looks strange like that, but don't forget
						-- that although `ax' is always positive, `ay' might be negative depending
						-- on the sign of `l'. This is why we need to reverse both coordinates,
						-- but because we also need to reverse the `ay' value because in a figure world
						-- the `ay' coordinates go down and not up, the effect is null, thus no operation
						-- on `ay'.
					ax := -ax
				else
						-- We need to reverse the y value, because in a figure world, the y coordinates
						-- go down and not up.
					ay := -ay
				end
			end
			p.set_precise (cx + ax, cy - ay)
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update
			-- Some properties of `Current' may have changed.
		do
			is_update_required := False
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION)
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		local
			i_radius: INTEGER
		do
			Precursor {EIFFEL_CLASS_FIGURE} (a_transformation)
			ellipse_radius_1 := ellipse_radius_1 * a_transformation.item (1, 1)
			ellipse_radius_2 := ellipse_radius_2 * a_transformation.item (2, 2)
			i_radius := as_integer (ellipse_radius_1)
			if ellipse.radius1 /= i_radius then
				ellipse.set_radius1 (i_radius)
			end
			i_radius := as_integer (ellipse_radius_2)
			if ellipse.radius2 /= i_radius then
				ellipse.set_radius2 (i_radius)
			end
		end

feature {EIFFEL_PROJECTOR} -- Ellipse

	ellipse: EV_MODEL_ELLIPSE
			-- The BON ellipse.

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected)
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					ellipse.set_line_width (bon_class_selected_line_width)
				else
					ellipse.set_line_width (bon_class_line_width)
				end
			end
		end

	is_default_background_color_used: BOOLEAN
			-- Was background color not changed by client?

	ellipse_radius_1: DOUBLE
			-- Horizontal radius of `ellipse'.

	ellipse_radius_2: DOUBLE
			-- Vertical radius of `ellipse'.

	number_of_figures: INTEGER = 2
			-- Number of figures used to visualize `Current'.
			-- (`ellipse', `anchor')

	icon_figures: EV_MODEL_GROUP
			-- Optional icon for class types deferred, effective, persistent, interfaced.

	icon_spacing: INTEGER = 1
			-- Space in pixel between icons in `icon_figures'.

	name_labels: EV_MODEL_GROUP
			-- All the part of the name of the class.

	generics_label: EV_MODEL_GROUP
			-- All parts of `model'.`generics' name.

	anchor: detachable EV_MODEL_GROUP note option: stable attribute end
			-- Anchor indicating that `Current' `is_fixed'.

	set_bon_icons
			-- Examine the properties of the class and add `icon_figures'.
		require
			model_not_void: model /= Void
		local
			icon: EV_MODEL_PICTURE
			hw: INTEGER
			l_bbox: EV_RECTANGLE
		do
			l_bbox := temp_bounding_box
			icon_figures.wipe_out
			icon_figures.set_point_position (0, 0)
			if model.is_deferred then
				create icon.make_with_identified_pixmap (bon_deferred_icon)
				icon_figures.extend (icon)
			end
			if model.is_effective then
				create icon.make_with_identified_pixmap (bon_effective_icon)
				if icon_figures.count > 0 then
					icon_figures.update_rectangle_to_bounding_box (l_bbox)
					icon.set_point_position (l_bbox.width + icon_spacing, 0)
				end
				icon_figures.extend (icon)
			end
			if model.is_persistent then
				create icon.make_with_identified_pixmap (bon_persistent_icon)
				if icon_figures.count > 0 then
					icon_figures.update_rectangle_to_bounding_box (l_bbox)
					icon.set_point_position (l_bbox.width + icon_spacing, 0)
				end
				icon_figures.extend (icon)
			end
			if model.is_interfaced then
				create icon.make_with_identified_pixmap (bon_interfaced_icon)
				if icon_figures.count > 0 then
					icon_figures.update_rectangle_to_bounding_box (l_bbox)
					icon.set_point_position (l_bbox.width + icon_spacing, 0)
				end
				icon_figures.extend (icon)
			end

			if icon_figures.count > 0 then
				from
					icon_figures.update_rectangle_to_bounding_box (l_bbox)
					hw := as_integer (l_bbox.width / 2)
					icon_figures.start
				until
					icon_figures.after
				loop
					icon_figures.item.set_x (icon_figures.item.x - hw)
					icon_figures.forth
				end
			end

			if world /= Void then
				icon_figures.scale (world.scale_factor)
			end
			if is_default_background_color_used then
				if model.is_compiled then
					if is_default_background_color_used then
						background_color := bon_class_fill_color
					end
				else
					if is_default_background_color_used then
						background_color := bon_class_uncompiled_fill_color
					end
				end
			 	set_ellipse_properties
			end
			update_information_positions
			request_update
		end

	set_name_label_text (a_text: READABLE_STRING_32)
			-- Set texts in `name_labels'.
			-- | With line wrap at `max_class_name_length'.
		local
			s, rest: STRING_32
			i: INTEGER
			part_text: EV_MODEL_TEXT
			l_bbox: EV_RECTANGLE
		do
			name_labels.wipe_out
			name_labels.set_point_position (0, 0)
			if a_text.count > max_class_name_length then
				from
					l_bbox := temp_bounding_box
					rest := a_text
					i := a_text.last_index_of ('_', max_class_name_length)
				until
					i = 0 or else rest.count <= max_class_name_length
				loop
					s := rest.substring (1, i)
					rest := rest.substring (i + 1, rest.count)
					if rest.count > max_class_name_length then
						i := rest.last_index_of ('_', max_class_name_length)
--						if i = 0 then
--							i := max_class_name_length
--						end
					end
					create part_text.make_with_text (s)
					assign_class_name_properties_to_text (part_text)
					if world /= Void then
						part_text.scale (world.scale_factor)
					end
					name_labels.update_rectangle_to_bounding_box (l_bbox)
					part_text.set_point_position (0, l_bbox.height)
					part_text.set_x (0)
					name_labels.extend (part_text)
				end
				s := rest
				create part_text.make_with_text (s)
				assign_class_name_properties_to_text (part_text)
				name_labels.update_rectangle_to_bounding_box (l_bbox)
				part_text.set_point_position (0, l_bbox.height)
				part_text.set_x (0)
				name_labels.extend (part_text)
			else
				create part_text.make_with_text (a_text)
				assign_class_name_properties_to_text (part_text)
				if world /= Void then
					part_text.scale (world.scale_factor)
				end
				part_text.set_x (0)
				name_labels.extend (part_text)
			end
			update_information_positions
		end

	set_generics
			-- Set text in `generics_label'.
			-- | With line wrap at `max_generics_name_length'.
		local
			s, rest: STRING
			a_text: STRING
			i, j: INTEGER
			part_text: EV_MODEL_TEXT
			l_max_generics_name_length: INTEGER
		do
			a_text := model.generics

			if a_text /= Void then
				generics_label.show
				generics_label.wipe_out
				generics_label.set_point_position (0, 0)
				if a_text.count > max_generics_name_length then
					if a_text.count > 2 * max_generics_name_length then
						-- warp to two lines
						l_max_generics_name_length := (a_text.count / 2).ceiling
						i := a_text.index_of (' ', l_max_generics_name_length)
						j := a_text.index_of ('_', l_max_generics_name_length)
						if j < i then
							i := j
						end
						s := a_text.substring (1, i)
						create part_text.make_with_text (s)
						assign_generics_properties_to_text (part_text)
						if world /= Void then
							part_text.scale (world.scale_factor)
						end
						part_text.set_point_position (0, generics_label.bounding_box.height)
						part_text.set_x (0)
						generics_label.extend (part_text)
						rest := a_text.substring (i + 1, a_text.count)
					else
						l_max_generics_name_length := max_generics_name_length
						from
							rest := a_text
							i := rest.last_index_of (' ', l_max_generics_name_length)
							j := rest.last_index_of ('_', l_max_generics_name_length)
							if j > i then
								i := j
							end
							if i = 0 then
								i := l_max_generics_name_length
							end
						until
							i = 0 or else rest.count <= l_max_generics_name_length
						loop
							s := rest.substring (1, i)
							rest := rest.substring (i + 1, rest.count)
							if rest.count > l_max_generics_name_length then
								i := rest.last_index_of (' ', l_max_generics_name_length)
								j := rest.last_index_of ('_', l_max_generics_name_length)
								if j > i then
									i := j
								end
								if i = 0 then
									i := l_max_generics_name_length
								end
							end
							create part_text.make_with_text (s)
							assign_generics_properties_to_text (part_text)
							if world /= Void then
								part_text.scale (world.scale_factor)
							end
							part_text.set_point_position (0, generics_label.bounding_box.height)
							part_text.set_x (0)
							generics_label.extend (part_text)
						end
					end

					s := rest
					create part_text.make_with_text (s)
					assign_generics_properties_to_text (part_text)
					if world /= Void then
						part_text.scale (world.scale_factor)
					end
					part_text.set_point_position (0, generics_label.bounding_box.height)
					part_text.set_x (0)
					generics_label.extend (part_text)
				else
					create part_text.make_with_text (a_text)
					assign_generics_properties_to_text (part_text)
					if world /= Void then
						part_text.scale (world.scale_factor)
					end
					part_text.set_x (0)
					generics_label.extend (part_text)
				end
				update_information_positions
			else
				update_information_positions
			end
			request_update
		end

	update_information_positions
			-- Set positions of `name_labels', `bon_icons' and `generics_label'.
		local
			cur_pos, l_label_pos: INTEGER
			h, w: INTEGER
			l_ibbox_height, l_ibbox_width, l_nbbox_height, l_nbbox_width, l_gbbox_height, l_gbbox_width: INTEGER
			l_bbox: EV_RECTANGLE
			l_single_line_label: BOOLEAN
			l_min_size_left, l_min_size_top: INTEGER
			r, omega, l_sine_omega, l_cosine_omega: REAL_64
			l_r1_changed, l_r2_changed: BOOLEAN
		do
			l_bbox := temp_bounding_box
			if is_high_quality then
				if icon_figures.is_show_requested and then icon_figures.count > 0 then
					icon_figures.update_rectangle_to_bounding_box (l_bbox)
					l_ibbox_height := l_bbox.height
					l_ibbox_width := l_bbox.width
				else
					l_ibbox_height := 10
					l_ibbox_width := 10
				end
				if generics_label.is_show_requested and then generics_label.count > 0 then
					generics_label.update_rectangle_to_bounding_box (l_bbox)
					l_gbbox_height := l_bbox.height
					l_gbbox_width := l_bbox.width
				end
				name_labels.update_rectangle_to_bounding_box (l_bbox)
				l_nbbox_height := l_bbox.height
				l_nbbox_width := l_bbox.width

				l_single_line_label := name_labels.count = 1 and then generics_label.count = 1

				if l_single_line_label then
					h := l_nbbox_height.max (l_gbbox_height)
				else
					h := l_nbbox_height + l_gbbox_height
				end
				cur_pos := port_y - as_integer (h / 2)
				icon_figures.set_point_position (port_x, cur_pos - l_ibbox_height)
				h := h + l_ibbox_height

				if l_single_line_label then
						-- Put both name label and generic label on the same line if both single lined.
					w := (l_nbbox_width + l_gbbox_width + 4)
					l_label_pos := (l_nbbox_width // 2) - ((w + 2) // 2)
					name_labels.set_point_position (port_x + l_label_pos, cur_pos)
					l_label_pos := (l_gbbox_width // 2) - ((w + 2) // 2) + l_nbbox_width + 4
					generics_label.set_point_position (port_x + l_label_pos, cur_pos)
				else
					w := l_nbbox_width.max (l_gbbox_width)
					name_labels.set_point_position (port_x, cur_pos)
					cur_pos := cur_pos + l_nbbox_height
					generics_label.set_point_position (port_x, cur_pos)
				end
				w := w.max (l_ibbox_width)
				l_min_size_top := -(w // 2)
				l_min_size_left := -(h // 2)
			else
				name_labels.set_x_y (port_x, port_y)
				name_labels.update_rectangle_to_bounding_box (l_bbox)
				w := l_bbox.width
				h := l_bbox.height
				l_min_size_left := l_bbox.x
				l_min_size_top := l_bbox.y
			end

				-- Make sure than an oval shape is maintained.
			w := w.max (h * 16 // 10)

			r := distance (l_min_size_left, l_min_size_top, l_min_size_left + w / 2, l_min_size_top + h / 2)
			omega := line_angle (l_min_size_left + w / 2, l_min_size_top + h / 2, l_min_size_left + w, l_min_size_top)

			l_sine_omega := sine (omega)
			l_cosine_omega := cosine (omega)

			ellipse_radius_2 := sqrt (r^2*l_sine_omega^2*(1 + (l_cosine_omega^2/(l_sine_omega^2*(w^2/h^2))))) + 2
			ellipse_radius_1 := w * ellipse_radius_2 / h

			l_r1_changed := ellipse.radius1 /= as_integer (ellipse_radius_1)
			l_r2_changed := ellipse.radius2 /= as_integer (ellipse_radius_2)
			if l_r1_changed and then l_r2_changed then
				ellipse.set_radius1_and_radius2 (as_integer (ellipse_radius_1), as_integer (ellipse_radius_2))
			elseif l_r1_changed then
				ellipse.set_radius1 (as_integer (ellipse_radius_1))
			elseif l_r2_changed then
				ellipse.set_radius2 (as_integer (ellipse_radius_2))
			end
		end

	set_ellipse_properties
			-- Set properties of ellipse.
		require
			ellipse_not_void: ellipse /= Void
		do
			if not is_high_quality and then is_default_background_color_used then
				ellipse.set_background_color (low_quality_fill_color)
			else
				if background_color = Void then
					ellipse.remove_background_color
				else
					ellipse.set_background_color (background_color)
				end
			end
			ellipse.set_foreground_color (bon_class_line_color)
			if is_selected then
				ellipse.set_line_width (bon_class_selected_line_width)
			else
				ellipse.set_line_width (bon_class_line_width)
			end
		end

	set_generics_properties
			-- Set properties of `generics_label' according to generics properties.
		local
			txt: EV_MODEL_TEXT
		do
			from
				generics_label.start
			until
				generics_label.after
			loop
				txt ?= generics_label.item
				assign_generics_properties_to_text (txt)
				generics_label.forth
			end
		end

	assign_generics_properties_to_text (a_text: EV_MODEL_TEXT)
			-- Set propertis of `a_text' according to generics properties.
		require
			a_text /= Void
		do
			a_text.set_identified_font (bon_generics_font)
			a_text.set_foreground_color (generics_color)
		end

	set_class_name_properties
			-- Set properties of `name_labels' according to name properties.
		local
			txt: EV_MODEL_TEXT
		do
			from
				name_labels.start
			until
				name_labels.after
			loop
				txt ?= name_labels.item
				assign_class_name_properties_to_text (txt)
				name_labels.forth
			end
		end

	assign_class_name_properties_to_text (a_text: EV_MODEL_TEXT)
			-- Set properties of `a_text' according to name properties.
		require
			a_text /= Void
		do
			a_text.set_identified_font (bon_class_name_font)
			a_text.set_foreground_color (class_name_color)
		end

	low_quality_fill_color: EV_COLOR
			-- Fill color for low quality ellipse.
		once
			create Result.make_with_rgb (1, 1, 1)
		ensure
			result_not_void: Result /= Void
		end

	set_is_high_quality (a_high_quality: like is_high_quality)
			-- Set `is_high_quality' to `a_high_quality'.
		do
			if is_high_quality /= a_high_quality then
				is_high_quality := a_high_quality
				if is_high_quality then
					set_ellipse_properties
					icon_figures.show
					generics_label.show
				else
					set_ellipse_properties
					icon_figures.hide
					generics_label.hide
				end
				update_information_positions
				request_update
			end
		end

	preferences_changed
			-- User changed values of interest in preferences.
		do
			retrieve_preferences
			set_ellipse_properties
			set_class_name_properties
			set_generics_properties
			request_update
		end

	retrieve_preferences
			-- Retrive preferences from shared resources.
		do
			if model = Void or else model.is_compiled then
				background_color := bon_class_fill_color
			else
				background_color := bon_class_uncompiled_fill_color
			end
			generics_color := bon_generics_color
			class_name_color := bon_class_name_color

			set_ellipse_properties
			set_class_name_properties
			set_generics_properties
			request_update
		end

feature {NONE} -- Implementation

	create_anchor
			-- Create and initialize `anchor'.
		require
			anchor_void: anchor = Void
		local
			anchor_pix: EV_MODEL_PICTURE
			circl: EV_MODEL_ELLIPSE
		do
			create anchor
			create circl.make_with_positions (-2, -4, 18, 16)
			circl.set_foreground_color (default_colors.black)
			circl.set_background_color (default_colors.white)
			anchor.extend (circl)
			create anchor_pix.make_with_identified_pixmap (bon_anchor)
			anchor.extend (anchor_pix)
			anchor.hide
			anchor.disable_sensitive
			is_anchor_shown := False
			extend (anchor)
		end

	temp_bounding_box: EV_RECTANGLE
			-- Temporary bounding box used for dimension calculation.
		once
			create Result
		end

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	generics_color_not_void: generics_color /= Void
	class_name_color_not_void: class_name_color /= Void
	ellipse_not_void: ellipse /= Void
	icon_figures_not_void: icon_figures /= Void
	name_labels_not_void: name_labels /= Void
	generics_label_not_void: generics_label /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
