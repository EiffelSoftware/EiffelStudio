indexing
	description: "Objects that represent a BON view for an EIFFEL_CLASS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
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
			update,
			set_name_label_text,
			set_is_selected,
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

	default_create is
			-- Create a BON_CLASS_FIGURE
		local
			anchor_pix: EV_MODEL_PICTURE
			circl: EV_MODEL_ELLIPSE

		do
			Precursor {EIFFEL_CLASS_FIGURE}
			prune_all (name_label)

			create ellipse
			extend (ellipse)

			create anchor
			create circl.make_with_positions (-2, -2, 18, 18)
			circl.set_foreground_color (default_colors.black)
			circl.set_background_color (default_colors.white)
			anchor.extend (circl)
			create anchor_pix.make_with_identified_pixmap (bon_anchor)
			anchor.extend (anchor_pix)
			anchor.hide
			anchor.disable_sensitive
			is_anchor_shown := False
			extend (anchor)

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

	make_with_model (a_model: ES_CLASS) is
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

	world: EIFFEL_WORLD is
			-- World `Current' is part of.
		do
			Result ?= Precursor {EIFFEL_CLASS_FIGURE}
		end

	port_x: INTEGER is
			-- x position where links are starting.
		do
			Result := point_x
		end

	port_y: INTEGER is
			-- y position where links are starting.
		do
			Result := point_y
		end

	size: EV_RECTANGLE is
			-- Size of `Current'.
		local
			pax, pay: INTEGER
		do
			pax := ellipse.point_a_x
			pay := ellipse.point_a_y
			create Result.make (pax, pay, ellipse.point_b_x - pax, ellipse.point_b_y - pay)
		end

	height: INTEGER is
			-- Height in pixels.
		do
			Result := ellipse.radius2 * 2
		end

	width: INTEGER is
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

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := model.name
		end

	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := once "BON_CLASS_FIGURE"
		end

	is_default_bg_color_used_string: STRING is "IS_DEFAULT_BG_COLOR_USED"
	cluster_name_string: STRING is "CLUSTER_NAME"
	background_color_string: STRING is "BACKGROUND_COLOR"
	generics_color_string: STRING is "GENERICS_COLOR"
	class_name_color_string: STRING is "CLASS_NAME_COLOR"

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		local
			colon_string: STRING
			l_color: EV_COLOR
			l_xml_routines: like xml_routines
			l_model: like model
		do
			colon_string := ";"
			l_xml_routines := xml_routines
			l_model := model
			Result := Precursor {EIFFEL_CLASS_FIGURE} (node)
			Result.add_attribute (cluster_name_string, xml_namespace, l_model.class_i.cluster.cluster_name)
			Result.put_last (l_xml_routines.xml_node (Result, is_default_bg_color_used_string, boolean_representation (is_default_background_color_used)))
			if not is_default_background_color_used then
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

	set_with_xml_element (node: XM_ELEMENT) is
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

	show_anchor is
			-- Show anchor, if `is_fixed'.
		do
			if is_fixed then
				anchor.show
				anchor.set_x_y (ellipse.point_a_x + 3, ellipse.point_a_y + 3)
				is_anchor_shown := True
				request_update
			end
		ensure
			fixed_implies_show: is_fixed implies is_anchor_shown
		end

	hide_anchor is
			-- Hide anchor.
		do
			if anchor.is_show_requested then
				anchor.hide
				is_anchor_shown := False
				request_update
			end
		ensure
			anchor_hidden: not is_anchor_shown
		end

	set_is_fixed (b: BOOLEAN) is
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

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			if model /= Void then
				model.properties_changed_actions.prune_all (agent set_bon_icons)
				model.generics_changed_actions.prune_all (agent set_generics)
			end
			preferences.diagram_tool_data.remove_observer (Current)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' to `a_color'.
		do
			is_default_background_color_used := False
			background_color := a_color
			set_ellipse_properties
		ensure
			set: background_color = a_color
		end

	set_generics_color (a_color: EV_COLOR) is
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

	set_class_name_color (a_color: EV_COLOR) is
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

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
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

	fade_out is
			-- Fade out `Current'.
		do
			if is_high_quality and then background_color /= Void then
				ellipse.set_background_color (faded_color (background_color))
			end
			is_faded := True
		end

	fade_in is
			-- Fade in `Current'.
		do
			if is_high_quality and then background_color /= Void then
				ellipse.set_background_color (background_color)
			end
			is_faded := False
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties of `Current' may have changed.
		do
			is_update_required := False
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
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

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					ellipse.set_line_width (bon_class_line_width * 2)
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

	number_of_figures: INTEGER is 2
			-- Number of figures used to visualize `Current'.
			-- (`ellipse', `anchor')

	icon_figures: EV_MODEL_GROUP
			-- Optional icon for class types deferred, effective, persistent, interfaced.

	icon_spacing: INTEGER is 2
			-- Space in pixel between icons in `icon_figures'.

	name_labels: EV_MODEL_GROUP
			-- All the part of the name of the class.

	generics_label: EV_MODEL_GROUP
			-- All parts of `model'.`generics' name.

	anchor: EV_MODEL_GROUP
			-- Anchor indicating that `Current' `is_fixed'.

	set_bon_icons is
			-- Examine the properties of the class and add `icon_figures'.
		require
			model_not_void: model /= Void
		local
			icon: EV_MODEL_PICTURE
			hw: INTEGER
		do
			icon_figures.wipe_out
			icon_figures.set_point_position (0, 0)
			if model.is_deferred then
				create icon.make_with_identified_pixmap (bon_deferred_icon)
				icon.set_point_position (0, 0)
				icon_figures.extend (icon)
			end
			if model.is_effective then
				create icon.make_with_identified_pixmap (bon_effective_icon)
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)
				icon_figures.extend (icon)
			end
			if model.is_persistent then
				create icon.make_with_identified_pixmap (bon_persistent_icon)
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)
				icon_figures.extend (icon)
			end
			if model.is_interfaced then
				create icon.make_with_identified_pixmap (bon_interfaced_icon)
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)
				icon_figures.extend (icon)
			end
			from
				hw := as_integer (icon_figures.bounding_box.width / 2)
				icon_figures.start
			until
				icon_figures.after
			loop
				icon_figures.item.set_x (icon_figures.item.x - hw)
				icon_figures.forth
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

	set_name_label_text (a_text: STRING) is
			-- Set texts in `name_labels'.
			-- | With line wrap at `max_class_name_length'.
		local
			s, rest: STRING
			i: INTEGER
			part_text: EV_MODEL_TEXT
		do
			name_labels.wipe_out
			name_labels.set_point_position (0, 0)
			if a_text.count > max_class_name_length then
				from
					s := ""
					rest := a_text
					i := a_text.last_index_of ('_', max_class_name_length)
					if i = 0 then
						i := max_class_name_length
					end
				until
					i = 0 or else rest.count <= max_class_name_length
				loop
					s := rest.substring (1, i)
					rest := rest.substring (i + 1, rest.count)
					if rest.count > max_class_name_length then
						i := rest.last_index_of ('_', max_class_name_length)
						if i = 0 then
							i := max_class_name_length
						end
					end
					create part_text.make_with_text (s)
					assign_class_name_properties_to_text (part_text)
					if world /= Void then
						part_text.scale (world.scale_factor)
					end
					part_text.set_point_position (0, name_labels.bounding_box.height)
					part_text.set_x (0)
					name_labels.extend (part_text)
				end
				s := rest
				create part_text.make_with_text (s)
				assign_class_name_properties_to_text (part_text)
				part_text.set_point_position (0, name_labels.bounding_box.height)
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

	set_generics is
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
							s := ""
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

	update_information_positions is
			-- Set positions of `name_labels', `bon_icons' and `generics_label'.
		local
			ibbox, nbbox, gbbox: EV_RECTANGLE
			cur_pos, cur_y_pos: INTEGER
			h, w: INTEGER
		do
			if is_high_quality then
				ibbox := icon_figures.bounding_box
				nbbox := name_labels.bounding_box
				gbbox := generics_label.bounding_box

				if model.generics /= Void and then model.generics.count + model.name.count <= max_class_name_length  then
					-- on one line
					h := ibbox.height + nbbox.height

					cur_pos := port_y - as_integer (h / 2)

					icon_figures.set_point_position (port_x, cur_pos)
					cur_pos := cur_pos + ibbox.height

					w := as_integer (gbbox.width / 2)

					cur_y_pos := port_x - w

					name_labels.set_point_position (cur_y_pos, cur_pos)
					cur_y_pos := cur_y_pos + as_integer (nbbox.width / 2) + w
					generics_label.set_point_position (cur_y_pos, cur_pos)
				else
					h := ibbox.height + nbbox.height + gbbox.height

					cur_pos := port_y - as_integer (h / 2)

					icon_figures.set_point_position (port_x, cur_pos)
					cur_pos := cur_pos + ibbox.height

					name_labels.set_point_position (port_x, cur_pos)
					cur_pos := cur_pos + nbbox.height

					generics_label.set_point_position (port_x, cur_pos)
				end
			else
				name_labels.set_x_y (port_x, port_y)
			end

			update_radius
		end

	update_radius is
			-- Update `ellipse_radius_1' and `ellipse_radius_2'.
		local
			l_min_size: EV_RECTANGLE
			w, h: INTEGER
			r, omega: DOUBLE
		do
			if is_high_quality then
				if model.generics /= Void and then model.generics.count + model.name.count <= max_class_name_length  then
					l_min_size := minimum_size

					w := l_min_size.width
					h := l_min_size.height
					if icon_figures.bounding_box.height = 0 then
						h := as_integer (h * 1.5)
					end
				else
					l_min_size := minimum_size

					w := l_min_size.width
					h := l_min_size.height
					if icon_figures.bounding_box.height = 0 and then generics_label.bounding_box.height = 0 and then name_labels.count = 1 then
						h := as_integer (h * 1.5)
					end
				end
			else
				l_min_size := name_labels.bounding_box

				w := l_min_size.width
				h := l_min_size.height
				if name_labels.count = 1 then
					h := as_integer (h * 1.5)
				end
			end

			r := distance (l_min_size.left, l_min_size.top, l_min_size.left + w / 2, l_min_size.top + h / 2)
			omega := line_angle (l_min_size.left + w / 2, l_min_size.top + h / 2, l_min_size.left + w, l_min_size.top)
			ellipse_radius_2 := sqrt (r^2*sine(omega)^2*(1 + (cosine(omega)^2/(sine(omega)^2*(w^2/h^2)))))
			ellipse_radius_1 := w * ellipse_radius_2 / h

			if ellipse.radius1 /= as_integer (ellipse_radius_1) then
				ellipse.set_radius1 (as_integer (ellipse_radius_1))
			end
			if ellipse.radius2 /= as_integer (ellipse_radius_2) then
				ellipse.set_radius2 (as_integer (ellipse_radius_2))
			end
		end


	set_ellipse_properties is
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
			if is_selected = True then
				ellipse.set_line_width (bon_class_line_width * 2)
			else
				ellipse.set_line_width (bon_class_line_width)
			end
		end

	set_generics_properties is
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

	assign_generics_properties_to_text (a_text: EV_MODEL_TEXT) is
			-- Set propertis of `a_text' according to generics properties.
		require
			a_text /= Void
		do
			a_text.set_identified_font (bon_generics_font)
			a_text.set_foreground_color (generics_color)
		end

	set_class_name_properties is
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

	assign_class_name_properties_to_text (a_text: EV_MODEL_TEXT) is
			-- Set properties of `a_text' according to name properties.
		require
			a_text /= Void
		do
			a_text.set_identified_font (bon_class_name_font)
			a_text.set_foreground_color (class_name_color)
		end

	low_quality_fill_color: EV_COLOR is
			-- Fill color for low quality ellipse.
		once
			create Result.make_with_rgb (1, 1, 1)
		ensure
			result_not_void: Result /= Void
		end

	set_is_high_quality (a_high_quality: like is_high_quality) is
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

	preferences_changed is
			-- User changed values of interest in preferences.
		do
			retrieve_preferences
			set_ellipse_properties
			set_class_name_properties
			set_generics_properties
			request_update
		end

	retrieve_preferences is
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

	new_filled_list (n: INTEGER): like Current is
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

end -- class BON_CLASS_FIGURE
