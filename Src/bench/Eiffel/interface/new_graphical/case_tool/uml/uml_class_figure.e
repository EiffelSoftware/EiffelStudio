indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLASS_FIGURE

inherit
	EIFFEL_CLASS_FIGURE
		redefine
			default_create,
			initialize,
			set_with_xml_element,
			xml_node_name,
			xml_element,
			recursive_transform,
			recycle
		end
		
	EXCEPTIONS
		export
			{NONE} all
		undefine
			default_create
		end
		
	UML_CONSTANTS
		undefine
			default_create
		end
	
create
	make_with_model
		
feature {NONE} -- Initialization

	default_create is
			-- Create an UML_CLASS_FIGURE.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			create rectangle
			rectangle.set_background_color (uml_class_fill_color)
			rectangle.set_line_width (uml_class_line_width)
			rectangle.set_foreground_color (uml_class_line_color)
			extend (rectangle)
			create queries_line
			extend (queries_line)
			create commands_line
			extend (commands_line)
			create queries
			extend (queries)
			create commands
			extend (commands)
			create names
			
				create name_group
				name_group.extend (name_label)
				name_label.set_font (uml_class_name_font)
				name_label.set_foreground_color (uml_class_name_color)
				
			names.extend (name_group)
			extend (names)
			real_border := 10
			disable_scaling
			disable_rotating
		end
		
	initialize is
			-- Initialize `Current' with model.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			set_queries_commands
			model.feature_clause_list_changed_actions.extend (agent set_queries_commands)
			set_generics
			model.generics_changed_actions.extend (agent set_generics)
			set_properties
			model.properties_changed_actions.extend (agent set_properties)
		end
		
	make_with_model (a_model: ES_CLASS) is
			-- Create a UML_CLASS_FIGURE using the `model' `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize
			update
		end
		
feature -- Access

	port_x: INTEGER is
			-- x position where links starting.
		do
			Result := rectangle.x
		end
		
	port_y: INTEGER is
			-- y position where links starting.
		do
			Result := rectangle.y
		end
		
	size: EV_RECTANGLE is
			-- Size of `Current'.
		do
			Result := rectangle.bounding_box
		end
		
	height: INTEGER is
			-- height of `Current'.
		do
			Result := rectangle.height
		end
		
	width: INTEGER is
			-- width of `Current'.
		do
			Result := rectangle.width
		end
		
	left: INTEGER is
			-- Left most position.
		do
			Result := rectangle.point_a_x
		end
		
	top: INTEGER is
			-- Top most position
		do
			Result := rectangle.point_a_y
		end
		
	right: INTEGER is
			-- Right most position.
		do
			Result := rectangle.point_b_x
		end

	bottom: INTEGER is
			-- Bottom most position.
		do
			Result := rectangle.point_b_y
		end
		
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			model.feature_clause_list_changed_actions.prune_all (agent set_queries_commands)
			model.generics_changed_actions.prune_all (agent set_generics)
			model.properties_changed_actions.prune_all (agent set_properties)
		end
	
	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Set `p' position such that it is on a point on the edge of `Current'.
		local
			m: DOUBLE
			new_x, new_y: DOUBLE
			w2: DOUBLE
			mod_angle: DOUBLE
			l_pi, l_pi2: DOUBLE
		do
			l_pi := pi
			l_pi2 := l_pi / 2
			mod_angle := modulo (an_angle, 2 * l_pi)
			if mod_angle = 0 then
				new_x := right
				new_y := port_y
			elseif mod_angle = l_pi2 then
				new_x := port_x
				new_y := bottom
			elseif mod_angle = l_pi then
				new_x := left
				new_y := port_y
			elseif mod_angle = 3 * l_pi2 then
				new_x := port_x
				new_y := top
			else
				m := tangent (mod_angle)
				check
					m_never_zero: m /= 0.0
				end
				new_x := (bottom + m * port_x - port_y) / m
				w2 := (right - left) / 2
				if new_x > left and new_x < right then
					if mod_angle > 0 and mod_angle < l_pi then
						-- intersect with bottom line
						new_y := bottom
					else
						-- intersect with top line
						new_y := top
						new_x := 2 * port_x - new_x
					end
				else
					new_y := m * right - m * port_x + port_y
					if mod_angle > l_pi2 and mod_angle < 3 * l_pi2 then
						-- intersect with left line
						new_x := left
						new_y := 2 * port_y - new_y
					else
						-- intersect with right line
						new_x := right
					end
				end
			end
			p.set_precise (new_x, new_y)
		end
		
