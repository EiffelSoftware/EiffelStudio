indexing
	description: "Representation of a non-Eiffel compiled class that is external to current system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CLASS_C

inherit
	CLASS_C
		rename
			cluster as assembly
		redefine
			lace_class,
			is_true_external,
			is_removable,
			make,
			assembly
		end

create
	make

feature {NONE} -- Initialization

	make (l: CLASS_I) is
			-- Create instance of a compiled class using 'l'.
		do
			Precursor {CLASS_C} (l)
			is_external := True
		end

feature -- Initialization

	process_degree_5 is
			-- Read XML data and analyzes syntactical suppliers.
		require
			not_built: not is_built
		local
			l_ast: CLASS_AS
		do
				-- Initialize `external_class' which will be used later by
				-- `initialize_from_xml_data', then it is discarded to save
				-- some memory as we do not use it anymore.
			external_class := lace_class.external_consumed_type

			if external_class = Void then
					-- For some reasons, the XML file could not be retried.
				error_handler.insert_error (create {VIIC}.make (Current))
				error_handler.raise_error
			else
				private_external_name := external_class.dotnet_name

					-- This initialization is required as `initialize_from_xml_data'
					-- needs proper information about classes to build correct feature
					-- signature.
				is_deferred := external_class.is_deferred
				is_expanded := external_class.is_expanded
				is_enum := external_class.is_enum
				is_frozen := external_class.is_frozen

					-- Initializes inheritance structure
				process_parents

					-- Check if it is a nested type or not.
				process_nesting

					-- Initializes client/supplier relations.
				if external_class.fields /= Void then
					process_syntax_features (external_class.fields)
				end
				if external_class.constructors /= Void then
					process_syntax_features (external_class.constructors)
				end
				if external_class.procedures /= Void then
					process_syntax_features (external_class.procedures)
				end
				if external_class.functions /= Void then
					process_syntax_features (external_class.functions)
				end

					-- Create abstract syntax tree.
				create l_ast.initialize (
					create {ID_AS}.make (10),
					create {STRING_AS}.initialize (external_class.dotnet_name, 0, 0, 0, 0),
					is_deferred,
					is_expanded,
					False,	-- is_separate
					is_frozen,
					True,	-- is_external
					False,  -- is_partial
					Void,	-- top_indexes
					Void,	-- bottom_indexes
					Void,	-- generics
					Void,	-- parents
					Void,	-- creators
					Void,	-- convertors
					Void,	-- features
					Void,	-- invariant_part
					create {SUPPLIERS_AS}.make,	-- suppliers
					Void,	-- obsolete_message
					True,	-- has_externals
					create {KEYWORD_AS}.make_null
					)
				l_ast.set_class_id (class_id)

				Tmp_ast_server.put (l_ast)

					-- Remove further processing except degree_4 since we assume that
					-- imported XML is correct.
				degree_3.remove_class (Current)
				degree_2.remove_class (Current)
				degree_1.remove_class (Current)
				System.degree_minus_1.remove_class (Current)
			end
		ensure
			external_class_not_void: external_class /= Void
			not_in_degree_3: not degree_3_needed
			not_in_degree_2: not degree_2_needed
			not_in_degree_1: not degree_1_needed
			not_in_degree_minus_1: not degree_minus_1_needed
		end

	process_degree_4 is
			-- Read XML data and create feature table.
		require
			not_built: not is_built
			external_class_not_void: external_class /= Void
		local
			nb: INTEGER
			l_feat_tbl: like feature_table
			l_orig_tbl: SELECT_TABLE
			l_fields, l_constructors, l_procedures, l_functions: ARRAYED_LIST [CONSUMED_ENTITY]
		do
				-- Create data structures to hold features information.
			l_fields := external_class.fields
			l_constructors := external_class.constructors
			l_procedures := external_class.procedures
			l_functions := external_class.functions
			if l_fields /= Void then
				nb := l_fields.count
			end
			if l_constructors /= Void and then not l_constructors.is_empty then
				create creators.make (l_constructors.count)
				nb := nb + l_constructors.count
			end
			if l_procedures /= Void then
				nb := nb + l_procedures.count
			end
			if l_functions /= Void then
				nb := nb + l_functions.count
			end

			create l_feat_tbl.make (nb)
			l_feat_tbl.set_feat_tbl_id (class_id)
			create l_orig_tbl.make (nb)
			l_feat_tbl.set_origin_table (l_orig_tbl)

				-- To store overloaded features.
			create overloaded_names.make (10)

				-- Add features from ANY
			add_features_of_any (l_feat_tbl)

				-- Initializes feature table.
			if l_fields /= Void then
				process_features (l_feat_tbl, l_fields)
			end
			if l_constructors /= Void and then not l_constructors.is_empty then
				process_features (l_feat_tbl, l_constructors)
			end
			if l_procedures /= Void then
				process_features (l_feat_tbl, l_procedures)
			end
			if l_functions /= Void then
				process_features (l_feat_tbl, l_functions)
			end

				-- Clean `overloaded_names' to remove non-overloaded routines.
			clean_overloaded_names (l_feat_tbl)
			l_feat_tbl.set_overloaded_names (overloaded_names)

				-- Initialize `types'.
			init_types

				-- Create CLASS_INTERFACE instance
			init_class_interface

				-- Topological sort has been done and therefore all parents of current class
				-- have been processed yet.
			class_interface.process_features (l_feat_tbl)

				-- Ensure .NET classes have a skeleton.
			set_skeleton (l_feat_tbl.skeleton)

				-- Save freshly computed feature table on disk.
			Tmp_feat_tbl_server.put (l_feat_tbl)
			external_class := Void
			is_built := True
		ensure
			external_class_void: external_class = Void
			feature_table_not_void: feature_table /= Void
			types_not_void: types /= Void
			class_interface_not_void: class_interface /= Void
			is_built: is_built
		end

feature -- Access

	is_built: BOOLEAN
			-- Is Current class built?

	lace_class: EXTERNAL_CLASS_I
			-- Corresponding lace class.

	external_class: CONSUMED_TYPE
			-- Data read from XML file.

	enclosing_class: CLASS_C
			-- Class in which Current class is defined when `is_nested'.

	assembly: ASSEMBLY_I is
			-- Associated assembly of current.
		do
			Result := lace_class.assembly
		end

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A is
			-- Given an external type `c' get its associated CL_TYPE_A.
			-- Void, if `c' is not part of system.
		require
			c_not_void: c /= Void
			c_in_assembly_of_current_class:
				lace_class.assembly.referenced_assemblies.item (c.assembly_id) /= Void
		do
			Result := internal_type_from_consumed_type (False, c)
		end

