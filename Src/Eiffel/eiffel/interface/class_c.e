indexing
	description: "Representation of a compiled class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CLASS_C

inherit
	SHARED_COUNTER

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

	SHARED_TYPEID_TABLE

	SHARED_CODE_FILES

	SHARED_BODY_ID

	SHARED_EIFFEL_PARSER

	HASHABLE

	SK_CONST

	COMPILER_EXPORTER

	SHARED_GENERATION

	COMPARABLE
		undefine
			is_equal
		end

	PROJECT_CONTEXT

	SHARED_WORKBENCH

	SHARED_DEGREES
		export
			{ANY} Degree_1
		end

	SHARED_EIFFEL_PROJECT

	SHARED_SERVER
		export
			{ANY} all
		end

	SHARED_INSTANTIATOR

	SHARED_INST_CONTEXT

	SHARED_ERROR_HANDLER

	SHARED_RESCUE_STATUS

	SHARED_TEXT_ITEMS

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	ABSTRACT_CLASS_C

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (l: like original_class) is
			-- Creation of Current class
		require
			good_argument: l /= Void
		do
			initialize (l)
				-- Creation of the syntactical supplier list
			create syntactical_suppliers.make (5)
				-- Creation of the syntactical client list
			create syntactical_clients.make (10)
				-- Filter list creation
			create filters.make
				-- Feature id counter creation
			create feature_id_counter
				-- Changed features list creation
			create changed_features.make (20)
				-- Propagator set creation
			create propagators.make

			internal_feature_table_file_id := -1
		end