feature -- Store/Retrive

	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "UML_CLASS_FIGURE"
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		local
			xqueries, xcommands, xsection: XM_ELEMENT
			l_item: FEATURE_SECTION_VIEW
			i, nb: INTEGER
			expanded_sections: ARRAYED_LIST [FEATURE_SECTION_VIEW]
		do
			create expanded_sections.make (0)
			create xqueries.make (node, "QUERIES_SECTIONS", xml_namespace)
			from
				i := 1
				nb := queries.count
			until
				i > nb
			loop
				l_item ?= queries.i_th (i)
				if l_item.is_expanded and then not l_item.feature_section.features.is_empty then
					create xsection.make (xqueries, "SECTION", xml_namespace)
					xsection.add_attribute ("NAME", xml_namespace, l_item.feature_section.first_feature_name)
					xqueries.put_last (xsection)
					l_item.collabse
					expanded_sections.extend (l_item)
				end
				i := i + 1
			end
			create xcommands.make (node, "COMMANDS_SECTIONS", xml_namespace)
			from
				i := 1
				nb := commands.count
			until
				i > nb
			loop
				l_item ?= commands.i_th (i)
				if l_item.is_expanded and then not l_item.feature_section.features.is_empty then
					create xsection.make (xqueries, "SECTION", xml_namespace)
					xsection.add_attribute ("NAME", xml_namespace, l_item.feature_section.first_feature_name)
					xcommands.put_last (xsection)
					l_item.collabse
					expanded_sections.extend (l_item)
				end
				i := i + 1
			end
			
			Result := Precursor {EIFFEL_CLASS_FIGURE} (node)
			Result.add_attribute ("CLUSTER_NAME", xml_namespace, model.class_i.cluster.cluster_name)
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
			Result.put_last (xqueries)
			Result.put_last (xcommands)
			
			from
				expanded_sections.start
			until
				expanded_sections.after
			loop
				expanded_sections.item.expand
				expanded_sections.forth
			end
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			xqueries, xcommands, l_item: XM_ELEMENT
			l_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			sname: STRING
			fsv: FEATURE_SECTION_VIEW
		do
			node.forth
			Precursor {EIFFEL_CLASS_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
			
			xqueries ?= node.item_for_iteration
			node.forth
			from
				l_cursor := xqueries.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item ?= l_cursor.item
				sname := l_item.attribute_by_name ("NAME").value
				fsv := query_section_view_with_first_feature_name (sname)
				if fsv /= Void then
					fsv.expand
				end
				l_cursor.forth
			end
			
			xcommands ?= node.item_for_iteration
			node.forth
			from
				l_cursor := xcommands.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item ?= l_cursor.item
				sname := l_item.attribute_by_name ("NAME").value
				fsv := command_section_view_with_first_feature_name (sname)
				if fsv /= Void then
					fsv.expand
				end
				l_cursor.forth
			end
			request_update
		end
		
feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_CLASS_FIGURE} (a_transformation)
			real_border := real_border * a_transformation.item (1, 1)
			request_update
		end
		
feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		local
			min_size: like minimum_size
			pos: INTEGER
			l_border: like border
		do
			l_border := border
			min_size := minimum_size
			rectangle.set_point_a_position (min_size.left - l_border, min_size.top - l_border)
			if commands.is_empty then
				rectangle.set_point_b_position (min_size.right + l_border, min_size.bottom + l_border * 2)
			else
				rectangle.set_point_b_position (min_size.right + l_border, min_size.bottom + l_border)
			end
			pos := names.bounding_box.bottom + l_border // 2
			queries_line.set_point_a_position (min_size.left - l_border, pos )
			queries_line.set_point_b_position (min_size.right + l_border, pos)
			
			pos := queries.point_y + queries.bounding_box.height + l_border // 2
			commands_line.set_point_a_position (min_size.left - l_border, pos)
			commands_line.set_point_b_position (min_size.right + l_border, pos)
				
			is_update_required := False
		end
		