feature {NONE} -- Implementation: Overloading

	overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			-- Hash_table of overloaded features.
			-- The key corresponds to overloaded feature name id, and for each entry it gives a
			-- list of associated resolved feature name id. (e.g. for `put' you will possibly
			-- find `put_integer', `put_double',...)

	clean_overloaded_names (a_feat_tbl: FEATURE_TABLE) is
			-- Remove single entries of `overloaded_names'.
		require
			overloaded_names_not_void: overloaded_names /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
		local
			l_result: like overloaded_names
			l_list: ARRAYED_LIST [INTEGER]
			l_count: INTEGER
		do
				-- First pass of cleaning to estimate the actual count
				-- of overloaded routines.
			from
				overloaded_names.start
			until
				overloaded_names.after
			loop
				if overloaded_names.item_for_iteration.count > 1 then
					l_count := l_count + 1
				end
				overloaded_names.forth
			end

			if l_count > 0 then
				from
					create l_result.make (l_count)
					overloaded_names.start
				until
					overloaded_names.after
				loop
					l_list := overloaded_names.item_for_iteration
					if l_list.count > 1 then
						l_list := updated_overloaded_list (a_feat_tbl, l_list)
						if l_list.count > 1 then
							l_result.put (l_list, overloaded_names.key_for_iteration)
						end
					end
					overloaded_names.forth
				end
				overloaded_names := l_result
			else
				overloaded_names := Void
			end
		end

	updated_overloaded_list (a_feat_tbl: FEATURE_TABLE; a_list: ARRAYED_LIST [INTEGER]): ARRAYED_LIST [INTEGER] is
			-- Process `a_list' to ensure that there are no 2 routines that only differ by
			-- their return type if any. CLS rules guarantee that the two routines cannot be in the
			-- same class, so we return a new list with the one which is defined in
			-- an ancestor class (including the Current class) the closest to the Current class,
			-- the others are removed from the list to avoid ambiguity when calling an
			-- overloaded routine.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_list_not_void: a_list /= Void
			a_list_has_at_least_2_items: a_list.count > 1
		local
			l_feat, l_other: FEATURE_I
			l_name_id: INTEGER
			i, j, nb: INTEGER
			l_has_overload_on_return_type, l_is_overloaded: BOOLEAN
			l_processed: SPECIAL [BOOLEAN]
		do
			l_feat := a_feat_tbl.item_id (a_list.first)
				-- Iterate through `a_list' and eliminate features with same parameters,
				-- more precisely only keeps the one that have distinct parameters.
			from
				i := 1
				nb := a_list.count
				create l_processed.make (nb + 1)
				create Result.make (nb)
			until
				i > nb
			loop
					-- If a routine was found in the sub-loop to be overloaded, we do not
					-- need to process it again.
				if not l_processed.item (i) then
					l_name_id := a_list.i_th (i)
					l_feat := a_feat_tbl.item_id (l_name_id)
					from
						l_has_overload_on_return_type := False
						j := i + 1
					until
						j > nb
					loop
						if not l_processed.item (j) then
							l_other := a_feat_tbl.item_id (a_list.i_th (j))
								-- Find if `l_feat' and `l_other' have the same parameter
								-- signature. If they do, we should not insert them in the
								-- overloading resolution list.
							l_is_overloaded :=
								(not l_feat.has_arguments and not l_other.has_arguments) or else
								((l_feat.has_arguments and l_other.has_arguments) and then
								(l_feat.arguments.count = l_other.arguments.count) and then
								l_feat.arguments.same_interface (l_other.arguments))
							if l_is_overloaded then
								l_has_overload_on_return_type := True
								l_processed.put (True, j)
							end
						end
						j := j + 1
					end
					if not l_has_overload_on_return_type then
						Result.extend (l_name_id)
					end
				end
				i := i + 1
			end
		end

feature -- Status report

	is_nested: BOOLEAN
			-- Is current external class a nested type?

	is_true_external: BOOLEAN is True
			-- Is class an instance of EXTERNAL_CLASS_C?
			-- If yes, we do not generate it.

	is_removable: BOOLEAN is False
			-- FIXME: Manu 08/07/2002: because of the way we initialize
			-- EXTERNAL_CLASS_C from the XML, we are missing some information
			-- that will generate incorrect VHPR error when removing an external
			-- class from the system. Therefore, we never remove EXTERNAL_CLASS_C
			-- from the system after they have been added.

