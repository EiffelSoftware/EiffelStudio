indexing
	description: "XMI Translation (for UML Tools)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_EXPORT

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initializes XMI Export Module.
		do
			create xmi_clusters.make
			create xmi_classes.make
			create xmi_associations.make
			create xmi_generalizations.make
			create xmi_diagrams.make
			create xmi_types.make
			xmi_types.compare_objects
			create doc_universe.make
			id_counter := 1001
			idref_counter := 2
			last_class_x := 500
			last_class_y := 200
		end

feature -- Status setting

	set_universe (a_universe: DOCUMENTATION_UNIVERSE) is
			-- Change `doc_universe' to `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
		do
			doc_universe := a_universe
		end

feature -- Access

	doc_universe: DOCUMENTATION_UNIVERSE
			-- Cluster selection to include in the generation.

	root_directory: DIRECTORY
			-- Directory where the documentation is going
			-- to be generated.

	target_file_name: FILE_NAME
			-- Location.

feature -- Actions

	generate (deg: DEGREE_OUTPUT) is
			-- Exports XMI, according to the user selection.
		local
			current_compiled_class: CLASS_C
			current_cluster: HASH_TABLE [CONF_CLASS, STRING]
			current_cluster_id: INTEGER
			new_xmi_cluster: XMI_CLUSTER
			new_xmi_class: XMI_CLASS
			new_xmi_diagram: XMI_DIAGRAM
			new_xmi_class_presentation: XMI_CLASS_PRESENTATION
			new_xmi_cluster_presentation: XMI_CLUSTER_PRESENTATION
			cancelled: BOOLEAN
			ir_error: INTERRUPT_ERROR
			l_class_i: CLASS_I
		do
			if not cancelled then
				deg.put_string ("Initializing")

				groups := doc_universe.groups

				classes := doc_universe.classes

					-- Clusters
				from
					groups.start
				until
					groups.after
				loop
					create new_xmi_cluster.make (id_counter, idref_counter, groups.item_for_iteration)
					id_counter := id_counter + 1
					create new_xmi_diagram.make (id_counter, new_xmi_cluster)
					id_counter := id_counter + 1
					current_cluster := groups.item_for_iteration.classes
					current_cluster_id := idref_counter
					idref_counter := idref_counter + 1
						-- Classes
					from
						current_cluster.start
					until
						current_cluster.after
					loop
						l_class_i ?= current_cluster.item_for_iteration
						check l_class_i_not_void: l_class_i /= Void end
						if l_class_i.is_compiled then
							current_compiled_class := l_class_i.compiled_class
							create new_xmi_class.make (id_counter, current_cluster_id, current_compiled_class)
							last_class_x := last_class_x + ((id_counter \\ 4) - 1) * 300
							last_class_y := last_class_y + 300
							create new_xmi_class_presentation.make (idref_counter, new_xmi_class, last_class_x, last_class_y)
							idref_counter := idref_counter + 1
							id_counter := id_counter + 1
							new_xmi_cluster.add_class (new_xmi_class)
							new_xmi_diagram.add_presentation (new_xmi_class_presentation)
							xmi_classes.extend (new_xmi_class)
						end
						current_cluster.forth
					end
					idref_counter := idref_counter + 1
					xmi_clusters.extend (new_xmi_cluster)
					xmi_diagrams.extend (new_xmi_diagram)
					groups.forth
				end

				deg.put_string ("Adding features")

				add_features

				create new_xmi_diagram.make_as_root (id_counter, idref_counter)
				idref_root_diagram := idref_counter
				id_counter := id_counter + 1
				idref_counter := idref_counter + 1
				from
					xmi_clusters.start
				until
					xmi_clusters.after
				loop
					create new_xmi_cluster_presentation.make (idref_counter, xmi_clusters.item)
					idref_counter := idref_counter + 1
					new_xmi_diagram.add_presentation (new_xmi_cluster_presentation)
					xmi_clusters.forth
				end
				xmi_diagrams.extend (new_xmi_diagram)

				deg.put_string ("Building generalizations list")

				from
					classes.start
				until
					classes.after
				loop
					l_class_i ?= classes.item_for_iteration
					check
						l_class_i_not_void: l_class_i /= Void
						l_class_i_is_compiled: l_class_i.is_compiled
					end
					current_compiled_class := l_class_i.compiled_class
					add_generalizations (current_compiled_class)
					classes.forth
				end

				deg.put_string ("Generating XMI")
				generate_from_lists
				deg.put_string ("XMI generated")
				classes := Void
				groups := Void
				xmi_classes := Void
				xmi_clusters := Void
				xmi_diagrams := Void
				xmi_generalizations := Void
				xmi_types := Void
				doc_universe := Void
			end
			deg.finish_degree_output
		rescue
			if Error_handler.error_list /= Void and then
				not Error_handler.error_list.is_empty then
				ir_error ?= Error_handler.error_list.first
				if ir_error /= Void then
					cancelled := True
					Error_handler.error_list.wipe_out
					retry
				end
			end
		end

