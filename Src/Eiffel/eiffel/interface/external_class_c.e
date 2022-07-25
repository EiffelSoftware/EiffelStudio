note
	description: "Representation of a non-Eiffel compiled class that is external to current system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CLASS_C

inherit
	CONSUMER_EXPORT

	CLASS_C
		rename
			group as assembly
		redefine
			original_class,
			is_true_external,
			is_removable,
			make,
			assembly,
			is_external_class_c,
			external_class_c
		end

	EXCEPTION_MANAGER_FACTORY

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

create
	make

feature {NONE} -- Initialization

	make (l: like original_class)
			-- Create instance of a compiled class using 'l'.
		do
			Precursor {CLASS_C} (l)
			is_external := True
		end

feature -- Initialization

	process_degree_5
			-- Read XML data and analyzes syntactical suppliers.
		require
			not_built: not is_built
		local
			l_ast: CLASS_AS
		do
				-- Initialize `external_class'.
			external_class := lace_class.external_consumed_type
			if external_class = Void and then assembly.is_partially_consumed then
					-- No class, try consume assembly
				fully_consume_assembly

					-- Now try retrieve class.
				external_class := lace_class.external_consumed_type
			end

			if external_class = Void then
					-- For some reasons, the XML file could not be retried.
				error_handler.insert_error (create {VIIC}.make (Current))
			else
				private_external_name := external_class.dotnet_name

					-- This initialization is required as `initialize_from_xml_data'
					-- needs proper information about classes to build correct feature
					-- signature.
				is_deferred := external_class.is_deferred
				is_expanded := external_class.is_expanded
				is_once := False
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
					create {ID_AS}.initialize (name),
					create {STRING_AS}.initialize (external_class.dotnet_name, 0, 0, 0, 0, 0, 0, 0),
					is_deferred,
					is_expanded,
					is_frozen,
					True,	-- is_external
					False,  -- is_partial
					is_once,
					Void,	-- top_indexes
					Void,	-- bottom_indexes
					Void,	-- generics
					Void,	-- conforming parents
					Void,	-- non-conforming parents.
					Void,	-- creators
					Void,	-- convertors
					Void,	-- features
					Void,	-- invariant_part
					create {SUPPLIERS_AS},	-- suppliers
					Void,	-- obsolete_message
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

	process_degree_4
			-- Read XML data and create feature table.
		require
			not_built: not is_built
			external_class_not_void: external_class /= Void
		local
			nb: INTEGER
			l_feat_tbl: like feature_table
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

				-- To store overloaded features.
			create overloaded_names.make (10)

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
				process_property_assigners (l_feat_tbl)
			end
				-- Add features from ANY
			add_features_of_any (l_feat_tbl)
			if is_enum then
				add_enum_conversion (l_feat_tbl)
			end

				-- Clean `overloaded_names' to remove non-overloaded routines.
			clean_overloaded_names (l_feat_tbl)
			l_feat_tbl.set_overloaded_names (overloaded_names)

				-- Building lookup tables for the feature_table.
			l_feat_tbl.compute_lookup_tables

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
			l_feat_tbl.flush
			current_feature_table := l_feat_tbl
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

	is_external_class_c: BOOLEAN = True
			-- Is `Current' an EXTERNAL_CLASS_C?

	external_class_c: EXTERNAL_CLASS_C
			-- `Current' as `EXTERNAL_CLASS_C'.
		do
			Result := Current
		end

	is_built: BOOLEAN
			-- Is Current class built?

	original_class: EXTERNAL_CLASS_I
			-- Original class.

	external_class: CONSUMED_TYPE
			-- Data read from XML file.

	enclosing_class: CLASS_C
			-- Class in which Current class is defined when `is_nested'.

	assembly: ASSEMBLY_I
			-- Associated assembly of current.
		do
			Result := lace_class.assembly
		end

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
			-- Given an external type `c' get its associated CL_TYPE_A.
			-- Void, if `c' is not part of system.
		require
			c_not_void: c /= Void
		do
			Result := internal_type_from_consumed_type (False, c)
		end

feature {NONE} -- Implementation: Overloading

	overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			-- Hash_table of overloaded features.
			-- The key corresponds to overloaded feature name id, and for each entry it gives a
			-- list of associated resolved feature name id. (e.g. for `put' you will possibly
			-- find `put_integer', `put_double',...)

	clean_overloaded_names (a_feat_tbl: FEATURE_TABLE)
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

	updated_overloaded_list (a_feat_tbl: FEATURE_TABLE; a_list: ARRAYED_LIST [INTEGER]): ARRAYED_LIST [INTEGER]
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
				create l_processed.make_filled (False, nb + 1)
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

	is_true_external: BOOLEAN = True
			-- Is class an instance of EXTERNAL_CLASS_C?
			-- If yes, we do not generate it.

	is_removable: BOOLEAN = False
			-- FIXME: Manu 08/07/2002: because of the way we initialize
			-- EXTERNAL_CLASS_C from the XML, we are missing some information
			-- that will generate incorrect VHPR error when removing an external
			-- class from the system. Therefore, we never remove EXTERNAL_CLASS_C
			-- from the system after they have been added.