feature -- Access

	is_eiffel_class_c: BOOLEAN is
			-- Is `Current' an EIFFEL_CLASS_C?
		do
		end

	is_external_class_c: BOOLEAN is
			-- Is `Current' an EXTERNAL_CLASS_C?
		do
		end

	is_valid_formal_position (a_formal_position: INTEGER): BOOLEAN
			-- Is `a_formal_position' a valid formal position for this class?
			--
			-- `a_formal_position' is the position index which has to be checked.
		require
			is_generic: is_generic
		do
			Result := a_formal_position >= 1 and then a_formal_position <= generics.count
		ensure
			Result_set: Result = (a_formal_position >= 1 and then a_formal_position <= generics.count)
		end

	eiffel_class_c: EIFFEL_CLASS_C is
			-- `Current' as `EIFFEL_CLASS_C'.
		require
			is_eiffel_class_c: is_eiffel_class_c
		do
		end

	external_class_c: EXTERNAL_CLASS_C is
			-- `Current' as `EXTERNAL_CLASS_C'.
		require
			is_external_class_c: is_external_class_c
		do
		end

	syntactical_suppliers: ARRAYED_LIST [CLASS_C]
			-- Syntactical suppliers of the class
			--| Useful for time-stamp

	syntactical_clients: ARRAYED_LIST [CLASS_C]
			-- Syntactical clients of the class
			--| Useful for class removal

	changed2: BOOLEAN
			-- Has the compiler to apply the second pass to this class
			-- again, even if the class didn't textually changed
			-- (i.e `changed' is set to False) ?

	changed3: BOOLEAN is
			-- Has the compiler to make a type check on the class ?
			-- At beginning of the third pass, if the class is marked
			-- `changed', the compiler produces byte code and type check
			-- the features marked `melted' and type check the others
			-- if the class is marked `changed3'.
		do
			Result := propagators.make_pass3 or need_type_check
		end

	changed3a : BOOLEAN
			-- Type check?

	need_type_check: BOOLEAN
			-- Does current needs a complete type check?
			-- If True, forces a complete type check in `pass3' on all features
			-- written in current class.

	changed4: BOOLEAN
			-- Has the class a new class type, or changed its generics?

	is_generic: BOOLEAN is
			-- Is current class generic?
		do
			Result := generics /= Void
		ensure
			result_is_generic: Result implies (generics /= Void)
		end

	is_removable: BOOLEAN is
			-- May current class be removed from system?
		do
				-- It should not be precompiled, nor already removed from system.
			Result := not is_precompiled and is_eiffel_class_c
		end

	is_in_system: BOOLEAN
			-- Is current class part of system (i.e. precompiled and used)?

	is_modifiable: BOOLEAN is
			-- Is current class not part of a precompiled library?
		do
			Result := not is_precompiled
		end

	is_debuggable: BOOLEAN is
			-- Is the class able to be debugged?
			-- (not if it doesn't have class types)
		do
			Result := has_types
		end

	has_expanded: BOOLEAN
			-- Does the class use expanded ?

	is_used_as_expanded: BOOLEAN
			-- Is `Current' used as an expanded class ?

	is_special: BOOLEAN is
			-- Is class SPECIAL?
		do
			-- Do nothing
		end

	is_tuple: BOOLEAN is
			-- Is class TUPLE?
		do

		end

	is_typed_pointer: BOOLEAN is
			-- Is class TYPED_POINTER?
		do
		end

	is_native_array: BOOLEAN is
			-- Is class a NATIVE_ARRAY class?
		do
		end

	conformance_table: PACKED_BOOLEANS
			-- Conformance table of the class: once a class has changed
			-- it must be reprocessed and the conformance table of the
			-- recursive descendants also.

	filters: FILTER_LIST 	-- ## FIXME 2.3 Patch: redefinition of equal in
							-- GEN_TYPE_A
			-- Filters associated to the class: useful for recalculating
			-- the type system: it is empty if the class is a non-generic
			-- one.

	feature_id_counter: COUNTER
			-- Counter of feature ids

	has_unique: BOOLEAN
			-- Does class have unique feature(s)?

	changed_features: SEARCH_TABLE [INTEGER]
			-- Names of the changed features

	propagators: PASS3_CONTROL
			-- Set of class ids of the classes responsible for
			-- a type check of the current class

	creators: HASH_TABLE [EXPORT_I, STRING]
			-- Creation procedure names

	creation_feature: FEATURE_I
			-- Creation feature for expanded types

	melted_set: SEARCH_TABLE [MELTED_INFO]
			-- Melting information list
			-- [Processed by the third pass.]

	skeleton: GENERIC_SKELETON
			-- Attributes skeleton

	changed: BOOLEAN is
			-- Is the class syntactically changed ?
		do
			Result := original_class.changed
		end

	already_compiled: BOOLEAN is
			-- Has the class already been compiled before the current
			-- compilation ?
		do
			Result := Ast_server.has (class_id)
		end

	assembly_info: ASSEMBLY_INFO
			-- Information about assembly in which current class is being generated

feature -- Access: Convertibility

	convert_to: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
			-- Set of feature name IDs indexed by type to which they convert to.

	convert_from: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
			-- Set of feature name IDs indexed by type to which they convert from.

feature -- Access: CLI implementation

	class_interface: CLASS_INTERFACE
			-- CLI corresponding interface of Current class.

feature -- Status report

	is_warning_enabled (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' set for Current?
		require
			a_warning_not_void: a_warning /= Void
		do
			Result := lace_class.options.is_warning_enabled (a_warning)
		end

	apply_msil_application_optimizations: BOOLEAN is
			-- Should MSIL application optimizations be applied?
		do
			Result := False
		end

	has_external_ancestor_class: BOOLEAN is
			-- Does current class have an external ancestor which is a class (not interface)?
		local
			p: like parents_classes
			parent_class: CLASS_C
		do
			p := parents_classes
			if p /= Void then
				from
					p.start
				until
					p.after
				loop
					parent_class := p.item
					if
						not parent_class.is_interface and then
						(parent_class.is_external or else parent_class.has_external_ancestor_class)
					then
						Result := True
						p.finish
					end
					p.forth
				end
			end
		end

feature -- Action

	record_precompiled_class_in_system is
		do
		end

feature -- Conformance dependencies

	conf_dep_table: PACKED_BOOLEANS
			-- Table for quick lookup

	conf_dep_classes : LINKED_LIST [CLASS_C]
			-- Classes which depend on Current's conformance
			-- to some other class.

	add_dep_class (a_class : CLASS_C) is
			-- Add `a_class' to `conf_dep_classes'
			-- Do nothing if already there.
		require
			not_void : a_class /= Void
		local
			topid: INTEGER
			loc_list: LINKED_LIST [CLASS_C]
			loc_tab: PACKED_BOOLEANS
		do
			topid := a_class.topological_id

			if conf_dep_table = Void then
				create conf_dep_table.make (topid + 32)

				if conf_dep_classes /= Void then
					-- Topological ids have changed
					-- Recreate lookup table

					from
						loc_list := conf_dep_classes
						loc_tab := conf_dep_table
						loc_list.start
					until
						loc_list.after
					loop
						loc_tab.force (True, loc_list.item.topological_id)
						loc_list.forth
					end
				end
			end

			if conf_dep_classes = Void then
				create conf_dep_classes.make
				create conf_dep_table.make (topid + 32)
			end

			loc_list := conf_dep_classes
			loc_tab := conf_dep_table

			if topid > loc_tab.upper then
					-- Table needs resizing
				loc_tab.resize (topid + 32)
			end

			if not loc_tab.item (topid) then
				loc_list.extend (a_class)
				loc_list.finish
				loc_tab.put (True, topid)
			end
		ensure
			has_dep_class : has_dep_class (a_class)
		end

	remove_dep_class (a_class : CLASS_C) is
			-- Remove `a_class' from `conf_dep_classes'
		require
			not_void : a_class /= Void
			has: has_dep_class (a_class)
		do
			conf_dep_classes.start
			conf_dep_classes.prune (a_class)
			conf_dep_table.put (False, a_class.topological_id)
		ensure
			removed : not has_dep_class (a_class)
		end

	has_dep_class (a_class: CLASS_C): BOOLEAN is
			-- Is `a_class' in `conf_dep_classes'?
		require
			not_void : a_class /= Void
		local
			topid: INTEGER
			loc_tab: PACKED_BOOLEANS
		do
			topid := a_class.topological_id
			loc_tab := conf_dep_table

			Result := (loc_tab /= Void)
					and then (topid <= loc_tab.upper)
					and then loc_tab.item (topid)
		end

	reset_dep_classes is
			-- Update `conf_dep_classes' with removed classes.
		local
			a_class: CLASS_C
		do
			if conf_dep_classes /= Void then
				from
					conf_dep_classes.start
				until
					conf_dep_classes.after
				loop
					a_class := conf_dep_classes.item
					if System.classes.item (a_class.class_id) = Void then
							-- Class has been removed and we should discard
							-- any previous dependency.
						conf_dep_classes.remove
					else
						conf_dep_classes.forth
					end
				end
			end
		end

feature -- Building conformance table

	fill_conformance_table is
			-- Fill the conformance table. All the class processed
			-- during second pass must see their conformance table
			-- processed/re-processed by this routine.
		require
			topological_id_processed: topological_id > 0
		do
			if conformance_table = Void then
				create conformance_table.make (topological_id)
			else
					-- Resize the table after the topological sort
				conformance_table.clear_all
				conformance_table.resize (topological_id)
			end
			conf_dep_table := Void
			build_conformance_table_of (Current)
		end

	build_conformance_table_of (cl: CLASS_C) is
			-- Build recursively the conformance table of class `cl.
		require
			good_argument: cl /= Void
			topological_id_processed: topological_id > 0
			conformance: topological_id <= cl.topological_id
		local
			i: INTEGER
		do
			if cl.conformance_table.item (topological_id) = False then
					-- The parent has not been inserted yet
				cl.conformance_table.put (True, topological_id)
				from
					i := conforming_parents_classes.count
				until
					i = 0
				loop
					conforming_parents_classes [i].build_conformance_table_of (cl)
					i := i - 1
				end
			end
		end

feature -- Expanded rules validity

	check_expanded is
			-- Check the expanded validity rule.
			-- Pass 2 must be done on all the classes
			-- (the creators must be up to date)
		local
			constraint_types: LIST[RENAMED_TYPE_A [TYPE_A]]
			l_formals: like generic_features
			l_cursor: CURSOR
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
debug ("CHECK_EXPANDED")
io.error.put_string ("Checking expanded for: ")
io.error.put_string (name)
io.error.put_new_line
end
			feature_table.check_expanded

				-- Check validity of all formal generic parameters instantiated
				-- as expanded types.
			l_formals := generic_features
			if l_formals /= Void then
				from
					l_cursor := l_formals.cursor
					l_formals.start
				until
					l_formals.after
				loop
					l_formals.item_for_iteration.check_expanded (Current)
					l_formals.forth
				end
				l_formals.go_to (l_cursor)
				Error_handler.checksum
			end

			if is_generic then
				from
					generics.start
				until
					generics.after
				loop
					l_formal_dec ?= generics.item
					check l_formal_dec_not_void: l_formal_dec /= Void end
					constraint_types := l_formal_dec.constraint_types (Current)
					from
						constraint_types.start
					until
						constraint_types.after
					loop
						if constraint_types.item.type.has_generics then
							System.expanded_checker.check_actual_type (constraint_types.item.type)
						end
						constraint_types.forth
					end
					generics.forth
				end
			end
		end

feature -- Third pass: byte code production and type check

	record_suppliers (feature_i: FEATURE_I; dependances: CLASS_DEPENDANCE) is
			-- Record suppliers of `feature_i' and insert it in `dependances'.
		require
			feature_i_not_void: feature_i /= Void
			dependances_not_void: dependances /= Void
		local
			f_suppliers: FEATURE_DEPENDANCE
			body_index: INTEGER
		do
			body_index := feature_i.body_index
				-- If `body_index' is 0, it means that `feature_i' is declared
				-- in an external class.
			check
				written_in_external_class: body_index = 0 implies
					feature_i.written_class.is_true_external
			end
			if body_index /= 0 then
				if dependances.has (body_index) then
					dependances.remove (body_index)
				end
				create f_suppliers.make
				f_suppliers.set_feature_name_id (feature_i.feature_name_id)
				feature_i.record_suppliers (f_suppliers)
				dependances.put (f_suppliers, body_index)
			end
		ensure
			inserted: feature_i.body_index /= 0 implies dependances.has (feature_i.body_index)
		end

	update_suppliers (new_suppliers: like suppliers) is
			-- Update the supplier list with `new_suppliers'.
		require
			good_argument: new_suppliers /= Void
		local
			local_suppliers: like suppliers
			supplier_clients: ARRAYED_LIST [CLASS_C]
		do
			from
				local_suppliers := suppliers
				local_suppliers.start
			until
				local_suppliers.after
			loop
				supplier_clients := local_suppliers.item.supplier.clients
				supplier_clients.start
				supplier_clients.search (Current)
				supplier_clients.remove
				local_suppliers.forth
			end

			from
				new_suppliers.start
			until
				new_suppliers.after
			loop
				new_suppliers.item.supplier.clients.extend (Current)
				new_suppliers.forth
			end
			set_suppliers (new_suppliers)
		end

feature -- Generation

	pass4 is
			-- Generation of C files for each type associated to the current
			-- class
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		do
		end

feature -- Setting

	set_assembly_info (a: like assembly_info) is
			-- Set `assembly_info' with `a'.
		require
			a_not_void: a /= Void
		do
			assembly_info := a
		ensure
			assembly_info_set: assembly_info = a
		end

feature -- Melting

	melt is
			-- Melt changed features.
		require
			good_context: has_features_to_melt
		do
		end

	update_execution_table is
			-- Update execution table.
		require
			good_context: has_features_to_melt
		do
		end

	has_features_to_melt: BOOLEAN is
			-- Has the current class features to melt ?
		do
		end

	melt_all is
			-- Melt all the features written in the class
		do
		end

feature -- Skeleton processing

	init_process_skeleton (old_skeletons: ARRAY [SKELETON]) is
			-- Fill `old_skeletons' with old skeleton of class types in `types'.
		require
			old_skeletons_not_void: old_skeletons /= Void
			has_skeleton: skeleton /= Void
		local
			class_type: CLASS_TYPE
		do
			from
				types.start
			until
				types.after
			loop
				class_type := types.item
				old_skeletons.force (class_type.skeleton, class_type.type_id)
				types.forth
			end
		end

	process_skeleton (old_skeletons: ARRAY [SKELETON]) is
			-- Type skeleton processing: If skeleton of a class type changed,
			-- it must be re-processed and marked `is_changed'.
		require
			old_skeletons_not_void: old_skeletons /= Void
			has_skeleton: skeleton /= Void
		local
			class_type: CLASS_TYPE
			new_skeleton, old_skeleton: SKELETON
			class_types: SPECIAL [CLASS_TYPE]
			i: INTEGER
			n: INTEGER
			generic_class_type: CLASS_TYPE
		do
			from
				types.start
			until
				types.after
			loop
				class_type := types.item
				old_skeleton := class_type.skeleton
				new_skeleton := skeleton.instantiation_in (class_type)
				if
					old_skeleton = Void
					or else not new_skeleton.equiv (old_skeletons, old_skeleton)
				then
					class_type.set_is_changed (True)
					class_type.set_skeleton (new_skeleton)
					if class_type.is_expanded and old_skeleton /= Void then
							-- Force recompilation of all clients, as the layout of expanded
							-- have changed possibly making some of our generated code incorrect
							-- if the skeleton size have change. Note that we cannot query the size
							-- here in case of VLEC errors that will be find later in the
							-- compilation.
						from
							clients.start
						until
							clients.after
						loop
							clients.item.melt_all
							clients.forth
						end
							-- Recompile generic derivations that depend on `class_type' as
							-- `clients' does not include them.
						from
							class_types := system.class_types
							i := class_types.lower
							n := class_types.upper
						until
							i > n
						loop
							generic_class_type := class_types [i]
							if generic_class_type /= Void and then generic_class_type.type.has_actual (class_type.type) then
								debug ("to_implement")
									to_implement ("Recompilation could be done on a per-class-type rather than per-class basis.")
								end
								generic_class_type.associated_class.melt_all
							end
							i := i + 1
						end
					end
					Degree_1.insert_class (Current)
				end
				types.forth
			end
			changed2 := False
			changed4 := False
		end

feature {NONE} -- Class initialization

	similar_parents
			(a_old_parents, a_new_parents: EIFFEL_LIST [PARENT_AS]): TUPLE [previous_types_remain: BOOLEAN; parents_removed: BOOLEAN]
		is
			-- First element of tuple: Does `a_new_parents' include all types used in
			-- `a_old_parents' and no type has been removed from `a_old_parents'.
			-- Second element of tuple: was a parent type of `a_old_parents' removed from
			-- `a_new_parents'.
		local
			i, o_count, j, l_count: INTEGER
			l_area, o_area: SPECIAL [PARENT_AS]
			l_parent_type, l_other_type: CLASS_TYPE_AS
			l_same_parent, l_removed_parent, l_found: BOOLEAN
		do
			if a_old_parents = Void then
					-- Parents may have changed, but none has been removed.
				Result := [a_new_parents = Void, False]
			elseif a_new_parents /= Void then
				l_area := a_new_parents.area
				o_area := a_old_parents.area
				l_count := a_new_parents.count - 1
				o_count := a_old_parents.count - 1

					-- Check if all types used in new parents clauses were also used in previous
					-- compilation (possibly in different order and with different number of
					-- occurrences)
				from
					check
						i_is_zero: i = 0
					end
					l_same_parent := True
				until
					i > l_count or else not l_same_parent
				loop
					l_parent_type := l_area.item (i).type
					from
						j := 0
						l_same_parent := False
					until
						j > o_count or else l_same_parent
					loop
						l_other_type := o_area.item (j).type
						l_same_parent := l_parent_type.same_type (l_other_type) and then l_parent_type.is_equivalent (l_other_type)
						j := j + 1
					end
					i := i + 1
				end

					-- We need to check that all types of `a_old_parents' are present
					-- in `a_new_parents'.
				from
					check
						l_removed_parent_set: not l_removed_parent
					end
					i := 0
					l_area := a_new_parents.area
					o_area := a_old_parents.area
				until
					i > o_count or else l_removed_parent
				loop
					l_parent_type := o_area.item (i).type
					from
						j := 0
						l_found := False
					until
						j > l_count or else l_found
					loop
						l_other_type := l_area.item (j).type
						l_found := l_parent_type.same_type (l_other_type) and then l_parent_type.is_equivalent (l_other_type)
						j := j + 1
					end
					l_removed_parent := not l_found
					i := i + 1
				end

				Result := [l_same_parent and not l_removed_parent, l_removed_parent]
			else
					-- Case where all parents have been removed, clearly it is not
					-- the same and they have been removed.
				check
					status: a_old_parents /= Void and a_new_parents = Void
				end
				Result := [False, True]
			end
		end

feature -- Class initialization

	init_class_interface is
			-- Initialize `class_interface' accordingly to current class
			-- definition.
		require
			il_generation: System.il_generation
		do
			if class_interface = Void then
				create class_interface.make_with_class (Current)
			end
		end

feature {NONE} -- Private access

	Any_type: CL_TYPE_A is
			-- Default parent type
		once
			create Result.make (System.any_id)
		ensure
			any_type_not_void: Result /= Void
		end

	Any_type_attached: CL_TYPE_A is
			-- Default parent type when it is attached by default
		once
			create Result.make (System.any_id)
			Result.set_is_attached
		ensure
			any_type_not_void: Result /= Void
		end

	Any_parent: PARENT_C is
			-- Default compiled parent
		once
			create Result
			Result.set_parent_type (Any_type)
		ensure
			any_parent_not_void: Result /= Void
		end

feature

	update_syntactical_relations (old_syntactical_suppliers: like syntactical_suppliers) is
			-- Remove syntactical client/supplier relations and take
			-- care of possible removed classes
		local
			a_class: CLASS_C
			supplier_clients: like syntactical_clients
			l_syntactical_suppliers: like syntactical_suppliers
		do
				-- Remove old syntactical supplier/client relations
			from
				old_syntactical_suppliers.start
			until
				old_syntactical_suppliers.off
			loop
				a_class := old_syntactical_suppliers.item
				if a_class /= Current then
					supplier_clients := a_class.syntactical_clients
					supplier_clients.start
					supplier_clients.compare_references
					supplier_clients.search (Current)
					if not supplier_clients.after then
						supplier_clients.remove
					end
				end
				old_syntactical_suppliers.forth
			end
				-- Add new syntactical supplier/client relations
			from
				l_syntactical_suppliers := syntactical_suppliers
				l_syntactical_suppliers.start
			until
				l_syntactical_suppliers.off
			loop
				a_class := l_syntactical_suppliers.item
				if a_class /= Current then
					supplier_clients := a_class.syntactical_clients
					supplier_clients.extend (Current)
				end
				l_syntactical_suppliers.forth
			end
		end

	remove_relations is
			-- Remove client/supplier and parent/descendant relations
			-- of the current class.
		require
			parents_exists: parents_classes /= Void
		local
			local_suppliers: SUPPLIER_LIST
			clients_list: ARRAYED_LIST [CLASS_C]
		do
			remove_parent_relations
			from
				local_suppliers := suppliers
				local_suppliers.start
			until
				local_suppliers.after
			loop
				clients_list := local_suppliers.item.supplier.clients
				clients_list.start
				clients_list.search (Current)
				if not clients_list.after then
					clients_list.remove
				end
				local_suppliers.forth
			end
			local_suppliers.wipe_out
		end

	remove_parent_relations is
			-- Remove parent/descendant relations of the Current class
		require
			parents_exists: parents_classes /= Void
		local
			des: ARRAYED_LIST [CLASS_C]
			l_area: SPECIAL [CLASS_C]
			i, nb: INTEGER
			c: CLASS_C
			l_parents_classes: like parents_classes
		do
			from
				l_parents_classes := parents_classes
				l_area := l_parents_classes.area
				nb := l_parents_classes.count
			until
				i = nb
			loop
				c := l_area.item (i)
				if c /= Void then
					des:= c.direct_descendants
					des.start
					des.search (Current)
					if not des.after then
						des.remove
					end
				end
				i := i + 1
			end
		end

	mark_class (marked_classes: SEARCH_TABLE [INTEGER]) is
			-- Mark the class as used in the system
			-- and propagate to the suppliers
			-- Used by remove_useless_classes in SYSTEM_I
		local
			l_syntactical_suppliers: like syntactical_suppliers
		do
			if not marked_classes.has (class_id) then
				marked_classes.put (class_id)
				from
					l_syntactical_suppliers := syntactical_suppliers
					l_syntactical_suppliers.start
				until
					l_syntactical_suppliers.after
				loop
					l_syntactical_suppliers.item.mark_class (marked_classes)
					l_syntactical_suppliers.forth
				end
			end
		end

	check_generics is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG (page 52)
		require
			generics_exists: is_generic
		do
		end

	check_generic_parameters is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG1 (page 52)
		require
			generics_exists: is_generic
		do
		end

	check_creation_constraint_genericity is
			-- Check validity of creation constraint genericity
			-- I.e. that the specified creation procedures does exist
			-- in the constraint class.
		require
			generics_exists: is_generic
		do
		end

	check_constraint_genericity is
			-- Check validity of constraint genericity
		require
			generics_exists: is_generic
		do
		end

	check_constraint_renaming is
			-- Check validity of renaming
			-- Requires feature tables!!
		do
		end

feature -- Parent checking

	fill_parents (a_old_class_info, a_class_info: CLASS_INFO) is
			-- Initialization of the parent types `parents': put
			-- the default parent HERE if needed. Calculates also the
			-- lists `descendants'. Since the routine `check_suppliers'
			-- has been called before, all the instances of CLASS_C
			-- corresponding to the parents of the current class are
			-- in the system (even if a parent is not already parsed).
		require
			need_new_parents: need_new_parents
			a_class_info_not_void: a_class_info /= Void
		local
			l_parents_as: EIFFEL_LIST [PARENT_AS]
			l_parents_classes: like parents_classes
			l_non_conforming_parents_as, l_conforming_parents_as: EIFFEL_LIST [PARENT_AS]
			l_has_non_conforming_parents, l_has_conforming_parents: BOOLEAN
			l_parent_c: PARENT_C
			l_parent_class: CLASS_C
			l_parent_as: PARENT_AS
			l_raw_type: CLASS_TYPE_AS
			l_any_id: INTEGER
			l_vhpr1: VHPR1
			l_ve04: VE04
			l_dummy_list: LINKED_LIST [INTEGER]
			l_client: CLASS_C
			l_conforming_parents_tuple, l_non_conforming_parents_tuple: like similar_parents
			l_conforming_parents_count: INTEGER
			l_compiled_parent_generator: AST_PARENT_C_GENERATOR
			l_parent_type: CL_TYPE_A
			l_vtug: VTUG
		do
				-- Reset flag
			need_new_parents := False

				-- Initialize context
			Inst_context.set_group (group)
			l_parents_as := a_class_info.parents
			l_non_conforming_parents_as := a_class_info.non_conforming_parents
			l_conforming_parents_as := a_class_info.conforming_parents
			l_has_non_conforming_parents := l_non_conforming_parents_as /= Void and then not l_non_conforming_parents_as.is_empty
			l_has_conforming_parents := l_conforming_parents_as /= Void and then not l_conforming_parents_as.is_empty
			if l_has_conforming_parents then
				l_conforming_parents_count := l_conforming_parents_as.count
			end
			l_any_id := System.any_id

			if l_parents_as /= Void and then not l_parents_as.is_empty then
				check
					inheritance_clauses_correct: l_has_non_conforming_parents or l_has_conforming_parents
						-- If we have a parents_as list then we must have a non-empty parents list.
				end
				if class_id = l_any_id then
						-- Throw a VHPR1 error is ANY contains any custom inheritance clauses.
					create l_vhpr1
					create l_dummy_list.make
					l_dummy_list.extend (class_id)
					l_vhpr1.set_involved_classes (l_dummy_list)
					Error_handler.insert_error (l_vhpr1)
				else
						-- VHPR3 checking and extract structure from parsing.
					from
							-- Reset any previous parent class storage.
						computed_parents := Void
						conforming_parents := Void
						non_conforming_parents := Void
						conforming_parents_classes := Void
						non_conforming_parents_classes := Void
						if l_has_conforming_parents then
							create conforming_parents_classes.make (l_conforming_parents_as.count)
							create conforming_parents.make (l_conforming_parents_as.count)
							if l_has_non_conforming_parents then
								create non_conforming_parents_classes.make (l_non_conforming_parents_as.count)
								create non_conforming_parents.make (l_non_conforming_parents_as.count)
							end
						else
								-- We must have non-conforming parents
							create non_conforming_parents_classes.make (l_non_conforming_parents_as.count)
							create non_conforming_parents.make (l_non_conforming_parents_as.count)

								-- We need to add class ANY as an ancestor as no conforming parents are syntactically specified.
							create conforming_parents_classes.make (1)
							create conforming_parents.make (1)
							create computed_parents.make (l_non_conforming_parents_as.count + 1)

								-- Add a descendant to class ANY
							System.any_class.compiled_class.add_descendant (Current)
								-- Insertion in `parents_classes'
							conforming_parents_classes.extend (System.any_class.compiled_class)
								-- Insertion in `parents'
							conforming_parents.extend (Any_type)
								-- Insertion in `computed_parents'
							computed_parents.extend (Any_parent)
						end

						if computed_parents = Void then
								-- If not already created by sole non-conforming inheritance, create the other parents lists.
							create computed_parents.make (l_parents_as.count)
						end

						create l_compiled_parent_generator
						l_parents_as.start
					until
						l_parents_as.after
					loop
							-- Evaluation of the parent type
						l_parent_as := l_parents_as.item
						l_raw_type := l_parent_as.type


							-- Create appropriate conforming or non-conforming compiled parent class.
							-- l_parents_as is a merging of conforming parents with non-conforming parents.
							-- If the conforming parents count is greater than the current index we know that
							-- we have to add a conforming PARENT_C, else a NON_CONFORMING_PARENT_C is added.
						l_parent_c := l_compiled_parent_generator.compiled_parent (system, Current, l_parent_as, l_parents_as.index > l_conforming_parents_count)

						l_parent_type := l_parent_c.parent_type

							-- Check if there is no anchor (has_like) and no bit symbol (is_class_valid) in the constraint type.
						if l_parent_type.has_like or not l_parent_type.is_class_valid then
							create l_ve04
							l_ve04.set_class (Current)
							l_ve04.set_parent_type (l_raw_type)
							l_ve04.set_location (l_parent_as.start_location)
							Error_handler.insert_error (l_ve04)
						elseif not l_parent_type.good_generics then
								-- This addresses eweasel test#term146 where we assumed before at degree 4
								-- they had the correct number of formal generics and thus performed conformance
								-- checking blindly. Now we check the error at the end of degree 5 to prevent
								-- this problem.
							l_vtug := l_parent_type.error_generics
							l_vtug.set_class (Current)
							l_vtug.set_location (l_parent_as.start_location)
							error_handler.insert_error (l_vtug)
						else
							computed_parents.extend (l_parent_c)

							l_parent_class := clickable_info.associated_eiffel_class (lace_class,
								l_parent_as.type).compiled_class

								-- Insertion of a new descendant for the parent class
							check
								parent_class_exists: l_parent_class /= Void
									-- This ensures that routine `check_suppliers'
									-- has been called before.
							end
							l_parent_class.add_descendant (Current)

								-- Use reference class type as a parent.
							if l_parent_type.is_expanded then
								l_parent_type := l_parent_type.reference_type
							end

							if l_parent_class.is_generic then
									-- Look for a derivation of the same class.
								from
									l_parents_classes := parents_classes
									l_parents_classes.start
								until
									l_parents_classes.after
								loop
									if l_parents_classes.item = l_parent_class then
										if not parents.i_th (l_parents_classes.index).same_as (l_parent_type) then
												-- Different generic derivations are used in Parent parts.
											error_handler.insert_error (create {VHPR5_ECMA}.make
												(Current, l_parent_type, parents.i_th (l_parents_classes.index), l_parent_as.start_location))
										end
									end
									l_parents_classes.forth
								end
							end

								-- Add parent class to either conforming or non-conforming inheritance list.
							if l_has_non_conforming_parents and then l_non_conforming_parents_as.has (l_parent_as) then
								non_conforming_parents_classes.extend (l_parent_class)
								non_conforming_parents.extend (l_parent_type)
							else
								conforming_parents_classes.extend (l_parent_class)
								conforming_parents.extend (l_parent_type)
							end
						end
						l_parents_as.forth
					end
				end
			elseif not (class_id = l_any_id) then
					-- No parents are syntactically specified: ANY is
					-- the default parent for Eiffel classes.
				create conforming_parents_classes.make (1)
				create computed_parents.make (1)
				create conforming_parents.make (1)

					-- Wipe out any previous non-conforming parents as they are no longer valid.
				non_conforming_parents := Void
				non_conforming_parents_classes := Void

					-- Add a descendant to class ANY
				System.any_class.compiled_class.add_descendant (Current)
					-- Insertion in `parents_classes'
				conforming_parents_classes.extend (System.any_class.compiled_class)
					-- Insertion in `parents'
				conforming_parents.extend (Any_type)
					-- Insertion in `computed_parents'
				computed_parents.extend (Any_parent)
			else
					-- In case of the ancestor class to all classes, just create an empty
					-- parent structure.
				create conforming_parents_classes.make (0)
				create conforming_parents.make (0)
				create computed_parents.make (0)

					-- Wipe out any previous non-conforming parents as they are no longer valid.
				non_conforming_parents := Void
				non_conforming_parents_classes := Void
			end

			if a_old_class_info /= Void then
				l_conforming_parents_tuple := similar_parents (a_old_class_info.conforming_parents, l_conforming_parents_as)
				l_non_conforming_parents_tuple := similar_parents (a_old_class_info.non_conforming_parents, l_non_conforming_parents_as)
				if not l_conforming_parents_tuple.previous_types_remain or else not l_non_conforming_parents_tuple.previous_types_remain then
						-- Conformance tables incrementality as inheritance has changed
					set_changed (True)
					set_changed3a (True)
					System.set_update_sort (True)

					if l_conforming_parents_tuple.parents_removed or else l_non_conforming_parents_tuple.parents_removed then
							-- A parent has been removed:
							-- Take care of signature conformance for redefinion of
							-- f(p:PARENT) in f(c: CHILD). If CHILD does not inherit
							-- from PARENT anymore, the redefinition of f is not valid
						from
							syntactical_clients.start
						until
							syntactical_clients.after
						loop
							l_client := syntactical_clients.item
							l_client.set_changed2 (True)
							Degree_4.insert_new_class (l_client)
							syntactical_clients.forth
						end
					end
				end
				if not changed then
						-- If the class is not changed, it is marked `changed2'
					changed2 := True
				end
			else
					-- First compilation of the class
				System.set_update_sort (True)
			end
		ensure
			not_need_new_parents: not need_new_parents
			parents_not_void: parents /= Void
			parents_classes_not_void: parents_classes /= Void
			computed_parents_not_void: computed_parents /= Void
		end

	check_parents is
			-- Check generical parents
		require
			parents_not_void: parents /= Void
		local
			vtcg4: VTCG4
			vifi1: VIFI1
			vifi2: VIFI2
			parent_actual_type: CL_TYPE_A
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
			l_parent_class: CLASS_C
			l_single_classes: LINKED_LIST [CLASS_C]
			l_old_is_single, l_has_external_parent: BOOLEAN
			l_error_level: NATURAL
			l_parents: like parents
		do
			l_error_level := error_handler.error_level
				-- Clear feature context
			ast_context.clear_feature_context
			from
				l_parents := parents
				l_area := l_parents.area
				nb := l_parents.count
				l_old_is_single := is_single
				has_external_main_parent := False
			until
				i = nb
			loop
				parent_actual_type := l_area.item (i)
				l_parent_class := parent_actual_type.associated_class
				l_has_external_parent := l_parent_class.is_external and then not l_parent_class.is_interface and then not l_parent_class.is_basic
				if l_has_external_parent then
					has_external_main_parent := True
				end
					-- Class type is generated as single if it has an external parent
					-- or its parent is a single reference type (parent class may be single
					-- in case it is expanded, but parent type is always reference)
				if l_has_external_parent or else l_parent_class.is_single then
					if l_single_classes = Void then
						create l_single_classes.make
					end
					l_single_classes.extend (l_parent_class)
					l_single_classes.finish
				end

				check
						-- This has already been checked in `fill_parents'.
					valid_generics: parent_actual_type.good_generics
				end
				if parent_actual_type.generics /= Void then
						-- Check constrained genericity validity rule
					parent_actual_type.reset_constraint_error_list
						-- Check creation readyness because parents have to be creation ready.
					parent_actual_type.check_constraints (Current, Void, True)
					if parent_actual_type.constraint_error_list.count > 0 then
						create vtcg4
						vtcg4.set_class (Current)
						vtcg4.set_error_list (parent_actual_type.constraint_error_list)
						vtcg4.set_parent_type (parent_actual_type)
						fixme ("Shouldn't we be able to provide a location?")
						error_handler.insert_error (vtcg4)
					end
				end

				if
					(l_parent_class.is_frozen and then
					(l_parent_class.is_external or else (non_conforming_parents_classes = Void or else conforming_parents_classes.has (l_parent_class))))
						-- We cannot inherit frozen external classes or frozen conforming classes.
				then
					create vifi1.make (Current)
					vifi1.set_parent_class (l_parent_class)
					fixme ("Shouldn't we be able to provide a location?")
					error_handler.insert_error (vifi1)
				end
				i := i + 1
			end

			if l_single_classes /= Void and then l_single_classes.count > 1 then
					-- Error we are trying to do multiple inheritance of classes
					-- that inherit from external classes or that are external classes.
					-- Error which occurs only during IL generation.
				create vifi2.make (Current)
				vifi2.set_parent_classes (l_single_classes)
				fixme ("Shouldn't we be able to provide a location?")
				error_handler.insert_error (vifi2)
			end
			if l_single_classes /= Void and then is_expanded then
					-- External classes are inherited by expanded class.
				check
					l_single_classes_not_empty: not l_single_classes.is_empty
				end
				fixme ("Shouldn't we be able to provide a location?")
				error_handler.insert_error (create {VIFI3}.make (Current, l_single_classes))
			end

				-- Only classes that explicitely inherit from an external class only once
				-- are marked `single.
			set_is_single (l_single_classes /= Void and then l_single_classes.count = 1)
			if System.il_generation and then l_old_is_single /= is_single then
					-- Class has its `is_single' status changed.
					-- We have to reset its `types' so that they are recomputed and
					-- we have to remove existing types from `System.class_types'
				remove_types
					-- Force recompilation of all clients, as the code to create objects might have changed
				from
					clients.start
				until
					clients.after
				loop
					clients.item.melt_all
					clients.forth
				end
			end
			if error_handler.error_level /= l_error_level then
				Error_handler.raise_error
			end
		ensure
			parents_set: parents /= Void
		end

	remove_types is
			-- Removes all types from system
		do
			if has_types then
				from
					types.start
				until
					types.after
				loop
					System.remove_class_type (types.item)
					types.forth
				end
				types.wipe_out
				set_changed4 (True)
			end
		ensure
			types_empty: not has_types
		end

feature -- Supplier checking

	check_that_root_class_is_not_deferred is
		-- Check non-genericity of root class
		local
			l_vsrt3: VSRT3
		do
			if is_deferred then
				create l_vsrt3
				l_vsrt3.set_class (Current)
				Error_handler.insert_error (l_vsrt3)
				Error_handler.checksum
			end
		end

	check_root_class_creators (a_creator: STRING; a_type: CL_TYPE_A) is
			-- Check creation procedures of root class
			--
			-- Note: if `a_creator' is empty and default_create is a valid creation procedure in `Current',
			--       `a_creator' will get the propriate default creation name appended.
		require
			a_creator_not_void: a_creator /= Void
			a_type_not_void: a_type /= Void
		local
			l_creation_proc: FEATURE_I
			l_error: BOOLEAN
			l_vsrp2: VSRP2
			l_arg_type: TYPE_A
			l_vd27: VD27
			l_feat_tbl: like feature_table
		do
			if creators /= Void and not a_creator.is_empty then
				l_feat_tbl := feature_table
				from
					creators.start
				until
					creators.after
				loop
					if a_creator.is_equal (creators.key_for_iteration) then
							-- `creators.key_for_iteration' contains the creation_name
						l_creation_proc := l_feat_tbl.item (creators.key_for_iteration)

						inspect
							l_creation_proc.argument_count
						when 0 then
							l_error := False
						when 1 then
							l_arg_type ?= l_creation_proc.arguments.first
							l_arg_type := l_arg_type.instantiation_in (a_type, class_id).actual_type
							l_error := not array_of_string.conform_to (l_arg_type)
						else
							l_error := True
						end

						if l_error then
							create l_vsrp2
							l_vsrp2.set_class (Current)
							l_vsrp2.set_root_type (a_type)
								-- Need duplication otherwise we would change the original FEATURE_I
								-- object while displaying the error.
							l_creation_proc := l_creation_proc.duplicate
							l_creation_proc.instantiation_in (a_type)
							l_vsrp2.set_creation_feature (l_creation_proc)
							Error_handler.insert_error (l_vsrp2)
						end
					end
					creators.forth
				end
			end

			if not a_creator.is_empty and creators = Void then
					-- Check default create
				l_creation_proc := default_create_feature
				if not l_creation_proc.feature_name.is_equal (a_creator) then
					create l_vd27
					l_vd27.set_creation_routine (a_creator)
					l_vd27.set_root_class (Current)
					Error_handler.insert_error (l_vd27)
				end
			elseif not a_creator.is_empty and not creators.has (a_creator) then
				create l_vd27
				l_vd27.set_creation_routine (a_creator)
				l_vd27.set_root_class (Current)
				Error_handler.insert_error (l_vd27)
			elseif a_creator.is_empty then
				if allows_default_creation then
						-- Redefine creation procedure
					a_creator.append (default_create_feature.feature_name)
				else
					create l_vd27
					l_vd27.set_creation_routine ("")
					l_vd27.set_root_class (Current)
					Error_handler.insert_error (l_vd27)
				end
			end

			Error_handler.checksum
		end

	Array_of_string: GEN_TYPE_A is
			-- Type ARRAY [STRING]
		local
			array_generics: ARRAY [TYPE_A]
			string_type: CL_TYPE_A
		once
			create string_type.make (System.string_8_id)
			string_type.set_attached_mark
			create array_generics.make (1, 1)
			array_generics.put (string_type, 1)
			create Result.make (System.array_id, array_generics)
			Result.set_attached_mark
		ensure
			array_of_string_not_void: Result /= Void
			result_is_attached: Result.is_attached
			result_has_generic: Result.generics.count = 1
			result_g_is_attached: Result.generics.item (1).is_attached
		end

feature -- Order relation for inheritance and topological sort

	simple_conform_to (other: CLASS_C): BOOLEAN is
			-- Is `other' an ancestor of Current?
		require
			good_argument: other /= Void
		local
			otopid: INTEGER
		do
			otopid := other.topological_id
			Result := otopid <= topological_id
						-- A parent has necessarily a class id
						-- less or equal than the one of the heir class
					and then conformance_table.item (otopid)
						-- Check conformance table
		end

	conform_to (other: CLASS_C): BOOLEAN is
			-- Is `other' an ancestor of Current ?
		require
			good_argument: other /= Void
		local
			dep_class: CLASS_C
			otopid: INTEGER
		do
			Result := True

			if Current /= other then
				otopid := other.topological_id
				Result := otopid <= topological_id
							-- A parent has necessarily a class id
							-- less or equal than the one of the heir class
						and then conformance_table.item (otopid)
							-- Check conformance table

 				if Result and then (not is_class_none) and then (not other.is_class_any) then
 					dep_class := System.current_class

 					if dep_class /= Void and then dep_class /= Current then
 						add_dep_class (dep_class)
 					end
 				end
			end
		end

	valid_creation_procedure (fn: STRING): BOOLEAN is
			-- Is `fn' a valid creation procedure ?
		require
			good_argument: fn /= Void
		local
			dcr_feat : FEATURE_I
		do
			if creators /= Void then
				Result := creators.has (fn)
			else
				dcr_feat := default_create_feature

				if dcr_feat /= Void then
					Result := fn.is_equal (dcr_feat.feature_name)
				end
			end
		end

feature -- Propagation

	recompile_syntactical_clients is
			-- Order relation on classes
		local
			class_i: CLASS_I
			l_syntactical_clients: like syntactical_clients
		do
			from
				l_syntactical_clients := syntactical_clients
				l_syntactical_clients.start
			until
				l_syntactical_clients.after
			loop
				class_i := l_syntactical_clients.item.original_class
				debug ("REMOVE_CLASS")
					io.error.put_string ("Propagation to client: ")
					io.error.put_string (class_i.name)
					io.error.put_new_line
				end
				workbench.add_class_to_recompile (class_i)
				class_i.set_changed (True)
				l_syntactical_clients.forth
			end
		end

feature -- Convenience features

	set_changed (b: BOOLEAN) is
			-- Mark the associated lace class changed.
		do
			original_class.set_changed (b)
		ensure
			changed_set: changed = b
		end

	set_changed2 (b: BOOLEAN) is
			-- Assign `b' to `changed2'.
		do
			changed2 := b
		ensure
			changed2_set: changed2 = b
		end

	set_changed3a (b: BOOLEAN) is
			-- Assign `b' to `changed3a'.
		do
			changed3a := b
		ensure
			changed3a_set: changed3a = b
		end

	set_need_type_check (b: like need_type_check) is
			-- Assign `b' to `need_type_check'.
		do
			need_type_check := b
		ensure
			need_type_check_set: need_type_check = b
		end

	set_changed4 (b: BOOLEAN) is
			-- Assign `b' to `changed4'.
		do
			changed4 := b
		ensure
			changed4_set: changed4 = b
		end

	set_has_unique is
			-- Set `has_unique' to True
		do
			has_unique := True
		ensure
			has_unique_set: has_unique
		end

	set_has_expanded is
			-- Set `has_expanded' to True
		do
			has_expanded := True
		ensure
			has_expanded_set: has_expanded
		end

	set_is_in_system (v: BOOLEAN) is
			-- Set `is_in_system' to `v'.
		require
			not_precompiling: not Compilation_modes.is_precompiling
		do
			is_in_system := v
		ensure
			is_in_system_set: is_in_system = v
		end

	set_is_used_as_expanded is
		do
			is_used_as_expanded := True
		ensure
			is_used_as_expanded_set: is_used_as_expanded
		end

	set_invariant_feature (f: INVARIANT_FEAT_I) is
			-- Set `invariant_feature' with `f'.
		do
			invariant_feature := f
		ensure
			invariant_feature_set: invariant_feature = f
		end

	set_skeleton (s: GENERIC_SKELETON) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s
		ensure
			skeleton_set: skeleton = s
		end

	set_convert_to (c: like convert_to) is
			-- Assign `c' to `convert_to'.
		do
			convert_to := c
		ensure
			convert_to_set: convert_to = c
		end

	set_convert_from (c: like convert_from) is
			-- Assign `c' to `convert_from'.
		do
			convert_from := c
		ensure
			convert_from_set: convert_from = c
		end

	set_creators (c: like creators) is
			-- Assign `c' to `creators'.
		do
			creators := c
		ensure
			creators_set: creators = c
		end

	set_visible_table_size (i: INTEGER) is
			-- Assign `i' to `visible_table_size'
		require
			i_positive: i >= 0
		do
			visible_table_size := i
		ensure
			visible_table_size_set: visible_table_size = i
		end

	set_is_single (v: BOOLEAN) is
			-- Set `is_single' with `v'
		do
			is_single := v
		ensure
			is_single_set: is_single = v
		end

	add_descendant (c: CLASS_C) is
			-- Insert class `c' into the descendant list
		require
			good_argument: c /= Void
		local
			desc: like direct_descendants
		do
			desc := direct_descendants
			if not desc.has (c) then
				desc.extend (c)
			end
		ensure
			inserted: direct_descendants.has (c)
		end

	external_name: STRING is
			-- External name
		local
			l_vis: EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]]
		do
			l_vis := lace_class.visible
			if l_vis /= Void then
				Result := l_vis.item.class_renamed
			else
				Result := name
			end
		ensure
			external_name_not_void: Result /= Void
			external_name_in_upper: Result.as_upper.is_equal (Result)
		end

	assertion_level: ASSERTION_I is
			-- Assertion level of the class
		do
			if System.in_final_mode then
					-- In final mode we do not generate assertions
					-- if the dead code remover is on.
				if not System.keep_assertions then
					create Result
				else
					Result := lace_class.assertion_level
				end
			else
				Result := lace_class.assertion_level
			end
		ensure
			assertion_level_not_void: Result /= Void
		end

	trace_level: OPTION_I is
			-- Trace level of the class
		do
			Result := lace_class.trace_level
		end

	profile_level: OPTION_I is
			-- Profile level of the class
		do
			Result := lace_class.profile_level
		end

	optimize_level: OPTIMIZE_I is
			-- Optimization level
		do
			Result := lace_class.optimize_level
		end

	debug_level: DEBUG_I is
			-- Debug level
		do
			Result := lace_class.debug_level
		end

	visible_level: VISIBLE_I is
			-- Visible level
		do
			Result := lace_class.visible_level
		end

	is_full_class_checking: BOOLEAN is
			-- Do we perform a flat checking on the class, i.e. checking
			-- inherited routines in the context of the descendant class?
		do
			Result := lace_class.is_full_class_checking
		end

	is_cat_call_detection: BOOLEAN is
			-- Do we perform cat-call detection on all feature calls?
		do
			Result := lace_class.is_cat_call_detection
		end

feature -- Actual class type

	constraint_actual_type: CL_TYPE_A is
			-- Actual type of class where all formals are replaced by their constraint.
		local
			i, count: INTEGER
			actual_generic: ARRAY [TYPE_A]
		do
			if generics = Void then
				Result := actual_type
			else
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
					create {GEN_TYPE_A} Result.make (class_id, actual_generic)
				until
					i > count
				loop
					actual_generic.put (constraints (i), i)
					i := i + 1
				end
			end
		ensure
			constraint_actual_type_not_void: Result /= Void
		end

	actual_type: CL_TYPE_A is
			-- Actual type of the class
		local
			i, nb: INTEGER
			actual_generic: ARRAY [TYPE_A]
			formal: FORMAL_A
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			if generics = Void then
				create Result.make (class_id)
			else
				from
					i := 1
					nb := generics.count
					create actual_generic.make (1, nb)
					create {GEN_TYPE_A} Result.make (class_id, actual_generic)
				until
					i > nb
				loop
					l_formal_dec ?= generics.i_th (i)
					check l_formal_dec_not_void: l_formal_dec /= Void end
					create formal.make (l_formal_dec.is_reference, l_formal_dec.is_expanded, i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			end
			if lace_class.is_attached_by_default then
				Result.set_is_attached
			else
				Result.set_is_implicitly_attached
			end
		ensure
			actual_type_not_void: Result /= Void
		end

feature {TYPE_AS, AST_TYPE_A_GENERATOR, AST_FEATURE_CHECKER_GENERATOR} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp, is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		require
			is_exp_set: is_exp implies (not is_sep)
			is_sep_set: is_sep implies (not is_exp)
		do
			if gen /= Void then
				create {GEN_TYPE_A} Result.make (class_id, gen)
			else
				create Result.make (class_id)
			end
			if is_exp then
				Result.set_expanded_mark
			elseif is_sep then
				Result.set_separate_mark
			end
			if is_expanded then
				Result.set_expanded_class_mark
			end
		ensure
			actual_type_not_void: Result /= Void
		end

feature -- Incrementality

	insert_changed_feature (feature_name_id: INTEGER) is
			-- Insert feature `feature_name_id' in `changed_features'.
		require
			good_argument: feature_name_id > 0
		do
debug ("ACTIVITY")
	io.error.put_string ("CLASS_C: ")
	io.error.put_string (name)
	io.error.put_string ("%NChanged_feature: ")
	io.error.put_string (Names_heap.item (feature_name_id))
	io.error.put_new_line
end
			changed_features.put (feature_name_id)
		end

	constraint (i: INTEGER): TYPE_A is
			-- I-th constraint of the class
		require
			generics_exists: is_generic
			valid_index: generics.valid_index (i)
			not_is_multi_constraint: not generics.i_th (i).has_multi_constraints
		local
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			l_formal_dec ?= generics.i_th (i)
			check l_formal_dec_not_void: l_formal_dec /= Void end
			Result := l_formal_dec.constraint_type (Current).type
		ensure
			constraint_not_void: Result /= Void
		end

	constraint_if_possible (i: INTEGER): TYPE_A is
			-- I-th constraint of the class
		require
			generics_exists: is_generic
			valid_index: generics.valid_index (i)
			not_is_multi_constraint: not generics.i_th (i).has_multi_constraints
		local
			l_formal_dec: FORMAL_CONSTRAINT_AS
			l_result: RENAMED_TYPE_A [TYPE_A]
		do
			l_formal_dec ?= generics.i_th (i)
			check l_formal_dec_not_void: l_formal_dec /= Void end
			l_result := l_formal_dec.constraint_type_if_possible (Current)
			if l_result /= Void then
				Result := l_result.type
			end
		end

	constraints (i: INTEGER): TYPE_SET_A is
			-- I-th constraint set of the class
		require
			generics_exists: is_generic
			valid_index: generics.valid_index (i)
		local
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
				-- Fixme: Should we store computation of `constraint_types'?
			l_formal_dec ?= generics.i_th (i)
			check l_formal_dec_not_void: l_formal_dec /= Void end
			Result := l_formal_dec.constraint_types (Current)
		ensure
			constraint_not_void: Result /= Void
		end

	constraints_if_possible (i: INTEGER): TYPE_SET_A is
			-- I-th constraint set of the class
		require
			generics_exists: is_generic
			valid_index: generics.valid_index (i)
		local
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
				-- Fixme: Should we store computation of `constraint_types_if_possible'?
			l_formal_dec ?= generics.i_th (i)
			check l_formal_dec_not_void: l_formal_dec /= Void end
			Result := l_formal_dec.constraint_types_if_possible (Current)
		ensure
			constraint_not_void: Result /= Void
		end

	constrained_type (a_formal_position: INTEGER): TYPE_A
			-- Constraint of Current.
			--
			-- `a_formal_position' is the position of the formal whose constraint is returned.
			-- Warning: Result is cached, do not modify it.
		require
			is_generic: is_generic
			valid_formal_position: is_valid_formal_position (a_formal_position)
			not_multi_constraint: not generics [a_formal_position].is_multi_constrained (generics)
		local
			l_formal_type: FORMAL_A
			l_recursion_break: SPECIAL [BOOLEAN]
			l_break: BOOLEAN
			l_formal_type_position: INTEGER
		do
			Result := constrained_type_cache [a_formal_position - 1]
			if Result = Void then
				create l_recursion_break.make (generics.count + 1)
				from
					Result := constraint (a_formal_position)
				until
					not Result.is_formal or l_break
				loop
					l_formal_type ?= Result
					check l_formal_type_not_void: l_formal_type /= Void end
					l_formal_type_position := l_formal_type.position
					check valid_formal_position: is_valid_formal_position (l_formal_type_position) end
					l_break := l_recursion_break [l_formal_type_position]
					l_recursion_break [l_formal_type_position] := True
					Result := constraint (l_formal_type_position)
				end
				if l_break then
					Result := any_type
				end
				constrained_type_cache [a_formal_position - 1] := Result
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_named_but_not_formal:  (Result.is_none or Result.is_named_type) and not Result.is_formal
		end

	constrained_types (a_formal_position: INTEGER): TYPE_SET_A
			-- Constrained types of Current.
			--
			-- `a_context_class' is the context class where the formal occurs in.
			--| It is a list of class types which constraint the current Formal.
			-- Warning: Result is cached, do not modify it.
		require
			valid_formal_position: is_valid_formal_position (a_formal_position)
		do
			Result ?= constrained_types_cache [a_formal_position - 1]
			if Result = Void then
				Result := constraints (a_formal_position).constraining_types (Current)
				constrained_types_cache [a_formal_position - 1] := Result
			end
		ensure
			Result_not_void_and_not_empty: Result /= Void and not Result.is_empty
		end

	update_instantiator1 is
			-- Ensure that parents classes have a proper generic derivation
			-- matching needs of current class which has syntactically
			-- been changed.
		require
			is_syntactically_changed: changed
			parents_not_void: parents /= Void
		local
			parent_type: CL_TYPE_A
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
			l_parents: like parents
		do
			from
				l_parents := parents
				l_area := l_parents.area
				nb := l_parents.count
			until
				i = nb
			loop
				parent_type := l_area.item (i)
					-- Because inheritance clause does not care about expanded
					-- status, we remove it in case parent class is by default
					-- expanded.
				if parent_type.is_expanded then
					parent_type := parent_type.reference_type
				end
				Instantiator.dispatch (parent_type, Current)
				i := i + 1
			end
		end

	init_types is
			-- Standard initialization of attribute `types' for non
			-- generic classes.
		require
			no_generic: not is_generic
		local
			data: CL_TYPE_A
		do
			data := actual_type
			register_type (data).do_nothing
			instantiator.dispatch (data, Current)
			if (data.is_expanded and not data.is_external) or data.is_basic then
					-- Process reference counterpart.
				data := data.reference_type
				register_type (data).do_nothing
				instantiator.dispatch (data, Current)
			end
		end

	update_types (data: CL_TYPE_A) is
			-- Update `types' with `data'.
		require
			good_argument: data /= Void
			consistency: data.associated_class = Current
			good_context: not data.is_formal
		local
			new_class_type: CLASS_TYPE
			l_parents_classes: like parents_classes
		do
			if not derivations.has_derivation (class_id, data) then
					-- The recursive update is done only once
				derivations.insert_derivation (class_id, data)

				new_class_type := register_type (data)
				if (data.is_expanded and not data.is_external) or data.is_basic then
						-- Process reference counterpart.
					update_types (data.reference_type)
				end

					-- Propagation along the filters since we have a new type
				update_filter_types (new_class_type)
				if new_class_type.is_expanded then
						-- Propagate to all parent filters to ensure that
						-- all the required class types are registered
						-- for generating this expanded class type
					from
						l_parents_classes := parents_classes
						l_parents_classes.start
					until
						l_parents_classes.after
					loop
						l_parents_classes.item.update_filter_anchored_types (new_class_type)
						l_parents_classes.forth
					end
				end
			end
		end

feature {NONE} -- Incrementality

	derivations: DERIVATIONS is
		once
			Result := instantiator.derivations
		ensure
			derivations_not_void: Result /= Void
		end

	register_type (data: CL_TYPE_A): CLASS_TYPE is
			-- Ensure that `data' has an associated class type by creating
			-- a new class type descriptor if it is not already created;
			-- return the associated class type.
		require
			data_not_void: data /= Void
		local
			g: GEN_TYPE_A
		do
			if data.generics /= Void then
					-- Register this generic type and other required types.
				g ?= data
				Result := register_generic_type (g, g.generics.count)
			elseif types.has_type (Void, data) then
				Result := types.found_item
			else
					-- Found a new type for the class
				Result := register_new_type (data)
			end
		ensure
			result_not_void: Result /= Void
			data_is_registered: types.has_type (Void, data)
		end

	register_new_type (data: CL_TYPE_A): CLASS_TYPE is
			-- Register new type `data' and return the corresponding descriptor.
		require
			data_attached: data /= Void
			data_is_new: not types.has_type (Void, data)
		do
debug ("GENERICITY")
	io.error.put_string ("new type%N")
end
			Result := new_type (data)
				-- If the $ operator is used in the class,
				-- an encapsulation of the feature must be generated
			if System.address_table.class_has_dollar_operator (class_id) then
				System.request_freeze
			end
				-- Mark the class `changed4' because there is a new type
			changed4 := True
			Degree_2.insert_new_class (Current)
				-- Insertion of the new class type
			types.extend (Result)
			System.insert_class_type (Result)
		ensure
			result_attached: Result /= Void
			data_is_registered: types.has_type (Void, data)
		end

	register_generic_type (data: GEN_TYPE_A; n: INTEGER): CLASS_TYPE is
			-- Ensure that `data' has an associated class type by creating
			-- a new class type descriptor if it is not already created;
			-- return the associated class type. Register all the types
			-- required by this type for code generation.
		local
			g: GEN_TYPE_A
			t: ARRAY [TYPE_A]
			p: TYPE_A
			c: CL_TYPE_A
			i: INTEGER
			a: NATIVE_ARRAY_TYPE_A
			r: GEN_TYPE_A
		do
			if types.has_type (Void, data) then
				Result := types.found_item
			else
					-- Found a new type for the class
				Result := register_new_type (data)
				r ?= Result.type
				check
					r_attached: r /= Void
				end
				a ?= r
--				if False then
--					-- TODO: see GEN_TYPE_A.enumerate_interfaces
				if a = Void and then system.is_precompiled then
						-- Register all types where expanded parameters are replaced with reference ones.
					t := r.generics
					from
						i := n
					until
						i <= 0
					loop
						p := t [i]
						if p.is_expanded then
							g := r.duplicate
							c ?= p
							check
								c_attached: c /= Void
							end
							g.generics [i] := c.reference_type
							register_generic_type (g, i - 1).do_nothing
							update_types (g)
						end
						i := i - 1
					end
				end
			end
		end

	new_type (data: CL_TYPE_A): CLASS_TYPE is
			-- New class type for current class
		do
			create Result.make (data)
			if already_compiled then
					-- Melt all the code written in the associated class of the new class type
				melt_all
			end
		ensure
			new_type_not_void: Result /= Void
		end

	update_filter_types (new_class_type: CLASS_TYPE) is
			-- Update all types associated with `filters' using `new_class_type'.
		require
			new_class_type_not_void: new_class_type /= Void
			filters_not_void: filters /= Void
		local
			class_filters: like filters
			filter: CL_TYPE_A
			class_filters_cursor: INTEGER
			l_system: like system
		do
			class_filters := filters
				-- Propagation along the filters since we have a new type
				-- Clean the filters. Some of the filters can be obsolete
				-- if the base class has been removed from the system
			class_filters.clean
			l_system := system
			from
				class_filters.start
			until
				class_filters.after
			loop
					-- We need to store cursor position because when you
					-- have an expanded class used as a reference or vice versa
					-- and that this class has some `like Current' then
					-- we are going to traverse recursively the `filters' list.
				class_filters_cursor := class_filters.cursor
					-- Instantiation of the filter with `data' but only if it is not a formal
					-- since in that case there is nothing to propagate.
				filter := class_filters.item_for_iteration.adapted_in (new_class_type)
				if not filter.is_formal then
					filter.associated_class.update_types (filter)
				end
				class_filters.go_to (class_filters_cursor)
				class_filters.forth
			end
		end

feature {CLASS_C} -- Incrementality

	update_filter_anchored_types (new_class_type: CLASS_TYPE) is
			-- Update all anchored types associated with `filters' using `new_class_type'.
		require
			new_class_type_not_void: new_class_type /= Void
			new_class_type_is_expanded: new_class_type.is_expanded
			filters_not_void: filters /= Void
			conformance: new_class_type.associated_class.simple_conform_to (Current)
		local
			class_filters: like filters
			filter: CL_TYPE_A
			class_filters_cursor: INTEGER
			l_system: SYSTEM_I
		do
			class_filters := filters
				-- Propagation along the filters since we have a new type
				-- Clean the filters. Some of the filters can be obsolete
				-- if the base class has been removed from the system
			class_filters.clean
			from
				class_filters.start
				l_system := system
			until
				class_filters.after
			loop
					-- We need to store cursor position because when you
					-- have an expanded class used as a reference or vice versa
					-- and that this class has some `like Current' then
					-- we are going to traverse recursively the `filters' list.
				class_filters_cursor := class_filters.cursor
					-- Instantiation of the filter with `new_class_type'
				filter ?= class_filters.item_for_iteration.instantiation_in (new_class_type.type, class_id)
				if filter /= Void and then not filter.has_formal_generic then
					check
						has_associated_class: filter.has_associated_class
					end
					filter.associated_class.update_types (filter)
				end
				class_filters.go_to (class_filters_cursor)
				class_filters.forth
			end
		end

feature -- Meta-type

	meta_type (class_type: CLASS_TYPE): CLASS_TYPE is
			-- Associated class type of Current class in the context
			-- of descendant type `class_type'.
		require
			good_argument: class_type /= Void
			conformance: class_type.associated_class.conform_to (Current) or else True --| FIXME IEK: Create inherits_from routine in CLASS_C for non-conforming inheritance.
		local
			actual_class_type, written_actual_type: CL_TYPE_A
		do
			if class_type.type.class_id = class_id then
					-- Use supplied `class_type' to preserve expandedness status, generic parameters, etc.
				Result := class_type
			elseif generics = Void then
					-- No instantiation for non-generic class
				Result := types.first
			else
					-- FIXME: Manu 2007/09/13: This way of finding the class type in descendant
					-- is clearly not the best way as it is slow since we are creating a new TYPE_A
					-- instance just to find its associated type id. The better way would be to
					-- iterate through the generics of Current and find a CLASS_TYPE instances.
					-- See eweasel test#valid045 to see the slowness.
				actual_class_type := class_type.associated_class.actual_type
					-- General instantiation of the actual class type where
					-- the feature is written in the context of the actual
					-- type of the base class of `class_type'.
				written_actual_type ?= actual_type.instantiation_in
											(actual_class_type, class_id)
				if written_actual_type.is_expanded then
						-- Ancestors are always reference types.
					written_actual_type := written_actual_type.reference_type
				end
					-- Ask for the meta-type
				Result := written_actual_type.associated_class_type (class_type.type)
			end
		ensure
			meta_type_not_void: Result /= Void
		end

feature -- Validity class

	check_validity is
			-- Special classes validity check.
		local
			l_feature: FEATURE_I
		do
			if System.any_class = original_class then
					-- We are checking ANY.
				l_feature := feature_table.item_id (names_heap.Internal_correct_mismatch_name_id)
				if
					l_feature = Void or else
					not l_feature.is_routine or l_feature.argument_count > 0
				then
					error_handler.insert_error (
						create {SPECIAL_ERROR}.make ("Class ANY must have a procedure `internal_correct_mismatch' with no arguments", Current))
				end
				l_feature := feature_table.item_id (names_heap.equal_name_id)
				if
					l_feature = Void or else
					l_feature.argument_count /= 2 or else
					not l_feature.arguments.i_th (1).actual_argument_type (l_feature.arguments).is_reference or else
					not l_feature.arguments.i_th (2).actual_argument_type (l_feature.arguments).is_reference or else
					not l_feature.type.is_boolean
				then
					error_handler.insert_error (
						create {SPECIAL_ERROR}.make ("Class ANY must have a boolean query `equal' with 2 reference arguments", Current))
				end
				l_feature := feature_table.item_id (names_heap.twin_name_id)
				if
					l_feature = Void or else
					not l_feature.is_routine or else l_feature.argument_count > 0 or else l_feature.type.is_expanded
				then
					error_handler.insert_error (
						create {SPECIAL_ERROR}.make ("Class ANY must have a function `twin' with no arguments", Current))
				end
			end
		end

feature -- default_rescue routine

	default_rescue_feature: FEATURE_I is
			-- The version of `default_rescue' from ANY.
			-- Void if ANY has not been compiled yet or
			-- does not possess the feature.
		require
			has_feature_table: has_feature_table
			any_class_compiled: System.any_class /= Void
		do
			Result := feature_table.feature_of_rout_id (System.default_rescue_rout_id)
		end

feature -- default_create routine

	default_create_feature : FEATURE_I is
			-- The version of `default_create' from ANY.
			-- Void if ANY has not been compiled yet or
			-- does not posess the feature or class is deferred.
		require
			has_feature_table: has_feature_table
		do
			Result := feature_table.feature_of_rout_id (System.default_create_rout_id)
		end

	allows_default_creation : BOOLEAN is
			-- Can an instance of this class be
			-- created with 'default_create'?
		require
			has_feature_table: has_feature_table
		local
			dcr_feat : FEATURE_I
		do
				-- Answer is NO if class is deferred
			if not is_deferred then
				dcr_feat := default_create_feature
					-- Answer is NO if the class has no
					-- 'default_create'
				Result := dcr_feat /= Void and then (
					(creators = Void) or else (not creators.is_empty and then creators.has (dcr_feat.feature_name)))
			end
		end

feature -- Dead code removal

	mark_visible (remover: REMOVER) is
			-- Dead code removal from the visible features
		require
			visible_level.has_visible
		do
			visible_level.mark_visible (remover, feature_table)
		end

	has_visible: BOOLEAN is
			-- Has the class some visible features
		do
			Result := visible_level.has_visible
		end

	visible_table_size: INTEGER
			-- Size of hash table for visible features of Current class.

feature -- Cecil

	generate_cecil (generated_wrappers: DS_HASH_SET [STRING]) is
			-- Generate cecil table for a class having visible features
		require
			has_visible: has_visible
			generated_wrappers_attached: generated_wrappers /= Void
		do
				-- Reset hash-table size which will be computed during
				-- generation.
			set_visible_table_size (0)
			visible_level.generate_cecil_table (Current, generated_wrappers)
		end

feature -- Invariant feature

	has_invariant: BOOLEAN is
			-- Has the current class an invariant clause ?
		do
			Result := invariant_feature /= Void
		end

feature -- Process the creation feature

	process_creation_feature is
			-- Assign `default_create' creation procedure (if applicable) to
			-- `creation_feature'.
		require
			has_feature_table: has_feature_table
		do
			if allows_default_creation then
				creation_feature := default_create_feature
			else
				creation_feature := Void
			end
		end

	insert_changed_assertion (a_feature: FEATURE_I) is
			-- Insert `a_feature' in the melted set
		do
			add_feature_to_melted_set (a_feature)
			Degree_1.insert_class (Current)
		end

feature {NONE} -- Implementation

	add_feature_to_melted_set (f: FEATURE_I) is
		local
			melt_set: like melted_set
			melted_info: MELTED_INFO
		do
			melt_set := melted_set
			if melt_set = Void then
				create melt_set.make (melted_set_chunk)
				melted_set := melt_set
			end

			if f = invariant_feature then
				create {INV_MELTED_INFO} melted_info.make (f, Current)
			else
				create {FEAT_MELTED_INFO} melted_info.make (f, Current)
			end
			melt_set.force (melted_info)
		end

	Melted_set_chunk: INTEGER is 20
			-- Size of `melted_set' which contains melted features.

feature -- Initialization

	initialize (l: like original_class) is
			-- Initialization of Current.
		require
			good_argument: l /= Void
		do
			original_class := l
			l.set_compiled_class (Current)

				-- Set `is_class_any' and `is_class_none'

				--| FIXME IEK Perhaps a 'NONE_B' and 'ANY_B' where these were redefinable functions would be better.
			is_class_any := name.is_equal (once "ANY")
			is_class_none := name.is_equal (once "NONE")
				-- Creation of the descendant list
			create suppliers.make (2)
				-- Creation of the client list
			create clients.make (2)
				-- Types list creation
			create types.make (1)
		end

feature -- Properties

	original_class: CLASS_I
			-- Original lace class
			--
			-- See `lace_class' for example.

	lace_class: like original_class is
			-- Lace class (takes overriding into account)
			--
			-- e.g. Class in cluster c1 and in override o1
			--
			-- c1.compiled_class = Current
			-- o1.compiled_class = Void
			-- Current.lace_class = o1
			-- Current.original_class = c1
		do
			Result := original_class.actual_class
		end

	main_parent: CLASS_C
			-- Parent of current class which has most features.

	number_of_features: INTEGER
			-- Number of features in current class including inherited one.

	parents_classes: FIXED_LIST [CLASS_C]
			-- Parent classes.
		local
			l_non_conforming_parents_classes: like non_conforming_parents_classes
			l_conforming_parents_classes: like conforming_parents_classes
		do
			Result := conforming_parents_classes
			l_non_conforming_parents_classes := non_conforming_parents_classes
			if Result /= Void then
				if l_non_conforming_parents_classes /= Void then
						-- We cannot just append `l_non_conforming_parents_classes' to a clone
						-- of Result, because its size is fixed and cannot be increased.
					l_conforming_parents_classes := Result
					create Result.make (l_conforming_parents_classes.count + l_non_conforming_parents_classes.count)
					Result.append (l_conforming_parents_classes)
					Result.append (l_non_conforming_parents_classes)
				end
			else
				Result := l_non_conforming_parents_classes
			end
		end

	conforming_parents_classes: FIXED_LIST [CLASS_C]
			-- Conforming parent classes.

	non_conforming_parents_classes: FIXED_LIST [CLASS_C]
			-- Non-conforming parent classes.

	need_new_parents: BOOLEAN
			-- Does Current need to recompute `parents' and `computed_parents'?

	number_of_ancestors: INTEGER is
			-- Number of direct and indirect ancestor of Current. If repeated inheritance
			-- parents are counted twice.
		do
			if conforming_parents /= Void then
				Result := conforming_parents.count
				from
					conforming_parents.start
				until
					conforming_parents.after
				loop
					Result := Result + conforming_parents.item.associated_class.number_of_ancestors
					conforming_parents.forth
				end
			end
			if non_conforming_parents /= Void then
				Result := Result + non_conforming_parents.count
				from
					non_conforming_parents.start
				until
					non_conforming_parents.after
				loop
					Result := Result + non_conforming_parents.item.associated_class.number_of_ancestors
					non_conforming_parents.forth
				end
			end
		end

	parents: FIXED_LIST [CL_TYPE_A]
			-- Parent class types
			-- List containing both conforming and non-conforming parent class types of `Current'.
		local
			l_conforming_parents: like conforming_parents
			l_non_conforming_parents: like non_conforming_parents
		do
			Result := conforming_parents
			l_non_conforming_parents := non_conforming_parents
			if Result /= Void then
				if l_non_conforming_parents /= Void then
						-- We cannot just append `l_non_conforming_parents' to a clone
						-- of Result, because its size is fixed and cannot be increased.
					l_conforming_parents := Result
					create Result.make (l_conforming_parents.count + l_non_conforming_parents.count)
					Result.append (l_conforming_parents)
					Result.append (l_non_conforming_parents)
				end
			else
				Result := l_non_conforming_parents
			end
		end

	conforming_parents: FIXED_LIST [CL_TYPE_A]
			-- Conforming parent class types.

	non_conforming_parents: FIXED_LIST [CL_TYPE_A]
			-- Non-conforming parent class types.

	computed_parents: PARENT_LIST
			-- Computed version of parent clauses.

	direct_descendants: ARRAYED_LIST [CLASS_C]
			-- Direct descendants of the current class
		do
			if direct_descendants_internal = Void then
				create direct_descendants_internal.make (2)
			end
			Result := direct_descendants_internal
		end

	direct_descendants_internal: like direct_descendants
			-- One per object storage for direct descendants.

	clients: ARRAYED_LIST [CLASS_C]
			-- Clients of the class

	suppliers: SUPPLIER_LIST
			-- Suppliers of the class in terms of calls
			-- [Useful for incremental type check].

	generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Formal generical parameters

	generic_features: HASH_TABLE [TYPE_FEATURE_I, INTEGER]
			-- Collect all possible generic derivations inherited or current.
			-- Indexed by `rout_id' of formal generic parameter.
			-- Updated during `pass2' of INHERIT_TABLE.

	anchored_features: like generic_features
			-- Collect all features that are used for creating or doing an assignment
			-- attempt in current or in an inherited class.
			-- Indexed by `rout_id' of feature on which anchor is done.
			-- Updated before each IL code generation.

	type_set: SEARCH_TABLE [INTEGER]
			-- Set of routine IDs used for anchored type in current class.
			-- It does not take into accounts inherited one.

	topological_id: INTEGER
			-- Unique number for a class. Could change during a topological
			-- sort on classes.

	is_deferred: BOOLEAN
			-- Is class deferred ?

	is_interface: BOOLEAN
			-- Is class an interface for IL code generation?

	is_expanded: BOOLEAN
			-- Is class expanded?

	is_enum: BOOLEAN
			-- Is class an IL enum type?
			-- Useful to perform call optimization on enum type in FEATURE_B.

	is_basic: BOOLEAN is
			-- Is class basic?
		do
		end

	is_single: BOOLEAN
			-- Is class generated as a single entity in IL code generation.

	has_external_main_parent: BOOLEAN
			-- Is one non-external parent class generated as a single IL type?

	is_frozen: BOOLEAN
			-- Is class frozen, ie we cannot inherit from it?

	is_optimized_as_frozen: BOOLEAN is
			-- Although class might not be marked `is_frozen' we may want to consider it as frozen
			-- for the code generation.
		do
			Result := is_frozen or apply_msil_application_optimizations
		end

	is_external: BOOLEAN
			-- Is class an external one?
			-- If yes, we do not generate it.

	is_true_external: BOOLEAN is
			-- Is class an instance of EXTERNAL_CLASS_C?
			-- If yes, we do not generate it.
		do
		end

	obsolete_message: STRING
			-- Obsolete message
			-- (Void if Current is not obsolete)

	custom_attributes, class_custom_attributes, interface_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Associated custom attributes if any.

	assembly_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Associated custom attributes for assembly if any.

	name: STRING is
			-- Class name
		do
			Result := lace_class.name
		end

	external_class_name: STRING is
			-- External class name.
		do
			if private_external_name /= Void then
				Result := private_external_name
			else
				Result := name
			end
		end

	text: STRING is
			-- Class text
		require
			valid_file_name: file_name /= Void
		do
			Result := lace_class.text
		end

	constraint_classes (a_formal_dec: FORMAL_DEC_AS) : ARRAY [CLASS_C] is
			-- Computed constraint classes for every formal of the current class.
			-- Only class types are put into this cache so every item in the cache is error free.
			-- All other positions are void especially those of formals.
		require
			a_formal_dec_not_void: a_formal_dec /= Void
			valid_formal: a_formal_dec.position <= generics.count
		local
			l_cache: like constraint_cache
			l_formal_cache: like formal_constraint_cache
			l_pos: INTEGER
		do
				-- Check if `constraint_cache' has been created.
			l_cache := constraint_cache
			if l_cache = Void then
				create l_cache.make (generics.count)
				constraint_cache := l_cache
			end
				-- Check if an entry for `a_formal_dec' was created.
			l_pos := a_formal_dec.position - 1
			l_formal_cache := l_cache.item (l_pos)
			if l_formal_cache /= Void then
				Result := l_formal_cache.constraint_classes
					-- Check if it is Void (case where `constraint_renaming'
					-- was already called for `a_formal_dec').
				if Result = Void then
					create Result.make (1, a_formal_dec.constraints.count)
					l_formal_cache.constraint_classes := Result
				end
			else
					-- Insert `a_formal_dec'.
				create Result.make (1, a_formal_dec.constraints.count)
				l_cache.put ([Result, Void], l_pos)
			end
		ensure
			constraint_classes_not_void: Result /= Void
		end

	constraint_renaming (a_formal_dec: FORMAL_DEC_AS): ARRAY [RENAMING_A] is
			-- Computed renamings for every formal of the current class.
			-- Only sane renamings are put into this cache so every item in the cache is error free.
			-- All other positions are void especially those of formal constraints as they are not allowed to have renamings.
		require
			a_formal_dec_not_void: a_formal_dec /= Void
		local
			l_cache: like constraint_cache
			l_formal_cache: like formal_constraint_cache
			l_pos: INTEGER
		do
				-- Check if `constraint_cache' has been created.
			l_cache := constraint_cache
			if l_cache = Void then
				create l_cache.make (generics.count)
				constraint_cache := l_cache
			end
				-- Check if an entry for `a_formal_dec' was created.
			l_pos := a_formal_dec.position - 1
			l_formal_cache := l_cache.item (l_pos)
			if l_formal_cache /= Void then
				Result := l_formal_cache.constraint_renaming
					-- Check if it is Void (case where `constraint_classes'
					-- was already called for `a_formal_dec').
				if Result = Void then
					create Result.make (1, a_formal_dec.constraints.count)
					l_formal_cache.constraint_renaming := Result
				end
			else
					-- Insert `a_formal_dec'.
				create Result.make (1, a_formal_dec.constraints.count)
				l_cache.put ([Void, Result], l_pos)
			end
		ensure
			constraint_renaming_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Properties

	constraint_cache: SPECIAL [like formal_constraint_cache]
			-- To store computed information about generic constraints of Current.

	formal_constraint_cache: TUPLE [
			constraint_classes: ARRAY [CLASS_C];
			constraint_renaming: ARRAY [RENAMING_A]]
		is
			-- For easy type checking of `constraint_cache'.
		do
		end

	constrained_type_cache: SPECIAL [TYPE_A]
			-- Constraining type for each given formal, if there exists one

	constrained_types_cache: SPECIAL [TYPE_SET_A]
			-- Constraining types for each given formal
			--| In case someone requests a type set for a single constraint this is just fine.
			--| That is why we have two caches.

feature -- IL code generation

	il_data_name: STRING is
			-- IL class name of class data
		require
			not_is_external: not is_external
		local
			namespace: STRING
			class_name: STRING
			use_dotnet_naming: BOOLEAN
		do
			if is_precompiled then
				namespace := precompiled_namespace
				class_name := precompiled_class_name
				use_dotnet_naming := is_dotnet_naming
			else
				namespace := original_class.actual_namespace
				class_name := name.as_lower
				use_dotnet_naming := System.dotnet_naming_convention
			end
			Result := il_casing.type_name (namespace, data_prefix, class_name, use_dotnet_naming)
		ensure
			result_not_void: Result /= Void
		end

	set_il_name is
			-- Store basic information that will help us reconstruct
			-- a complete name.
		require
			not_is_precompiled: not is_precompiled
		do
			is_dotnet_naming := System.dotnet_naming_convention
			precompiled_namespace := original_class.actual_namespace.twin
			precompiled_class_name := il_casing.type_name (Void, Void, name.as_lower, is_dotnet_naming)
		end

	is_dotnet_naming: BOOLEAN
			-- Is current class being generated using dotnet naming convention?

feature {NONE} -- IL code generation

	precompiled_namespace: STRING
			-- Namespace of this class when it is precompiled

	precompiled_class_name: STRING
			-- Name of this class when it is precompiled

	data_prefix: STRING is "Data"
			-- Prefix in a name of class data

feature -- status

	hash_code: INTEGER is
			-- Hash code value corresponds to `class_id'.
		do
			Result := class_id
		end

feature {CLASS_I} -- Settings

	set_original_class (cl: like original_class) is
			-- Assign `cl' to `lace_class'.
		require
			cl_not_void: cl /= Void
			cl_different_from_current_lace_class: cl /= original_class
		do
			original_class := cl
		ensure
			original_class_set: original_class = cl
		end

feature -- Access

	has_multi_constraints (i: INTEGER): BOOLEAN is
			-- Does i-th generic parameter have multiple constraints?
		require
			has_generics: generics /= Void
		local
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			l_formal_dec ?= generics.i_th (i)
			check l_formal_dec_not_void: l_formal_dec /= Void end
			Result := l_formal_dec.has_multi_constraints
		end

	is_fully_deferred: BOOLEAN is
			-- Are parents of current class either ANY or a fully deferred class?
			-- Does current class contain only deferred features?
		require
			has_feature_table: has_feature_table
			parents_classes_not_void: parents_classes /= Void
		local
			feat: FEATURE_I
			feat_tbl: FEATURE_TABLE
			written_in: INTEGER
			par: like parents_classes
		do
			Result := True
				-- FIXME: Manu 1/21/2002: Test below is not the most correct one.
			if class_id > 1 then
				Result := is_deferred
				if Result then
					from
						par := parents_classes
						par.start
					until
						par.after or else not Result
					loop
						Result := Result and then par.item.is_fully_deferred
						par.forth
					end
					if Result then
						from
							written_in := class_id
							feat_tbl := feature_table
							feat_tbl.start
						until
							feat_tbl.after or else not Result
						loop
							feat := feat_tbl.item_for_iteration
							if feat.written_in = written_in then
								Result := Result and then feat.is_deferred
							end
							feat_tbl.forth
						end
					end
				end
			end
		end

	name_in_upper: STRING is
			-- Class name in upper case
		do
			Result := name
		ensure
			name_in_upper_not_void: Result /= Void
		end

	ast: CLASS_AS is
			-- Associated AST structure
		do
			if Tmp_ast_server.has (class_id) then
				Result := Tmp_ast_server.item (class_id)
			elseif Ast_server.has (class_id) then
				Result := Ast_server.item (class_id)
			end
		ensure
			non_void_result_if: has_ast implies Result /= Void
		end

	invariant_ast: INVARIANT_AS is
			-- Associated invariant AST structure
		do
			if invariant_feature /= Void then
				Result := Inv_ast_server.item (class_id)
			end
		end

	has_types: BOOLEAN is
			-- Are there any generic instantiations of Current
			-- in the system or is Current a non generic class?
		do
			Result := (types /= Void) and then (not types.is_empty)
		end

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end

	feature_with_name_id (a_feature_name_id: INTEGER): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_a_feature_name_id: a_feature_name_id > 0
			has_feature_table: has_feature_table
		local
			f: FEATURE_I
		do
			f := feature_table.item_id (a_feature_name_id)
			if f /= Void then
				Result := f.api_feature (class_id)
			end
		end

	feature_with_id (a_feature_id: ID_AS): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_a_feature_id: a_feature_id /= Void
			has_feature_table: has_feature_table
		local
			f: FEATURE_I
		do
			f := feature_table.item_id (a_feature_id.name_id)
			if f /= Void then
				Result := f.api_feature (class_id)
			end
		end

	frozen feature_with_name (n: STRING): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_n: n /= Void
			has_feature_table: has_feature_table
		local
			l_id: INTEGER
		do
			l_id := names_heap.id_of (n)
			if l_id > 0 then
				Result := feature_with_name_id (l_id)
			end
		end

	feature_with_rout_id (rout_id: INTEGER): E_FEATURE is
			-- Feature whose routine id `rout_id'.
		require
			valid_rout_id: rout_id /= 0
			has_feature_table: has_feature_table
		local
			feat: FEATURE_I
		do
			feat := feature_table.feature_of_rout_id (rout_id)
			if feat /= Void then
				Result := feat.api_feature (class_id)
			end
		end

	feature_with_body_index (a_body_index: INTEGER): E_FEATURE is
			-- Feature whose body index is `a_body_index'.
		require
			a_body_index_non_negative: a_body_index >= 0
			has_feature_table: has_feature_table
		local
			l_feat: FEATURE_I
		do
			l_feat := feature_table.feature_of_body_index (a_body_index)
			if l_feat /= Void then
				Result := l_feat.api_feature (class_id)
			end
		end

	feature_with_feature_id (a_feature_id: INTEGER): E_FEATURE is
			-- Feature whose feature id `a_feature_id.
		require
			feature_id_non_negative: a_feature_id >= 0
			has_feature_table: has_feature_table
		local
			l_feat: FEATURE_I
		do
			l_feat := feature_table.feature_of_feature_id (a_feature_id)
			if l_feat /= Void then
				Result := l_feat.api_feature (class_id)
			end
		end

	feature_of_body_index (a_body_index: INTEGER): FEATURE_I is
			-- Feature whose body index is `a_body_index'.
		require
			a_body_index_non_negative: a_body_index >= 0
			has_feature_table: has_feature_table
		do
			Result := feature_table.feature_of_body_index (a_body_index)
		end

	feature_of_rout_id (a_routine_id: INTEGER): FEATURE_I is
			-- Feature whose routine_id is `a_routine_id'.
			-- Look into `feature_table', `generic_features' and
			-- `anchored_features'.
		require
			rout_id_valid: a_routine_id > 0
			has_feature_table: has_feature_table
		local
			l_cursor: CURSOR
			l_anch: like anchored_features
			l_gen: like generic_features
		do
			Result := feature_table.feature_of_rout_id (a_routine_id)
			if Result = Void then
				l_anch := anchored_features
				if l_anch /= Void then
					from
						l_cursor := l_anch.cursor
						l_anch.start
					until
						l_anch.after or Result /= Void
					loop
						if l_anch.item_for_iteration.rout_id_set.has (a_routine_id) then
							Result := l_anch.item_for_iteration
						end
						l_anch.forth
					end
					l_anch.go_to (l_cursor)
				end
				l_gen := generic_features
				if Result = Void and l_gen /= Void then
					from
						l_cursor := l_gen.cursor
						l_gen.start
					until
						l_gen.after or Result /= Void
					loop
						if l_gen.item_for_iteration.rout_id_set.has (a_routine_id) then
							Result := l_gen.item_for_iteration
						end
						l_gen.forth
					end
					l_gen.go_to (l_cursor)
				end
					-- Check the invariant now.
				if
					Result = Void and
					(invariant_feature /= Void and then
					invariant_feature.rout_id_set.has (a_routine_id))
				then
					Result := invariant_feature
				end
			end
		end

	feature_of_feature_id (a_feature_id: INTEGER): FEATURE_I is
			-- Feature whose feature_id is `a_feature_id'.
			-- Look into `feature_table', `generic_features' and
			-- `anchored_features'.
		require
			a_feature_id_positive: a_feature_id > 0
			has_feature_table: has_feature_table
		local
			l_cursor: CURSOR
			l_anch: like anchored_features
			l_gen: like generic_features
		do
			Result := feature_table.feature_of_feature_id (a_feature_id)
			if Result = Void then
				l_anch := anchored_features
				if l_anch /= Void then
					from
						l_cursor := l_anch.cursor
						l_anch.start
					until
						l_anch.after or Result /= Void
					loop
						if l_anch.item_for_iteration.feature_id = a_feature_id then
							Result := l_anch.item_for_iteration
						end
						l_anch.forth
					end
					l_anch.go_to (l_cursor)
				end
				l_gen := generic_features
				if Result = Void and l_gen /= Void then
					from
						l_cursor := l_gen.cursor
						l_gen.start
					until
						l_gen.after or Result /= Void
					loop
						if l_gen.item_for_iteration.feature_id = a_feature_id then
							Result := l_gen.item_for_iteration
						end
						l_gen.forth
					end
					l_gen.go_to (l_cursor)
				end
			end
		end

	feature_of_name_id (a_name_id: INTEGER): FEATURE_I is
			-- Feature whose feature_id is `a_feature_id'.
			-- Look into `feature_table', `generic_features' and
			-- `anchored_features'.
		require
			a_name_id: a_name_id > 0
			has_feature_table: has_feature_table
		do
			Result := feature_table.item_id (a_name_id)
		end

	api_feature_table: E_FEATURE_TABLE is
			-- Feature table for current class
			--| Can be Void when `feature_table' has not yet
			--| been computed (for example, error at degree 5).
		do
			if feature_table /= Void then
				Result := feature_table.api_table
			end
		end

	once_functions: SORTED_TWO_WAY_LIST [E_FEATURE] is
			-- List of once functions.
		local
			f_table: FEATURE_TABLE
			feat: FEATURE_I
			cid: INTEGER
		do
			cid := class_id
			create Result.make
			f_table := feature_table
			from
				f_table.start
			until
				f_table.after
			loop
				feat := f_table.item_for_iteration
				if feat.is_once and then feat.is_function then
					Result.put_front (feat.api_feature (cid))
				end
				f_table.forth
			end
			Result.sort
		ensure
			non_void_result: Result /= Void
			result_sorted: Result.sorted
		end

	once_routines: SORTED_TWO_WAY_LIST [E_FEATURE] is
			-- List of once features (functions and procedures).
		local
			f_table: FEATURE_TABLE
			feat: FEATURE_I
			cid: INTEGER
		do
			cid := class_id
			create Result.make
			f_table := feature_table
			from
				f_table.start
			until
				f_table.after
			loop
				feat := f_table.item_for_iteration
				if feat.is_once then
					Result.put_front (feat.api_feature (cid))
				end
				f_table.forth
			end
			Result.sort
		ensure
			non_void_result: Result /= Void
			result_sorted: Result.sorted
		end

	is_valid: BOOLEAN is
			-- Is the current class valid?
			-- (After a compilation Current may become
			-- invalid)
		do
			Result := class_id > 0 and then lace_class.is_valid and then class_id <= System.classes.array_count
				and then System.class_of_id (class_id) = Current
		end

	written_in_features: LIST [E_FEATURE] is
			-- List of features defined in current class
		require
			has_feature_table: has_feature_table
		do
			Result := feature_table.written_in_features
		ensure
			non_void_Result: Result /= Void
		end

	is_class_any: BOOLEAN
			-- Is it class ANY?

	is_class_none: BOOLEAN
			-- Is it class NONE?

feature -- Precompilation Access

	is_precompiled: BOOLEAN is
			-- Is class precompiled?
		do
			Result := System.class_counter.is_precompiled (class_id)
		end

feature -- Server Access

	has_ast: BOOLEAN is
			-- Does Current class have an AST structure?
		do
			Result := Ast_server.has (class_id) or else Tmp_ast_server.has (class_id)
		end

	group: CONF_GROUP is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.group
		ensure
			group_not_void: Result /= Void
		end

	file_name: STRING is
			-- File name of the class
		do
			Result := lace_class.file_name
		ensure
			file_name_not_void: Result /= Void
		end

	file_is_readable: BOOLEAN is
			-- Is file with `file_name' readable?
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (file_name)
			Result := f.exists and f.is_readable
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Order relation on classes
		do
			Result := topological_id < other.topological_id
		end

feature -- Output

	class_signature: STRING is
			-- Signature of class
		local
			formal_dec: FORMAL_DEC_AS
			old_group: CONF_GROUP
			gens: like generics
		do
			create Result.make (50)
			Result.append (name)
			gens := generics
			if gens /= Void then
				old_group := Inst_context.group
				Inst_context.set_group (group)
				Result.append (" [")
				from
					gens.start
				until
					gens.after
				loop
					formal_dec := gens.item
					Result.append (formal_dec.constraint_string)
					gens.forth
					if not gens.after then
						Result.append (", ")
					end
				end
				Inst_context.set_group (old_group)
				Result.append ("]")
			end
		ensure
			class_signature_not_void: Result /= Void
		end

	append_header (a_text_formatter: TEXT_FORMATTER) is
			-- Append class header to `a_text_formatter'.
		do
			if is_expanded then
				a_text_formatter.process_keyword_text (ti_Expanded_keyword, Void)
				a_text_formatter.add_space
			elseif is_deferred then
				a_text_formatter.process_keyword_text (ti_Deferred_keyword, Void)
				a_text_formatter.add_space
			end
			a_text_formatter.process_keyword_text (ti_Class_keyword, Void)
			a_text_formatter.add_new_line
			a_text_formatter.add_indent
			append_signature (a_text_formatter, False)
			a_text_formatter.add_new_line
		end

	append_signature (a_text_formatter: TEXT_FORMATTER; a_with_deferred_symbol: BOOLEAN) is
			-- Append the signature of current class in `a_text_formatter'. If `a_with_deferred_symbol'
			-- then add a `*' to the class name.
		require
			non_void_st: a_text_formatter /= Void
		do
			append_signature_internal (a_text_formatter, a_with_deferred_symbol, False)
		end

	append_short_signature (a_text_formatter: TEXT_FORMATTER; a_with_deferred_symbol: BOOLEAN) is
			-- Append short signature of current class in `a_text_formatter'.
			-- Short signature is to use "..." to replace constrained generic type, so
			-- class {HASH_TABLE [G, H -> HASHABLE]} becomes {HASH_TABLE [G, H -> ...]}.
			-- Short signature is used to save some display space.
			-- If `a_with_deferred_symbol' then add a `*' to the class name.
		require
			non_void_st: a_text_formatter /= Void
		do
			append_signature_internal (a_text_formatter, a_with_deferred_symbol, True)
		end

	append_name (a_text_formatter: TEXT_FORMATTER) is
			-- Append the name ot the current class in `a_text_formatter'
		require
			non_void_st: a_text_formatter /= Void
		do
			a_text_formatter.add_class (lace_class)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_main_parent (cl: like main_parent) is
			-- Assign `cl' to `main_parent'.
		require
			cl_not_void: cl /= Void
			il_generation: System.il_generation
		do
			main_parent := cl
		ensure
			main_parent_set: main_parent = cl
		end

	set_number_of_features (n: like number_of_features) is
			-- Assign `n' to `number_of_features'.
		do
			number_of_features := n
		ensure
			number_of_features_set: number_of_features = n
		end

	set_topological_id (i: INTEGER) is
			-- Assign `i' to `topological_id'.
		do
			topological_id := i
		ensure
			topological_id_set: topological_id = i
		end

	set_is_deferred (b: BOOLEAN) is
			-- Assign `b' to `is_deferred'.
		do
			is_deferred := b
		ensure
			is_deferred_set: is_deferred = b
		end

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
		ensure
			is_expanded_set: is_expanded = b
		end

	set_is_enum (b: BOOLEAN) is
			-- Assign `b' to `is_enum'.
		require
			il_generation: System.il_generation
		do
			is_enum := b
		ensure
			is_enum_set: is_enum = b
		end

	set_suppliers (s: like suppliers) is
			-- Assign `s' to `suppliers'.
		do
			suppliers := s
		ensure
			suppliers_set: suppliers = s
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g
			if g /= Void then
				create constrained_type_cache.make (g.count)
				create constrained_types_cache.make (g.count)
			end
		ensure
			generics_set: generics = g
		end

	set_obsolete_message (m: like obsolete_message) is
			-- Set `obsolete_message' to `m'.
		do
			obsolete_message := m
		ensure
			obsolete_message_set: obsolete_message = m
		end

	set_generic_features (f: like generic_features) is
			-- Set `generic_features' to `f'.
		require
			f_not_void: f /= Void
		do
			generic_features := f
		ensure
			generic_features_set: generic_features = f
		end

feature -- Genericity

	invalidate_caches_related_to_generics
			-- Invalidates the cache which stores computed renamings
		do
			constraint_cache := Void
		ensure
			constraint_cache_void: constraint_cache = Void
		end

	formal_at_position (n: INTEGER): TYPE_FEATURE_I is
			-- Find first TYPE_FEATURE_I in `generic_features' that
			-- matches position `n'.
		require
			has_formal: is_generic
			generic_features_computed: generic_features /= Void
		local
			l_formals: like generic_features
			l_formal: FORMAL_A
			l_cursor: CURSOR
		do
			from
				l_formals := generic_features
				l_cursor := l_formals.cursor
				l_formals.start
			until
				l_formals.after or Result /= Void
			loop
				l_formal ?= l_formals.item_for_iteration.type
				if l_formal /= Void and then l_formal.position = n then
					Result := l_formals.item_for_iteration
				end
				l_formals.forth
			end
			l_formals.go_to (l_cursor)
		ensure
			result_not_void: Result /= Void
		end

	update_generic_features is
			-- Update `generic_features' with information of Current.
		require
			parents_not_void: parents /= Void
		local
			l_parents: like parents
			l_formal, l_parent_formal: TYPE_FEATURE_I
			l_formal_type: FORMAL_A
			l_generic_features, l_old: like generic_features
			l_inherited_formals: SEARCH_TABLE [INTEGER]
			l_rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
			l_formal_dec: FORMAL_DEC_AS
			l_formals: SPECIAL [TYPE_FEATURE_I]
		do
				-- Clean previously stored information.
			l_old := generic_features
			if l_old /= Void and is_generic then
					-- We prepare a fast lookup table so that
					-- no new routine IDs are assigned to formal generic
					-- parameters of a class which introduce them if the class
					-- is processed at degree 4 and nothing really changed.
					-- Fixes eweasel test#incrXXX.
				create l_formals.make (generics.count + 1)
				from
					l_old.start
				until
					l_old.after
				loop
					l_formal_type ?= l_old.item_for_iteration.type
					if
							-- We check that the previous formal was written in the Current class and that
							-- it is still makes sense. A case where it does not make sense is when the Current
							-- class has less generics than before.
						(l_formal_type /= Void and l_old.item_for_iteration.written_in = class_id) and then
						l_formals.valid_index (l_formal_type.position)
					then
						check
							not_inserted: l_formals.item (l_formal_type.position) = Void
						end
						l_formals.put (l_old.item_for_iteration, l_formal_type.position)
					end
					l_old.forth
				end
			end
			generic_features := Void

				-- Collect all information about parent formal generic parameters.
			from
				l_parents := parents
				l_parents.start
			until
				l_parents.after
			loop
				l_generic_features := l_parents.item.associated_class.generic_features
				if l_generic_features /= Void then
					from
						l_generic_features.start
					until
						l_generic_features.after
					loop
							-- Extract parent generic parameter and perform instantiation
							-- in current class.
						l_parent_formal := l_generic_features.item_for_iteration
						l_formal := l_parent_formal.duplicate
						l_formal.set_type (l_formal.type.instantiated_in (l_parents.item))
						l_formal.set_is_origin (False)
						if l_old /= Void and then l_old.has (l_formal.rout_id_set.first) then
							l_formal.set_feature_id (
								l_old.item (l_formal.rout_id_set.first).feature_id)
						else
							l_formal.set_feature_id (feature_id_counter.next)
						end
						l_formal.set_origin_feature_id (l_parent_formal.origin_feature_id)

						if not l_formal.type.same_as (l_parent_formal.type) then
								-- If there is an implicit type change of the formal
								-- generic parameter, then we need to generate
								-- a new body for specifying the new type of the formal
								-- generic parameter.
							l_formal.set_written_in (class_id)
						end

						extend_generic_features (l_formal)
						l_generic_features.forth
					end
				end
				l_parents.forth
			end

			l_generic_features := generic_features

			if is_generic then
				create l_inherited_formals.make (generics.count)
				if l_generic_features = Void then
					create l_generic_features.make (generics.count)
					generic_features := l_generic_features
				else
					from
						l_generic_features.start
					until
						l_generic_features.after
					loop
						l_formal := l_generic_features.item_for_iteration
						if l_formal.is_formal then
							l_formal_type ?= l_formal.type
							l_inherited_formals.put (l_formal_type.position)
						end
						l_generic_features.forth
					end
				end

				from
					i := 1
					nb := generics.count
				until
					i > nb
				loop
					if not l_inherited_formals.has (i) then
						l_formal_dec := generics.i_th (i)
						create l_formal_type.make (l_formal_dec.is_reference,
							l_formal_dec.is_expanded, i)

						create l_formal
						l_formal.set_feature_name ("_" + name + "_Formal#" + i.out)
						l_formal.set_type (l_formal_type)
						l_formal.set_written_in (class_id)
						l_formal.set_origin_class_id (class_id)

						if l_formals /= Void and then l_formals.item (i) /= Void then
								-- Reuse existing TYPE_FEATURE_I information for routine IDs and feature ID.
							l_rout_id_set := l_formals.item (i).rout_id_set
							l_formal.set_feature_id (l_formals.item (i).feature_id)
						else
							create l_rout_id_set.make
							l_rout_id_set.put (l_formal.new_rout_id)
							l_formal.set_feature_id (feature_id_counter.next)
						end
						l_formal.set_rout_id_set (l_rout_id_set)
						l_formal.set_is_origin (True)
						l_formal.set_position (i)
						l_formal.set_origin_feature_id (l_formal.feature_id)
						l_generic_features.put (l_formal, l_rout_id_set.first)
					end
					i := i + 1
				end
			else
					-- FIXME: Manu 01/02/2002. Add assertion that shows
					-- that all TYPE_FEATURE_I.type of `l_generic_features'
					-- are not instances of FORMAL_I.
			end

 			debug ("FORMAL_GENERIC")
				if l_generic_features /= Void then
					print ("%NFor class " + name + ": " + l_generic_features.count.out)
					print (" local + inherited generic parameters%N")
				end
 			end
		end

feature {NONE} -- Genericity

	extend_generic_features (an_item: TYPE_FEATURE_I) is
			-- Insert `an_item' in `generic_features'. If `generic_features'
			-- is not yet created, creates it.
		require
			an_item_not_void: an_item /= Void
		local
			l_generic_features: like generic_features
			l_rout_id_set: ROUT_ID_SET
			l_rout_id, i, nb: INTEGER
		do
			l_generic_features := generic_features
			if l_generic_features = Void then
				create l_generic_features.make (5)
				generic_features := l_generic_features
			end

			from
				l_rout_id_set := an_item.rout_id_set
				i := 1
				nb := l_rout_id_set.count
			until
				i > nb
			loop
				l_rout_id := l_rout_id_set.item (i)
				if not l_generic_features.has (l_rout_id) then
					l_generic_features.put (an_item, l_rout_id)
				else
						-- Should we report an error in this case, as it is not
						-- well implemented by compiler? Meaning that we have
						-- some repeated inheritance of generic parameters.
				end

				i := i + 1
			end
		end

feature -- Anchored types

	update_anchors is
			-- Update `anchored_features' with information of Current.
		require
			il_generation: System.il_generation
		local
			l_feat_tbl: like feature_table
			l_anchor, l_previous_anchor: TYPE_FEATURE_I
			l_anchored_features, l_old: like anchored_features
			l_inherited_features: like anchored_features
			l_parents: like parents_classes
			l_feat: FEATURE_I
			l_rout_id: INTEGER
			l_rout_id_set: ROUT_ID_SET
			l_type_set: SEARCH_TABLE [INTEGER]
			l_select: SELECT_TABLE
			l_type: TYPE_A
		do
				-- Get all inherited anchored features.
			from
				create l_inherited_features.make (0)
				l_parents := parents_classes
				l_parents.start
			until
				l_parents.after
			loop
				l_old := l_parents.item.anchored_features
				if l_old /= Void then
					l_inherited_features.merge (l_old)
				end
				l_parents.forth
			end

				-- Initialize `l_type_set'
			from
				l_feat_tbl := feature_table
				l_type_set := type_set
				l_feat_tbl.start
			until
				l_feat_tbl.after
			loop
				l_feat := l_feat_tbl.item_for_iteration
				if l_feat.is_attribute then
					l_type := l_feat.type.actual_type
					if l_type.is_formal or l_type.has_generics then
						if l_type_set = Void then
							create l_type_set.make (5)
						end
						l_type_set.put (l_feat.rout_id_set.first)
					end
				end
				l_feat_tbl.forth
			end

				-- Create `anchored_features' if needed and fill it with inherited
				-- anchors.
			from
				l_old := anchored_features
				create l_anchored_features.make (10)
				l_select := feature_table.select_table
				l_select.start
			until
				l_select.after
			loop
				l_rout_id := l_select.key_for_iteration
				if
					(l_type_set /= Void and then l_type_set.has (l_rout_id)) or
					l_inherited_features.has (l_rout_id)
				then
					l_feat := l_select.item_for_iteration

					create l_anchor
					l_anchor.set_type (l_feat.type.actual_type)
					l_anchor.set_written_in (class_id)

					create l_rout_id_set.make
					l_rout_id_set.put (l_rout_id)
					l_anchor.set_rout_id_set (l_rout_id_set)

					if l_old /= Void and then l_old.has (l_rout_id) then
						l_anchor.set_feature_id (l_old.item (l_rout_id).feature_id)
					else
						l_anchor.set_feature_id (feature_id_counter.next)
					end

					if l_inherited_features.has (l_rout_id) then
						l_previous_anchor := l_inherited_features.item (l_rout_id)
						l_anchor.set_origin_class_id (l_previous_anchor.origin_class_id)
						l_anchor.set_origin_feature_id (l_previous_anchor.origin_feature_id)
						l_anchor.set_feature_name_id (l_previous_anchor.feature_name_id, 0)
						l_anchor.set_is_origin (False)
					else
						l_anchor.set_is_origin (True)
						l_anchor.set_origin_class_id (class_id)
						l_anchor.set_origin_feature_id (l_anchor.feature_id)
						l_anchor.set_feature_name ("_" + System.name + "_type_" + l_rout_id.out)
					end

					l_anchored_features.put (l_anchor, l_rout_id)
				end
				l_select.forth
			end

 			debug ("ANCHORED_FEATURES")
				if l_anchored_features /= Void then
					print ("%NFor class " + name + ": " + l_anchored_features.count.out)
					print (" local + inherited generic parameters%N")
				end
 			end

			anchored_features := l_anchored_features
		end

	extend_type_set (r_id: INTEGER) is
			-- Extend `type_set' with `r_id'. If `type_set' is
			-- not yet created, creates it.
		require
			valid_routine_id: r_id > 0
			il_generation: System.il_generation
		local
			l_type_set: like type_set
		do
			l_type_set := type_set
			if l_type_set = Void then
				create l_type_set.make (10)
				type_set := l_type_set
			end
			l_type_set.force (r_id)
		ensure
			inserted: type_set.has (r_id)
		end

feature -- Implementation

	invariant_feature: INVARIANT_FEAT_I
			-- Invariant feature

	types: TYPE_LIST
			-- Meta-class types associated to the class: it contains
			-- only one type if the class is not generic

	feature_named (n: STRING): FEATURE_I is
			-- Feature whose internal name is `n'
		require
			n_not_void: n /= Void
		do
			if not n.is_empty and then has_feature_table then
				if feature_table.is_mangled_alias_name (n) then
						-- Lookup for alias feature
					Result := feature_table.alias_item (n)
				else
						-- Lookup for identifier feature
					Result := feature_table.item (n)
				end
			end
		end

feature -- Implementation

	set_current_feature_table (a_tbl: like feature_table) is
		do
			current_feature_table := a_tbl
		ensure
			current_feature_table_set: current_feature_table = a_tbl
		end

	set_previous_feature_table (a_tbl: like feature_table) is
		do
			previous_feature_table := a_tbl
		ensure
			previous_feature_table_set: previous_feature_table = a_tbl
		end

	previous_feature_table, current_feature_table: FEATURE_TABLE

	feature_table: FEATURE_TABLE is
			-- Compiler feature table
		require
			has_feature_table: has_feature_table
		do
			Result := current_feature_table
			if Result = Void then
				Result := previous_feature_table
			end
		ensure
			valid_result: Result /= Void
		end

	has_feature_table: BOOLEAN is
			-- Has Current a feature table
		do
			Result := current_feature_table /= Void or previous_feature_table /= Void
		end

feature {NONE} -- Implementation

	private_external_name: STRING
			-- Store class alias name clause value.

	private_base_file_name: STRING
			-- Base file name used in code generation.

feature {DEGREE_5} -- Degree 5

	add_to_degree_5 is
			-- Add current class to Degree 5.
		do
			degree_5_needed := True
		ensure
			added: degree_5_needed
		end

	remove_from_degree_5 is
			-- Remove current class from Degree 5.
		do
			degree_5_needed := False
			parsing_needed := False
		ensure
			removed: not degree_5_needed
		end

	degree_5_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree 5?

	parsing_needed: BOOLEAN
			-- Does current class need to be
			-- parsed during Degree 5?

	set_parsing_needed (b: BOOLEAN) is
			-- Set `parsing_needed' to `b'.
		do
			parsing_needed := b
		ensure
			parsing_needed_set: parsing_needed = b
		end

feature {DEGREE_4, NAMED_TUPLE_TYPE_A} -- Degree 4

	add_to_degree_4 is
			-- Add current class to Degree 4.
		do
			degree_4_needed := True
		ensure
			added: degree_4_needed
		end

	remove_from_degree_4 is
			-- Remove current class from Degree 4.
		do
			degree_4_needed := False
			degree_4_processed := False
			expanded_modified := False
			deferred_modified := False
			supplier_status_modified := False
		ensure
			removed: not degree_4_needed
		end

	degree_4_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree 4?

	degree_4_processed: BOOLEAN
			-- Has current class been processed in
			-- first pass of Degree 4?

	expanded_modified: BOOLEAN
			-- Has the expanded status of current
			-- class been modified?

	supplier_status_modified: BOOLEAN
			-- Has the status of a supplier changed?

	set_degree_4_processed is
			-- Set `degree_4_processed' to True.
		do
			degree_4_processed := True
		ensure
			degree_4_processed_set: degree_4_processed
		end

	set_expanded_modified is
			-- Set `expanded_modifed' to True.
		do
			expanded_modified := True
		ensure
			expanded_modified_set: expanded_modified
		end

	set_deferred_modified is
			-- Set `deferred_modified' to True.
		do
			deferred_modified := True
		ensure
			deferred_modified_set: deferred_modified
		end

	set_supplier_status_modified is
			-- Set `supplier_status_modified' to True.
		do
			supplier_status_modified := True
		ensure
			supplier_status_modified_set: supplier_status_modified
		end

feature {DEGREE_4, INHERIT_TABLE} -- Degree 4

	deferred_modified: BOOLEAN
			-- Has the deferred status of current
			-- class been modified?

feature {DEGREE_4, DEGREE_3} -- Used by degree 4 and 3 to compute new assertions

	assert_prop_list: LINKED_LIST [INTEGER]
			-- List of routine ids to be propagated

	set_assertion_prop_list (l: like assert_prop_list) is
			-- Set `assert_prop_list' to `l'.
		do
			assert_prop_list := l
		ensure
			assert_prop_list_set: assert_prop_list = l
		end

feature {DEGREE_3} -- Degree 3

	add_to_degree_3 is
			-- Add current class to Degree 3.
			-- Set `finalization_needed' to True
		require
			not_a_true_external_class: not is_true_external
		do
			degree_3_needed := True
			finalization_needed := True
		ensure
			added: degree_3_needed
			finalization_needed_set: finalization_needed
		end

	remove_from_degree_3 is
			-- Remove current class from Degree 3.
		do
			degree_3_needed := False
		ensure
			removed: not degree_3_needed
		end

	degree_3_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree 3?

feature {DEGREE_2} -- Degree 2

	add_to_degree_2 is
			-- Add current class to Degree 2.
		require
			not_a_true_external_class: not is_true_external
		do
			degree_2_needed := True
		ensure
			added: degree_2_needed
		end

	remove_from_degree_2 is
			-- Remove current class from Degree 2.
		do
			degree_2_needed := False
		ensure
			removed: not degree_2_needed
		end

	degree_2_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree 2?

feature {DEGREE_1} -- Degree 1

	add_to_degree_1 is
			-- Add current class to Degree 1.
		require
			not_a_true_external_class: not is_true_external
		do
			degree_1_needed := True
		ensure
			added: degree_1_needed
		end

	remove_from_degree_1 is
			-- Remove current class from Degree 1.
		do
			degree_1_needed := False
		ensure
			removed: not degree_1_needed
		end

	degree_1_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree 1?

feature {DEGREE_MINUS_1, IL_GENERATOR} -- Degree -1

	add_to_degree_minus_1 is
			-- Add current class to Degree -1.
		require
			not_a_true_external_class: not is_true_external
		do
			degree_minus_1_needed := True
		ensure
			added: degree_minus_1_needed
		end

	remove_from_degree_minus_1 is
			-- Remove current class from Degree -1.
		do
			degree_minus_1_needed := False
		ensure
			removed: not degree_minus_1_needed
		end

	degree_minus_1_needed: BOOLEAN
			-- Does current class need to be
			-- processed in Degree -1?

feature -- Degree -2/-3

	finalization_needed: BOOLEAN
			-- Does current class need to be processed for
			-- finalization?

	set_finalization_needed (v: BOOLEAN) is
			-- Assign `finalization_needed' with `v'.
		do
			finalization_needed := v
		ensure
			finalization_needed_set: finalization_needed = v
		end

feature -- output

	debug_output: STRING is
			-- Generate a nice representation of Current to be seen
			-- in debugger.
		local
			l_name: STRING
		do
			l_name := name
			create Result.make (l_name.count + 6)
			Result.append_integer (class_id)
			Result.append_character (':')
			Result.append_character (' ')
			Result.append (l_name)
		end

feature {NONE} -- Implementation

	internal_feature_table_file_id: INTEGER
			-- Number added at end of C file corresponding to generated
			-- feature table. Initialized by default to -1.

	append_signature_internal (a_text_formatter: TEXT_FORMATTER; a_with_deferred_symbol: BOOLEAN; a_short: BOOLEAN) is
			-- Append the signature of current class in `a_text_formatter'. If `a_with_deferred_symbol'
			-- then add a `*' to the class name.
			-- If `a_short', use "..." to replace constrained generic type.
		require
			non_void_st: a_text_formatter /= Void
		local
			formal_dec: FORMAL_CONSTRAINT_AS
			old_group: CONF_GROUP
			gens: like generics
		do
			append_name (a_text_formatter)
			if a_with_deferred_symbol and is_deferred then
				a_text_formatter.add_char ('*')
			end
			gens := generics
			if gens /= Void then
				old_group := Inst_context.group
				Inst_context.set_group (group)
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (ti_L_bracket)
				from
					gens.start
				until
					gens.after
				loop
					formal_dec ?= gens.item
					check formal_dec_not_void: formal_dec /= Void end
					formal_dec.append_signature (a_text_formatter, a_short, Current)
					gens.forth
					if not gens.after then
						a_text_formatter.process_symbol_text (ti_Comma)
						a_text_formatter.add_space
					end
				end
				a_text_formatter.process_symbol_text (ti_R_bracket)
				Inst_context.set_group (old_group)
			end
		end

invariant

		-- Default invariants common to all kind of generation.
	lace_class_exists: lace_class /= Void
	descendants_exists: direct_descendants /= Void
	suppliers_exisis: suppliers /= Void
	clients_exists: clients /= Void
	config_class_connection: original_class.compiled_class = Current

		-- Invariants IL versus normal generation.
	anchored_features_void_in_non_il_generation:
		not System.il_generation implies anchored_features = Void

	-- True after proper initialization of Current instance.
	-- has_ast: has_ast

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class CLASS_C


