note
	description: "Objects that is a UML view for an Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
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

	OBSERVER
		rename
			update as retrieve_preferences
		undefine
			default_create
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	SHARED_SERVER
		undefine
			default_create
		end

create
	make_with_model

create {UML_CLASS_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create an UML_CLASS_FIGURE.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			create rectangle
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
			create generics
			create properties

			names.extend (name_label)
			properties.hide
			names.extend (properties)
			generics.hide
			names.extend (generics)

			extend (names)
			real_border := 10
			disable_scaling
			disable_rotating

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences
		end

	initialize
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

	make_with_model (a_model: ES_CLASS)
			-- Create a UML_CLASS_FIGURE using the `model' `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize
		end

feature -- Access

	port_x: INTEGER
			-- x position where links starting.
		do
			Result := point_x--rectangle.x
		end

	port_y: INTEGER
			-- y position where links starting.
		do
			Result := point_y--rectangle.y
		end

	size: EV_RECTANGLE
			-- Size of `Current'.
		do
			create Result.make (rectangle.point_a_x, rectangle.point_a_y, rectangle.width, rectangle.height)
		end

	height: INTEGER
			-- height of `Current'.
		do
			Result := rectangle.height
		end

	width: INTEGER
			-- width of `Current'.
		do
			Result := rectangle.width
		end

	left: INTEGER
			-- Left most position.
		do
			Result := rectangle.point_a_x
		end

	top: INTEGER
			-- Top most position
		do
			Result := rectangle.point_a_y
		end

	right: INTEGER
			-- Right most position.
		do
			Result := rectangle.point_b_x
		end

	bottom: INTEGER
			-- Bottom most position.
		do
			Result := rectangle.point_b_y
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLASS_FIGURE}
			if model /= Void then
				model.feature_clause_list_changed_actions.prune_all (agent set_queries_commands)
				model.generics_changed_actions.prune_all (agent set_generics)
				model.properties_changed_actions.prune_all (agent set_properties)
			end
		end

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE)
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

	xml_node_name: STRING
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "UML_CLASS_FIGURE"
		end

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml element representing `Current's state.
		local
			xqueries, xcommands, xsection: like xml_element
			i, nb: INTEGER
			l_expanded_sections: ARRAYED_LIST [FEATURE_SECTION_VIEW]
		do
			create l_expanded_sections.make (0)
			create xqueries.make (node, "QUERIES_SECTIONS", xml_namespace)
			from
				i := 1
				nb := queries.count
			until
				i > nb
			loop
				if
					attached {FEATURE_SECTION_VIEW} queries.i_th (i) as l_item and then
					l_item.is_expanded and then not l_item.feature_section.features.is_empty
				then
					create xsection.make (xqueries, "SECTION", xml_namespace)
					xsection.add_attribute ("NAME", xml_namespace, l_item.feature_section.first_feature_name)
					xqueries.put_last (xsection)
					l_item.collabse
					l_expanded_sections.extend (l_item)
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
				if
					attached {FEATURE_SECTION_VIEW} commands.i_th (i) as l_item and then
					l_item.is_expanded and then not l_item.feature_section.features.is_empty
				then
					create xsection.make (xqueries, "SECTION", xml_namespace)
					xsection.add_attribute ("NAME", xml_namespace, l_item.feature_section.first_feature_name)
					xcommands.put_last (xsection)
					l_item.collabse
					l_expanded_sections.extend (l_item)
				end
				i := i + 1
			end

			Result := Precursor {EIFFEL_CLASS_FIGURE} (node)
			Result.add_attribute ("CLUSTER_NAME", xml_namespace, model.class_i.group.name)
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
			Result.put_last (xqueries)
			Result.put_last (xcommands)

			from
				l_expanded_sections.start
			until
				l_expanded_sections.after
			loop
				l_expanded_sections.item.expand
				l_expanded_sections.forth
			end
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			fsv: FEATURE_SECTION_VIEW
		do
			node.forth
			Precursor {EIFFEL_CLASS_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end

			if attached {like xml_element} node.item_for_iteration as xqueries then
				node.forth
				across
					xqueries as q_ic
				loop
					if attached {like xml_element} q_ic.item as l_item then
						fsv := query_section_view_with_first_feature_name (l_item.attribute_by_name ("NAME").value)
						if fsv /= Void then
							fsv.expand
						end
					end
				end
			end

			if attached {like xml_element} node.item_for_iteration as xcommands then
				node.forth
				across
					xcommands as c_ic
				loop
					if attached {like xml_element} c_ic.item as l_item then
						fsv := command_section_view_with_first_feature_name (l_item.attribute_by_name ("NAME").value)
						if fsv /= Void then
							fsv.expand
						end
					end
				end
			end
			update_positions
			request_update
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION)
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_CLASS_FIGURE} (a_transformation)
			real_border := real_border * a_transformation.item (1, 1).truncated_to_real
			update_border
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update
			-- Some properties may have changed.
		do
			is_update_required := False
		end

