indexing
	description: "Objects that represent a BON view for an EIFFEL_CLASS"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLASS_FIGURE

inherit
	EIFFEL_CLASS_FIGURE
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
	
create
	default_create,
	make_with_model
	
feature {NONE} -- Initialization

	default_create is
			-- Create a BON_CLASS_FIGURE
		local
			anchor_pix: EV_MODEL_PICTURE
			circl: EV_MODEL_ELLIPSE
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			prune_all (name_label)
			
			background_color := bon_class_fill_color
			foreground_color := bon_class_line_color
			line_width := bon_class_line_width
			
			id_generics_font := bon_generics_font
			generics_color := bon_generics_color
			
			id_class_name_font := bon_class_name_font
			class_name_color := bon_class_name_color
			
			real_ellipse_border_horizontal := 10
			real_ellipse_border_vertical := 10
			
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

			set_ellipse_properties
			
			is_high_quality := True
			disable_rotating
			disable_scaling
			
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
			Result := ellipse.x
		end
		
	port_y: INTEGER is
			-- y position where links are starting.
		do
			Result := ellipse.y
		end
		
	size: EV_RECTANGLE is
			-- Size of `Current'.
		do
			Result := ellipse.bounding_box
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
			
	foreground_color: EV_COLOR
			-- Foreground color for the ellipse.
			
	line_width: INTEGER
			-- Line width of the ellipse.
			
	generics_font: EV_FONT is
			-- Font for generics parameter.
		do
			Result := id_generics_font.font
		end
			
	generics_color: EV_COLOR
			-- Color for generics parameter.
			
	class_name_font: EV_FONT is
			-- Font for the class name.
		do
			Result := id_class_name_font.font
		end
			
	class_name_color: EV_COLOR
			-- Color for the class name.
			
	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := model.name
		end
		
	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "BON_CLASS_FIGURE"
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		do
			Result := Precursor {EIFFEL_CLASS_FIGURE} (node)
			Result.add_attribute ("CLUSTER_NAME", xml_namespace, model.class_i.cluster.cluster_name)
			Result.put_last (Xml_routines.xml_node (Result, "IS_DEFAULT_BG_COLOR_USED", is_default_background_color_used.out))
			if not is_default_background_color_used then
				Result.put_last (Xml_routines.xml_node (Result, "BACKGROUND_COLOR", 
					background_color.red_8_bit.out + ";" +
					background_color.green_8_bit.out + ";" +
					background_color.blue_8_bit.out))
				Result.put_last (Xml_routines.xml_node (Result, "GENERICS_COLOR", 
					generics_color.red_8_bit.out + ";" +
					generics_color.green_8_bit.out + ";" +
					generics_color.blue_8_bit.out))
				Result.put_last (Xml_routines.xml_node (Result, "CLASS_NAME_COLOR", 
					class_name_color.red_8_bit.out + ";" +
					class_name_color.green_8_bit.out + ";" +
					class_name_color.blue_8_bit.out))
			end
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			node.forth
			Precursor {EIFFEL_CLASS_FIGURE} (node)
			if not xml_routines.xml_boolean (node, "IS_DEFAULT_BG_COLOR_USED") then
				set_background_color (xml_routines.xml_color (node, "BACKGROUND_COLOR"))
				set_generics_color (xml_routines.xml_color (node, "GENERICS_COLOR"))
				set_class_name_color (xml_routines.xml_color (node, "CLASS_NAME_COLOR"))
			else
				if is_high_quality then
					ellipse.set_background_color (bon_class_fill_color)
				else
					ellipse.set_background_color (low_quality_fill_color)
				end
				set_generics_color (bon_generics_color)
				set_class_name_color (bon_class_name_color)
				is_default_background_color_used := True
			end
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
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
			model.properties_changed_actions.prune_all (agent set_bon_icons)
			model.generics_changed_actions.prune_all (agent set_generics)
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

-- if you uncomment this, store the colors in xml.
--
--	set_foreground_color (a_color: EV_COLOR) is
--			-- Set `foreground_color' to `a_color'.
--		require
--			a_color_not_void: a_color /= Void
--		do
--			foreground_color := a_color
--			set_ellipse_properties
--		ensure
--			set: foreground_color = a_color
--		end
		