feature -- Settings

	set_directory (p: DIRECTORY) is
			-- Assign `p' to `root_directory'.
			-- This is the location where the documentation will be generated.
		require
			p_not_void: p /= Void
		do
			root_directory := p
			if not root_directory.exists then
				root_directory.create_dir
			end
			set_target_file_name
		ensure
			root_directory_assigned: root_directory = p
			directory_exists: p.exists
			directory_is_writable: p.is_writable
		end

feature {NONE} -- Implementation

	classes: DS_ARRAYED_LIST [CONF_CLASS]
			-- Classes to be generated.

	groups: DS_ARRAYED_LIST [CONF_GROUP]
			-- Clusters to be generated.

	xmi_clusters: LINKED_LIST [XMI_CLUSTER]
			-- Representations of the system clusters for XMI.

	xmi_classes: LINKED_LIST [XMI_CLASS]
			-- Representations of the system classes for XMI.

	xmi_associations: LINKED_LIST [XMI_ASSOCIATION]
			-- Representations of the system associations between classes for XMI.

	xmi_generalizations: LINKED_LIST [XMI_GENERALIZATION]
			-- Representations of the system inheritance relations for XMI.

	xmi_diagrams: LINKED_LIST [XMI_DIAGRAM]
			-- Class diagrams representing the system in Rose.

	xmi_types: LINKED_LIST [XMI_TYPE]
			-- Formal types or types associated with classes
			-- not present in user's selection.

	id_counter: INTEGER
			-- XMI id of classes, packages, diagrams and attributes.

	idref_counter: INTEGER
			-- XMI id of models, presentations and relations.

	idref_root_diagram: INTEGER
			-- Number identifying the root diagram in Rose.

	last_class_x: INTEGER
			-- X-coordinate of the last instance of XMI_CLASS_PRESENTATION created.

	last_class_y: INTEGER
			-- Y-coordinate of the last instance of XMI_CLASS_PRESENTATION created.			

	xmi_class_by_class_c (a_class_c: CLASS_C): XMI_CLASS is
			-- Search XMI representation of `a_class_c'.
		require
				compiled_class_not_void: a_class_c /= Void
		local
			xmi_class_cursor: CURSOR
		do
			xmi_class_cursor := xmi_classes.cursor
			from
				xmi_classes.start
			until
				Result /= Void or else xmi_classes.after
			loop
				if xmi_classes.item.compiled_class = a_class_c then
					Result := xmi_classes.item
				end
				xmi_classes.forth
			end
			xmi_classes.go_to (xmi_class_cursor)
		end

	xmi_diagram_by_group (a_group: CONF_GROUP): XMI_DIAGRAM is
			-- Search Rose diagram linked to `a_group'.
		require
			cluster_not_void: a_group /= Void
		local
			l_item: XMI_DIAGRAM
		do
			from
				xmi_diagrams.start
			until
				Result /= Void or else xmi_diagrams.after
			loop
				l_item := xmi_diagrams.item
				if not l_item.is_root and then l_item.associated_cluster.group = a_group then
					Result := xmi_diagrams.item
				end
				xmi_diagrams.forth
			end
				-- we don't have the cluster but we should have the enclosing library
			if Result = Void then
				Result := xmi_diagram_by_group (a_group.target.system.lowest_used_in_library)
			end
		ensure
			result_not_void: Result /= Void
		end

	is_in_selection (c: CLASS_C): BOOLEAN is
			-- Is `c' in the clusters selected by the user?
		local
			l_class: CONF_CLASS
		do
			l_class ?= c.lace_class
			check
				l_class_not_void: l_class /= Void
			end
			Result := doc_universe.classes.has (l_class)
		end

	add_type (t: XMI_TYPE) is
			-- Add `t' to `xmi_types' if not already present.
		require
			type_not_void: t /= Void
		do
			if not xmi_types.has (t) then
				xmi_types.extend (t)
			end
		ensure
			type_present: xmi_types.has (t)
		end

	add_generalizations (c: CLASS_C) is
			-- Add all inheritance relations where `c' is involved.
		require
			arg_not_void: c /= Void
		local
			current_parent: CLASS_C
			new_xmi_class: XMI_CLASS
			new_xmi_parent_class: XMI_CLASS
			new_xmi_generalization: XMI_GENERALIZATION
			new_xmi_generalization_presentation: XMI_GENERALIZATION_PRESENTATION
			current_diagram: XMI_DIAGRAM
			l_parents: FIXED_LIST [CL_TYPE_A]
		do
			from
				l_parents := c.parents
				l_parents.start
			until
				l_parents.after
			loop
				current_parent := l_parents.item.associated_class
				if is_in_selection (current_parent) then
					new_xmi_class := xmi_class_by_class_c (c)
					new_xmi_parent_class := xmi_class_by_class_c (current_parent)
					create new_xmi_generalization.make (idref_counter, new_xmi_class, new_xmi_parent_class)
					idref_counter := idref_counter + 1
					create new_xmi_generalization_presentation.make (idref_counter, new_xmi_generalization)
					idref_counter := idref_counter + 1
					xmi_generalizations.extend (new_xmi_generalization)
					if new_xmi_generalization.enclosing_group /= Void then
						current_diagram := xmi_diagram_by_group (new_xmi_generalization.enclosing_group)
						current_diagram.add_presentation (new_xmi_generalization_presentation)
					end
				end
				l_parents.forth
			end
		end

	add_features is
			-- Fill field `features' in items of `xmi_classes'.
		local
			current_xmi_class: XMI_CLASS
			current_compiled_class: CLASS_C
			current_feature: E_FEATURE
			current_feature_list: LIST [E_FEATURE]
		do
			from
				xmi_classes.start
			until
				xmi_classes.after
			loop

				current_compiled_class := xmi_classes.item.compiled_class
				current_xmi_class := xmi_classes.item
				current_feature_list := current_compiled_class.written_in_features
				from
					current_feature_list.start
				until
					current_feature_list.after
				loop
					current_feature := current_feature_list.item
					if current_feature.is_attribute then
						add_attribute_or_association (current_feature, current_xmi_class)
					else
						if not current_feature.is_procedure then
							add_function (current_feature, current_xmi_class)
						else
							add_procedure (current_feature, current_xmi_class)
						end
					end
					current_feature_list.forth
				end
				xmi_classes.forth
			end
		end

	add_function (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `a_feature' to the field `features' in `a_xmi_class'.
		require
			a_feature_not_void: a_feature /= void
		local
			feature_type: XMI_CLASS
		do
			if a_feature.type.has_associated_class then
				feature_type := xmi_class_by_class_c (a_feature.type.associated_class)
				if feature_type = Void then
					add_function_type_unknown (a_feature, a_xmi_class)
				else
					add_function_type_known (a_feature, a_xmi_class, feature_type)
				end
			else
				add_function_type_formal (a_feature, a_xmi_class)
			end
		end

	add_function_type_unknown (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- create, if necessary, a new type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_operation: XMI_OPERATION
			full_type_name: STRING
			f_name: STRING
			c: CLASS_C
		do
			f_name := feature_name (a_feature)
			c := a_feature.type.associated_class
			full_type_name := c.name_in_upper.twin
			if c.has_ast and c.generics /= Void then
				full_type_name.append (c.ast.generics_as_string)
			end
			create new_xmi_type.make_type (idref_counter, full_type_name)
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type := xmi_types.item
			end
			create new_xmi_operation.make_op (id_counter, idref_counter, f_name, new_xmi_type)
			id_counter := id_counter + 1
			idref_counter := idref_counter + 1
			if a_feature.has_arguments then
				add_arguments (a_feature, new_xmi_operation)
			end
			if a_feature.export_status.is_none then
				new_xmi_operation.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_operation.set_protected
			else
				new_xmi_operation.set_public
			end
			a_xmi_class.add_feature (new_xmi_operation)
		end

	add_function_type_known (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS; a_xmi_type: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- assign `a_xmi_type' to its type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_xmi_type_not_void: a_xmi_type /= Void
		local
			new_xmi_operation: XMI_OPERATION
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			create new_xmi_operation.make_op (id_counter, idref_counter, f_name, a_xmi_type)
			id_counter := id_counter + 1
			idref_counter := idref_counter + 1
			if a_feature.has_arguments then
				add_arguments (a_feature, new_xmi_operation)
			end
			if a_feature.export_status.is_none then
				new_xmi_operation.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_operation.set_protected
			else
				new_xmi_operation.set_public
			end
			a_xmi_class.add_feature (new_xmi_operation)
		end

	add_function_type_formal (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- create, if necessary, a new formal type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_operation: XMI_OPERATION
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			if a_feature.type.is_formal then
				create new_xmi_type.make_type (idref_counter, "G")
			else
				create new_xmi_type.make_type (0, "NONE")
			end
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type := xmi_types.item
			end
			create new_xmi_operation.make_op (id_counter, idref_counter, f_name, new_xmi_type)
			id_counter := id_counter + 1
			idref_counter := idref_counter + 1
			if a_feature.has_arguments then
				add_arguments (a_feature, new_xmi_operation)
			end
			if a_feature.export_status.is_none then
				new_xmi_operation.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_operation.set_protected
			else
				new_xmi_operation.set_public
			end
			a_xmi_class.add_feature (new_xmi_operation)
		end

	add_procedure (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `a_feature' to the field `features' in `a_xmi_class'.
		require
			a_feature_not_void: a_feature /= void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_operation: XMI_OPERATION
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			create new_xmi_type.make_type (0, "NONE")
			add_type (new_xmi_type)
			create new_xmi_operation.make_op (id_counter, idref_counter, f_name, new_xmi_type)
			id_counter := id_counter + 1
			idref_counter := idref_counter + 1
			if a_feature.has_arguments then
				add_arguments (a_feature, new_xmi_operation)
			end
			if a_feature.export_status.is_none then
				new_xmi_operation.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_operation.set_protected
			else
				new_xmi_operation.set_public
			end
			a_xmi_class.add_feature (new_xmi_operation)
		end

	add_arguments (a_feature: E_FEATURE; a_xmi_operation: XMI_OPERATION) is
			-- Add to `a_xmi_operation' the representation of `a_feature' arguments.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_operation_not_void: a_xmi_operation /= Void
			a_feature_has_arguments: a_feature.has_arguments
		local
			current_argument_list: E_FEATURE_ARGUMENTS
			current_argument_names_list: LIST [STRING]
			new_xmi_class: XMI_CLASS
			new_xmi_type: XMI_TYPE
			new_xmi_argument: XMI_ARGUMENT
		do
			current_argument_list := a_feature.arguments
			current_argument_names_list := a_feature.argument_names
			from
				current_argument_list.start
				current_argument_names_list.start
			until
				current_argument_list.after
			loop
				if current_argument_list.item.has_associated_class then
					new_xmi_class := xmi_class_by_class_c (current_argument_list.item.associated_class)
					if new_xmi_class = Void then
						create new_xmi_type.make_type (idref_counter, current_argument_list.item.associated_class.name_in_upper.twin)
						if not xmi_types.has (new_xmi_type) then
							idref_counter := idref_counter + 1
							add_type (new_xmi_type)
						else
							xmi_types.start
							xmi_types.search (new_xmi_type)
							new_xmi_type := xmi_types.item
						end
						create new_xmi_argument.make (idref_counter, current_argument_names_list.item, new_xmi_type)
						idref_counter := idref_counter + 1
					else
						create new_xmi_argument.make (idref_counter, current_argument_names_list.item, new_xmi_class)
						idref_counter := idref_counter + 1
					end
				else
					create new_xmi_type.make_type (idref_counter, "G")
					if not xmi_types.has (new_xmi_type) then
						idref_counter := idref_counter + 1
						add_type (new_xmi_type)
					else
						xmi_types.start
						xmi_types.search (new_xmi_type)
						new_xmi_type := xmi_types.item
					end
					create new_xmi_argument.make (idref_counter, current_argument_names_list.item, new_xmi_type)
					idref_counter := idref_counter + 1
				end
				a_xmi_operation.add_argument (new_xmi_argument)
				current_argument_list.forth
				current_argument_names_list.forth
			end
		ensure
			added_right_number: a_xmi_operation.arguments.count = a_feature.arguments.count
		end

	add_attribute_or_association (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `a_feature' to the field `features' in `a_xmi_class'
			-- once we have determined whether the type of 'a_feature' should be represented
			-- as an association or as an attribute in the XMI.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_is_attribute: a_feature.is_attribute
		do
			if a_feature.type.has_associated_class then
				if a_feature.type.has_generics and not a_feature.type.generics.is_empty then
					add_generics_association (a_feature, a_xmi_class)
				else
					if a_feature.type.is_basic then
							-- Basic types are considered attributes
						add_attribute (a_feature, a_xmi_class)
					else
							-- Complex types are considered associations
						add_association (a_feature, a_xmi_class)
					end
				end
			end
		end

	add_association (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `a_feature' to the field `features' in `a_xmi_class'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_is_attribute: a_feature.is_attribute
		local
			feature_type: XMI_CLASS
		do
			if a_feature.type.has_associated_class then
				feature_type := xmi_class_by_class_c (a_feature.type.associated_class)
				if feature_type = Void then
					add_association_type_unknown (a_feature, a_xmi_class)
				else
					add_association_type_known (a_feature, a_xmi_class, feature_type)
				end
			end
		end

	add_association_type_unknown (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'.
			-- Create, if necessary, a new type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_association: XMI_ASSOCIATION
			full_type_name: STRING
			f_name: STRING
			c: CLASS_C
		do
			f_name := feature_name (a_feature)
			c := a_feature.type.associated_class
			full_type_name := c.name_in_upper.twin
			if c.has_ast and c.generics /= Void then
				full_type_name.append (c.ast.generics_as_string)
			end
			create new_xmi_type.make_type (idref_counter, full_type_name)
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type ?= xmi_types.item
			end
			create new_xmi_association.make (idref_counter, f_name, new_xmi_type, a_xmi_class, False, False)
			idref_counter := idref_counter + 3
			if a_feature.export_status.is_none then
				new_xmi_association.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_association.set_protected
			else
				new_xmi_association.set_public
			end
			a_xmi_class.add_association (new_xmi_association)
			new_xmi_type.add_association (new_xmi_association)
			xmi_associations.extend (new_xmi_association)
		end

	add_association_type_known (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS; a_xmi_type: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'.
			-- Assign `a_xmi_type' to its type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_xmi_type_not_void: a_xmi_type /= Void
		local
			new_xmi_association: XMI_ASSOCIATION
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			create new_xmi_association.make (idref_counter, f_name, a_xmi_type, a_xmi_class, False, False)
			idref_counter := idref_counter + 3
			if a_feature.export_status.is_none then
				new_xmi_association.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_association.set_protected
			else
				new_xmi_association.set_public
			end
			a_xmi_class.add_association (new_xmi_association)
			a_xmi_type.add_association (new_xmi_association)
			xmi_associations.extend (new_xmi_association)
		end

	add_generics_association (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class' where 'a_feature' is
			-- contains generics.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_feature_has_generics: a_feature.type.has_generics
		local
			feature_type: XMI_CLASS
			l_type: TYPE_A
		do
			if a_feature.type.has_associated_class then
					-- Is first generic known?
				l_type := a_feature.type.generics.item (1)
				if l_type.has_associated_class then
					feature_type := xmi_class_by_class_c (l_type.associated_class)
				end
				if feature_type = Void then
					add_generics_association_unknown (a_feature, a_xmi_class)
				else
					add_generics_association_known (a_feature, a_xmi_class, feature_type)
				end
			end
		end

	add_generics_association_known (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS; a_xmi_type: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class' where 'a_feature' is
			-- contains generics.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_feature_has_generics: a_feature.type.has_generics
		local
			new_xmi_association: XMI_ASSOCIATION
			l_ordered,
			l_multiple: BOOLEAN
			f_name,
			full_type_name: STRING
		do
			f_name := feature_name (a_feature)
				-- Take 1st generic
			full_type_name := full_class_name_from_generic_class (a_feature)
			if is_parent_of (ordered_type, full_type_name) then
				l_ordered := True
			end
			if is_parent_of (multiple_type, full_type_name) then
				l_multiple := True
			end
			create new_xmi_association.make (idref_counter, f_name, a_xmi_type, a_xmi_class, l_ordered, l_multiple)
			idref_counter := idref_counter + 3
			if a_feature.export_status.is_none then
				new_xmi_association.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_association.set_protected
			else
				new_xmi_association.set_public
			end
			a_xmi_class.add_association (new_xmi_association)
			a_xmi_type.add_association (new_xmi_association)
			xmi_associations.extend (new_xmi_association)
		end

	add_generics_association_unknown (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class' where 'a_feature' is
			-- contains generics.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_feature_has_generics: a_feature.type.has_generics
		local
			new_xmi_association: XMI_ASSOCIATION
			new_xmi_type: XMI_TYPE
			l_ordered,
			l_multiple: BOOLEAN
			f_name,
			full_type_name: STRING
			c: CLASS_C
		do
			f_name := feature_name (a_feature)
			c := a_feature.type.associated_class
				-- Take 1st generic.
			full_type_name := full_class_name_from_generic_class (a_feature)
			create new_xmi_type.make_type (idref_counter, full_type_name)
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type ?= xmi_types.item
			end
			if is_parent_of (ordered_type, full_type_name) then
				l_ordered := True
			end
			if is_parent_of (multiple_type, full_type_name) then
				l_multiple := True
			end
			create new_xmi_association.make (idref_counter, f_name, new_xmi_type, a_xmi_class, l_ordered, l_multiple)
			idref_counter := idref_counter + 3
			if a_feature.export_status.is_none then
				new_xmi_association.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_association.set_protected
			else
				new_xmi_association.set_public
			end
			a_xmi_class.add_association (new_xmi_association)
			new_xmi_type.add_association (new_xmi_association)
			xmi_associations.extend (new_xmi_association)
		end

	add_attribute (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `a_feature' to the field `features' in `a_xmi_class'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_is_attribute: a_feature.is_attribute
		local
			feature_type: XMI_CLASS
		do
			if a_feature.type.has_associated_class then
				feature_type := xmi_class_by_class_c (a_feature.type.associated_class)
				if feature_type = Void then
					add_attribute_type_unknown (a_feature, a_xmi_class)
				else
					add_attribute_type_known (a_feature, a_xmi_class, feature_type)
				end
			else
				add_attribute_type_formal (a_feature, a_xmi_class)
			end
		end

	add_attribute_type_unknown (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- create, if necessary, a new type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_attribute: XMI_ATTRIBUTE
			full_type_name: STRING
			f_name: STRING
			c: CLASS_C
		do
			f_name := feature_name (a_feature)
			c := a_feature.type.associated_class
			full_type_name := c.name_in_upper.twin
			if c.has_ast and c.generics /= Void then
				full_type_name.append (c.ast.generics_as_string)
			end
			create new_xmi_type.make_type (idref_counter, full_type_name)
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type := xmi_types.item
			end
			create new_xmi_attribute.make (id_counter, f_name, new_xmi_type)
			id_counter := id_counter + 1
			if a_feature.export_status.is_none then
				new_xmi_attribute.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_attribute.set_protected
			else
				new_xmi_attribute.set_public
			end
			a_xmi_class.add_feature (new_xmi_attribute)
		end

	add_attribute_type_known (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS; a_xmi_type: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- assign `a_xmi_type' to its type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
			a_xmi_type_not_void: a_xmi_type /= Void
		local
			new_xmi_attribute: XMI_ATTRIBUTE
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			create new_xmi_attribute.make (id_counter, f_name, a_xmi_type)
			id_counter := id_counter + 1
			if a_feature.export_status.is_none then
				new_xmi_attribute.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_attribute.set_protected
			else
				new_xmi_attribute.set_public
			end
			a_xmi_class.add_feature (new_xmi_attribute)
		end

	add_attribute_type_formal (a_feature: E_FEATURE; a_xmi_class: XMI_CLASS) is
			-- Add XMI representation of `e_feature' in `a_xmi_class'
			-- create, if necessary, a new formal type.
		require
			a_feature_not_void: a_feature /= Void
			a_xmi_class_not_void: a_xmi_class /= Void
		local
			new_xmi_type: XMI_TYPE
			new_xmi_attribute: XMI_ATTRIBUTE
			f_name: STRING
		do
			f_name := feature_name (a_feature)
			if a_feature.type.is_formal then
				create new_xmi_type.make_type (idref_counter, "G")
			else
				create new_xmi_type.make_type (0, "NONE")
			end
			if not xmi_types.has (new_xmi_type) then
				idref_counter := idref_counter + 1
				add_type (new_xmi_type)
			else
				xmi_types.start
				xmi_types.search (new_xmi_type)
				new_xmi_type := xmi_types.item
			end
			create new_xmi_attribute.make (id_counter, f_name, new_xmi_type)
			id_counter := id_counter + 1
			if a_feature.export_status.is_none then
				new_xmi_attribute.set_private
			elseif a_feature.export_status.is_set then
				new_xmi_attribute.set_protected
			else
				new_xmi_attribute.set_public
			end

			a_xmi_class.add_feature (new_xmi_attribute)
		end

	generate_from_lists is
			-- Write XMI description to `target_file_name'.
		local
			fi: PLAIN_TEXT_FILE
			src: STRING
			src_depot: XMI_CODE
		do
			create src_depot.make
			create fi.make_create_read_write (target_file_name)
			src := src_depot.header
			src.append (src_depot.content_start (idref_root_diagram))
			from
				xmi_clusters.start
			until
				xmi_clusters.after
			loop
				src.append (xmi_clusters.item.code)
				xmi_clusters.forth
			end

			from
				xmi_associations.start
			until
				xmi_associations.after
			loop
				src.append (xmi_associations.item.code)
				xmi_associations.forth
			end

			from
				xmi_generalizations.start
			until
				xmi_generalizations.after
			loop
				src.append (xmi_generalizations.item.code)
				xmi_generalizations.forth
			end

			from
				xmi_types.start
			until
				xmi_types.after
			loop
				src.append (xmi_types.item.code)
				xmi_types.forth
			end

			src.append (src_depot.content_end)

			src.append (src_depot.extensions_start)

			from
				xmi_diagrams.start
			until
				xmi_diagrams.after
			loop
				src.append (xmi_diagrams.item.code)
				xmi_diagrams.forth
			end

			src.append (src_depot.extensions_end)
			src.append (src_depot.file_end)
			fi.put_string (src)
			fi.close
		end

	set_target_file_name is
			-- Finalize file name using `root_directory'.
		do
			create target_file_name.make_from_string (root_directory.name)
			target_file_name.set_file_name (Eiffel_system.name)
			target_file_name.add_extension ("xml")
		end

	feature_name (f: E_FEATURE): STRING is
			-- Formatted name of `f'.
		require
			valid_feature: f /= Void
		local
			st: YANK_STRING_WINDOW
		do
			create st.make
			f.append_full_name (st)
			Result := st.stored_output
			Result.replace_substring_all ("&", "&amp;")
			Result.replace_substring_all ("<", "&lt;")
			Result.replace_substring_all (">", "&gt;")
		end

	is_parent_of (a_parent_name, a_child_name: STRING): BOOLEAN is
			-- Is class with name 'a_parent_name' an actual parent class with name 'a_child_name'?
		require
			a_parent_not_void: a_parent_name /= Void
			a_child_not_void: a_child_name /= Void
		local
			internal: INTERNAL
			l_child_id,
			l_parent_id: INTEGER
		do
			create internal
			l_parent_id := internal.dynamic_type_from_string (a_parent_name)
			l_child_id := internal.dynamic_type_from_string (a_child_name)
			if l_parent_id >= 0 and then l_child_id >= 0 then
				Result := internal.type_conforms_to (l_child_id, l_parent_id)
			end
		end

	full_class_name_from_generic_class (a_feature: E_FEATURE): STRING is
			-- Get the full string representation 'a_feature' including actual generic types.
		require
			a_feature_not_void: a_feature /= Void
		local
			full_type_name: STRING
			l_cnt: INTEGER
			l_multiple_generics: BOOLEAN
		do
			full_type_name := a_feature.type.associated_class.name_in_upper.twin
			from
				l_cnt := 1
				full_type_name.append (" [")
			until
				l_cnt > a_feature.type.generics.count
			loop
				if l_multiple_generics then
					if a_feature.type.generics.item (l_cnt).has_associated_class then
						full_type_name.append ("," + a_feature.type.generics.item (l_cnt).associated_class.name_in_upper)
					else
						full_type_name.append ("," + a_feature.associated_class.generics.i_th (l_cnt).name.name)
					end
				else
					if a_feature.type.generics.item (l_cnt).has_associated_class then
						full_type_name.append (a_feature.type.generics.item (l_cnt).associated_class.name_in_upper)
					else
						full_type_name.append (a_feature.associated_class.generics.i_th (l_cnt).name.name)
					end
					l_multiple_generics := True
				end
				l_cnt := l_cnt + 1
			end
			full_type_name.append ("]")
			Result := full_type_name
		end

	ordered_type: STRING is "CHAIN [ANY]"
			-- Name of topmost ordered type

	multiple_type: STRING is "CONTAINER [ANY]";
			-- Name of topmost multiple type

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class XMI_EXPORT