feature {FEATURE_SECTION_VIEW} -- Expand/Collapse section

	update_size (fsv: FEATURE_SECTION_VIEW)
			-- `fsv' was expanded or collabsed.
		require
			fsv_not_void: fsv /= Void
			has_fsv: has_section (fsv)
		local
			l_item: EV_MODEL_GROUP
			pos: INTEGER
		do
			queries.start
			queries.search (fsv)
			if not queries.after then
				from
					l_item := {EV_MODEL_GROUP} / queries.item
					pos := l_item.point_y + l_item.bounding_box.height
					queries.forth
				until
					queries.after
				loop
					l_item := {EV_MODEL_GROUP} / queries.item
					l_item.set_point_position (queries.point_x, pos)
					pos := pos + l_item.bounding_box.height
					queries.forth
				end
				pos := commands.point_y
				from
					commands.start
				until
					commands.after
				loop
					l_item := {EV_MODEL_GROUP} / commands.item
					l_item.set_point_position (commands.point_x, pos)
					pos := pos + l_item.bounding_box.height
					commands.forth
				end
			else
				from
					commands.start
					commands.search (fsv)
					l_item := {EV_MODEL_GROUP} / commands.item
					pos := l_item.point_y + l_item.bounding_box.height
					commands.forth
				until
					commands.after
				loop
					l_item := {EV_MODEL_GROUP} / commands.item
					l_item.set_point_position (commands.point_x, pos)
					pos := pos + l_item.bounding_box.height
					commands.forth
				end
			end
			update_positions
			request_update
			if world.is_right_angles then
				world.apply_right_angles
			end
		end

	has_section (fsv: FEATURE_SECTION_VIEW): BOOLEAN
			-- Is `fsv' a section of the class?
		require
			fsv_not_void: fsv /= Void
		do
			Result := queries.has (fsv) or else commands.has (fsv)
		end