feature -- Query

	has_associated_property_setter (a_feat: FEATURE_I): BOOLEAN
			-- Associated property setter of `a_feat' if any.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_is_function: a_feat.is_function
			a_feat_is_external: a_feat.is_external
		local
			l_consumed_type: CONSUMED_TYPE
			l_properties: ARRAYED_LIST [CONSUMED_PROPERTY]
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
					i := 1
					nb := l_properties.count
				until
					i > nb or done
				loop
					if
						attached l_properties [i] as l_prop and then
						l_prop.getter.eiffel_name.is_equal (a_feat.feature_name)
					then
						done := True
						Result := l_prop.setter /= Void
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Initialization

	process_parents
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

			create conforming_parents_classes.make (nb)
			create conforming_parents.make (nb)

			if external_class.parent /= Void then
				parent_type := internal_type_from_consumed_type (True, external_class.parent)
				parent_class := parent_type.base_class
				conforming_parents.extend (parent_type)
				conforming_parents_classes.extend (parent_class)
				parent_class.add_descendant (Current)
				add_syntactical_supplier (parent_type)
			elseif external_class.is_interface then
					-- Force inheritance to `System.Object' for interfaces.
				is_interface := True
				parent_class := System.system_object_class.compiled_class
				parent_type := parent_class.actual_type
				conforming_parents.extend (parent_type)
				conforming_parents_classes.extend (parent_class)
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
						parent_class := parent_type.base_class
						conforming_parents.extend (parent_type)
						conforming_parents_classes.extend (parent_class)
						parent_class.add_descendant (Current)
						add_syntactical_supplier (parent_type)
					end
					external_class.interfaces.forth
				end
			end

			if class_id = System.system_object_id then
					-- Add ANY as a parent class of SYSTEM_OBJECT, and therefore
					-- of all .NET classes
				parent_class := any_type.base_class
				conforming_parents.extend (any_type)
				conforming_parents_classes.extend (parent_class)
				parent_class.add_descendant (Current)
				add_syntactical_supplier (any_type)
			end
		ensure
			conforming_parents_not_void: conforming_parents /= Void
			conforming_parents_filled:
				Current /= System.system_object_class.compiled_class
					implies conforming_parents.count > 0
			conforming_parents_classes_not_void: conforming_parents_classes /= Void
			conformgin_parents_classes_filled:
				Current /= System.system_object_class.compiled_class
					implies conforming_parents_classes.count > 0
		end

	process_syntax_features (a_features: ARRAYED_LIST [CONSUMED_ENTITY])
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
				add_syntactical_supplier (l_external_type)

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
						l_external_type := internal_type_from_consumed_type (True, l_args.item (j).type)
						add_syntactical_supplier (l_external_type)
						l := l + 1
						j := j + 1
					end
				end
				a_features.forth
			end
		end

	add_features_of_any (a_feat_tbl: like feature_table)
			-- Get all features of ANY and add them in `a_feat_tbl'.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			any_compiled: system.any_class.is_compiled
			any_has_feature_table: system.any_class.compiled_class.has_feature_table
		local
			l_any_tbl: like feature_table
			l_feat, l_table_feat: FEATURE_I
			any_parent_type: LIKE_CURRENT
			is_type_checking_required: BOOLEAN
		do
			l_any_tbl := system.any_class.compiled_class.feature_table
			if lace_class.is_attached_by_default then
				create any_parent_type.make (any_type_attached)
			else
				create any_parent_type.make (any_type)
			end
			check
				l_any_tbl_not_void: l_any_tbl /= Void
			end

				-- Make sure context is initialized for `a_feat_tbl' before calling check_types on the feature_i objects.
			ast_context.initialize (a_feat_tbl.associated_class, a_feat_tbl.associated_class.actual_type)

			from
				l_any_tbl.start
			until
				l_any_tbl.after
			loop
					-- Update `l_feat' in context of current class.
				l_table_feat := l_any_tbl.item_for_iteration
				if l_table_feat.is_type_evaluation_delayed then
						-- Make a clone of the current feature that will be updated later.
					l_feat := l_table_feat.twin
						-- Register update action.
					degree_4.put_action (
						agent (destination: FEATURE_I; source: FEATURE_I; instantiation_type: TYPE_A)
							local
								i: FEATURE_I
							do
								i := source.instantiated (instantiation_type)
								destination.set_type (i.type, destination.assigner_name_id)
								destination.set_arguments (i.arguments)
								destination.set_pattern_id (i.pattern_id)
							end
						(l_feat, l_table_feat, any_parent_type)
					)
				else
					l_feat := l_table_feat.instantiated (any_parent_type)
				end

				is_type_checking_required := True
				if l_feat = l_table_feat then
						-- If the instantiation didn't return a new object then we twin.
					l_feat := l_feat.twin
						-- We only need to check types should feature be instantiated for `Current'.
					is_type_checking_required := False
				end
				l_feat.set_feature_id (feature_id_counter.next)
				l_feat.set_is_origin (False)
				l_feat.set_rout_id_set (l_feat.rout_id_set.twin)

					-- Insert modified `l_feat' in current feature table.
				insert_feature (l_feat, a_feat_tbl)

					-- Check types after insertion since we do not know if the feature
					-- type checks will be delayed or not and when this decision is made
					-- the feature has to be registered already.
				if is_type_checking_required then
					l_feat.delayed_check_types (a_feat_tbl)
				end

				l_any_tbl.forth
			end
		end

	insert_feature (a_feat: FEATURE_I; a_feat_tbl: like feature_table)
			-- Insert `a_feat' into `a_feat_tbl'. If there is a name conflict with
			-- a routine already there, we rename the version from ANY.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
		local
			i: INTEGER
			l_base_name, l_new_name, l_feat_name: STRING
		do

				-- In case we have a coneflict (mostly due to a routine of ANY)
				-- we will rename the new feature `xxx' into `written_class_xxx'
				-- where `written_class' is the name of the class where `a_feat'
				-- is written.
			if a_feat_tbl.has_id (a_feat.feature_name_id) then
				l_new_name := a_feat.written_class.name.as_lower
				l_feat_name  := a_feat.feature_name
				create l_base_name.make (l_new_name.count + 1 + l_feat_name.count)
				l_base_name.append (l_new_name)
				l_base_name.append_character ('_')
				l_base_name.append (l_feat_name)
				a_feat.set_feature_name (l_base_name)
				from
					i := 1
				until
					not a_feat_tbl.has_id (a_feat.feature_name_id)
				loop
					l_new_name := l_base_name.twin
					l_new_name.append_character ('_')
					l_new_name.append_integer (i)
					a_feat.set_feature_name (l_new_name)
					i := i + 1
				end
			end

			a_feat_tbl.put (a_feat, a_feat.feature_name_id, False)
		end

	process_features (a_feat_tbl: like feature_table; a_features: ARRAYED_LIST [CONSUMED_ENTITY])
			-- Get all features and make sure all referenced types are in system.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_features_not_void: a_features /= Void
		local
			l_member: CONSUMED_ENTITY
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
			l_name_id: INTEGER
			l_underlying_enum_type: STRING
			l_enum_member: CONSUMED_ENTITY
			l_enum_value: INTEGER_CONSTANT
			l_changed: BOOLEAN
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
						if attached {CONSUMED_LITERAL_FIELD} l_member as l_literal_field then
							l_literal := l_literal_field
						else
							check is_literal_filed: False end
							l_literal := Void
						end
						if l_return_type.base_class.is_enum then
								-- Too bad here we just discarded newly created extension
								-- object `l_ext', but that simpler this way.
							create l_enum_ext
							l_ext := l_enum_ext
							if l_return_type.base_class = Current then
								create l_constant.make
								l_constant.set_extension (l_ext)
								l_feat := l_constant
							else
								create {EXTERNAL_FUNC_I} l_external.make (l_ext)
								l_feat := l_external
							end
						else
							create l_constant.make
							l_feat := l_constant
						end
					else
						create l_attribute.make
						l_attribute.set_extension (l_ext)
						l_feat := l_attribute
					end
				elseif l_member.is_deferred then
					if l_member.has_return_value then
						create {DEF_FUNC_I} l_deferred
					else
						create {DEF_PROC_I} l_deferred
					end
					l_deferred.set_extension (l_ext)
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

					-- Check if this is a constructor
				if attached {CONSUMED_CONSTRUCTOR} l_member as l_construct then
					l_constructor := l_construct
				else
					l_constructor := Void
				end

				if l_member.is_static then
					if l_member.is_attribute then
						if l_member.is_literal and l_return_type.base_class.is_enum then
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
				if
					attached {CONSUMED_MEMBER} l_member as l_consumed_member and then
					l_consumed_member.is_attribute_setter
				then
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
					check l_literal_attached: l_literal /= Void end
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
						create l_arg_ids.make_filled (0, 1, k - j + 1)
					until
						j > k
					loop
						l_arg := l_args.item (j)
						if j >= l_record_pos then
							l_external_type := internal_type_from_consumed_type (True,
								l_arg.type)
							l_names_heap.put (l_arg.eiffel_name)
							l_feat_arg.extend_with_name (l_external_type, l_names_heap.found_item)
							m := m + 1
						end

						l_names_heap.put (l_arg.type.name)
						l_arg_ids.put (l_names_heap.found_item, l + 1)

						l := l + 1
						j := j + 1
					end
					l_ext.set_argument_types (l_arg_ids)
					if attached {PROCEDURE_I} l_feat as l_proc then
						l_proc.set_arguments (l_feat_arg)
					else
						check is_procedure: False end
					end
				end

				l_feat.set_is_frozen (l_member.is_frozen)
				if l_member.is_prefix then
						-- Set both feature name and alias name.
					names_heap.put (Prefix_infix_names.prefix_feature_name_with_symbol (l_member.eiffel_name))
					l_name_id := names_heap.found_item
					names_heap.put (l_member.eiffel_name)
					l_feat.set_feature_name_id (l_name_id, create {like {FEATURE_I}.alias_name_ids}.make_filled
						({OPERATOR_KIND}.alias_id
							(names_heap.found_item,
							{OPERATOR_KIND}.is_valid_unary_kind_mask ⦶ {OPERATOR_KIND}.is_unary_kind_mask),
						1))
						-- Set feature flags.
					l_feat.set_is_prefix (True)
					l_feat.set_is_unary (True)
				elseif l_member.is_infix then
						-- Set both feature name and alias name
					names_heap.put (Prefix_infix_names.infix_feature_name_with_symbol (l_member.eiffel_name))
					l_name_id := names_heap.found_item
					names_heap.put (l_member.eiffel_name)
					l_feat.set_feature_name_id (l_name_id, create {like {FEATURE_I}.alias_name_ids}.make_filled
						({OPERATOR_KIND}.alias_id
							(names_heap.found_item,
							{OPERATOR_KIND}.is_valid_binary_kind_mask ⦶ {OPERATOR_KIND}.is_binary_kind_mask),
						1))
						-- Set feature flags.
					l_feat.set_is_infix (True)
					l_feat.set_is_binary (True)
				else
					l_feat.set_feature_name (l_member.eiffel_name)
				end
				l_feat.set_feature_id (feature_id_counter.next)

				l_written_type := internal_type_from_consumed_type (True, l_member.declared_type)
				l_feat.set_written_in (l_written_type.class_id)

					-- Add creation routine to `creators' if any.
				if attached l_constructor then
						-- Special case for value type where creation routines
						-- are simply generated as normal feature and cannot be used
						-- as creation procedure because usually there are more
						-- than one possible creation routine and this is forbidden
						-- by Eiffel specification on expanded.
					l_creators.put (l_all_export, names_heap.id_of (l_member.eiffel_name))
					if external_class.is_expanded then
						l_feat.set_export_status (l_all_export)
					else
						l_feat.set_export_status (l_none_export)
					end
				else
					if l_member.is_public then
						l_feat.set_export_status (l_all_export)
					else
							-- It is not exported but consumed, it means it is only
							-- available to descendants in unqualified and qualified calls.
						l_feat.set_export_status (new_family_export (l_written_type.class_id))
					end
				end

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
					l_changed := changed
						-- If not marked as changed, then do so to satisfy `update_instantiator2' precondition.
					if not l_changed then
						set_changed (True)
					end
					l_feat.update_instantiator2 (Current)
					if not l_changed then
							-- Reset changed status.
						set_changed (False)
					end
				end

				l_names_heap.put (l_member.dotnet_eiffel_name)
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

	process_property_assigners (a_feat_tbl: like feature_table)
			-- Processes current feature table `feature_table' and matches
			-- property functions (getters) with an assigner (setter), if available.
		require
			a_feat_tbl_attached: a_feat_tbl /= Void
		local
			l_class: like external_class
			l_properties: ARRAYED_LIST [CONSUMED_PROPERTY]
			l_property: CONSUMED_PROPERTY
			l_fields: ARRAYED_LIST [CONSUMED_FIELD]
			l_getter, l_setter: CONSUMED_ENTITY
			l_extrn_func_i: EXTERNAL_FUNC_I
			l_def_func_i: DEF_FUNC_I
			l_feat_i: FEATURE_I
			l_inherited: ARRAYED_LIST [CONSUMED_ENTITY]
			l_setter_name: STRING
		do
			l_class := external_class
			l_inherited := l_class.inherited_entities
			l_properties := l_class.properties
			from
				l_properties.start
			until
				l_properties.after
			loop
				l_property := l_properties.item
				if l_property /= Void  then
					l_setter := l_property.setter
						-- Only setters with one argument can be used as assigner commands
						-- because order of arguments in setters and assigner commands is
						-- opposite.
					if l_setter /= Void and then l_setter.arguments.count = 1 then
						l_getter := l_property.getter
						if l_getter /= Void then
							l_feat_i := a_feat_tbl.item (l_getter.eiffel_name)
							l_extrn_func_i := Void
							l_def_func_i := Void

							if attached {EXTERNAL_FUNC_I} l_feat_i as l_external_func_i  then
								l_extrn_func_i := l_external_func_i
							elseif attached {DEF_FUNC_I} l_feat_i as l_def_function_i then
								l_def_func_i := l_def_function_i
							end
							check func_attached: l_extrn_func_i /= Void or l_def_func_i /= Void end

							l_setter_name := l_setter.eiffel_name
							if
								attached l_inherited and then
								l_inherited.has (l_property) and then
								attached l_feat_i.written_class.feature_named (l_getter.eiffel_name) as l_feat and then
								attached l_feat.assigner_name
							then
									-- property is inherited so use inherit setter name (fixes test#dotnet043)
								l_setter_name := l_feat.assigner_name
							end
							check l_setter_name_attached: l_setter_name /= Void end
							l_feat_i := a_feat_tbl.item (l_setter_name)
							if l_feat_i /= Void then
								if l_extrn_func_i /= Void then
									l_extrn_func_i.set_type (l_extrn_func_i.type, l_feat_i.feature_name_id)
								elseif l_def_func_i /= Void then
									l_def_func_i.set_type (l_def_func_i.type, l_feat_i.feature_name_id)
								end
							else
								check has_feature_setter: False end
							end
						end
					end
				end
				l_properties.forth
			end

			l_fields := l_class.fields
			if l_fields.count > 0 then
				from
					l_fields.start
				until
					l_fields.after
				loop
					l_getter := l_fields.item
					if l_getter /= Void and then not l_inherited.has (l_getter) then
						l_setter := l_fields.item.setter
						if l_setter /= Void then
							if
								attached {ATTRIBUTE_I} a_feat_tbl.item (l_getter.eiffel_name) as l_attr_i and
								attached a_feat_tbl.item (l_setter.eiffel_name) as l_feat
							then
								l_attr_i.set_type (l_attr_i.type, l_feat.feature_name_id)
							else
								check
									getter_is_attribute_i: False
									setter_is_feature_i: False
								end
							end
						end
					end
					l_fields.forth
				end
			end
		end

	add_enum_conversion (a_feat_tbl: like feature_table)
			-- Binds a conversion routine to an Enum type for artifical `to_integer' feature.
		require
			is_enum: is_enum
			a_feat_tbl_attached: a_feat_tbl /= Void
			convert_to_unattached: convert_to = Void
		do
			if attached a_feat_tbl.item_id ({NAMES_HEAP}.to_integer_name_id) as l_feat then
				if attached {DEANCHORED_TYPE_A} l_feat.type as l_type then
					check
						l_type_is_integer_or_natural: l_type.is_integer or l_type.is_natural
					end
					create {HASH_TABLE_EX [INTEGER, DEANCHORED_TYPE_A]} convert_to.make_with_key_tester (1, create {CONVERTIBILITY_CHECKER})
					convert_to.force ({NAMES_HEAP}.to_integer_name_id, l_type)
				else
					check is_deanchored_type_a: False end
				end
			else
				check has_item_id: False end
			end
		end

	process_nesting
			-- If `external_class' represent an instance of CONSUMED_NESTED_TYPE
			-- we initialize `enclosing_class' correctly.
		require
			external_class_not_void: external_class /= Void
		local
			l_enclosing_type: CL_TYPE_A
		do
			if attached {CONSUMED_NESTED_TYPE} external_class as l_nested then
				l_enclosing_type := internal_type_from_consumed_type (True, l_nested.enclosing_type)
				is_nested := True
				enclosing_class := l_enclosing_type.base_class
				add_syntactical_supplier (l_enclosing_type)
			end
		end

feature {NONE} -- Implementation

	update_feature_with_parents (a_feat_tbl: FEATURE_TABLE; a_feat: FEATURE_I;
			a_member: CONSUMED_ENTITY)

			-- Compute a new `rout_id_set' for `a_feat' based on info of current class and
			-- parent classes. If we do not found a matching routine in a parent class, then
			-- we set `is_origin' on `a_feat'.
			-- Set `written_feature_id'.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_feat_not_void: a_feat /= Void
			a_feat_with_no_rout_id_set: a_feat.rout_id_set = Void
			a_member_not_void: a_member /= Void
		local
			l_rout_id_set: ROUT_ID_SET
			l_feat: FEATURE_I
			l_parents: FIXED_LIST [CL_TYPE_A]
		do
				-- We need to look up parents of current class to find if some routine IDs
				-- have been assigned or not. At this stage `a_feat' contains valid data,
				-- only `rout_id_set' of `a_feat' has not yet been set.
				--
				-- Note: Manu 08/13/2002
				-- In most cases the algorithm below is going to find an inherited
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
					if l_feat.written_in = a_feat.written_in then
							-- Inherited feature is written in same class as `a_feat'
							-- therefore we can safely store inherited `written_feature_id'
							-- into `a_feat'.
						a_feat.set_written_feature_id (l_feat.written_feature_id)
					end
				end
			else
					-- It is virtual, we need to find out from where we are coming.
					-- We first check on all interfaces of current class, and only when
					-- we do not find any matching routine, then we check the main parent.
				from
					l_parents := parents
					l_parents.start
				until
					l_parents.after
				loop
					l_feat := matching_external_feature_in (a_feat,
						l_parents.item.base_class, a_member)
					if l_feat /= Void then
						l_rout_id_set.merge (l_feat.rout_id_set)
						if l_feat.written_in = a_feat.written_in then
								-- Inherited feature is written in same class as `a_feat'
								-- therefore we can safely store inherited `written_feature_id'
								-- into `a_feat'.
							a_feat.set_written_feature_id (l_feat.written_feature_id)
						end
					end
					l_parents.forth
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
					-- Insertion into the system routine info table.				
				System.rout_info_table.put (l_rout_id_set.first, Current);
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
--			not_already_inserted:
--				not a_feat.rout_id_set.linear_representation.there_exists (
--					agent (a_feat_tbl.origin_table).has)
			a_feat_written_feature_id_set: a_feat.written_feature_id /= 0
		end

	matching_external_feature_in (
			a_feat: FEATURE_I; a_class: CLASS_C; a_member: CONSUMED_ENTITY): FEATURE_I

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
		do
			if not attached {IL_EXTENSION_I} a_feat.extension as l_feat_ext then
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
						attached {IL_EXTENSION_I} l_feat.extension as l_other_ext and then
						l_other_ext.alias_name_id = l_feat_ext.alias_name_id and then
						(a_feat.written_class = l_feat.written_class or else not l_feat.is_frozen) and then
							-- We found a routine, let's check that is the right one
							-- by comparing their return type and their arguments type.
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
					l_feat_tbl.forth
				end
			end
		end

	internal_type_from_consumed_type (
			force_compilation: BOOLEAN; c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A

			-- Given an external type `c' get its associated CL_TYPE_A.
			-- If `force_compilation' automatically add it for later compilation
		require
			c_not_void: c /= Void
		local
			l_result: CLASS_I
			l_class: CLASS_C
			l_generics: ARRAYED_LIST [TYPE_A]
			l_type_a: CL_TYPE_A
			vtct: VTCT
			l_type_name: STRING
		do
			if c.is_by_ref then
				l_type_name := c.name.substring (1, c.name.count - 1)
			else
				l_type_name := c.name
			end
			if attached {CONSUMED_ARRAY_TYPE} c as l_array_type then
				l_type_a := internal_type_from_consumed_type (force_compilation, l_array_type.element_type)
				if l_type_a /= Void then
					create l_generics.make (1)
					l_generics.extend (l_type_a)
					create {NATIVE_ARRAY_TYPE_A} Result.make (
						System.native_array_class.compiled_class.class_id, l_generics)
				end
			else
				if attached {CLASS_I} assembly.class_by_dotnet_name (l_type_name, c.assembly_id) as l_class_i then
					l_result := l_class_i
				else
						-- Case where this is a class from `mscorlib' that is in fact
						-- written as an Eiffel class, e.g. INTEGER, ....
					l_result := lace_class.basic_type_mapping.item (l_type_name)
				end

				if l_result = Void then
						-- Type could not be found. Something must be inconsistent in
						-- this assembly.
					create vtct
					vtct.set_class (Current)
					vtct.set_dotnet_class_name (l_type_name)
					Error_handler.insert_error (vtct)
				else
					if force_compilation and then not l_result.is_compiled then
						Workbench.add_class_to_recompile (l_result)
					end
					if l_result.is_compiled then
						l_class := l_result.compiled_class
						debug
							to_implement ("Initialize actual_type only once to avoid multiple object creation.")
						end
						l_class.initialize_actual_type
						Result := l_class.actual_type
					end
				end
			end
				-- If there is no error we can go on.
			if vtct = Void then
				if not Result.is_expanded then
					Result := Result.duplicate
					Result.set_detachable_mark
				end
				if c.is_by_ref then
						-- We need to create an instance of TYPED_POINTER here.
					create {TYPED_POINTER_A} Result.make_typed (Result)
				end
			end
		end

	set_constant_value (a_constant: CONSTANT_I; a_external_type: CL_TYPE_A; a_value: STRING)
			-- Set `value' of `a_constant' with data of `a_value' using `a_external_type'
			-- to find out type of constant.
		require
			a_constant_not_void: a_constant /= Void
			a_external_type_not_void: a_external_type /= Void
			a_value_not_void: a_value /= Void and then not a_value.is_empty
		local
			l_val: like a_value
			l_is_negative: BOOLEAN
			l_value: VALUE_I
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
				variant
					n - i + 1
				end
				($l_real64).memory_copy ($l_int64, 8)
				create {REAL_VALUE_I} l_value.make (l_real64, True)
			elseif a_external_type.is_real_32 then
					-- Read hexadecimal representation in little-endian byte order
				from
					n := a_value.count.min (8)
					i := 1
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
				variant
					n - i + 1
				end
				($l_real32).memory_copy ($l_int32, 4)
				create {REAL_VALUE_I} l_value.make (l_real32, False)
			elseif a_external_type.is_integer or a_external_type.is_enum then
				if a_value.item (1) = '-' then
					l_val := a_value.substring (2, a_value.count)
					l_is_negative := True
				else
					l_val := a_value
				end
				create {INTEGER_CONSTANT} l_value.make_from_string (Void, l_is_negative, l_val)
			elseif a_external_type.is_natural then
				create {INTEGER_CONSTANT} l_value.make_from_type (a_external_type, False, a_value)
			elseif a_external_type.is_boolean then
				create {BOOL_VALUE_I} l_value.make (a_value.is_case_insensitive_equal (a_value.true_constant))
			elseif a_external_type.is_character then
				check
					valid_count: a_value.count = 1
				end
				create {CHAR_VALUE_I} l_value.make_character_8 (a_value.item (1))
			elseif a_external_type.base_class.original_class = System.system_string_class then
				create {STRING_VALUE_I} l_value.make (a_value, True)
			end
			a_constant.set_value (l_value)
		end

	add_syntactical_supplier (cl: CL_TYPE_A)
			-- Add every class mentioned in `cl' to `syntactical_suppliers' list.
		do
			if cl /= Void then
				syntactical_suppliers.force (cl.base_class)
				if cl.has_generics then
					check
						one_generic_parameter: cl.generics.count = 1
						lower_is_one: cl.generics.lower = 1
						has_class: cl.generics.first.base_class /= Void
					end
					syntactical_suppliers.force (cl.generics.first.base_class)
				end
			end
		ensure
			inserted_class: cl /= Void implies syntactical_suppliers.has (cl.base_class)
			inserted_generic_parameter: (cl /= Void and then cl.has_generics) implies
				syntactical_suppliers.has (cl.generics.first.base_class)
		end

	prefix_infix_names: PREFIX_INFIX_NAMES
		once
			create Result
		end

	new_emitter (a_manager: CONF_CONSUMER_MANAGER): detachable CONSUMER
			-- If there is an error generated by `a_manager' while trying to get the emitter
			-- we catch that error and wrap it into a compiler error before sending it back.
			-- If it is an unknown exception we let it go through.
		require
			a_manager_attached: a_manager /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := a_manager.consumer
			else
				error_handler.insert_error (create {VD71}.make (a_manager.last_error))
				error_handler.raise_error
			end
		rescue
			if not retried and then attached {CONF_EXCEPTION} exception_manager.last_exception.original as lt_ex then
				retried := True
				retry
			end
		end

	fully_consume_assembly
			-- Fully consumes external class' assembly
		require
			assembly_attached: assembly /= Void
		local
			l_emitter: CONSUMER
			l_man: CONF_CONSUMER_MANAGER
			l_assemblies: STRING_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE]
			l_path: STRING_32
		do
				-- Create message
			degree_output.put_string ({STRING_32} "   Consuming assembly '" + assembly.location.evaluated_path.name + "'...")

			l_assemblies := universe.conf_system.all_assemblies
			if l_assemblies /= Void then
				create l_path.make (256)
					-- Note: All system assemblies are required because they are needed by the consumer
					-- to resolve dependencies.
				from l_assemblies.start until l_assemblies.after loop
					if attached {CONF_PHYSICAL_ASSEMBLY} l_assemblies.item_for_iteration as l_assembly then
						if not l_assembly.is_dependency then
							l_path.append_character (';')
							l_path.append (l_assembly.consumed_assembly.location.name)
						end
					else
						check is_physical_assembly: False end
					end
					l_assemblies.forth
				end
				if not l_path.is_empty then
					create l_man.make (create {CONF_COMP_FACTORY}, create {PATH}.make_from_string (system.metadata_cache_path), system.clr_runtime_version, assembly.target,  create {SEARCH_TABLE [CONF_CLASS]}.make (0), create {SEARCH_TABLE [CONF_CLASS]}.make (0), create {SEARCH_TABLE [CONF_CLASS]}.make (0))
					l_emitter := new_emitter (l_man)
					if l_emitter.is_available and then l_emitter.is_initialized then
						l_emitter.consume_assembly_from_path (assembly.consumed_assembly.location.name, False, l_path)
						l_man.rebuild_assembly (assembly)
						l_emitter.release
					end
				end
			end
		ensure
			not_assembly_is_partially_consumed: not assembly.is_partially_consumed
		end

	new_family_export (written_in: INTEGER): EXPORT_SET_I
			-- New export clause to
		local
			l_clients: ID_LIST
			l_names_heap: like names_heap
		do
			create l_clients.make
			l_names_heap := names_heap
			l_names_heap.put (system.class_of_id (written_in).name)
			l_clients.extend (l_names_heap.found_item)
			create Result.make (create {CLIENT_I}.make (l_clients, written_in))
		ensure
			Result_not_void: Result /= Void
		end

invariant
	il_generation: System.il_generation
	is_external_set: is_external
	is_true_external_set: is_true_external
	valid_enclosing_class: is_nested implies enclosing_class /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