--	set_line_width (a_width: INTEGER) is
--			-- Set `line_width' to `a_width'.
--		require
--			a_width_greater_equal_zero: a_width >= 0
--		do
--			line_width := a_width
--			set_ellipse_properties
--		ensure
--			set: line_width = a_width
--		end
--
--	set_generics_font (a_font: EV_FONT) is
--			-- Set `generics_font' to `a_font'.
--		require
--			a_font_not_void: a_font /= Void
--		local
--			txt: EV_MODEL_TEXT
--		do
--			generics_font := a_font
--			from
--				generics_label.start
--			until
--				generics_label.after
--			loop
--				txt ?= generics_label.item
--				set_generics_properties (txt)
--				generics_label.forth
--			end
--		ensure
--			set: generics_font = a_font
--		end
--
--	set_class_name_font (a_font: EV_FONT) is
--			-- Set `class_name_font' to `a_font'.
--		require
--			a_font_not_void: a_font /= Void
--		do
--			class_name_font := a_font
--			set_class_name_properties
--		ensure
--			set: class_name_font = a_font
--		end
		
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
				txt.set_foreground_color (generics_color)
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
			if a = 0 and b = 0 then
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
		
	update is
			-- Some properties of `Current' may have changed.
		local
			l_min_size: like minimum_size
		do
			l_min_size := minimum_size			
			ellipse.set_point_a_position (l_min_size.left - ellipse_border_horizontal, l_min_size.top - ellipse_border_vertical)
			ellipse.set_point_b_position (l_min_size.right + ellipse_border_horizontal, l_min_size.bottom + ellipse_border_vertical)
			if anchor.is_show_requested then
				anchor.set_x_y (ellipse.point_a_x + 3, ellipse.point_a_y + 3)
			end
			is_update_required := False
		end
		
feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_CLASS_FIGURE} (a_transformation)
			real_ellipse_border_horizontal := real_ellipse_border_horizontal * a_transformation.item (1, 1)
			real_ellipse_border_vertical := real_ellipse_border_vertical * a_transformation.item (2, 2)
		end
		
feature {EIFFEL_PROJECTOR} -- Ellipse
		
	ellipse: EV_MODEL_ELLIPSE
			-- The BON ellipse.

feature {NONE} -- Implementation

	id_class_name_font: EV_IDENTIFIED_FONT
	
	id_generics_font: EV_IDENTIFIED_FONT

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					ellipse.set_line_width (line_width * 2)
				else
					ellipse.set_line_width (line_width)
				end
			end
		end

	is_default_background_color_used: BOOLEAN
			-- Was background color not changed by client?

	ellipse_border_horizontal: INTEGER is
			-- Horizontal border for the ellipse.
		do
			Result := real_ellipse_border_horizontal.truncated_to_integer
		end
		
	real_ellipse_border_horizontal: REAL
			-- Real value of `ellipse_border_horizontal'.
			-- Needed to prevent rounding errors on scale.
	
	ellipse_border_vertical: INTEGER is
			-- Vertical border for the ellipse.
		do
			Result := real_ellipse_border_vertical.truncated_to_integer
		end
		
	real_ellipse_border_vertical: REAL
			-- Real value of `ellipse_border_vertical'.

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
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)--icon.height // 2)
				icon_figures.extend (icon)
			end
			if model.is_persistent then
				create icon.make_with_identified_pixmap (bon_persistent_icon)
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)--icon.height // 2)
				icon_figures.extend (icon)
			end
			if model.is_interfaced then
				create icon.make_with_identified_pixmap (bon_interfaced_icon)
				icon.set_point_position (icon_figures.bounding_box.width + icon_spacing, 0)--icon.height // 2)
				icon_figures.extend (icon)
			end
			from
				hw := icon_figures.bounding_box.width // 2
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
		do
			a_text := model.generics
			
			if a_text /= Void then
				generics_label.show
				generics_label.wipe_out
				generics_label.set_point_position (0, 0)
				if a_text.count > max_generics_name_length then
					from
						s := ""
						rest := a_text
						i := rest.last_index_of (' ', max_generics_name_length)
						j := rest.last_index_of ('_', max_generics_name_length)
						if j > i then
							i := j
						end
						if i = 0 then
							i := max_generics_name_length
						end
					until
						i = 0 or else rest.count <= max_generics_name_length
					loop
						s := rest.substring (1, i)
						rest := rest.substring (i + 1, rest.count)
						if rest.count > max_generics_name_length then
							i := rest.last_index_of (' ', max_generics_name_length)
							j := rest.last_index_of ('_', max_generics_name_length)
							if j > i then
								i := j
							end
							if i = 0 then
								i := max_generics_name_length
							end
						end
						create part_text.make_with_text (s)
						set_generics_properties (part_text)
						part_text.set_point_position (0, generics_label.bounding_box.height)
						part_text.set_x (0)
						generics_label.extend (part_text)
					end
					s := rest			
					create part_text.make_with_text (s)
					set_generics_properties (part_text)
					part_text.set_point_position (0, generics_label.bounding_box.height)
					part_text.set_x (0)
					generics_label.extend (part_text)
				else
					create part_text.make_with_text (a_text)
					set_generics_properties (part_text)
					part_text.set_x (0)
					generics_label.extend (part_text)
				end
				update_information_positions
			else
				update_information_positions
			end
			request_update
		end
		
	information_border: INTEGER is 0
		
	update_information_positions is
			-- Set positions of `name_labels', `bon_icons' and `generics_label'.
		local
			ibbox, nbbox, gbbox: EV_RECTANGLE
			h, w, cur_pos, cur_y_pos: INTEGER
		do
			ibbox := icon_figures.bounding_box
			nbbox := name_labels.bounding_box
			gbbox := generics_label.bounding_box
			
			if model.generics /= Void and then model.generics.count + model.name.count < 10  then
				-- on one line
				h := ibbox.height + nbbox.height
				
				cur_pos := port_y - h // 2
				
				icon_figures.set_point_position (port_x, cur_pos)
				cur_pos := cur_pos + ibbox.height
				
				w := gbbox.width // 2
				
				cur_y_pos := port_x - w
				
				name_labels.set_point_position (cur_y_pos, cur_pos)
				cur_y_pos := cur_y_pos + nbbox.width // 2 + w
				generics_label.set_point_position (cur_y_pos, cur_pos)	
			else
				h := ibbox.height + nbbox.height + gbbox.height
				
				cur_pos := port_y - h // 2
				
				icon_figures.set_point_position (port_x, cur_pos)
				cur_pos := cur_pos + ibbox.height
				
				name_labels.set_point_position (port_x, cur_pos)
				cur_pos := cur_pos + nbbox.height
				
				generics_label.set_point_position (port_x, cur_pos)	
			end
		end

	set_ellipse_properties is
			-- Set properties of ellipse.
		require
			ellipse_not_void: ellipse /= Void
		do
			if background_color = Void then
				ellipse.remove_background_color
			else
				ellipse.set_background_color (background_color)
			end
			ellipse.set_foreground_color (foreground_color)
			if is_selected = True then
				ellipse.set_line_width (line_width * 2)
			else
				ellipse.set_line_width (line_width)
			end
		end
		
	set_generics_properties (a_text: EV_MODEL_TEXT) is
			-- Set propertis of `a_text' according to generics properties.
		require
			a_text /= Void
		do
			a_text.set_identified_font (id_generics_font)
			a_text.set_foreground_color (generics_color)
			if world /= Void then
				a_text.scale (world.scale_factor)
			end
		end
		
	set_class_name_properties is
			-- Set the properties of `name_labels' accoring to name properties.
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
			a_text.set_identified_font (id_class_name_font)
			a_text.set_foreground_color (class_name_color)
			if world /= Void then
				a_text.scale (world.scale_factor)
			end
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
					if is_default_background_color_used then
						ellipse.set_background_color (low_quality_fill_color)
					end
					icon_figures.hide
					generics_label.hide
				end
				request_update
			end
		end
		
invariant
	foreground_color_not_void: foreground_color /= Void
	generics_font_not_void: generics_font /= Void
	generics_color_not_void: generics_color /= Void
	class_name_font_not_void: class_name_font /= Void
	class_name_color_not_void: class_name_color /= Void
	ellipse_not_void: ellipse /= Void
	icon_figures_not_void: icon_figures /= Void
	name_labels_not_void: name_labels /= Void
	generics_label_not_void: generics_label /= Void

end -- class BON_CLASS_FIGURE