feature {FEATURE_SECTION_VIEW} -- Expand/Collapse section

	update_size (fsv: FEATURE_SECTION_VIEW) is
			-- `fsv' was expanded or collabsed.
		require
			fsv_not_Void: fsv /= Void
			has_fsv: has_section (fsv)
		local
			l_item: EV_MODEL_GROUP
			pos: INTEGER
			min_size: like minimum_size
		do
			queries.start
			queries.search (fsv)
			if not queries.after then
				from	
					l_item ?= queries.item
					pos := l_item.point_y + l_item.bounding_box.height
					queries.forth
				until
					queries.after
				loop
					l_item ?= queries.item
					l_item.set_point_position (l_item.point_x, pos)
					pos := pos + l_item.bounding_box.height
					queries.forth
				end
				pos := pos + border
				from
					commands.start
				until
					commands.after
				loop
					l_item ?= commands.item
					l_item.set_point_position (l_item.point_x, pos)
					pos := pos + l_item.bounding_box.height
					commands.forth
				end
			else
				from
					commands.start
					commands.search (fsv)
					l_item ?= commands.item
					pos := l_item.point_y + l_item.bounding_box.height
					commands.forth
				until
					commands.after
				loop
					l_item ?= commands.item
					l_item.set_point_position (l_item.point_x, pos)
					pos := pos + l_item.bounding_box.height
					commands.forth
				end
			end
			min_size := minimum_size
			names.set_x (min_size.left + min_size.width // 2)
			request_update
			world.apply_right_angles
		end
		
	has_section (fsv: FEATURE_SECTION_VIEW): BOOLEAN is
			-- Is `fsv' a section of the class?
		require
			fsv_not_Void: fsv /= Void
		do
			Result := queries.has (fsv) or else commands.has (fsv)
		end
	