feature {NONE} -- Implementation

	border: INTEGER
			-- Border for `rectangle'.
		do
			Result := real_border.truncated_to_integer.max (0)
		end

	real_border: REAL
			-- Real border for `rectangle'

	number_of_figures: INTEGER = 3
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

	names: EV_MODEL_GROUP
			-- Group of `properties', `name_lable', `generics'.

	generics: EV_MODEL_TEXT
			-- Generics text.

	properties: EV_MODEL_TEXT
			-- Text for properties of class.

	expanded_sections: ARRAYED_LIST [FEATURE_SECTION]
			-- Expanded sections.

	query_section_view_with_first_feature_name (a_name: READABLE_STRING_GENERAL): FEATURE_SECTION_VIEW
			-- Return feature section view with first feature name `a_name' if any.
		do
			from
				queries.start
			until
				queries.after or else Result /= Void
			loop
				if
					attached {FEATURE_SECTION_VIEW} queries.item as l_item and then
					not l_item.feature_section.features.is_empty and then
					a_name.same_string (l_item.feature_section.first_feature_name)
				then
					Result := l_item
				end
				queries.forth
			end
		end

	command_section_view_with_first_feature_name (a_name: READABLE_STRING_GENERAL): FEATURE_SECTION_VIEW
			-- Return feature section view with name `a_name' if any.
		do
			from
				commands.start
			until
				commands.after or else Result /= Void
			loop
				if
					attached {FEATURE_SECTION_VIEW} commands.item as l_item and then
					not l_item.feature_section.features.is_empty and then
					a_name.same_string (l_item.feature_section.first_feature_name)
				then
					Result := l_item
				end
				commands.forth
			end
		end

	set_queries_commands
			-- Set `queries' and `commands' according to `model'.`feature_clause_list'.
		do
			if model.is_compiled then
				create expanded_sections.make (0)
				expanded_sections.compare_objects
				across
					queries as q_ic
				loop
					if
						attached {FEATURE_SECTION_VIEW} q_ic.item as l_item and then
						l_item.is_expanded
					then
						expanded_sections.extend (l_item.feature_section)
					end
				end
				across
					commands as c_ic
				loop
					if
						attached {FEATURE_SECTION_VIEW} c_ic.item as l_item and then
						l_item.is_expanded
					then
						expanded_sections.extend (l_item.feature_section)
					end
				end
				build_queries_commands_list
				set_queries
				set_commands
			else
				queries.hide
				commands.hide
			end
			update_positions
		end

	set_queries
			-- Set names in `queries' according to `queries_list'.
		require
			model_not_void: model /= Void
		do
			queries.wipe_out
			queries.set_point_position (0, 0)
			fill_group_with_features (queries, queries_list)
		end

	set_commands
			-- Set names `commands' according to `model'.`queries'.
		require
			model_not_void: model /= Void
		do
			commands.wipe_out
			commands.set_point_position (0, 0)
			fill_group_with_features (commands, commands_list)
		end

	set_is_selected (an_is_selected: like is_selected)
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

	fill_group_with_features (a_group: EV_MODEL_GROUP; feature_sections: LIST [FEATURE_SECTION])
			-- Fill `a_group' with features in `feature_sections'.
		require
			group_not_void: a_group /= Void
			group_empty: a_group.is_empty
			features_not_void: feature_sections /= Void
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
				if expanded_sections.has (l_item) then
					l_fsv.expand
				end
				attr_height := attr_height + l_fsv.bounding_box.height
				a_group.extend (l_fsv)
				feature_sections.forth
			end
		end

	queries_list: ARRAYED_LIST [FEATURE_SECTION]
			-- List of features sections for queries.

	commands_list: ARRAYED_LIST [FEATURE_SECTION]
			-- List of features sections for commands.

	build_queries_commands_list
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
			retried: BOOLEAN
		do
			if retried then
				create queries_list.make (0)
				create commands_list.make (0)
			else
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
			end
		ensure
			queries_list_not_void: queries_list /= Void
			commands_list_not_void: commands_list /= Void
		rescue
			retried := True
			retry
		end

	features_list (compiled_class: CLASS_C): LIST [FEATURE_SECTION]
			-- List of features ordered by section name and export status corresponding to `compiled_class'.
		require
			compiled_class_not_void: compiled_class /= Void
		local
			features: EIFFEL_LIST [FEATURE_AS]
			name: STRING
			retried: BOOLEAN
			l_section: FEATURE_SECTION
			fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_export_status: EXPORT_I
			l_item: FEATURE_CLAUSE_AS
			l_match_list: LEAF_AS_LIST
			l_comments: EIFFEL_COMMENTS
		do
			create {ARRAYED_LIST[FEATURE_SECTION]} Result.make (0)
			if not retried then
				eiffel_system.system.set_current_class (compiled_class)
				fcl := model.feature_clause_list
				if fcl /= Void and then not fcl.is_empty then
					l_match_list := match_list_server.item (compiled_class.class_id)
					if not compiled_class.has_feature_table then
							--| We cannot rely on feature calls on Void targets: they corrupt memory.
						raise ("No feature table")
					end
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
						l_item := fcl.item

						l_comments := l_item.comment (l_match_list)
						if l_comments = Void or else l_comments.is_empty then
							name := " "
						else
								-- |FIXME: Unicode Improvemet.
							name := l_comments.first.content_32.as_string_8
						end
						name.right_adjust
						create l_section.make (name, features, compiled_class)
						l_export_status := export_status_generator.
							feature_clause_export_status (system, compiled_class, l_item)
						if l_export_status = Void then
							l_section.enable_is_none
						elseif l_export_status.is_none then
							l_section.enable_is_none
						elseif l_export_status.is_set then
							l_section.enable_is_some
						else
							l_section.enable_is_any
						end
						Result.extend (l_section)
						fcl.forth
					end
				end
			end
			eiffel_system.system.set_current_class (Void)
		ensure
			Result_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

	set_generics
			-- Extend class name with `model'.`generics' if any.
		require
			model_not_void: model /= Void
		local
			a_text: STRING
		do
			a_text := model.generics
			if a_text /= Void then
				if not generics.is_show_requested then
					generics.show
				end
				generics.set_text (a_text)
				generics.set_identified_font (uml_generics_font)
				generics.set_foreground_color (uml_generics_color)
				if world /= Void and then world.scale_factor /= 1.0 then
					generics.scale (world.scale_factor)
				end
			else
				if generics.is_show_requested then
					generics.hide
				end
			end
			update_positions
		end

	set_properties
			-- Set porperties of class according to `model'.
		require
			model_not_void: model /= Void
		local
			prop_text: STRING
		do
			if model.is_deferred then
				name_label.set_identified_font (uml_class_deferred_font)
			end
			prop_text := ""
			if model.is_root_class then
				prop_text.append ("root")
			end
			if model.is_effective then
				if not prop_text.is_empty then
					prop_text.append (", ")
				end
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
				if not properties.is_show_requested then
					properties.show
				end
				prop_text.prepend ("{")
				prop_text.append ("}")
				properties.set_text (prop_text)
				set_properties_text_properties (properties)
			else
				properties.hide
			end
			update_positions
		end

	set_properties_text_properties (a_text: EV_MODEL_TEXT)
			-- Set properties of `a_text'
		do
			a_text.set_identified_font (uml_class_properties_font)
			a_text.set_foreground_color (uml_class_properties_color)
			if world /= Void and then world.scale_factor /= 1.0 then
				a_text.scale (world.scale_factor)
			end
		end

	update_positions
			-- Set positions for `root_text', `properties_text', `queries', `commands' such that port position is the center.
		local
			h, cur_y, f_pos, r_pos: INTEGER
			nbbox, qbbox, cbbox: EV_RECTANGLE
			l_border: like border
		do
			-- Align elements in `names'

			if properties.is_show_requested then
				h := properties.height
			end
			h := h + name_label.height
			if generics.is_show_requested then
				h := h + generics.height
			end

			cur_y := names.point_y - as_integer (h / 2)
			properties.set_point_position (names.point_x - as_integer (properties.width / 2), cur_y)
			if properties.is_show_requested then
				cur_y := cur_y + properties.height
			end
			name_label.set_point_position (names.point_x - as_integer (name_label.width / 2), cur_y)
			cur_y := cur_y + name_label.height
			generics.set_point_position (names.point_x - as_integer (generics.width / 2), cur_y)

			-- Align `names', `queries' and `commands'

			l_border := border
			nbbox := names.bounding_box
			f_pos := point_x - as_integer (nbbox.width / 2)
			r_pos := point_x + as_integer (nbbox.width / 2)
			h := nbbox.height
			h := h + l_border
			if queries.is_show_requested then
				qbbox := queries.bounding_box
				f_pos := f_pos.min (point_x - as_integer (qbbox.width / 2))
				r_pos := r_pos.max (f_pos + qbbox.width)
				h := h + qbbox.height
			end
			h := h + l_border
			if commands.is_show_requested then
				cbbox := commands.bounding_box
				f_pos := f_pos.min (point_x - as_integer (cbbox.width / 2))
				r_pos := r_pos.max (f_pos + cbbox.width)
				h := h + cbbox.height
			end

			cur_y := point_y - as_integer (h / 2)

			rectangle.set_point_a_position (f_pos - border, cur_y - border)

			names.set_point_position (point_x, cur_y + as_integer (nbbox.height / 2))
			cur_y := cur_y + nbbox.height + l_border
			queries_line.set_point_a_position (f_pos - border, cur_y - l_border // 2)
			queries_line.set_point_b_position (r_pos + border, cur_y - l_border // 2)
			if queries.is_show_requested then
				queries.set_point_position (f_pos, cur_y)
				cur_y := cur_y + qbbox.height
			end
			cur_y := cur_y + l_border
			commands_line.set_point_a_position (f_pos - border, cur_y - l_border // 2)
			commands_line.set_point_b_position (r_pos + border, cur_y - l_border // 2)
			if commands.is_show_requested then
				commands.set_point_position (f_pos, cur_y)
				cur_y := cur_y + cbbox.height
			end

			rectangle.set_point_b_position (r_pos + border, cur_y + border)

			request_update
		end

	update_border
			-- Update border position (required because text is not scaled smoothley)
		local
			l_right: INTEGER
		do
			l_right := names.bounding_box.right
			if commands.is_show_requested then
				l_right := l_right.max (commands.bounding_box.right)
			end
			if queries.is_show_requested then
				l_right := l_right.max (queries.bounding_box.right)
			end
			if
				rectangle.point_b_x < l_right or else
				rectangle.point_b_x > l_right + border
			then
				update_positions
			end
		end

	retrieve_preferences
			-- Retrieve properties from preference.
		do
			if uml_class_fill_color /= Void then
				rectangle.set_background_color (uml_class_fill_color)
			else
				rectangle.remove_background_color
			end
			rectangle.set_line_width (uml_class_line_width)
			rectangle.set_foreground_color (uml_class_line_color)
			if model /= Void and then model.is_deferred then
				name_label.set_identified_font (uml_class_deferred_font)
			else
				name_label.set_identified_font (uml_class_name_font)
			end
			name_label.set_foreground_color (uml_class_name_color)
			if generics /= Void then
				generics.set_identified_font (uml_generics_font)
				generics.set_foreground_color (uml_generics_color)
			end
			if properties /= Void then
				properties.set_identified_font (uml_class_properties_font)
				properties.set_foreground_color (uml_class_properties_color)
			end
			request_update
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	rectangle_not_void: rectangle /= Void
	queries_line_not_void: queries_line /= Void
	commands_line_not_void: commands_line /= Void
	queries_not_void: queries /= Void
	commands_not_void: commands /= Void
	names_not_void: names /= Void
	properties_not_void: properties /= Void
	generics_not_void: generics /= Void
	border_positive: border >= 0

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

end -- class UML_CLASS_FIGURE