feature -- Query

	has_associated_property_setter (a_feat: FEATURE_I): BOOLEAN is
			-- Associated property setter of `a_feat' if any.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_is_function: a_feat.is_function
			a_feat_is_external: a_feat.is_external
		local
			l_consumed_type: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_prop: CONSUMED_PROPERTY
			i, nb: INTEGER
			done: BOOLEAN
		do
			l_consumed_type := lace_class.external_consumed_type

				-- It should not be Void, since we were able to parse it before, but it
				-- is possible that someone might remove the file or other external
				-- events, so we protect our call.
			if l_consumed_type /= Void and l_consumed_type.properties /= Void then
				l_properties := l_consumed_type.properties
				from
					i := l_properties.lower
					nb := l_properties.upper
				until
					i > nb or done
				loop
					l_prop := l_properties.item (i)
					if l_prop /= Void then
						if l_prop.getter.eiffel_name.is_equal (a_feat.feature_name) then
							done := True
							Result := l_prop.setter /= Void
						end
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Initialization

	process_parents is
			-- Initialize inheritance clause of Current using `external_class'
		require
			system_object_not_void: System.system_object_class /= Void
			system_object_compiled: System.system_object_class.is_compiled
		local
			parent_type: CL_TYPE_A
			parent_class: CLASS_C
			l_ext_class: CONSUMED_REFERENCED_TYPE
			nb: INTEGER
		do
			nb := 1
			if external_class.interfaces /= Void then
				nb := nb + external_class.interfaces.count
			end

			create parents_classes.make (nb)
			create parents.make (nb)

			if external_class.parent /= Void then
				parent_type := internal_type_from_consumed_type (True, external_class.parent)
				parent_class := parent_type.associated_class
				parents.extend (parent_type)
				parents_classes.extend (parent_class)
				parent_class.add_descendant (Current)
				add_syntactical_supplier (parent_type)
			elseif external_class.is_interface then
					-- Force inheritance to `System.Object' for interfaces.
				is_interface := True
				parent_class := System.system_object_class.compiled_class
				parent_type := parent_class.actual_type
				parents.extend (parent_type)
				parents_classes.extend (parent_class)
				parent_class.add_descendant (Current)
				syntactical_suppliers.start
				syntactical_suppliers.search (parent_class)
				if not syntactical_suppliers.after then
					syntactical_suppliers.extend (parent_class)
				end
			end

			if external_class.interfaces /= Void and not external_class.interfaces.is_empty then
				from
					external_class.interfaces.start
				until
					external_class.interfaces.after
				loop
					l_ext_class := external_class.interfaces.item
					if l_ext_class /= Void then
						parent_type := internal_type_from_consumed_type (True, l_ext_class)
						parent_class := parent_type.associated_class
						parents.extend (parent_type)
						parents_classes.extend (parent_class)
						parent_class.add_descendant (Current)
						add_syntactical_supplier (parent_type)
					end
					external_class.interfaces.forth
				end
			end

			if class_id = System.system_object_id then
					-- Add ANY as a parent class of SYSTEM_OBJECT, and therefore
					-- of all .NET classes
				parent_class := any_type.associated_class
				parents.extend (any_type)
				parents_classes.extend (parent_class)
				parent_class.add_descendant (Current)
				add_syntactical_supplier (any_type)
			end
		ensure
			parents_not_void: parents /= Void
			parents_filled:
				Current /= System.system_object_class.compiled_class
					implies parents.count > 0
			parents_classes_not_void: parents_classes /= Void
			parents_classes_filled:
				Current /= System.system_object_class.compiled_class
					implies parents_classes.count > 0
		end

	process_syntax_features (a_features: ARRAYED_LIST [CONSUMED_ENTITY]) is
			-- Get all features and make sure all referenced types are in system.
		require
			a_features_not_void: a_features /= Void
		local
			l_member: CONSUMED_ENTITY
			l_args: ARRAY [CONSUMED_ARGUMENT]
			j, k, l: INTEGER
			l_external_type: CL_TYPE_A
		do
			from
				a_features.start
			until
				a_features.after
			loop
				l_member := a_features.item

				l_external_type := internal_type_from_consumed_type (True, l_member.declared_type)

				if l_member.has_return_value then
					l_external_type := internal_type_from_consumed_type (True, l_member.return_type)
					add_syntactical_supplier (l_external_type)
				end

				if l_member.has_arguments then
					from
						l_args := l_member.arguments
						l := 0
						j := l_args.lower
						k := l_args.upper
					until
						j > k
					loop
						l_external_type := internal_type_from_consumed_type (True,
							l_args.item (j).type)
						add_syntactical_supplier (l_external_type)
						l := l + 1
						j := j + 1
					end
				end
				a_features.forth
			end
		end

	add_features_of_any (a_feat_tbl: like feature_table) is
			-- Get all features of ANY and add them in `a_feat_tbl'.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
		local
			l_any_tbl: like feature_table
			l_orig_tbl: SELECT_TABLE
			l_feat: FEATURE_I
			any_parent_type: LIKE_CURRENT
		do
			l_any_tbl := feat_tbl_server.item (system.any_id)
			create any_parent_type
			any_parent_type.set_actual_type (any_type)
			check
				l_any_tbl_not_void: l_any_tbl /= Void
			end
			from
				l_orig_tbl := a_feat_tbl.origin_table
				l_any_tbl.start
			until
				l_any_tbl.after
			loop
				l_feat := l_any_tbl.item_for_iteration.duplicate
					-- Update `l_feat' in context of current class.
				l_feat.instantiate (any_parent_type)
				l_feat.check_types (a_feat_tbl)
				l_feat.set_feature_id (feature_id_counter.next)
				l_feat.set_is_origin (False)
				l_feat.set_rout_id_set (l_feat.rout_id_set.twin)

					-- Insert modified `l_feat' in current feature table.
				a_feat_tbl.put (l_feat, l_feat.feature_name_id)
				l_orig_tbl.put (l_feat, l_feat.rout_id_set.first)
				l_any_tbl.forth
			end
		end

	insert_feature (a_feat: FEATURE_I; a_feat_tbl: like feature_table) is
			-- Insert `a_feat' into `a_feat_tbl'. If there is a name conflict with
			-- a routine already there, we rename the version from ANY.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			has_select_table: a_feat_tbl.origin_table /= Void
		local
			l_orig_tbl: SELECT_TABLE
			l_feat: FEATURE_I
			i: INTEGER
			l_base_name: STRING
			l_new_name: STRING
		do
			l_orig_tbl := a_feat_tbl.origin_table

				-- In case we have a conflict (mostly due to a routine of ANY)
				-- we will rename the feature coming from ANY into `any_xxx'
				-- and preserve the .NET name, if it is not coming from ANY,
				-- it will be `unknown_xxx'
			if a_feat_tbl.has_id (a_feat.feature_name_id) then
				l_feat := a_feat_tbl.found_item
				a_feat_tbl.remove (l_feat.feature_name_id)
				l_base_name := l_feat.feature_name.twin
				if l_feat.written_in = system.any_id then
					l_base_name.prepend ("any_")
				else
					l_base_name.prepend ("unknown_")
				end
				l_feat.set_feature_name (l_base_name)
				from
					i := 1
				until
					not a_feat_tbl.has_id (l_feat.feature_name_id)
				loop
					l_new_name := l_base_name.twin
					l_new_name.append_character ('_')
					l_new_name.append_integer (i)
					l_feat.set_feature_name (l_new_name)
					i := i + 1
				end
					-- Insert back routine we just removed above.
					-- No need to update `l_orig_tbl' since this table
					-- does not depend on the name of `l_feat'.
				a_feat_tbl.put (l_feat, l_feat.feature_name_id)
			end

			a_feat_tbl.put (a_feat, a_feat.feature_name_id)
			l_orig_tbl.put (a_feat, a_feat.rout_id_set.first)
		end

	process_features (a_feat_tbl: like feature_table; a_features: ARRAYED_LIST [CONSUMED_ENTITY]) is
			-- Get all features and make sure all referenced types are in system.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			has_origin_table: a_feat_tbl.origin_table /= Void
			a_features_not_void: a_features /= Void
		local
			l_member: CONSUMED_ENTITY
			l_consumed_member: CONSUMED_MEMBER
			l_literal: CONSUMED_LITERAL_FIELD
			l_constructor: CONSUMED_CONSTRUCTOR
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
			l_arg_ids: ARRAY [INTEGER]
			j, k, l, m, l_record_pos, l_id: INTEGER
			l_creators: like creators
			l_return_type, l_external_type, l_written_type: CL_TYPE_A
			l_feat: FEATURE_I
			l_attribute: ATTRIBUTE_I
			l_proc: PROCEDURE_I
			l_deferred: DEF_PROC_I
			l_external: EXTERNAL_I
			l_constant: CONSTANT_I
			l_ext: IL_EXTENSION_I
			l_enum_ext: IL_ENUM_EXTENSION_I
			l_all_export: EXPORT_ALL_I
			l_none_export: EXPORT_NONE_I
			l_feat_arg: FEAT_ARG
			l_names_heap: like Names_heap
			l_list: ARRAYED_LIST [INTEGER]
			l_name: STRING
			l_name_id: INTEGER
			l_underlying_enum_type: STRING
			l_enum_member: CONSUMED_ENTITY
			l_enum_value: INTEGER_CONSTANT
		do
			from
				a_features.start
				l_creators := creators
				l_names_heap := Names_heap
				create l_all_export
				create l_none_export
			until
				a_features.after
			loop
				l_deferred := Void
				l_external := Void
				l_constant := Void
				l_attribute := Void

				l_member := a_features.item
				a_features.forth

				create l_ext

					-- First get return type. It is needed now in case we are handling a constant
					-- whose type is enum based, then we need to create an instance of EXTERNAL_FUNC_I
					-- and not an instance of CONSTANT_I.
				if l_member.has_return_value then
					l_return_type := internal_type_from_consumed_type (True, l_member.return_type)
				end

				if l_member.is_attribute then
					if l_member.is_literal then
						l_literal ?= l_member
						check
							l_literal_not_void: l_literal /= Void
						end
						if l_return_type.associated_class.is_enum then
								-- Too bad here we just discarded newly created extension
								-- object `l_ext', but that simpler this way.
							create l_enum_ext
							l_ext := l_enum_ext
							create {EXTERNAL_FUNC_I} l_external.make (l_ext)
							l_feat := l_external
						else
							create l_constant.make
							l_feat := l_constant
						end
					else
						create l_attribute.make
						l_feat := l_attribute
					end
				elseif l_member.is_deferred then
					if l_member.has_return_value then
						create {DEF_FUNC_I} l_deferred
					else
						create {DEF_PROC_I} l_deferred
					end
					l_feat := l_deferred
				else
					if l_member.is_artificially_added then
							-- Special care of `|', `to_integer' and `from_integer' of
							-- enum classes which have to be non-external feature.
						if l_member.has_return_value then
							create {DYN_FUNC_I} l_feat
						else
							create {DYN_PROC_I} l_feat
						end
					else
						if l_member.has_return_value then
							create {EXTERNAL_FUNC_I} l_external.make (l_ext)
						else
							create {EXTERNAL_I} l_external.make (l_ext)
						end
						l_feat := l_external
					end
				end

					-- Add creation routine to `creators' if any.
				l_constructor ?= l_member
				if l_constructor /= Void then
						-- Special case for value type where creation routines
						-- are simply generated as normal feature and cannot be used
						-- as creation procedure because usually there are more
						-- than one possible creation routine and this is forbidden
						-- by Eiffel specification on expanded.
					l_creators.put (l_all_export, l_member.eiffel_name)
					if external_class.is_expanded then
						l_feat.set_export_status (l_all_export)
					else
						l_feat.set_export_status (l_none_export)
					end
				else
					if l_member.is_public then
						l_feat.set_export_status (l_all_export)
					else
						l_feat.set_export_status (l_none_export)
					end
				end

				if l_deferred /= Void then
					l_deferred.set_extension (l_ext)
				elseif l_attribute /= Void then
					l_attribute.set_extension (l_ext)
				end

				if l_member.is_static then
					if l_member.is_attribute then
						if l_return_type.associated_class.is_enum then
							l_ext.set_type ({SHARED_IL_CONSTANTS}.Enum_field_type)
						else
							l_ext.set_type ({SHARED_IL_CONSTANTS}.Static_field_type)
						end
					else
						if l_member.is_prefix or l_member.is_infix then
							check
								not_manually_added: not l_member.is_artificially_added
							end
							l_ext.set_type ({SHARED_IL_CONSTANTS}.Operator_type)
						else
							l_ext.set_type ({SHARED_IL_CONSTANTS}.Static_type)
						end
					end
				else
					if l_member.is_attribute then
						l_ext.set_type ({SHARED_IL_CONSTANTS}.Field_type)
					elseif l_constructor /= Void then
						l_ext.set_type ({SHARED_IL_CONSTANTS}.Creator_type)
					elseif l_deferred /= Void then
						l_ext.set_type ({SHARED_IL_CONSTANTS}.Deferred_type)
					else
						l_ext.set_type ({SHARED_IL_CONSTANTS}.Normal_type)
					end
				end

					-- Special override of external type in case we handle an attribute setter routine.
				l_consumed_member ?= l_member
				if l_consumed_member /= Void and then l_consumed_member.is_attribute_setter then
					if l_consumed_member.is_static then
						l_ext.set_type ({SHARED_IL_CONSTANTS}.set_static_field_type)
					else
						l_ext.set_type ({SHARED_IL_CONSTANTS}.set_field_type)
					end
				end

				l_ext.set_base_class (l_member.declared_type.name)

				l_names_heap.put (l_member.dotnet_name)
				l_ext.set_alias_name_id (l_names_heap.found_item)
				if l_ext.type = {SHARED_IL_CONSTANTS}.Enum_field_type then
					check
						l_enum_ext_not_void: l_enum_ext /= Void
					end
						-- Find underlying type of an enumeration
					if l_underlying_enum_type = Void then
						from
							j := a_features.count
						until
							j <= 0
						loop
							l_enum_member := a_features.i_th (j)
							if not l_enum_member.is_literal and then l_enum_member.is_field then
								l_underlying_enum_type := l_enum_member.return_type.name
							end
							j := j - 1
						end
						if l_underlying_enum_type = Void then
							l_underlying_enum_type := "System.Int32"
						end
					end
					if l_literal.value.item (1) = '-' then
						create l_enum_value.make_from_string (Void, True, l_literal.value.substring (2, l_literal.value.count))
					else
						create l_enum_value.make_from_string (Void, False, l_literal.value)
					end
					if l_underlying_enum_type.is_equal ("System.SByte") then
						l_enum_value.set_real_type (integer_8_type)
					elseif l_underlying_enum_type.is_equal ("System.Int16") then
						l_enum_value.set_real_type (integer_16_type)
					elseif l_underlying_enum_type.is_equal ("System.Int32") then
						l_enum_value.set_real_type (integer_type)
					elseif l_underlying_enum_type.is_equal ("System.Int64") then
						l_enum_value.set_real_type (integer_64_type)
					elseif l_underlying_enum_type.is_equal ("System.Byte") then
						l_enum_value.set_real_type (natural_8_type)
					elseif l_underlying_enum_type.is_equal ("System.UInt16") then
						l_enum_value.set_real_type (natural_16_type)
					elseif l_underlying_enum_type.is_equal ("System.UInt32") then
						l_enum_value.set_real_type (natural_32_type)
					elseif l_underlying_enum_type.is_equal ("System.UInt64") then
						l_enum_value.set_real_type (natural_64_type)
					else
						debug ("refactor_fixme")
							fixme ("Types Char, IntPtr, UIntPtr are not processed correctly.")
						end
					end
					l_enum_ext.set_value (l_enum_value)
				end
				l_feat.set_private_external_name_id (l_names_heap.found_item)
				if l_member.has_return_value then
					l_feat.set_type (l_return_type, 0)

					l_names_heap.put (l_member.return_type.name)
					l_ext.set_return_type (l_names_heap.found_item)

					if l_constant /= Void then
						set_constant_value (l_constant, l_return_type, l_literal.value)
					end
				end

				if l_member.has_arguments then
					from
						l_args := l_member.arguments
						l := 0
						m := 0
						j := l_args.lower
						k := l_args.upper
						if
							not l_member.is_artificially_added and
							(l_member.is_infix or l_member.is_prefix)
						then
							check
								l_args_big_enough:
									l_member.is_infix implies l_args.lower + 1 <= l_args.upper
								l_args_big_enough2: l_member.is_prefix implies l_args.count = 1
							end
							l_record_pos := j + 1
						else
							l_record_pos := j
						end
						create l_feat_arg.make (k - l_record_pos + 1)
						create l_arg_ids.make (1, k - j + 1)
					until
						j > k
					loop
						l_arg := l_args.item (j)
						if j >= l_record_pos then
							l_external_type := internal_type_from_consumed_type (True,
								l_arg.type)
							l_feat_arg.put_i_th (l_external_type, m + 1)
							l_names_heap.put (l_arg.eiffel_name)
							l_feat_arg.argument_names.put (l_names_heap.found_item, m)
							m := m + 1
						end

						l_names_heap.put (l_arg.type.name)
						l_arg_ids.put (l_names_heap.found_item, l + 1)

						l := l + 1
						j := j + 1
					end
					l_proc ?= l_feat
					check
						is_procedure: l_proc /= Void
					end
					l_ext.set_argument_types (l_arg_ids)
					l_proc.set_arguments (l_feat_arg)
				end

				l_feat.set_is_frozen (l_member.is_frozen)
				if l_member.is_prefix then
						-- Set feature flags
					l_feat.set_is_prefix (True)
					l_feat.set_is_unary (True)
						-- Set both feature name and alias name
					names_heap.put (Prefix_infix_names.prefix_feature_name_with_symbol (l_member.eiffel_name))
					l_name_id := names_heap.found_item
					l_feat.set_feature_name_id (l_name_id, l_name_id)
				elseif l_member.is_infix then
						-- Set feature flags
					l_feat.set_is_infix (True)
					l_feat.set_is_binary (True)
						-- Set both feature name and alias name
					names_heap.put (Prefix_infix_names.infix_feature_name_with_symbol (l_member.eiffel_name))
					l_name_id := names_heap.found_item
					l_feat.set_feature_name_id (l_name_id, l_name_id)
				else
					l_feat.set_feature_name (l_member.eiffel_name)
				end
				l_feat.set_feature_id (feature_id_counter.next)

				l_written_type := internal_type_from_consumed_type (True, l_member.declared_type)
				l_feat.set_written_in (l_written_type.class_id)

					-- Let's update `l_feat' with info from parent classes.
				update_feature_with_parents (a_feat_tbl, l_feat, l_member)

					-- Insert `l_feat' in feature tables
				insert_feature (l_feat, a_feat_tbl)

					-- Process the types of the external routines, no doing it would
					-- cause the compiler to miss certain derivation of NATIVE_ARRAY
					-- that are necessary to get the right associated NATIVE_ARRAY_CLASS_TYPE
					-- at code generation
				if l_feat.written_in = class_id then
						-- Only do it for feature written in current class, inherited
						-- one have already been processed.
					set_changed (True)
					l_feat.update_instantiator2 (Current)
					set_changed (False)
				end

				l_name := l_member.dotnet_eiffel_name
				l_names_heap.put (l_name)
				l_id := l_names_heap.found_item

				if overloaded_names.has (l_id) then
					l_list := overloaded_names.item (l_id)
					l_list.extend (l_feat.feature_name_id)
				else
					create l_list.make (10)
					l_list.extend (l_feat.feature_name_id)
					overloaded_names.put (l_list, l_id)
				end
			end
		end

	process_nesting is
			-- If `external_class' represent an instance of CONSUMED_NESTED_TYPE
			-- we initialize `enclosing_class' correctly.
		require
			external_class_not_void: external_class /= Void
		local
			l_nested: CONSUMED_NESTED_TYPE
			l_enclosing_type: CL_TYPE_A
		do
			l_nested ?= external_class
			if l_nested /= Void then
				l_enclosing_type := internal_type_from_consumed_type (True, l_nested.enclosing_type)
				is_nested := True
				enclosing_class := l_enclosing_type.associated_class
				add_syntactical_supplier (l_enclosing_type)
			end
		end

feature {NONE} -- Implementation

	update_feature_with_parents (a_feat_tbl: FEATURE_TABLE; a_feat: FEATURE_I;
			a_member: CONSUMED_ENTITY)
		is
			-- Compute a new `rout_id_set' for `a_feat' based on info of current class and
			-- parent classes. If we do not found a matching routine in a parent class, then
			-- we set `is_origin' on `a_feat'.
			-- Set `written_feature_id'.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_feat_tbl_has_origin_table: a_feat_tbl.origin_table /= Void
			a_feat_not_void: a_feat /= Void
			a_feat_with_no_rout_id_set: a_feat.rout_id_set = Void
			a_member_not_void: a_member /= Void
		local
			l_rout_id_set: ROUT_ID_SET
			l_feat: FEATURE_I
			l_parent_class: CLASS_C
		do
				-- We need to look up parents of current class to find if some routine IDs
				-- have been assigned or not. At this stage `a_feat' contains valid data,
				-- only `rout_id_set' of `a_feat' has not yet been set.
				--
				-- Note: Manu 08/13/2002
				-- In most cases the below alogorithm is going to find an inherited
				-- routine id, however in the case where a MethodImpl has been done in current
				-- class, we do not get a routine because it is private, or if it is public
				-- we cannot yet trace back to which inherited feature/class MethodImpl has been
				-- done, so we will create a new routine id, we will not do a merge, which seems to
				-- be the .NET behavior anyway.

			create l_rout_id_set.make

			if not a_member.is_virtual then
					-- Either it is a new feature of current or an inherited one,
					-- in the first case we create a new routine id, otherwise we reuse the
					-- parent one.
				if a_feat.written_class /= Current then
					l_feat := matching_external_feature_in (a_feat, a_feat.written_class, a_member)
					check
						l_feat_not_void: l_feat /= Void
					end
					l_rout_id_set.merge (l_feat.rout_id_set)
				end
			else
					-- It is virtual, we need to find out from where we are coming.
					-- We first check on all interfaces of current class, and only when
					-- we do not find any matching routine, then we check the main parent.
				from
					parents.start
				until
					parents.after
				loop
					if parents.item.associated_class.is_interface then
						l_feat := matching_external_feature_in (a_feat,
							parents.item.associated_class, a_member)
						if l_feat /= Void then
							l_rout_id_set.merge (l_feat.rout_id_set)
							if l_feat.written_in = a_feat.written_in then
									-- Inherited feature is written in same class as `a_feat'
									-- therefore we can safely store inherited `written_feature_id'
									-- into `a_feat'.
								a_feat.set_written_feature_id (l_feat.written_feature_id)
							end
						end
					else
						check
							no_parent_found_yet: l_parent_class = Void
						end
						l_parent_class := parents.item.associated_class
					end
					parents.forth
				end
				if l_rout_id_set.is_empty and l_parent_class /= Void then
						-- Let's check the main parent now.
					l_feat := matching_external_feature_in (a_feat, l_parent_class, a_member)
					if l_feat /= Void then
						l_rout_id_set.merge (l_feat.rout_id_set)
						if l_feat.written_in = a_feat.written_in then
								-- Inherited feature is written in same class as `a_feat'
								-- therefore we can safely store inherited `written_feature_id'
								-- into `a_feat'.
							a_feat.set_written_feature_id (l_feat.written_feature_id)
						end
					end
				end
			end

			if l_rout_id_set.is_empty then
					-- No existing routine id has been found, let's create a new one.
				if a_feat.is_attribute then
					l_rout_id_set.put (Routine_id_counter.next_attr_id)
				else
					l_rout_id_set.put (Routine_id_counter.next_rout_id)
				end
					-- Because no previous routine could be found, this is an origin.
				a_feat.set_is_origin (True)
			end

				-- Insert the computed routine IDs.
			a_feat.set_rout_id_set (l_rout_id_set)

			if a_feat.written_in = class_id then
					-- Feature is written in current class, we need to assign its
					-- `written_feature_id'.
				check
					not_assigned_yet: a_feat.written_feature_id = 0
				end
				a_feat.set_written_feature_id (a_feat.feature_id)
			end
		ensure
			a_feat_updated: a_feat.rout_id_set /= Void and then not a_feat.rout_id_set.is_empty
			not_already_inserted:
				not a_feat.rout_id_set.linear_representation.there_exists (
					agent (a_feat_tbl.origin_table).has)
		end

	matching_external_feature_in (
			a_feat: FEATURE_I; a_class: CLASS_C; a_member: CONSUMED_ENTITY): FEATURE_I
		is
			-- Look up a feature whose external name is `a_name_id' in `a_class'.
		require
			a_feat_not_void: a_feat /= Void
			a_class_not_void: a_class /= Void
			a_member_not_void: a_member /= Void
		local
			l_feat_tbl: FEATURE_TABLE
			l_feat: FEATURE_I
			l_found: BOOLEAN
			i, nb: INTEGER
			l_other_ext, l_feat_ext: IL_EXTENSION_I
		do
			l_feat_ext ?= a_feat.extension

			if l_feat_ext = Void then
					-- If it does not have an extension is either means that `a_feat' is either:
					-- 1 - a constant
					-- 2 - an artificially added feature such as `from_integer', `infix "|"' and
					--     `to_integer' on all enum types.
					--
					-- In those cases, we can safely assume that because the aboves features
					-- are frozen, that generating a new routine id is not going to be harmfull.
				check
					frozen_feature: a_feat.is_frozen or a_feat.is_constant
				end
			elseif a_class.is_true_external then
					-- Let's find a matching inherited feature.
				l_feat_tbl := a_class.feature_table
				from
					l_feat_tbl.start
					l_found := False
				until
					l_feat_tbl.after or else Result /= Void
				loop
					l_feat := l_feat_tbl.item_for_iteration
					l_other_ext ?= l_feat.extension
						-- We only analyze an inherited routine `l_feat' when it makes sense:
						-- 1 - `l_feat' should be defined in a class that is an ancestor of the
						--      class where `a_feat' is defined.
						-- 2 - It should have an extension part, since `a_feat' has one.
						-- 3 - It should have the same external name
						-- 4 - Both routines seems to be coming from the same class, otherwise
						--     the parent one should not be frozen (as it makes no sense to be
						--     able to redefine a frozen feature.
					if
						a_feat.written_class.simple_conform_to (l_feat.written_class) and then
						l_other_ext /= Void and then
						l_other_ext.alias_name_id = l_feat_ext.alias_name_id and then
						(a_feat.written_class = l_feat.written_class or else not l_feat.is_frozen)
					then
							-- We found a routine, let's check that is the right one
							-- by comparing their return type and their arguments type.
						if
							l_feat.type.same_as (a_feat.type) and then
							l_feat.argument_count = a_feat.argument_count
						then
							if l_feat.argument_count = 0 then
								l_found := True
							else
								from
									i := l_other_ext.argument_types.lower
									nb := l_other_ext.argument_types.upper
									l_found := True
								until
									i > nb or not l_found
								loop
									l_found := l_other_ext.argument_types.item (i) =
										l_feat_ext.argument_types.item (i)

									i := i + 1
								end
							end
							if l_found then
									-- We found an inherited feature matching current.
									-- If we are in an interface and that a parent interface
									-- already define the same feature, then we have to create
									-- a new routine ID.
								if is_interface then
									if
										not a_feat.is_deferred or else
										a_feat.written_class = l_feat.written_class
									then
										Result := l_feat
									end
								else
									Result := l_feat
								end
							end
						end
					end
					l_feat_tbl.forth
				end
			end
		end

	internal_type_from_consumed_type (
			force_compilation: BOOLEAN; c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
		is
			-- Given an external type `c' get its associated CL_TYPE_A.
			-- If `force_compilation' automatically add it for later compilation
		require
			c_not_void: c /= Void
			c_in_assembly_of_current_class:
				lace_class.assembly.referenced_assemblies.item (c.assembly_id) /= Void
		do
			Result := internal_type_from_consumed_type_in_assembly (
				lace_class.assembly.referenced_assemblies.item (c.assembly_id),
				force_compilation, c)
		ensure
			result_not_void: force_compilation implies Result /= Void
		end

	internal_type_from_consumed_type_in_assembly (
			an_assembly: ASSEMBLY_I; force_compilation: BOOLEAN;
			c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
		is
			-- Given an external type `c' in assembly `an_assembly' get its
			-- associated CL_TYPE_A.
			-- If `force_compilation' automatically add it for later compilation
		require
			assembly_not_void: an_assembly /= Void
			c_not_void: c /= Void
		local
			l_result: CLASS_I
			l_class: CLASS_C
			l_is_array: BOOLEAN
			l_generics: ARRAY [TYPE_A]
			l_array_type: CONSUMED_ARRAY_TYPE
			l_type_a: CL_TYPE_A
			vtct: VTCT
			l_type_name: STRING
		do
			if c.is_by_ref then
				l_type_name := c.name.substring (1, c.name.count - 1)
			else
				l_type_name := c.name
			end
			l_array_type ?= c
			l_is_array := l_array_type /= Void
			if l_is_array then
				l_type_a := internal_type_from_consumed_type (force_compilation,
					l_array_type.element_type)
				if l_type_a /= Void then
					create l_generics.make (1, 1)
					l_generics.put (l_type_a, 1)
					create {NATIVE_ARRAY_TYPE_A} Result.make (
						System.native_array_class.compiled_class.class_id, l_generics)
				end
			else
				l_result := an_assembly.dotnet_classes.item (l_type_name)
				if l_result = Void then
						-- Case where this is a class from `mscorlib' that is in fact
						-- written as an Eiffel class, e.g. INTEGER, ....
					check
						has_basic: lace_class.basic_type_mapping.has (l_type_name)
					end
					l_result := lace_class.basic_type_mapping.item (l_type_name)
				end

				if l_result = Void then
						-- Type could not be found. Something must be inconsistent in
						-- this assembly.
					create vtct
					vtct.set_class (Current)
					vtct.set_dotnet_class_name (l_type_name)
					Error_handler.insert_error (vtct)
					Error_handler.raise_error
				else
					if force_compilation and then not l_result.is_compiled then
						Workbench.add_class_to_recompile (l_result)
					end
					if l_result.is_compiled then
						l_class := l_result.compiled_class
						Result := l_class.actual_type
					end
				end
			end
			if c.is_by_ref then
					-- We need to create an instance of TYPED_POINTER here.
				create {TYPED_POINTER_A} Result.make_typed (Result)
			end
		ensure
			result_not_void: force_compilation implies Result /= Void
		end

	set_constant_value (a_constant: CONSTANT_I; a_external_type: CL_TYPE_A; a_value: STRING) is
			-- Set `value' of `a_constant' with data of `a_value' using `a_external_type'
			-- to find out type of constant.
		require
			a_constant_not_void: a_constant /= Void
			a_external_type_not_void: a_external_type /= Void
			a_value_not_void: a_value /= Void and then not a_value.is_empty
		local
			l_int: INTEGER_CONSTANT
			l_val: like a_value
			l_is_negative: BOOLEAN
			l_value: VALUE_I
			l_bool_value: BOOL_VALUE_I
			l_char_value: CHAR_VALUE_I
			l_string_value: STRING_VALUE_I
			l_int32: INTEGER
			l_int64: INTEGER_64
			l_real64: DOUBLE
			l_real32: REAL
			i: INTEGER
			n: INTEGER
			c: CHARACTER
			h: INTEGER
		do
			if a_external_type.is_real_64 then
					-- Read hexadecimal representation in little-endian byte order
				from
					n := a_value.count.min (16)
					i := 1
				variant
					n - i + 1
				until
					i > n
				loop
					c := a_value.item (i)
						-- Save integer value of character `c' to `h'
					if c < 'A' then
							-- This is a digit
						h := c.code - 48
					elseif c >= 'a' then
							-- This is a character 'a'..'f'
						h := c.code - 87
					else
							-- This is a character 'A'..'F'
						h := c.code - 55
					end
						-- Bytes are encoded in big-endian order
					l_int64 := l_int64 + h.to_integer_64 |<< ((i + (i & 1) |<< 1 - 2) * 4)
					i := i + 1
				end
				($l_real64).memory_copy ($l_int64, 8)
				create {REAL_VALUE_I} l_value.make_real_64 (l_real64)
			elseif a_external_type.is_real_32 then
					-- Read hexadecimal representation in little-endian byte order
				from
					n := a_value.count.min (8)
					i := 1
				variant
					n - i + 1
				until
					i > n
				loop
					c := a_value.item (i)
						-- Save integer value of character `c' to `h'
					if c < 'A' then
							-- This is a digit
						h := c.code - 48
					elseif c >= 'a' then
							-- This is a character 'a'..'f'
						h := c.code - 87
					else
							-- This is a character 'A'..'F'
						h := c.code - 55
					end
						-- Bytes are encoded in big-endian order
					l_int32 := l_int32 + h |<< ((i + (i & 1) |<< 1 - 2) * 4)
					i := i + 1
				end
				($l_real32).memory_copy ($l_int32, 4)
				create {REAL_VALUE_I} l_value.make_real_32 (l_real32)
			elseif a_external_type.is_integer then
				if a_value.item (1) = '-' then
					l_val := a_value.substring (2, a_value.count)
					l_is_negative := True
				else
					l_val := a_value
				end
				create l_int.make_from_string (Void, l_is_negative, l_val)
				l_value := l_int
			elseif a_external_type.is_natural then
				create {INTEGER_CONSTANT} l_value.make_from_type (a_external_type, False, a_value)
			elseif a_external_type.is_boolean then
				a_value.to_lower
				create l_bool_value.make (a_value.is_equal (a_value.True_constant))
				l_value := l_bool_value
			elseif a_external_type.is_character then
				check
					valid_count: a_value.count = 1
				end
				create l_char_value.make (a_value.item (1))
				l_value := l_char_value
			elseif a_external_type.associated_class.lace_class = System.system_string_class then
				create l_string_value.make (a_value, True)
				l_value := l_string_value
			end
			a_constant.set_value (l_value)
		end

	add_syntactical_supplier (cl: CL_TYPE_A) is
			-- Add every class mentioned in `cl' to `syntactical_suppliers' list.
		require
			cl_not_void: cl /= Void
		do
			syntactical_suppliers.force (cl.associated_class)
			if cl.has_generics then
				check
					one_generic_parameter: cl.generics.count = 1
					lower_is_one: cl.generics.lower = 1
					has_class: cl.generics.item (1).associated_class /= Void
				end
				syntactical_suppliers.force (cl.generics.item (1).associated_class)
			end
		ensure
			inserted_class: syntactical_suppliers.has (cl.associated_class)
			inserted_generic_parameter: cl.has_generics implies
				syntactical_suppliers.has (cl.generics.item (1).associated_class)
		end

	prefix_infix_names: PREFIX_INFIX_NAMES is
		once
			create Result
		end

invariant
	il_generation: System.il_generation
	is_external_set: is_external
	is_true_external_set: is_true_external
	valid_enclosing_class: is_nested implies enclosing_class /= Void

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

end -- class EXTERNAL_CLASS_C