feature {NONE} -- Implementation

	border: INTEGER is
			-- Border for `rectangle'.
		do
			Result := real_border.truncated_to_integer.max (0)
		end
		
	real_border: REAL
			-- Real border for `rectangle'

	number_of_figures: INTEGER is 3
			-- `rectangle', `queries_line', `commands_line'.
			
	rectangle: EV_MODEL_RECTANGLE
			-- Rectangle around the UML class.
	
	queries_line: EV_MODEL_LINE
			-- Line separating class name from query section.
			
	commands_line: EV_MODEL_LINE
			-- Line separating query section from command section.
			
	queries: EV_MODEL_GROUP
			-- Group of queries name.
			
	commands: EV_MODEL_GROUP
			-- Group of operations.
			
	name_group: EV_MODEL_GROUP
			-- Group containing `name_label' and `generics'
			
	names: EV_MODEL_GROUP
			-- Group of name, generics and properties.
			
	generics: EV_MODEL_TEXT
			-- Generics text.
			
	root_text: EV_MODEL_TEXT
			-- Text indicating `Current' is root.
			
	properties_text: EV_MODEL_TEXT
			-- Text for properties of class.
			
	query_section_view_with_first_feature_name (a_name: STRING): FEATURE_SECTION_VIEW is
			-- Return feature section view with first feature name `a_name' if any.
		local
			l_item: FEATURE_SECTION_VIEW
		do
			from
				queries.start
			until
				queries.after or else Result /= Void
			loop
				l_item ?= queries.item
				if not l_item.feature_section.features.is_empty and then l_item.feature_section.first_feature_name.is_equal (a_name) then
					Result := l_item
				end
				queries.forth
			end
		end
		
	command_section_view_with_first_feature_name (a_name: STRING): FEATURE_SECTION_VIEW is
			-- Return feature section view with name `a_name' if any.
		local
			l_item: FEATURE_SECTION_VIEW
		do
			from
				commands.start
			until
				commands.after or else Result /= Void
			loop
				l_item ?= commands.item
				if not l_item.feature_section.features.is_empty and then l_item.feature_section.first_feature_name.is_equal (a_name) then
					Result := l_item
				end
				commands.forth
			end
		end

	set_queries_commands is
			-- Set `queries' and `commands' according to `model'.`feature_clause_list'.
		do
			if model.is_compiled then
				build_queries_commands_list
				set_queries
				set_commands
			else
				queries.hide
				commands.hide
			end
		end

	set_queries is
			-- Set names in `queries' according to `queries_list'.
		require
			model_not_void: model /= Void
		do
			queries.wipe_out
			queries.set_point_position (0, 0)
			fill_group_with_features (queries, queries_list)
			update_positions
		end
		
	set_commands is
			-- Set names `commands' according to `model'.`queries'.
		require
			model_not_void: model /= Void
		do
			commands.wipe_out
			commands.set_point_position (0, 0)
			fill_group_with_features (commands, commands_list)
			update_positions
		end

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					rectangle.set_line_width (2)
				else
					rectangle.set_line_width (1)
				end
			end	
		end
	
	fill_group_with_features (a_group: EV_MODEL_GROUP; feature_sections: LIST [FEATURE_SECTION]) is
			-- Fill `a_group' with features in `feature_sections'.
		require
			group_not_Void: a_group /= Void
			group_empty: a_group.is_empty
			features_not_Void: feature_sections /= Void
		local
			l_item: FEATURE_SECTION
			l_fsv: FEATURE_SECTION_VIEW
			attr_height: INTEGER
		do
			from
				feature_sections.start
				attr_height := 0
			until
				feature_sections.after
			loop
				l_item := feature_sections.item
				
				create l_fsv.make (l_item, Current)
				l_fsv.set_point_position (a_group.point_x, a_group.point_y + attr_height)
				attr_height := attr_height + l_fsv.bounding_box.height
				a_group.extend (l_fsv)
				feature_sections.forth
			end
		end

	queries_list: ARRAYED_LIST [FEATURE_SECTION]
			-- List of features sections for queries.
			
	commands_list: ARRAYED_LIST [FEATURE_SECTION]
			-- List of features sections for commands.
	
	build_queries_commands_list is
			-- Build `queries_list' and `features_list'.
		require
			model_not_void: model /= Void
			model_is_compiled: model.is_compiled
		local
			l_item: FEATURE_SECTION
			l_features: LIST [FEATURE_AS]
			l_feature: FEATURE_AS
			l_features_list: like features_list
			q_section, c_section: FEATURE_SECTION
		do
			l_features_list := features_list (model.class_c) 
			from
				create queries_list.make (0)
				create commands_list.make (0)
				l_features_list.start
			until
				l_features_list.after
			loop
				l_item := l_features_list.item
				create q_section.make_empty (l_item.name, model.class_c)
				create c_section.make_empty (l_item.name, model.class_c)
				if l_item.is_none then
					q_section.enable_is_none
					c_section.enable_is_none
				elseif l_item.is_some then
					q_section.enable_is_some
					c_section.enable_is_some
				end
				from
					l_features := l_item.features
					l_features.start
				until
					l_features.after
				loop
					l_feature := l_features.item
					if l_feature.is_function or else l_feature.is_attribute then
						q_section.features.extend (l_feature)
					else
						c_section.features.extend (l_feature)
					end
					l_features.forth
				end
				if not q_section.features.is_empty then
					queries_list.extend (q_section)
				end
				if not c_section.features.is_empty then
					commands_list.extend (c_section)
				end
				l_features_list.forth
			end
		ensure
			queries_list_not_Void: queries_list /= Void
			commands_list_not_Void: commands_list /= Void
		end
		
	features_list (compiled_class: CLASS_C): LIST [FEATURE_SECTION] is
			-- List of features ordered by section name and export status corresponding to `compiled_class'.
		require
			compiled_class_not_Void: compiled_class /= Void
		local
			features: EIFFEL_LIST [FEATURE_AS]
			name: STRING
			class_text: STRING
			retried: BOOLEAN
			l_section: FEATURE_SECTION
			fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			create {ARRAYED_LIST[FEATURE_SECTION]} Result.make (0)
			if not retried then
				
				fcl := model.feature_clause_list
				if fcl /= Void and then not fcl.is_empty then
					class_text := compiled_class.text
					if not compiled_class.has_feature_table then
							--| We cannot rely on feature calls on Void targets: they corrupt memory.
						raise ("No feature table")
					end
					if class_text /= Void then
							--| Features
						from 
							fcl.start
						until
							fcl.after
						loop
							if fcl.item = Void then
								raise ("Void feature clause")
							end
							features := fcl.item.features
							name := fcl.item.comment (class_text)
							name.right_adjust
							create l_section.make (name, features, compiled_class)
							
							if fcl.item.export_status.is_none then
								l_section.enable_is_none
							elseif fcl.item.export_status.is_set then
								l_section.enable_is_some
							else
								l_section.enable_is_any
							end
							Result.extend (l_section)
							fcl.forth
						end
					elseif compiled_class.cluster.is_precompiled then
						from 
							fcl.start
						until
							fcl.after
						loop
							if fcl.item = Void then
								raise ("Void feature clause")
							end
							features := fcl.item.features
							create l_section.make ("", features, compiled_class)
							if fcl.item.export_status.is_none then
								l_section.enable_is_none
							elseif fcl.item.export_status.is_set then
								l_section.enable_is_some
							else
								l_section.enable_is_any
							end
							Result.extend (l_section)
							fcl.forth
						end
					end
				end
			end
		ensure
			Result_not_Void: Result /= Void
		rescue
			retried := True
			retry
		end
		
	set_generics is
			-- Extend class name with `model'.`generics' if any.
		require
			model_not_void: model /= Void
		local
			a_text: STRING
		do
			a_text := model.generics
			if a_text /= Void then
				if name_group.has (generics) then
					name_group.prune_all (generics)
				end
				create generics.make_with_text (a_text)
				generics.set_font (uml_generics_font)
				generics.set_foreground_color (uml_generics_color)
				if world /= Void and then world.scale_factor /= 1.0 then
					generics.scale (world.scale_factor)
				end
				name_group.extend (generics)
				update_positions
			end
		end
		
	set_properties is
			-- Set porperties of class according to `model'.
		require
			model_not_Void: model /= Void
		local
			prop_text: STRING
		do
			if model.is_deferred then
				name_label.set_font (uml_class_deferred_font)
			end
			if model.is_root_class then
				if root_text = Void then
					create root_text.make_with_text ("{root}")
					set_properties_text_properties (root_text)
					names.extend (root_text)
				end
			else
				if root_text /= Void then
					names.prune_all (root_text)
					root_text := Void
				end
			end
			prop_text := ""
			if model.is_effective then
				prop_text.append ("effective")
			end
			if model.is_expanded then
				if not prop_text.is_empty then
					prop_text.append (", ")
				end
				prop_text.append ("expanded")
			end
			if model.is_interfaced then
				if not prop_text.is_empty then
					prop_text.append (", ")
				end
				prop_text.append ("interfaced")
			end
			if model.is_persistent then
				if not prop_text.is_empty then
					prop_text.append (", ")
				end
				prop_text.append ("persistent")
			end
			if model.is_reused then
				if not prop_text.is_empty then
					prop_text.append (", ")
				end
				prop_text.append ("reused")
			end
			if not prop_text.is_empty then
				if properties_text = Void then
					create properties_text
					names.extend (properties_text)
				end
				prop_text.prepend ("{")
				prop_text.append ("}")
				properties_text.set_text (prop_text)
				set_properties_text_properties (properties_text)
			else
				if properties_text /= Void then
					names.prune_all (properties_text)
					properties_text := Void
				end
			end
			update_positions
		end
		
	set_properties_text_properties (a_text: EV_MODEL_TEXT) is
			-- Set properties of `a_text'
		do
			a_text.set_font (uml_class_properties_font)	
			a_text.set_foreground_color (uml_class_properties_color)
			if world /= Void and then world.scale_factor /= 1.0 then
				a_text.scale (world.scale_factor)
			end
		end
		
	update_positions is
			-- Set positions for `root_text', `properties_text', `queries', `commands'
		local
			w, w2: INTEGER
			bbox: EV_RECTANGLE
		do
			if generics /= Void then
				generics.set_point_position (name_label.bounding_box.width, name_label.point_y)
			end
			if root_text /= Void then
				root_text.set_x_y (name_group.x, name_group.point_y + name_label.height + root_text.height // 2)
			end
			if properties_text /= Void then
				properties_text.set_x_y (name_group.x, name_group.point_y - properties_text.height + properties_text.height // 2)
			end
			w := names.bounding_box.width.max (queries.bounding_box.width).max (commands.bounding_box.width)
			w2 := w // 2
			bbox := names.bounding_box
			queries.set_point_position (names.x - w2, bbox.top + bbox.height + border)
			if queries.is_empty then
				if queries.is_show_requested then
					queries.hide
				end
			else
				if not queries.is_show_requested then
					queries.show
				end
			end
			commands.set_point_position (names.x - w2, queries.point_y + queries.bounding_box.height + border)
			if commands.is_empty then
				if commands.is_show_requested then
					commands.hide
				end
			else
				if not commands.is_show_requested then
					commands.show
				end
			end
			request_update
		end
		
invariant
	rectangle_not_void: rectangle /= Void
	queries_line_not_void: queries_line /= Void
	commands_line_not_void: commands_line /= Void
	queries_not_void: queries /= Void
	commands_not_void: commands /= Void
	names_not_Void: names /= Void
	name_group_not_Void: name_group /= Void
	border_positive: border >= 0

end -- class UML_CLASS_FIGURE
