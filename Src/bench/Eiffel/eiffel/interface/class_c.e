indexing
	description: "Representation of a compiled class."
	date: "$Date$"
	revision: "$Revision $"

class CLASS_C

inherit
	CLASS_C_ROUTINES
		export
			{ANY} feature_table, types, invariant_feature
		end

	SHARED_COUNTER

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

	SHARED_TYPES

	SHARED_TYPEID_TABLE

	SHARED_CODE_FILES

	SHARED_BODY_ID

	SHARED_EIFFEL_PARSER

	HASHABLE

	SK_CONST

	SHARED_ASSERTION_LEVEL

	COMPILER_EXPORTER

	SHARED_GENERATION

creation

	make
	
feature {NONE} -- Initialization

	make (l: CLASS_I) is
			-- Creation of Current class
		require
			good_argument: l /= Void
		do
			initialize (l)
				-- Creation of a conformance table
			!! conformance_table.make (1,1)
				-- Creation of the syntactical supplier list
			!! syntactical_suppliers.make
				-- Creation of the syntactical client list
			!! syntactical_clients.make
				-- Filter list creation
			!! filters.make
			filters.compare_objects
				-- Feature id counter creation
			!! feature_id_counter
				-- Changed features list creation
			!! changed_features.make (20)
				-- Propagator set creation
			!! propagators.make
		end

feature -- Access

	syntactical_suppliers: LINKED_LIST [SUPPLIER_CLASS]
			-- Syntactical suppliers of the class
			--| Useful for time-stamp

	syntactical_clients: LINKED_LIST [CLASS_C]
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
			Result := propagators.make_pass3
		end -- changed3

	changed3a : BOOLEAN
			-- Type check?

	changed4: BOOLEAN
			-- Has the class a new class type ?

	is_removable: BOOLEAN is
			-- May current class be removed from system?
		do
			Result := not is_precompiled
		end

	is_modifiable: BOOLEAN is
			-- Is current class not part of a precompiled library?
		do
			Result := not is_precompiled
		end

	is_debuggable: BOOLEAN is
			-- Is the class able to be debugged?
			-- (not if it doesn't have class types
			-- or is a special class)
		do
			Result := (not (is_special or else is_basic)) and then has_types
		end

	is_used_as_separate: BOOLEAN
			-- Is the class used as a separate class ?

	has_expanded: BOOLEAN
			-- Does the class use expanded ?

	is_used_as_expanded: BOOLEAN
			-- Is `Current' used as an expanded class ?

	conformance_table: ARRAY [BOOLEAN]
			-- Conformance table of the class: once a class has changed
			-- it must be reprocessed and the conformance table of the
			-- recursive descendants also.

	filters: FILTER_LIST 	-- ## FIXME 2.3 Patch: redefinition of equal in
							-- GEN_TYPE_I
			-- Filters associated to the class: useful for recalculating
			-- the type system: it is empty if the class is a non-generic
			-- one.

	feature_id_counter: COUNTER
			-- Counter of feature ids

	has_unique: BOOLEAN
			-- Does class have unique feature(s)?

	changed_features: SEARCH_TABLE [STRING]
			-- Names of the changed features

	propagators: PASS3_CONTROL
			-- Set of class ids of the classes responsible for
			-- a type check of the current class
	
	creators: EXTEND_TABLE [EXPORT_I, STRING]
			-- Creation procedure names

	creation_feature: FEATURE_I
			-- Creation feature for expanded types

	melted_set: TWO_WAY_SORTED_SET [MELTED_INFO]
			-- Melting information list
			-- [Processed by the third pass.]

	skeleton: GENERIC_SKELETON
			-- Attributes skeleton

	changed: BOOLEAN is
			-- Is the class syntactically changed ?
		do	
			Result := lace_class.changed
		end

	already_compiled: BOOLEAN is
			-- Has the class already been compiled before the current
			-- compilation ?
		do
			Result := Ast_server.has (id)
		end

	generate_descriptors: BOOLEAN
			-- Does `Current' have to generate its descriptor table?

	must_be_recompiled: BOOLEAN
			-- Does `Current' have to be regenerated at the C level?

	set_must_be_recompiled (v: BOOLEAN) is
			-- Make `Current' a class which needs to be regenerated at the C level.
		do
			must_be_recompiled := v
		end

	set_generate_descriptors (v: BOOLEAN) is
			-- Make `Current' a class which needs to generate its descriptor table.
		do
			generate_descriptors := v
		end

	clear_compilation_flags is
			-- Reset all the compilation flags `generate_descriptors' and
			-- `must_be_recompiled'.
		do
			generate_descriptors := False
			must_be_recompiled := False
		end

feature -- Action

	build_ast: CLASS_AS is
			-- Parse the file and generate the AST
		local
			parser: like eiffel_parser
			file, copy_file: RAW_FILE
			f_name: FILE_NAME
			class_file_name: STRING
			vd21: VD21
		do
			class_file_name := file_name
			!!file.make (class_file_name)

				-- Check if the file to parse is readable
			if not file.exists or else not file.is_readable then
					-- Need to check for existance for the quick melt operation
					-- since it doesn't remove unused classes.
				!!vd21
				vd21.set_cluster (cluster)
				vd21.set_file_name (class_file_name)
				Error_handler.insert_error (vd21)
					-- Cannot go on here
				Error_handler.raise_error
					--
					-- NOT REACHED
					--
				check
					False
				end
			end
			check
				file.is_readable
			end

			file.open_read
			check
				file.is_open_read
			end

				-- Save the source class in a Backup directory
			if Workbench.automatic_backup then
				!! f_name.make_from_string (cluster.backup_directory)
				f_name.extend (lace_class.base_name)
				!! copy_file.make (f_name)
				if copy_file.is_creatable then
					copy_file.open_write
					file.readstream (file.count)
					file.start
					copy_file.putstring (file.laststring)
					copy_file.close
				end
			end

			has_unique := False

				-- Call Eiffel parser
			parser := Eiffel_parser
			parser.parse (file)
			Result := parser.root_node

			file.close
			Error_handler.checksum
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened
				if not (file = Void or else file.is_closed) then
					file.close
				end
			end
		end
	
	end_of_pass1 (ast_b: CLASS_AS) is
				-- End of the first pass after syntax analysis
		local
			supplier_list: LINKED_LIST [ID_AS]
			class_info: CLASS_INFO
				-- Temporary structure to build about the current class
				-- which will be useful for second pass.
			parent_list: EIFFEL_LIST [PARENT_AS]
			invariant_info: READ_INFO
			old_syntactical_suppliers: like syntactical_suppliers
			unique_values: HASH_TABLE [INTEGER, STRING]
				-- Stores the values of the unique attributes
			unique_counter: COUNTER
				-- Counter for unique features
		do
				-- Check suppliers of parsed class represented by `ast_b'.
				-- Supplier classes not present already in the system
				-- are introduced in it, after having verified that they
				-- are avaible in the universe.
				-- Empty syntactical supplier list from compilation
				-- to another one after duplicating it.
			old_syntactical_suppliers := syntactical_suppliers
			!! syntactical_suppliers.make
			supplier_list := ast_b.suppliers.supplier_ids
			if not supplier_list.empty then
				check_suppliers (supplier_list)
			end
			parent_list := ast_b.parents
			if parent_list /= Void then

-- FIXME add incrementality check  Type check error d.add (Current) of type B not conform to A ...
				check_parent_classes (parent_list)
			end

				-- Process a compiled form of the parents
			class_info := ast_b.info
			class_info.set_id (id)

				-- Initialization of the current class
			init (ast_b, class_info, old_syntactical_suppliers)

				-- Check sum error
			Error_handler.checksum
			check
				No_error: not Error_handler.has_error
			end

				-- The class has not been removed (modification of the
				-- number of generics)
if System.class_of_id (id) /= Void then
				-- Update syntactical supplier/client relations and take
				-- care of removed classes
			update_syntactical_relations (old_syntactical_suppliers)

				-- Save the abstract syntax tree: the AST of a class
				-- (instance of CLASS_C) is retrieved through the feature
				-- `id' of CLASS_C and file ".TMP_AST".
			ast_b.set_id (id)
			Tmp_ast_server.put (ast_b)

			if has_unique then
				!! unique_counter
				!! unique_values.make (7)

				ast_b.assign_unique_values (unique_counter, unique_values)

					-- Compute the values of the unique constants
				class_info.set_unique_values (unique_values)
			end
 
				-- Save index left by the temporary ast server into the
				-- class information.
			class_info.set_index (clone (Tmp_ast_server.index))
			invariant_info := Tmp_ast_server.invariant_info
			if invariant_info /= Void then
				class_info.set_invariant_info (Tmp_ast_server.invariant_info)
				Tmp_inv_ast_server.force (invariant_info, id)
			end

				-- Put class information in class information table for
				-- feature `init'.
			Tmp_class_info_server.put (class_info)

				-- Clear index of the temporary ast server for next first
				-- pass
			Tmp_ast_server.clear_index

				-- Clean the filters, i.e. remove all the obsolete types
			filters.clean
end
		ensure
			No_error: not Error_handler.has_error
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened
				if old_syntactical_suppliers /= Void then
					syntactical_suppliers.copy (old_syntactical_suppliers)
				end
			end
		end

feature -- Conformance dependenies

	conf_dep_table: ARRAY [BOOLEAN]
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
			loc_tab: ARRAY [BOOLEAN]
		do
			topid := a_class.topological_id

			if conf_dep_table = Void then
				!! conf_dep_table.make (0, topid + 32)

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
				!! conf_dep_classes.make
				!! conf_dep_table.make (0, topid + 32)
			end

			loc_list := conf_dep_classes
			loc_tab := conf_dep_table

			if topid > loc_tab.upper then
					-- Table needs resizing
				loc_tab.resize (0, topid + 32)
			end

			if not loc_tab.item (topid) then
				loc_list.extend (a_class)
				loc_list.forth
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

	has_dep_class (a_class : CLASS_C) : BOOLEAN is
			-- Is `a_class' in `conf_dep_classes'?
		require
			not_void : a_class /= Void
		local
			topid: INTEGER
			loc_tab: ARRAY [BOOLEAN]
		do
			topid := a_class.topological_id
			loc_tab := conf_dep_table

			Result := (loc_tab /= Void)
					and then (topid <= loc_tab.upper)
					and then loc_tab.item (topid)
		end
 
feature -- Building conformance table

	fill_conformance_table is
			-- Fill the conformance table. All the class processed
			-- during second pass must see their conformance table
			-- processed/re-processed by this routine.
		require
			topological_id_processed: topological_id > 0
		do
				-- Resize the table after the topological sort
			conformance_table.resize (1, topological_id)
			conformance_table.clear_all
			conf_dep_table := Void
			build_conformance_table_of (Current)
		end

	build_conformance_table_of (cl: CLASS_C) is
			-- Build recursively the conformance table of class `cl.
		require
			good_argument: cl /= Void
			conformance_table_exists: cl.conformance_table /= Void
			topological_id_processed: topological_id > 0
			conformance: topological_id <= cl.topological_id
		local
			a_parent: CLASS_C
			a_table: ARRAY [BOOLEAN]
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
		do
			a_table := cl.conformance_table
			if a_table.item (topological_id) = False then
					-- The parent has not been inserted yet
				a_table.put (True, topological_id)
				from
					l_area := parents.area
					nb := parents.count
				until
					i = nb
				loop
					a_parent := l_area.item (i).associated_class
					if a_parent /= Void then
						a_parent.build_conformance_table_of (cl)
					end
					i := i + 1
				end
			end
		end

feature -- Expanded rues validity

	check_expanded is
			-- Check the expanded validity rule.
			-- Pass 2 must be done on all the classes
			-- (the creators must be up to date)
		local
			constraint_type: TYPE_A
		do
debug ("CHECK_EXPANDED")
io.error.putstring ("Checking expanded for: ")
io.error.putstring (name)
io.error.new_line
end
			feature_table.check_expanded
			if generics /= Void then
				from
					generics.start
				until
					generics.after
				loop
					constraint_type := generics.item.constraint_type
					if constraint_type /= Void and then constraint_type.has_generics then
						System.expanded_checker.check_actual_type (constraint_type)
					end
					generics.forth
				end
			end

				-- Now we must check if `creation_feature' is set.
				-- If not, set it to `default_create_feature'.
				-- Cannot be done earlier!
			if creation_feature = Void then
				creation_feature := default_create_feature
			end
		end

feature -- Third pass: byte code production and type check

	pass3 is
			-- Third pass of the compiler on current class. Two cases:
			-- 1. the class is marked `changed': for all the features
			--	marked `melted', produce byte code and make a type check.
			--	If the class id also marked `changed3', make a type check
			--	for all the other features.
			-- 2. the class is marked `changed3' only, make a type check
			--	on all the features of the class.
		local
			feat_table: FEATURE_TABLE
				-- Feature table of the class
			feature_i, def_resc: FEATURE_I
				-- A feature of the class
			feature_changed: BOOLEAN
				-- Is the current feature `feature_i' changed ?
			dependances: CLASS_DEPENDANCE
			rep_dep: REP_CLASS_DEPEND
			new_suppliers: like suppliers
			feature_name: STRING
			f_suppliers: FEATURE_DEPENDANCE
			removed_features: SEARCH_TABLE [FEATURE_I]
			melted_info: FEAT_MELTED_INFO
			melt_set: like melted_set
			type_check_error: BOOLEAN
			byte_code_generated, has_default_rescue: BOOLEAN
			body_id: BODY_ID
			feat_dep: FEATURE_DEPENDANCE
			rep_removed: BOOLEAN

				-- Invariant
			invar_clause: INVARIANT_AS
			invar_byte: INVARIANT_B
			invariant_changed: BOOLEAN
			inv_melted_info: INV_MELTED_INFO

			new_body_id: BODY_ID
			old_body_id: BODY_ID
			changed_body_ids: EXTEND_TABLE [CHANGED_BODY_ID_INFO, BODY_ID]
			changed_body_id_info: CHANGED_BODY_ID_INFO
			old_invariant_body_id: BODY_ID
			feature_body_id: BODY_ID

				-- For Concurrent Eiffel
			body_id_changed: BOOLEAN
			def_resc_depend: DEPEND_UNIT
			type_checked   : BOOLEAN
		do
			def_resc := default_rescue_feature

			from
				system.changed_body_ids.clear_all

					-- Initialization for actual types evaluation
				Inst_context.set_cluster (cluster)
				
					-- For a changed class, the supplier list has
					-- to be updated
				if Tmp_depend_server.has (id) then
					dependances := Tmp_depend_server.item (id)
				elseif Depend_server.has (id) then
					dependances := Depend_server.item (id)
				else
					!!dependances.make (changed_features.count)
					dependances.set_id (id)
				end

				if Rep_depend_server.server_has (id) then
					rep_dep := Rep_depend_server.server_item (id)
				elseif Tmp_rep_depend_server.has (id) then
					rep_dep := Tmp_rep_depend_server.item (id)
				end

				if changed then
					new_suppliers := suppliers.same_suppliers
				end

				feat_table := Feat_tbl_server.item (id)

				ast_context.set_a_class (Current)

				!!melt_set.make
				melt_set.compare_objects
				feat_table.start
			until
				feat_table.after
			loop
				feature_i := feat_table.item_for_iteration
				feature_name := feature_i.feature_name
				type_checked := False

debug ("SEP_DEBUG")
io.error.putstring ("CLASS_C.PASS3 Feature ")
io.error.putstring (feature_name)
io.error.putstring (" whose FEATURE_ID: ")
io.error.putint (feature_i.feature_id)
io.error.new_line
end

				if feature_i.to_melt_in (Current) then

					has_default_rescue := False
					if
						def_resc /= Void
						and then not def_resc.empty_body
						and then not equal (def_resc.feature_name, feature_name)
					then
						feature_i.create_default_rescue (def_resc.feature_name)
						has_default_rescue := True
					end

debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%TTo melt_in true: ")
	io.error.putstring (feature_name)
	io.error.new_line
end
					if System.has_separate then
						body_id_changed := False 
					end
						-- For a feature written in the class
					feature_changed := 	changed_features.has (feature_name)
										and not feature_i.is_attribute
debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%T%Tfeature_changed: ")
	io.error.putbool (feature_changed)
	io.error.new_line
end
			
					f_suppliers := dependances.item (feature_i.body_id)

						-- Feature is considered syntactically changed if
						-- some of the entities used by it have changed
						-- of nature (attribute/function versus incrementality).
					if not (feature_changed or else f_suppliers = Void) then
						feature_changed := (not propagators.melted_empty_intersection (f_suppliers))
debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%T%Tfeature_changed (After melted_empty_intersection): ")
	io.error.putbool (feature_changed)
	io.error.new_line
end
						if not feature_changed then
							if f_suppliers.has_removed_id then
								feature_changed := True
							end
						end

						if feature_changed then
								-- Automatic melting of the feature
							if System.has_separate then
								body_id_changed := True 
							end
							feature_i.change_body_id
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
						end
					end
			
					if feature_i.is_attribute then	
							-- Redefinitions of functions into attributes are
							-- always melted
						if System.has_separate then
							body_id_changed := True 
						end
						feature_changed := True
						feature_i.change_body_id
					end
	
					ast_context.set_a_feature (feature_i)

					if feature_i.in_pass3 then
						if
							-- No type check for constants and attributes.
							-- [It is done in second pass.]
							feature_changed
							or else
							not (f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
						then
								-- Type check
debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%Ttype check ")
	io.error.putstring (feature_name)
	io.error.new_line
end
debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%T%Tfeature changed: ")
	io.error.putbool (feature_changed)
	io.error.new_line
	if f_suppliers /= Void then
		io.error.putstring ("%T%Tf_suppliers /= Void%N%T%Tempty_intersection: ")
		io.error.putbool (propagators.empty_intersection (f_suppliers))
		io.error.putstring ("%N%T%Tchanged_status_empty_intersection: ")
		io.error.putbool (propagators.changed_status_empty_intersection (f_suppliers.suppliers))
		io.error.new_line
	end
end

							Error_handler.mark
debug ("SEP_DEBUG", "ACTIVITY")
	if f_suppliers /= Void then
		io.error.putstring ("Feature_suppliers%N")
		f_suppliers.trace
		io.error.new_line
	end
end

							feature_i.type_check
							type_checked := True
							type_check_error := Error_handler.new_error

							if not type_check_error then
								if f_suppliers /= Void then
										-- Dependances update: remove old
										-- dependances for `feature_name'.
									if new_suppliers = Void then
										new_suppliers := suppliers.same_suppliers
									end
									new_suppliers.remove_occurence (f_suppliers)
									dependances.remove (feature_i.body_id)
								end
										
								if not feature_i.is_code_replicated then
										-- Dependances update: add new
										-- dependances for `feature_name'.

									f_suppliers := clone (ast_context.supplier_ids)

									if
										def_resc /= Void and then
										not feature_i.is_deferred and then
										not feature_i.is_external and then
										not feature_i.is_attribute and then
										not feature_i.is_constant
									then
											-- Make it dependant on `default_rescue'
										!!def_resc_depend.make (id, def_resc)
										f_suppliers.extend (def_resc_depend)
									end
									f_suppliers.set_feature_name (feature_name)
									dependances.put (f_suppliers, feature_i.body_id)
									if new_suppliers = Void then
										new_suppliers := suppliers.same_suppliers
									end
									new_suppliers.add_occurence (f_suppliers)
								end

									-- Byte code processing
debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%Tbyte code for ")
	io.error.putstring (feature_name)
	io.error.new_line
end
									if System.has_separate and then not body_id_changed then
										body_id_changed := True 
										feature_i.change_body_id
									end
									feature_i.compute_byte_code (has_default_rescue)
									byte_code_generated := True

							end
						else
							-- Check the conflicts between local variable names
							-- and feature names
-- FIX ME
-- ONLY needed when new features are inserted in the feature table
							feature_i.check_local_names
						end
					else
							-- in_pass3 = False
						record_suppliers (feature_i, dependances)
					end

					ast_context.clear2

					if	(feature_changed or else byte_code_generated)
						and then not (type_check_error or else feature_i.is_deferred)
					then
debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%TMelted_set.put for ")
	io.error.putstring (feature_name)
	io.error.new_line
end
							-- Remember the melted feature information
							-- if it is not deferred.
						!!melted_info.make (feature_i)
						melt_set.put (melted_info)
					end
					type_check_error := False
					byte_code_generated := False

					if not type_checked and then changed3 and then
						not (feature_i.is_attribute or else feature_i.is_constant) then
						-- Forced type check on the feature
						ast_context.set_a_feature (feature_i)

						feature_i.type_check
						ast_context.clear2
					end

				elseif
					((not feature_i.in_pass3)
							-- The feature is deferred and written in the current class
					or else (feature_i.is_deferred and then id.is_equal (feature_i.written_in)))
				then
					if feature_i.is_deferred then
							-- Just type check it. See if VRRR or
							-- VMRX error has occurred.
						ast_context.set_a_feature (feature_i)

						feature_i.type_check
						ast_context.clear2
					end
					record_suppliers (feature_i, dependances)
				end
				feat_table.forth
			end -- Main loop

				-- Recomputation of invariant clause

debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%TProcessing invariant%N")
end

			if invariant_feature /= Void then
				old_invariant_body_id := invariant_feature.body_id
				f_suppliers := dependances.item (old_invariant_body_id)
			else
				f_suppliers := Void
			end

			if propagators.invariant_removed then
				if old_invariant_body_id /= Void then
					dependances.remove (old_invariant_body_id)
				end
				if new_suppliers = Void then
					new_suppliers := suppliers.same_suppliers
				end
				if f_suppliers /= Void then
					new_suppliers.remove_occurence (f_suppliers)
				end
				invariant_feature := Void
			else
				invariant_changed := propagators.invariant_changed
				if not (invariant_changed or else f_suppliers = Void) then
					invariant_changed :=
						not propagators.melted_empty_intersection (f_suppliers)
				end
				if invariant_changed then
					if invariant_feature = Void then
						!!invariant_feature.make (Current)
						invariant_feature.set_body_index
											(Body_index_counter.next_id)
					end
					new_body_id := Body_id_counter.next_id
					System.body_index_table.force
								(new_body_id, invariant_feature.body_index)
					--invariant_feature.change_body_id
				end
				if
					invariant_changed
					or else not	(f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
				then
					invar_clause := Inv_ast_server.item (id)
					Error_handler.mark

debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%TType check for invariant%N")
end
					invar_clause.type_check

					if
						not Error_handler.new_error
					then
						if f_suppliers /= Void then
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
							new_suppliers.remove_occurence (f_suppliers)
							if old_invariant_body_id /= Void then
								dependances.remove (old_invariant_body_id)
							end
						end
						f_suppliers := clone (ast_context.supplier_ids)
						if invariant_feature /= Void then
							f_suppliers.set_feature_name ("_inv_")
							dependances.put (f_suppliers, invariant_feature.body_id)
						end
						if new_suppliers = Void then
							new_suppliers := suppliers.same_suppliers
						end
						new_suppliers.add_occurence (f_suppliers)

debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%TByte code for invariant%N")
end

						ast_context.start_lines
						!!invar_byte
						invar_byte.set_id (id)
						invar_byte.set_byte_list (invar_clause.byte_node)
						Tmp_inv_byte_server.put (invar_byte)

						!!inv_melted_info
						melt_set.put (inv_melted_info)
					end
						-- Clean context
					ast_context.clear2
				end
			end

				-- Check sum error
			Error_handler.checksum

			if changed then

					-- Remove dependances of removed features
				from
					removed_features := propagators.removed_features
					removed_features.start
				until
					removed_features.after
				loop
					feature_i := removed_features.item_for_iteration
					feature_body_id := feature_i.body_id
					if not feature_i.is_code_replicated then
						f_suppliers := dependances.item (feature_body_id)
						if f_suppliers /= Void then
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
							new_suppliers.remove_occurence (f_suppliers)
						end
						dependances.remove (feature_body_id)

					end
					if
						rep_dep /= Void and then
						rep_dep.has (feature_name)
					then
debug ("REPLICATION")
	io.error.putstring ("removing dependency feature :")
	io.error.putstring (feature_name)
	io.error.new_line
end
						rep_dep.remove (feature_name)
						rep_removed := True
					end
					body_id := feature_i.body_id
						-- Second pass desactive body id of changed
						-- features only. Deactive body ids of removed
						-- features.
					if not feature_i.is_code_replicated then
						Tmp_body_server.desactive (body_id)
					else
						Tmp_rep_feat_server.desactive (body_id)
					end

					removed_features.forth
				end
			end
			if rep_removed and then rep_dep /= Void then
				Tmp_rep_depend_server.put (rep_dep)
			end

			if new_suppliers /= Void then
					-- Write new dependances in the dependances temporary
					-- server
				Tmp_depend_server.put (dependances)

					-- Update the client/supplier relations for the current
					-- class
				update_suppliers (new_suppliers)

			end

				-- Update `melted_set'.
			if melted_set = Void then
				melted_set := melt_set
			else
				melted_set.merge (melt_set)
			end

			if not melted_set.empty then
				System.melted_set.put (Current)
				set_must_be_recompiled (True)
				set_generate_descriptors (True)
			elseif propagators.invariant_removed then
				System.melted_set.put (Current)
				set_generate_descriptors (True)
			end
		ensure
			No_error: not Error_handler.has_error
		rescue
			if Rescue_status.is_error_exception then
					-- Clean context if error
						-- FIXME call clear1 ????
				ast_context.clear2

					-- Undo the `change_body_id' calls
				from
					changed_body_ids := system.changed_body_ids
					changed_body_ids.start
				until
					changed_body_ids.after
				loop
					changed_body_id_info := changed_body_ids.item_for_iteration
					old_body_id := changed_body_ids.key_for_iteration
					new_body_id := changed_body_id_info.new_body_id
						-- Undo
					if not changed_body_id_info.is_code_replicated then
						Body_server.change_id (old_body_id, new_body_id)
					else
						Rep_feat_server.change_id (old_body_id, new_body_id)
					end
					System.depend_server.change_ids (old_body_id, new_body_id)

					Byte_server.change_id (old_body_id, new_body_id)
					System.Body_index_table.force (old_body_id, changed_body_id_info.body_index)
					System.onbidt.undo_put (old_body_id, new_body_id)
					if changed_body_id_info.has_to_update_dependances then
						depend_server.item (changed_body_id_info.written_in).replace_key (old_body_id, new_body_id)
					end
					
					changed_body_ids.forth
				end

					-- Clean the caches if error

					--| TMP_AST_SERVER is a SERVER, not a DELAY_SERVER
					--| Calling `wipe_out' on the cache won't remove anything
					--| from the server itself

					--| The other servers are READ_SERVERs.

				Tmp_ast_server.cache.wipe_out
				Tmp_body_server.cache.wipe_out
				Tmp_rep_feat_server.cache.wipe_out
				Tmp_inv_ast_server.cache.wipe_out
			end
		end

	record_suppliers (feature_i: FEATURE_I; dependances: CLASS_DEPENDANCE) is
		local
			feature_name: STRING
			f_suppliers: FEATURE_DEPENDANCE
			body_id: BODY_ID
		do
			body_id := feature_i.body_id
			if dependances.has (body_id) then
				dependances.remove (body_id)
			end
			!!f_suppliers.make
			f_suppliers.set_feature_name (feature_i.feature_name)
			feature_i.record_suppliers (f_suppliers)
			dependances.put (f_suppliers, body_id)
		end

	invariant_pass3 (	dependances: CLASS_DEPENDANCE
						new_suppliers: like suppliers
						melt_set: like melted_set) is
			-- Recomputation of invariant clause
--		require
--			good_argument1: dependances /= Void
--			good_argument2: changed implies new_suppliers /= Void
--			good_argument3: melt_set /= Void
--		local
--			invar_clause: INVARIANT_AS
--			invar_byte: INVARIANT_B
--			f_suppliers: FEATURE_DEPENDANCE
--			invariant_changed: BOOLEAN
--			melted_info: INV_MELTED_INFO
--			new_body_id: BODY_ID
		do
--			f_suppliers := dependances.item ("_inv_")
--
--			if propagators.invariant_removed then
--				dependances.remove ("_inv_")
--				new_suppliers.remove_occurence (f_suppliers)
--				invariant_feature := Void
--			else
--				invariant_changed := propagators.invariant_changed
--				if not (invariant_changed or else f_suppliers = Void) then
--					invariant_changed :=
--						not propagators.melted_empty_intersection (f_suppliers)
--				end
--				if invariant_changed then
--					if invariant_feature = Void then
--						!!invariant_feature.make (Current)
--						invariant_feature.set_body_index
--											(Body_index_counter.next_id)
--					end
--					new_body_id := Body_id_counter.next
--					System.body_index_table.force
--								(new_body_id, invariant_feature.body_index)
--				end
--				if	(	invariant_changed
--						or else
--						not	(	f_suppliers = Void
--								or else
--								(propagators.empty_intersection (f_suppliers)
--								and then
--								propagators.changed_status_empty_intersection (f_suppliers.suppliers))
--							)
--					)
--				then
--					invar_clause := Tmp_inv_ast_server.item (id)
--					Error_handler.mark
--
--debug ("ACTIVITY")
--	io.error.putstring ("%TType check for invariant%N")
--end
--					invar_clause.type_check
--					--if	invariant_changed
--					--	and then
--					if
--						not Error_handler.new_error
--					then
--						if f_suppliers /= Void then
--							new_suppliers.remove_occurence (f_suppliers)
--							dependances.remove ("_inv_")
--						end
--						f_suppliers := clone (ast_context.supplier_ids)
--						dependances.put (f_suppliers, "_inv_")
--						new_suppliers.add_occurence (f_suppliers)
--
--debug ("ACTIVITY")
--	io.error.putstring ("%TByte code for invariant%N")
--end
--
--						ast_context.start_lines
--						!!invar_byte
--						invar_byte.set_id (id)
--						invar_byte.set_byte_list (invar_clause.byte_node)
--						Tmp_inv_byte_server.put (invar_byte)
--
--						!!melted_info
--						melt_set.put (melted_info)
--
--					end
--						-- Clean context
--					ast_context.clear2
--				end
--			end
		end

	update_suppliers (new_suppliers: like suppliers) is
			-- Update the supplier list with `new_suppliers'.
		require
			good_argument: new_suppliers /= Void
		local
			local_suppliers: like suppliers
			supplier_clients: LINKED_LIST [CLASS_C]
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
				new_suppliers.item.supplier.clients.put_front (Current)
				new_suppliers.forth
			end
			set_suppliers (new_suppliers)
		end

feature -- Generation

	update_valid_body_ids is
		do
			Inst_context.set_cluster (cluster)
			types.update_valid_body_ids
		end

	pass4 is
			-- Generation of C files for each type associated to the current
			-- class
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		do
			Inst_context.set_cluster (cluster)
			types.pass4
		end

feature -- Melting

	update_melted_set is
			-- Remove the non valid MELTED_INFO
		do
			if melted_set /= Void then
				from
					melted_set.start
				until
					melted_set.after
				loop
					if not melted_set.item.is_valid (Current) then
						melted_set.remove
					else
						melted_set.forth
					end
				end
			end
		end

	melt is
			-- Melt changed features.
		require
			good_context: has_features_to_melt
		do
			Inst_context.set_cluster (cluster)
			types.melt

				-- Forget melted list
			melted_set := Void
		end
	
	update_dispatch_table is
			-- Update dispatch table.
		require
			good_context: has_features_to_melt
		do
			Inst_context.set_cluster (cluster)
			types.update_dispatch_table

				-- Forget melted list
			melted_set := Void
		end

	has_features_to_melt: BOOLEAN is
			-- Has the current class features to melt ?
		do
			Result := not (melted_set = Void or else melted_set.empty)
		end

	melt_all is
			-- Melt all the features written in the class
		local
			c_dep: CLASS_DEPENDANCE
			tbl: FEATURE_TABLE
			melted_info: FEAT_MELTED_INFO
			inv_melted_info: INV_MELTED_INFO
			new_body_id: BODY_ID
			feature_i: FEATURE_I
		do
			Inst_context.set_cluster (cluster)
			if melted_set = Void then
				!!melted_set.make
				melted_set.compare_objects
			end

				-- Melt feature written in the class
			from
				tbl := feature_table
				tbl.start
			until
				tbl.after
			loop
				feature_i := tbl.item_for_iteration
				if feature_i.to_generate_in (Current) then
					!!melted_info.make (feature_i)
					if not melted_set.has (melted_info) then
						melted_set.put (melted_info)
						feature_i.change_body_id
					end
				end
				tbl.forth
			end
			c_dep := depend_server.item (id)
			depend_server.put (c_dep)

				-- Melt possible invariant clause
			if invariant_feature /= Void then
				!!inv_melted_info
				if not melted_set.has (inv_melted_info) then
					melted_set.put (inv_melted_info)
					--new_body_id := Body_id_counter.next_id
					--System.body_index_table.force (new_body_id, invariant_feature.body_index)
					invariant_feature.change_body_id
				end
			end

			if not Tmp_m_rout_id_server.has (id) then
					-- If not already done, Melt routine id array
				tbl.melt
			end
				-- Mark the class to be frozen later again.
			System.melted_set.put (Current)
			set_must_be_recompiled (True)
			set_generate_descriptors (True)
			pass4_controler.insert_new_class (Current)
		end

	melt_feature_table is
			-- Melt feature table.
			--|Don't forget to modify also `melt_feature_and_descriptor_tables'
			--|when modifying this function
		require
			good_context: System.melted_set.has (Current)
		do
			if not types.empty then
				Inst_context.set_cluster (cluster)
				types.melt_feature_table
			end
		end

	melt_descriptor_tables is
			-- Melt descriptor tables of associated class types
			--|Don't forget to modify also `melt_feature_and_descriptor_tables'
			--|when modifying this function
		require
			good_context: System.melted_set.has (Current)
		do
			feature_table.origin_table.melt (Current)
		end

	melt_feature_and_descriptor_tables is
			-- Melt feature table.
			-- Melt descriptor tables of associated class types
		require
			good_context: System.melted_set.has (Current)
		do
				-- Melt feature table.
			if not types.empty then
				Inst_context.set_cluster (cluster)
				types.melt_feature_table
			end

				-- Melt descriptor tables
			feature_table.origin_table.melt (Current)
		end

feature -- Workbench feature and descriptor table generation

	generate_feature_table is
			-- Generation of workbench mode feature table for
			-- the current class
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		local
			table_file_name: STRING
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for Current generation
			buffer := generation_buffer
			buffer.clear_all
			buffer.putstring ("#include %"eif_macros.h%"%N#include %"eif_struct.h%"%N%N")
			feature_table.generate (buffer)

			table_file_name := full_file_name
			table_file_name.append_integer (id.id)
			table_file_name.append_character (feature_table_file_suffix)
			table_file_name.append (Dot_c)
			!! file.make_open_write (table_file_name)
			file.put_string (buffer)
			file.close
		end

	generate_workbench_files is
			-- replace generate_decriptor_table,
			-- generate_feature_table and pass4
			-- in case of first compilation.
			-- Just a problem of efficiency
		local
			table_file_name: STRING
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
			feat_tbl: FEATURE_TABLE
		do
			feat_tbl := feature_table

				-- Generation of workbench mode descriptor tables
				-- of associated class types.
				--|Note: when precompiling a system a class might
				--|have no generic derivations
			if has_types then
				feat_tbl.origin_table.generate (Current)
			end

				-- Clear buffer for Current generation
			buffer := generation_buffer
			buffer.clear_all
			buffer.putstring ("#include %"eif_macros.h%"%N#include %"eif_struct.h%"%N%N")
			feat_tbl.generate (buffer)

				-- Generation of workbench mode feature table for
				-- the current class
			table_file_name := full_file_name
			table_file_name.append_integer (id.id)
			table_file_name.append_character (feature_table_file_suffix)
			table_file_name.append (Dot_c)
			!! file.make_open_write (table_file_name)
			file.put_string (buffer)
			file.close

				-- Generation of C files for each type associated to the current
				-- class
			Inst_context.set_cluster (cluster)
			types.pass4
 		end

	generate_descriptor_tables is
			-- Generation of workbench mode descriptor tables
			-- of associated class types.
			--|Note: when precompiling a system a class might
			--|have no generic derivations
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		do
			if has_types then
				feature_table.origin_table.generate (Current)
			end
		end

feature

	full_file_name: STRING is
			-- Generated file name prefix
			-- Side effect: Create the corresponding subdirectory if it
			-- doesnot exist yet.
		local
			subdirectory: STRING
			dir: DIRECTORY
			f_name: FILE_NAME
			d_name: DIRECTORY_NAME
		do
			if System.in_final_mode then
				!!d_name.make_from_string (Final_generation_path)
			else
				!!d_name.make_from_string (Workbench_generation_path)
			end
			!!subdirectory.make (5)
			subdirectory.append (Feature_table_suffix)
			subdirectory.append_integer (packet_number)
			d_name.extend (subdirectory)
			!!dir.make (d_name)
			if not dir.exists then	
				dir.create_dir
			end
			!!f_name.make_from_string (d_name)
			f_name.set_file_name (base_file_name)
			Result := f_name
		end

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			!!Result.make (11)
			if name.count > Max_non_encrypted then
				Result.append (name.substring (1, Max_non_encrypted))
			else
				Result.append (name)
			end
		end

	packet_number: INTEGER is
			-- Packet in which the file will be generated
		do
			Result := id.packet_number
		end

feature -- Skeleton processing

	process_skeleton is
			-- Process the skeleton of class types in `types'.
			-- For a class marked `changed2' or else `changed3', the class
			-- types must be all reprocessed and mark `is_changed' if needed
			-- so a new skeleton must be generated.
			-- For class marked `changed4' only, a new type was introduced.
		local
			feature_table_changed: BOOLEAN
			class_type: CLASS_TYPE
			type_i: CL_TYPE_I
			new_skeleton, old_skeleton: SKELETON
		do
debug ("SKELETON")
io.error.putstring ("Class: ")
io.error.putstring (name)
io.error.putstring (" process_skeleton%N")
end
			from
				feature_table_changed := changed2
				types.start
			until
				types.after
			loop
				class_type := types.item
				if 	feature_table_changed
					or else
					(changed4 and then class_type.is_changed)
				then
					old_skeleton := class_type.skeleton
					new_skeleton := skeleton.instantiation_in (class_type)
					if
						old_skeleton = Void
						or else not new_skeleton.equiv (old_skeleton)
					then
						class_type.set_is_changed (True)
						class_type.set_skeleton (new_skeleton)
debug ("SKELETON")
io.error.putstring ("Changed_skeleton:%N")
new_skeleton.trace
io.error.putstring ("Old skeleton:%N")
old_skeleton.trace
io.error.new_line
end

						System.melted_set.put (Current)
						set_generate_descriptors (True)
					else
debug ("SKELETON")
io.error.putstring ("Skeleton has not changed:%N")
new_skeleton.trace
io.error.new_line
end
					end
				else
debug ("SKELETON")
io.error.putstring ("Nothing is done%N")
end
				end
				types.forth
			end
changed2 := False
changed4 := False
		end

feature -- Class initialization

	init (ast_b: CLASS_AS; class_info: CLASS_INFO; old_suppliers: like syntactical_suppliers) is
			-- Initialization of the class with AST produced by yacc
		require
			good_argument: ast_b /= Void
		local
			old_parents: like parents
			old_generics: like generics
			parents_as: EIFFEL_LIST [PARENT_AS]
			p: ARRAY [PARENT_AS]
			lower, upper: INTEGER
			raw_type: CLASS_TYPE_AS
			cl_type: CLASS_TYPE
			parent_type: CL_TYPE_A
			parent_class: CLASS_C
			parent_list: PARENT_LIST
			parent_c: PARENT_C
			ve04: VE04
			is_exp, old_is_expanded: BOOLEAN
			old_is_separate: BOOLEAN
			old_is_deferred: BOOLEAN
			a_client: CLASS_C
			changed_status: BOOLEAN
			class_i: CLASS_I
			changed_generics: BOOLEAN
			changed_expanded: BOOLEAN
			changed_separate: BOOLEAN
			pars: like parents
			gens: like generics
			obs_msg: like obsolete_message
		do
				-- Check if obsolete clause was present.
				-- (Void if none was present)
			if ast_b.obsolete_message /= Void then
				obs_msg := ast_b.obsolete_message.value
			else
				obs_msg := Void
			end
			set_obsolete_message (obs_msg)
			old_parents := parents

			if old_parents /= Void then
					-- Class was compiled before so we have to update
					-- parent/descendant relation.
					-- [Note that the client/supplier relations will be
					-- updated by the third pass].
				remove_parent_relations
			end

				-- Deferred mark
			old_is_deferred := is_deferred
			set_is_deferred (ast_b.is_deferred)
			if (old_is_deferred /= is_deferred and then old_parents /= Void) then
				pass2_controler.set_deferred_modified (Current)
				changed_status := True
			end

				-- Expanded mark
			old_is_expanded := is_expanded
			is_exp := ast_b.is_expanded
			set_is_expanded (is_exp)

			if is_exp then
					-- Record the fact that an expanded is in the system
					-- Extra check must be done after pass2
				if
					Current /= System.boolean_class.compiled_class and then
					Current /= System.character_class.compiled_class and then
					Current /= System.double_class.compiled_class and then
					Current /= System.integer_class.compiled_class and then
					Current /= System.real_class.compiled_class and then
					Current /= System.pointer_class.compiled_class
				then
					System.set_has_expanded
				end
			end

			if (is_exp /= old_is_expanded and then old_parents /= Void) then
					-- The expanded status has been modifed
					-- (`old_parents' is Void only for the first compilation of the class)
				pass2_controler.set_expanded_modified (Current)
				changed_status := True
				changed_expanded := True
			end

				-- Separate mark
			old_is_separate := is_separate
			if ast_b.is_separate then
				set_is_separate (True)
				System.set_has_separate
			else
				set_is_separate (False)
			end

			if (is_separate /= old_is_separate and then old_parents /= Void) then
				pass2_controler.set_separate_modified (Current)
				changed_status := True
				changed_separate := True
			end

			if changed_status then
				pass2_controler.add_changed_status (Current)
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					a_client := syntactical_clients.item
					if changed_expanded or changed_separate then
							-- `changed' is set to True so that a complete
							-- pass2 is done on the client. `feature_unit'
							-- will find the type changes
						if not a_client.changed then
							a_client.set_changed (True)
								-- The ast is in the temporary server
								-- so pass 2 can be done the same way
							pass1_controler.insert_changed_class (a_client)
						end
					else
						set_changed2 (True)
					end
					pass2_controler.set_supplier_status_modified (a_client)
					pass3_controler.insert_new_class (a_client)
					pass4_controler.insert_new_class (a_client)
					syntactical_clients.forth
				end

					-- All the skeletons must be processed
				changed4 := True
				from
					types.start
				until
					types.after
				loop
					cl_type := types.item
					cl_type.set_is_changed (True)
					cl_type.type.set_is_expanded (is_expanded)
					types.forth
				end
			end

				-- Initialization of the parent types `parents': put
				-- the default parent HERE if needed. Calculates also the
				-- lists `descendants'. Since the routine `check_suppliers'
				-- has been called before, all the instances of CLASS_C
				-- corresponding to the parents of the current class are
				-- in the system (even if a parent is not already parsed).

			Inst_context.set_cluster (cluster)
			parents_as := ast_b.parents
			parent_list := class_info.parents

			if parents_as /= Void then

					-- Separate loop for VHPR3 checking
				from
					p := parents_as
					check p.lower = 1 end
					lower := 1
					upper := parents_as.count
				until
					lower > upper
				loop
						-- Evaluation of the parent type
					raw_type := p.item (lower).type
						-- Check if there is no anchor in the parent type
					if raw_type.has_like then
						!!ve04
						ve04.set_class (Current)
						ve04.set_parent_type (parent_type)
						Error_handler.insert_error (ve04)
							-- Cannot ge on here
						Error_handler.raise_error
					end
					lower := lower + 1
				end

					-- Take the structure produced by Yacc
				from
					p := parents_as
					check p.lower = 1 end
					lower := 1
					upper := parents_as.count
					!! pars.make_filled (upper)
				until
					lower > upper
				loop
						-- Fill attribute `pars' of class CLASS_INFO
					parent_c := p.item (lower).parent_c
					parent_list.put_i_th (parent_c, lower)
						-- Insertion of a new descendant for the parent class
					parent_type := parent_c.parent_type
					parent_class := parent_type.associated_class
					check
						parent_class_exists: parent_class /= Void
							-- This ensures that routine `check_suppliers'
							-- has been called before.
					end
					parent_class.add_descendant (Current)
					pars.put_i_th (parent_type, lower)
					lower := lower + 1
				end
			elseif not id.is_equal (System.general_id) then
					-- No parents are syntactiaclly specified: ANY is
					-- the default parent, except for class GENERAL which has
					-- no parent at all (we don't want a cycle in the
					-- inheritance graph, otherwise the topological sort
					-- on the classes will fail...).
				!! pars.make (1)
				pars.extend (Any_type)
					-- Add a descendant to class ANY
				System.any_class.compiled_class.add_descendant (Current)
					-- Fill parent list of corresponding class info
				parent_list.put_i_th (Any_parent, 1)
			else
					-- In case of the GENERAL class, just create an empty
					-- parent structure
				!! pars.make (0)
			end

			set_parents (pars)

				-- Init generics
			old_generics := generics

			gens := ast_b.generics

			set_generics (gens)

			if gens /= Void then
					-- Check generic parameter declaration rule
				check_generics
			end

			if old_parents /= Void then
				-- Recompilation of the class
				if gens /= Void then
					if
						old_generics = Void
					or else
						old_generics.count /= generics.count
					then
						changed_generics := True
					else
						from
							old_generics.start
							gens.start
						until
							changed_generics or else gens.after
						loop
							if not gens.item.equiv (old_generics.item) then	
								changed_generics := True
							end
							gens.forth
							old_generics.forth
						end
					end
				elseif old_generics /= Void then
					changed_generics := True
				end
			end
			if changed_generics then
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					a_client := syntactical_clients.item
					Workbench.add_class_to_recompile (a_client.lace_class)
					a_client.set_changed (True)
					syntactical_clients.forth
				end
					-- The syntactical client/supplier relation must be consistent before
					-- the removal
				update_syntactical_relations (old_suppliers)
				class_i := lace_class
				System.remove_class (Current)
				Workbench.change_class (class_i)
			end

			if old_parents /= Void then
				if not same_parents (old_parents) then
						-- Conformance tables incrementality
					set_changed (True)
					set_changed3a (True)
					System.set_update_sort (True)

--						-- Take care of signature conformance for redefinion of
--						-- f(p:PARENT) in f(c: CHILD). If CHILD does not inherit
--						-- from PARENT anymore, the redefinition of f is not valid
--					if removed_parent (old_parents) then
--						from
--							syntactical_clients.start
--						until
--							syntactical_clients.after
--						loop
--							a_client := syntactical_clients.item
--							a_client.set_changed2 (True)
--							pass2_controler.insert_new_class (a_client)
--							syntactical_clients.forth
--						end
--					end
				end
				if not changed then
						-- If the class is not changed, it is marked `changed2'
					changed2 := True
				end
			else
				-- First compilation of the class
				System.set_update_sort (True)
			end

				-- Conformance tables incrementality
			if 	(not System.update_sort)	-- Topological sort not already
				and then					-- set on.
				(	old_parents = Void		-- First compilation of the class
					or else
					not same_parents (old_parents))	-- Parent changed from the
			then									-- inheritance graph point
													-- of view
				System.set_update_sort (True)
			end
		ensure
			parents /= Void
		end

	same_parents (old_parents: like parents): BOOLEAN is
			-- Are `old_parents' the same as `parents' ?
			-- [Incrementality for conformance tables building.]
		require
			good_argument: old_parents /= Void
		local
			i, nb, j, l_count: INTEGER
			l_area, o_area: SPECIAL [CL_TYPE_A]
			parent_class: CLASS_C
		do
			from
				Result := True
				l_area := parents.area
				nb := parents.count
				o_area := old_parents.area
				l_count := old_parents.count
			until
				i = nb or else not Result
			loop
				parent_class := l_area.item (i).associated_class
				from
					j := 0
					Result := False
				until
					j = l_count or else Result
				loop
					Result := parent_class = o_area.item (j).associated_class
					j := j + 1
				end
				i := i + 1
			end
			if Result then
				Result := removed_parent (old_parents)
			end
		end

	removed_parent (old_parents: like parents): BOOLEAN is
			-- A parent has been removed from `parents' ?
			-- [Incrementality for propagation of pass2.]
		require
			good_argument: old_parents /= Void
		local
			pos: INTEGER
			parent_class: CLASS_C
			l_area, o_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
			j, l_count: INTEGER
		do
			from
				Result := True
				l_area := parents.area
				l_count := parents.count
				o_area := old_parents.area
				nb := old_parents.count
			until
				i = nb or else not Result
			loop
				parent_class := o_area.item (i).associated_class
				from
					j := 0	
				until
					j= l_count or else Result
				loop
					Result := parent_class = l_area.item (j).associated_class
					j := j + 1
				end
				i := i + 1
			end
		end

	Any_type: CL_TYPE_A is
			-- Default parent type
		once
			!!Result
			Result.set_base_class_id (System.any_id)
		end

	Any_parent: PARENT_C is
			-- Default compiled parent
		once
			!!Result
			Result.set_parent_type (Any_type)
		end

feature

	update_syntactical_relations
		(old_syntactical_suppliers: like syntactical_suppliers) is
			-- Remove syntactical client/supplier relations ans take
			-- care of possible removed classes
		local
			a_class: CLASS_C
			supplier_clients: like syntactical_clients
		do
				-- Remove old syntactical supplier/client relations
			from
				old_syntactical_suppliers.start
			until
				old_syntactical_suppliers.off
			loop
				a_class := old_syntactical_suppliers.item.supplier
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
				syntactical_suppliers.start
			until
				syntactical_suppliers.off
			loop
				a_class := syntactical_suppliers.item.supplier
				if a_class /= Current then
					supplier_clients := a_class.syntactical_clients
					supplier_clients.put_front (Current)
				end
				syntactical_suppliers.forth
			end
		end

	remove_relations is
			-- Remove client/supplier and parent/descendant relations
			-- of the current class.
		require
			parents_exists: parents /= Void
		local
			local_suppliers: SUPPLIER_LIST
			clients_list: LINKED_LIST [CLASS_C]
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
			parents_exists: parents /= Void
		local
			des: LINKED_LIST [CLASS_C]
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
			c: CLASS_C
		do
			from
				l_area := parents.area
				nb := parents.count
			until
				i = nb
			loop
				c := l_area.item (i).associated_class
				if c /= Void then
					des:= c.descendants
					des.start
					des.search (Current)
					if not des.after then
						des.remove
					end
				end
				i := i + 1
			end
		end

	mark_class (marked_classes: SEARCH_TABLE [CLASS_ID]) is
			-- Mark the class as used in the system
			-- and propagate to the suppliers
			-- Used by remove_useless_classes in SYSTEM_I
		do
			if not marked_classes.has (id) then
				marked_classes.put (id)
				from
					syntactical_suppliers.start
				until
					syntactical_suppliers.after
				loop
					syntactical_suppliers.item.supplier.mark_class (marked_classes)
					syntactical_suppliers.forth
				end
			end
		end

	check_generics is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG (page 52)
		require
			generics_exists: generics /= Void
		local
			generic_dec, next_dec: FORMAL_DEC_AS
			generic_name: ID_AS
			vcfg1: VCFG1
			vcfg2: VCFG2
			error: BOOLEAN
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, j, nb: INTEGER
		do
			from
				l_area := generics.area
				nb := generics.count
			until
				error or else i = nb
			loop
				generic_dec := l_area.item (i)
				generic_name := generic_dec.formal_name

					-- First, check if the formal generic name is not the
					-- anme of a class in the surrounding universe.
				if Universe.class_named (generic_name, cluster) /= Void then
					!!vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name)
					Error_handler.insert_error (Vcfg1)
					error := True
				end

					-- Second, check if the formal generic name doesn't
					-- appear twice in `generics'.
				from
					j := 0
				until
					error or else j = nb
				loop
					next_dec := l_area.item (j)
					if next_dec /= generic_dec then
						if next_dec.formal_name.is_equal (generic_name) then
							!!vcfg2
							vcfg2.set_class (Current)
							vcfg2.set_formal_name (generic_name)
							Error_handler.insert_error (vcfg2)
							error := True
						end
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	check_generic_parameters is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG1 (page 52)
		require
			generics_exists: generics /= Void
		local
			generic_dec: FORMAL_DEC_AS
			generic_name: ID_AS
			vcfg1: VCFG1
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, nb: INTEGER
		do
			from
				l_area := generics.area
				nb := generics.count
			until
				i = nb
			loop
				generic_dec := l_area.item (i)
				generic_name := generic_dec.formal_name

				if Universe.class_named (generic_name, cluster) /= Void then
					!!vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name)
					Error_handler.insert_error (Vcfg1)
				end
				i := i + 1
			end
		end

	check_creation_constraint_genericity is
		require
			generics_exists: generics /= Void
		local
			generic_dec: FORMAL_DEC_AS
			constraint_type: TYPE
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, nb: INTEGER
		do
			Inst_context.set_cluster (cluster)
			from
				l_area := generics.area
				nb := generics.count
			until
				i = nb
			loop
				generic_dec := l_area.item (i)
				if generic_dec.has_constraint and then generic_dec.has_creation_constraint then
					generic_dec.check_constraint_creation (Current, generic_dec.constraint)
				end
				i := i + 1
			end
		end

	check_constraint_genericity is
			-- Check validity of constraint genericity
		require
			generics_exists: generics /= Void
		local
			generic_dec: FORMAL_DEC_AS
			constraint_type: TYPE
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, nb: INTEGER
		do
			Inst_context.set_cluster (cluster)
			from
				l_area := generics.area
				nb := generics.count
			until
				i = nb
			loop
				generic_dec := l_area.item (i)
				constraint_type := generic_dec.constraint
				if constraint_type /= Void then
					constraint_type.check_constraint_type (Current)
				end
				i := i + 1
			end
		end

feature -- Parent checking

	check_parents is
			-- Check generical parents
		local
			vtug: VTUG
			vtcg4: VTCG4
			constraint_error_list: LINKED_LIST [CONSTRAINT_INFO]
			parent_actual_type: CL_TYPE_A
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
		do
			from
				l_area := parents.area
				nb := parents.count
			until
				i = nb
			loop
				parent_actual_type := l_area.item (i)
				if not parent_actual_type.good_generics then
						-- Wrong number of geneneric parameters in parent
					vtug := parent_actual_type.error_generics
					vtug.set_class (Current)
					Error_handler.insert_error (vtug)
						-- Cannot go on ...
					Error_handler.raise_error
				end

				if parent_actual_type.generics /= Void then
						-- Check constrained genericity validity rule
					constraint_error_list := parent_actual_type.check_constraints (Current)
					if constraint_error_list /= Void then
						!!vtcg4
						vtcg4.set_class (Current)
						vtcg4.set_error_list (constraint_error_list)
						vtcg4.set_parent_type (parent_actual_type)
						Error_handler.insert_error (vtcg4)
					end
				end
				i := i + 1
			end
		end

feature -- Supplier checking

	check_suppliers_and_parents is
			-- Check the suppliers and the parents before a recompilation
			-- of a system
		local
			a_class: CLASS_C
			recompile: BOOLEAN
		do
			from
				syntactical_suppliers.start
			until
				syntactical_suppliers.after or else recompile
			loop
				a_class := syntactical_suppliers.item.supplier
				Universe.compute_last_class (a_class.name, cluster)
				if Universe.last_class /= a_class.lace_class then
						-- one of the suppliers has changed (different CLASS_I)
						-- recompile the client (Current class)
					a_class := lace_class.compiled_class
					if a_class = Void or else not a_class.is_precompiled then
						recompile := True
						Workbench.add_class_to_recompile (lace_class)
					end
				end
				syntactical_suppliers.forth
			end
		end

	check_suppliers (supplier_list: LINKED_LIST [ID_AS]) is
			-- Check the supplier ids of the current parsed class
			-- and add perhaps classes to the system.
		require
			good_argument: not
				(supplier_list = Void or else supplier_list.empty)
		local
			old_cursor: CURSOR
		do
			from
				supplier_list.start
			until
				supplier_list.off
			loop
					-- Check supplier class_name `supplier_list.item' of the class
				check_one_supplier (supplier_list.item)
				supplier_list.forth
			end
		end

	check_parent_classes (parent_list: EIFFEL_LIST [PARENT_AS]) is
			-- Check the parents of the current parsed class
			-- and add perhaps classes to the system.
		require
			good_argument: parent_list /= Void
		local
			l_area: SPECIAL [PARENT_AS]
			i, nb: INTEGER
		do
			from
				l_area := parent_list.area
				nb := parent_list.count
			until
				i = nb
			loop
				check_one_supplier (l_area.item (i).type.class_name)
				i := i + 1
			end
		end

	check_one_supplier (cl_name: STRING) is
			-- Check if supplier class named `cl_name' is in the
			-- universe.
		require
			good_argument: cl_name /= Void
		local
			supplier_class: CLASS_I
			vtct: VTCT
			supplier: SUPPLIER_CLASS
			comp_class: CLASS_C
		do
				-- 1.	Check if the supplier class is in the universe
				--		associated to `cluster'.
				-- 2.	Check if the supplier class is a new class
				--		for the system.
			Universe.compute_last_class (cl_name, cluster)
			supplier_class := Universe.last_class
			if supplier_class /= Void and then not cl_name.is_equal ("none") then
					-- The supplier class is in the universe associated
					-- to `cluster'.
				if not supplier_class.compiled then
						-- Class is not in the system yet: ask the
						-- workbench to mark it `changed'.
						-- Mark the class `changed'.
					Workbench.change_class (supplier_class)
						-- Insertion the new compiler class (instance of
						-- CLASS_C) in the system.
				end
				comp_class := supplier_class.compiled_class
				if comp_class /= Current then
					!!supplier.make (comp_class, cl_name)
					syntactical_suppliers.start
					syntactical_suppliers.compare_objects
					syntactical_suppliers.search (supplier)
					if syntactical_suppliers.after then
						syntactical_suppliers.put_front (supplier)
					end
				end
			else
					-- ERROR: Cannot find a supplier class
				!!vtct
				vtct.set_class (Current)
				vtct.set_class_name (cl_name)
				Error_handler.insert_error (vtct)
					-- Cannot go on here
				Error_handler.raise_error
			end
		end

	check_non_genericity_of_root_class is
		-- Check non-genericity of root class
		require
			is_root_class: Current = System.root_class.compiled_class
		local
			vsrc1: VSRC1
			vsrc2: VSRC2
		do
			if generics /= Void then
				!!vsrc1
				vsrc1.set_class (Current)
				Error_handler.insert_error (vsrc1)
				Error_handler.checksum
			end

			if is_deferred then
				!!vsrc2
				vsrc2.set_class (Current)
				Error_handler.insert_error (vsrc2)
				Error_handler.checksum
			end
		end

	check_root_class_creators is
			-- Check creation procedures of root class
		require
			is_root: Current = System.root_class.compiled_class
		local
			creation_proc: FEATURE_I
			system_creation: STRING
			error: BOOLEAN
			vsrc3: VSRC3
			arg_type: TYPE_A
			vd27: VD27
			feat_tbl: like feature_table
		do
			if creators /= Void then
				feat_tbl := feature_table
				from
					creators.start
				until
					creators.after
				loop
						-- `creators.key_for_iteration' contains the creation_name
					creation_proc := feat_tbl.item (creators.key_for_iteration)

					inspect
						creation_proc.argument_count
					when 0 then
						error := False
					when 1 then
						arg_type ?= creation_proc.arguments.first
						error := not arg_type.is_deep_equal (Array_of_string)
					else
						error := True
					end

					if error then
						!!vsrc3
						vsrc3.set_class (Current)
						vsrc3.set_creation_feature (creation_proc)
						Error_handler.insert_error (vsrc3)
					end
					creators.forth
				end
			end

			system_creation := System.creation_name

			if 	system_creation /= Void
				and then
				(creators = Void or else not creators.has (system_creation))
			then
					-- Check default create
				creation_proc := default_create_feature
				if (creation_proc = Void) or else
					not system_creation.is_equal (creation_proc.feature_name) then
					!!vd27
					vd27.set_creation_routine (system_creation)
					vd27.set_root_class (Current)
					Error_handler.insert_error (vd27)
				end
			end

			if (system_creation = Void) then
				if allows_default_creation then
						-- Set creation_name in System
					System.set_creation_name (default_create_feature.feature_name)
				else
					!!vd27
					vd27.set_creation_routine ("")
					vd27.set_root_class (Current)
					Error_handler.insert_error (vd27)
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
			!!Result
			Result.set_base_class_id (System.array_id)
			!! string_type
			string_type.set_base_class_id (System.string_id)
			!!array_generics.make (1, 1)
			array_generics.put (string_type, 1)
			Result.set_generics (array_generics)
		end

feature -- Order relation for inheritance and topological sort

	simple_conform_to (other: CLASS_C): BOOLEAN is
			-- Is `other' an ancestor of Current?
		require
			good_argument: other /= Void
			conformance_table_exists: conformance_table /= Void
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
			conformance_table_exists: conformance_table /= Void
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
		do
			from
				syntactical_clients.start
			until
				syntactical_clients.after
			loop
				class_i := syntactical_clients.item.lace_class
				debug ("REMOVE_CLASS")
					io.error.putstring ("Propagation to client: ")
					io.error.putstring (class_i.name)
					io.error.new_line
				end
				workbench.add_class_to_recompile (class_i)
				class_i.set_changed (true)
				syntactical_clients.forth
			end
		end

feature -- Convenience features

	set_changed (b: BOOLEAN) is
			-- Mark the associated lace class changed.
		do
			lace_class.set_changed (b)
		end

	set_changed2 (b: BOOLEAN) is
			-- Assign `b' to `changed2'.
		do
			changed2 := b
		end

	set_changed3a (b: BOOLEAN) is
			-- Assign `b' to `changed3a'.
		do
			changed3a := b
		end

	set_changed4 (b: BOOLEAN) is
			-- Assign `b' to `changed4'.
		do
			changed4 := b
		end

	set_has_unique is
			-- Set `has_unique' to True
		do
			has_unique := True
		end

	set_has_expanded is
			-- Set `has_expanded' to True
		do
			has_expanded := True
		end

	set_is_used_as_expanded is
		do
			is_used_as_expanded := True
		end

	set_is_used_as_separate is
		do
			is_used_as_separate := True
		end

	set_invariant_feature (f: INVARIANT_FEAT_I) is
		do
			invariant_feature := f
		end

	set_skeleton (s: GENERIC_SKELETON) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s
		end

	set_creators (c: like creators) is
			-- Assign `c' to `creators'.
		do
			creators := c
		end

	add_descendant (c: CLASS_C) is
			-- Insert class `c' into the descendant list
		require
			good_argument: c /= Void
		local
			desc: LINKED_LIST [CLASS_C]
		do
			desc := descendants
			if not desc.has (c) then
				desc.put_front (c)
			end
		end

	visible_name: STRING is
			-- Visible name
		do
			Result := lace_class.visible_name
		end

	external_name: STRING is
			-- External name
		do
			Result := lace_class.external_name
		end

	assertion_level: ASSERTION_I is
			-- Assertion level of the class
		do
			if System.in_final_mode then
					-- In final mode we do not generate assertions
					-- if the dead code remover is on.
				if not System.keep_assertions then
					Result := No_level
				else
					Result := lace_class.assertion_level
				end
			else
				Result := lace_class.assertion_level
			end
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
			if is_used_as_separate then
				!VISIBLE_SEPARATE_I! Result
			else
				Result := lace_class.visible_level
			end
		end

feature -- Actual class type

	actual_type: CL_TYPE_A is
			-- Actual type of the class
		local
			i, count: INTEGER
			gen_type: GEN_TYPE_A
			actual_generic: ARRAY [FORMAL_A]
			formal: FORMAL_A
		do
			if generics = Void then
				!!Result
			else
				!!gen_type
				Result := gen_type
				from
					i := 1
					count := generics.count
					!! actual_generic.make (1, count)
					gen_type.set_generics (actual_generic)
				until
					i > count
				loop
					!! formal
					formal.set_position (i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			end
			Result.set_base_class_id (id)
			Result.set_is_expanded (is_expanded)
		end
		
	insert_changed_feature (feature_name: STRING) is
			-- Insert feature `feature_name' in `changed_features'.
		require
			good_argument: feature_name /= Void
		do
debug ("ACTIVITY")
	io.error.putstring ("CLASS_C: ")
	io.error.putstring (name)
	io.error.putstring ("%NChanged_feature: ")
	io.error.putstring (feature_name)
	io.error.new_line
end
			changed_features.put (feature_name)
		end
	
	constraint (i: INTEGER): TYPE_A is
			-- I-th constraint of the class
		require
			positive_argument: i > 0
			has_generics: generics /= Void
			index_small_enough: i <= generics.count
		do
			Result := generics.i_th (i).constraint_type
		end

	update_instantiator1 is
			-- Look for generic types in the inheritance clause of
			-- a syntactically changed class
		require
			is_syntactically_changed: changed
		local
			generic_parent: GEN_TYPE_A
			parent_type: CL_TYPE_A
			l_area: SPECIAL [CL_TYPE_A]
			i, nb: INTEGER
		do
			from
				l_area := parents.area
				nb := parents.count
			until
				i = nb
			loop
				parent_type := l_area.item (i)
				if parent_type.generics /= Void then
						-- Found a generic type in the inheritance clause
					generic_parent ?= parent_type
					Instantiator.dispatch (generic_parent, Current)
				end
				i := i + 1
			end
		end

	init_types is
			-- Standard initialization of attribute `types' for non
			-- generic classes.
		require
			no_generic: generics = Void
		local
			class_type: CLASS_TYPE
			type_i: CL_TYPE_I
		do
			!!type_i
			type_i.set_base_id (id)
			class_type := new_type (type_i)
			types.put_front (class_type)
			System.insert_class_type (class_type)
		end

	update_types (data: GEN_TYPE_I) is
			-- Update `types' with `data'.
		require
			good_argument: data /= Void
			good_context: not data.has_formal
			consistency: data.base_class = Current
		local
			filter: GEN_TYPE_I
			new_class_type: CLASS_TYPE
		do
			if not derivations.has_derivation (id, data) then
					-- The recursive update is done only once
				derivations.insert_derivation (id, data)
				
debug ("GENERICITY")
	io.error.putstring ("Update_types%N")
	io.error.putstring (name)
	data.trace
end
				if not types.has_type (data) then
					-- Found a new type for the class
debug ("GENERICITY")
	io.error.putstring ("new type%N")
end
					new_class_type := new_type (data)
						-- If class is TO_SPECIAL or else SPECIAL
						-- then freeze system.
					if is_special then
						System.set_freeze
					end

						-- If the $ operator is used in the class,
						-- an encapsulation of the feature must be generated

					if System.address_table.class_has_dollar_operator (id) then
						System.set_freeze
					end

						-- Mark the class `changed4' because there is a new
						-- type
					changed4 := True
					pass4_controler.insert_new_class (Current)
						-- Insertion of the new class type
					types.put_front (new_class_type)
					System.insert_class_type (new_class_type)
					if already_compiled then
							-- Melt all the code written in the associated class of
							-- the new class type
						melt_all
					end
				end

					-- Propagation along the filters since we have a new type
					-- Clean the filters. Some of the filters can be obsolete
					-- if the base class has been remove from the system
				filters.clean
				from
					filters.start
				until
					filters.after
				loop
						-- Instantiation of the filter with `data'
					filter := filters.item.instantiation_in (data)
debug ("GENERICITY")
	io.error.putstring ("Propagation of ")
	filter.trace
	io.error.putstring ("propagation to ")
	io.error.putstring (filter.base_class.name)
	io.error.new_line
end
					filter.base_class.update_types (filter)
					filters.forth
				end
			end
		end

	derivations: DERIVATIONS is
		once
			Result := instantiator.derivations
		end

	new_type (data: CL_TYPE_I): CLASS_TYPE is
			-- New class type for current class
		do
			!!Result.make (data)
		end

	is_special: BOOLEAN is
			-- Is the class SPECIAL or TO_SPECIAL ?
		do
			-- Do nothing
		end

feature -- Meta-type

	meta_type (class_type: CL_TYPE_I): CL_TYPE_I is
			-- Meta type of the class in the context of `class_type'.
		require
			good_argument: class_type /= Void
			conformance: class_type.base_class.conform_to (Current)
		local
			actual_class_type, written_actual_type: CL_TYPE_A
			gen_type: GEN_TYPE_I
		do
			if generics = Void then
					-- No instantiation for non-generic class
				Result := types.first.type
			else
				actual_class_type := class_type.base_class.actual_type
					-- General instantiation of the actual class type where
					-- the feature is written in the context of the actual
					-- type of the base class of `class_type'.
				written_actual_type ?= actual_type.instantiation_in
											(actual_class_type, id)
					-- Ask for the meta-type
				Result := written_actual_type.type_i
					-- Meta instantiation
				if Result.has_formal then
					gen_type ?= class_type
					Result ?= Result.instantiation_in (gen_type)
				end
			end
		end

feature -- Validity class

	check_validity is
			-- Special classes validity check.
		do
			-- Do nothing
		end

feature -- default_rescue routine

	default_rescue_feature: FEATURE_I is
			-- The version of `default_rescue' from GENERAL.
			-- Void if GENERAL has not been compiled yet or
			-- does not posess the feature.
		local
			ftab: FEATURE_TABLE
			item: FEATURE_I
			pos : INTEGER
		do
			if (System.general_class /= Void) then
				from
					ftab := feature_table
					pos  := ftab.iteration_position
					ftab.start
				until
					ftab.after or (Result /= Void)
				loop
					item := ftab.item_for_iteration

					if equal (item.rout_id_set.first, System.default_rescue_id) then
						Result := item
					end

					ftab.forth
				end

				ftab.go (pos)
			end
		end

feature -- default_create routine

	default_create_feature : FEATURE_I is
			-- The version of `default_create' from GENERAL.
			-- Void if GENERAL has not been compiled yet or
			-- does not posess the feature or class is deferred.
		local
			ftab: FEATURE_TABLE
			item: FEATURE_I
			pos : INTEGER
		do
			if not is_deferred and then (System.general_class /= Void) then
				from
					ftab := feature_table
					pos  := ftab.iteration_position
					ftab.start
				until
					ftab.after or (Result /= Void)
				loop
					item := ftab.item_for_iteration

					if equal (item.rout_id_set.first, System.default_create_id) then
						Result := item
					end

					ftab.forth
				end

				ftab.go (pos)
			end
		end

	allows_default_creation : BOOLEAN is
			-- Can an instance of this class be
			-- created with 'default_create'?
		local
			dcr_feat : FEATURE_I
		do
			-- Answer is NO if class is deferred
			if not is_deferred then
				dcr_feat := default_create_feature
				-- Answer is NO if the class has no 
				-- 'default_create'
				if dcr_feat /= Void then
					Result := (creators = Void) or else
							  (not creators.empty and then
							   creators.has (dcr_feat.feature_name))
				end
			end
		end

feature -- Dispose routine

	dispose_feature: FEATURE_I is
			-- Feature for dispose routine
			-- Void if dispose routine does not exist.
		local
			ftab: FEATURE_TABLE
			item: FEATURE_I
		do
			if (System.memory_class /= Void) then
				from
					ftab := feature_table
					ftab.start
				until
					ftab.after or (Result /= Void)
				loop
					item := ftab.item_for_iteration
					if equal (item.rout_id_set.first, System.memory_dispose_id) then
						Result := item
					end
					ftab.forth
				end
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

	mark_all_used (remover: REMOVER) is
			-- Mark all the features written in the Current class used.
			-- [Useful for basic class like INTEGER_REF, etc...].
		local
			tbl: FEATURE_TABLE
			a_feature: FEATURE_I
			pos: INTEGER
		do
			from
				tbl := feature_table
				tbl.start
			until
				tbl.after
			loop
				a_feature := tbl.item_for_iteration
				pos := tbl.iteration_position
				if a_feature.written_class = Current then
					remover.record (a_feature, Current)
				end
				tbl.go (pos)
				tbl.forth
			end
		end

	has_visible: BOOLEAN is
			-- Has the class some visible features
		do
			Result := visible_level.has_visible
		end

	nb_visible: INTEGER is
			-- Number of visible features from the class
		require
			visible_level /= Void
		do
			Result := visible_level.nb_visible (Current)
		end

	visible_table_size: INTEGER is
			-- Size of the hash table for the visible features
		require
			visible_level /= Void
		do
			Result := visible_level.visible_table_size (Current)
		end

feature -- Cecil

	generate_cecil is
			-- Generate cecil table for a class having visible features
		require
			has_visible: has_visible
		do
			visible_level.generate_cecil_table (Current)
		end

	generate_cecil_value is
			-- Generate Cecil type value for a non generic class
		require
			no_generics: generics = Void
		local
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			if is_expanded then
				buffer.putstring ("SK_EXP + ")
			end
			buffer.putstring ("(uint32) ")
			buffer.putint (types.first.type_id - 1)
		end

	cecil_value: INTEGER is
			-- Cecil type value for a non generic class
		require
			no_generics: generics = Void
			one_type_only: types.count = 1
		do
			if is_expanded then
				Result := Sk_exp
			end
			Result := Result + types.first.type_id - 1
		end

feature -- Conformance table generation

	process_polymorphism is
		do
			feature_table.origin_table.add_units (id)
		end

	make_conformance_table (t: CONFORM_TABLE) is
			-- Make final conformance table
		require
			good_argument: t /= Void
		local
			dec: LINKED_LIST [CLASS_C]
			type_list: TYPE_LIST
		do
				-- Mark conformance table `t' first.
			from
				type_list := types
				type_list.start
			until
				type_list.off
			loop
				t.mark (type_list.item.type_id)
				type_list.forth
			end
				-- Recursion on descendants
			from
				dec := descendants
				dec.start
			until
				dec.after
			loop
				dec.item.make_conformance_table (t)
				dec.forth
			end
		end

feature -- Redeclaration valididty

	valid_redeclaration (a_precursor: TYPE_A; redeclared: TYPE_A): BOOLEAN is
			-- Is the redeclaration of `a_precursor' into `redeclared' valid
			-- in the current class ?
		require
			good_argument: not (a_precursor = Void or else redeclared = Void)
		do
			Result := redeclared.redeclaration_conform_to (a_precursor)
		end

feature -- Invariant feature

	has_invariant: BOOLEAN is
			-- Has the current class an invariant clause ?
		do
			Result := invariant_feature /= Void
		end
			
	is_basic: BOOLEAN is
			-- Is the current class a basic class ?
		do
			-- Do nothing
		end

feature -- Process the creation feature

	process_creation_feature (tbl: like feature_table) is
			-- Assign the first creation procedure (if any) to
			-- `creation_feature'.
		do
			if creators /= Void then
				if not creators.empty then
					creators.start
					creation_feature := tbl.item (creators.key_for_iteration)
				end
			else
				creation_feature := Void
			end
		end

feature -- Replication

	propagate_replication (feat_dep: REP_FEATURE_DEPEND) is
			-- Propagate `feat_dep' to do Degree 3. This checks
			-- to see if the feature to be propagated exists in
			-- the descendant. If not, then remove the rep_depend_unit.
		local
			unit: REP_DEPEND_UNIT
			class_c: CLASS_C
			rep_depend: REP_CLASS_DEPEND
			feat_depend: REP_FEATURE_DEPEND
			f_table: FEATURE_TABLE
			feat: FEATURE_I
			class_id: CLASS_ID
			found: BOOLEAN
		do
			from
				feat_dep.start
			until
				feat_dep.after
			loop
				unit := feat_dep.item
				class_id := unit.id
				class_c := System.class_of_id (class_id)
					-- Get feature table
				if class_c /= Void then
					-- Class exists in system
					f_table := class_c.feature_table
						-- Get feature_i to be propagated (if valid)
					feat := f_table.item (unit.feature_name)
					if
						(feat /= Void) and then
						(feat.rout_id_set.same_as (unit.rout_id_set))
					then
						-- Then Propagate
						class_c.set_changed2 (True)
						pass2_controler.insert_new_class (class_c)
						if Rep_depend_server.server_has (class_id) then
							rep_depend := Rep_depend_server.server_item (class_id)
							found := True
						elseif Tmp_rep_depend_server.has (class_id) then
							rep_depend := Tmp_rep_depend_server.item (class_id)
							found := True
						else
							found := False
						end
						if found then
							feat_depend := rep_depend.item (unit.feature_name)
							if feat_depend /= Void then
								propagate_replication (feat_depend)
								if feat_depend.count > 0 then
									Tmp_rep_depend_server.put (rep_depend)
								else
									Tmp_rep_depend_server.remove (class_id)
								end
							end
						end
						feat_dep.forth
					else
							-- Remove depend unit
						feat_dep.remove
debug ("REPLICATION")
	io.error.putstring ("removing dependency to feature: ")
	io.error.putstring (unit.feature_name)
	io.error.putstring ("from class : ")
	io.error.new_line
end
					end
debug ("REPLICATION")
	io.error.putstring ("propagating feature: ")
	io.error.putstring (unit.feature_name)
	io.error.putstring ("to class : ")
	io.error.new_line
end
				else
debug ("REPLICATION")
	io.error.putstring ("removing dependency to feature: ")
	io.error.putstring (unit.feature_name)
	io.error.putstring ("from class : ")
	io.error.new_line
end
						-- Remove depend unit
					feat_dep.remove
				end
debug ("REPLICATION")
	io.error.putstring (class_c.name)
	io.error.new_line
end
			end
		end

	process_replicated_features is
			-- Process replicated features for Current
		require
			have_replicated_features: Tmp_rep_info_server.has (id)
		local
			rep_class_info: REP_CLASS_INFO	
			stored_rep_name_list: S_REP_NAME_LIST
			replicator: REPLICATOR
			rep_name: S_REP_NAME
			old_feat, new_feat: FEATURE_I
			old_body_id, new_body_id: BODY_ID
			rep_table: REP_FEATURES
			new_feat_as, old_feat_as: FEATURE_AS
			rep_features: LINKED_LIST [S_REP_NAME]
		do
			rep_class_info := Tmp_rep_info_server.item (id)
debug ("ACTUAL_REPLICATION", "REPLICATION")
	io.error.putstring ("Replication for class ")
	io.error.putstring (name)
	io.error.new_line
	rep_class_info.trace	
end
			from
				!!rep_table.make (rep_class_info.count, id)
				rep_class_info.start
			until
				rep_class_info.after
			loop
				stored_rep_name_list := rep_class_info.item
				rep_features := stored_rep_name_list.replicated_features
				from
					rep_features.start
				until
					rep_features.after
				loop
					rep_name := rep_features.item
					old_feat := rep_name.old_feature
					new_feat := rep_name.new_feature
					!!replicator.make (old_feat,
									new_feat,
									stored_rep_name_list,
									stored_rep_name_list.parent,
									Current,
									new_feat.feature_name)
					new_feat_as := replicator.ast
					new_body_id := new_feat.body_id
					if new_body_id = Void then
						-- Must check old and new ast for incrementality
						old_body_id := new_feat.original_body_id
						old_feat_as := Rep_feat_server.server_item (old_body_id)
						if
							not old_feat_as.is_assertion_equiv (new_feat_as)
							or else not old_feat_as.is_body_equiv (new_feat_as)
						then
						--	new_body_id := Body_id_counter.next_id
							new_feat.change_body_id
							new_body_id := new_feat.body_id
							insert_changed_feature (new_feat.feature_name)

								-- We do not have enough information to know
								-- in which server we should deactivate, so
								-- we do it in both -- FRED
							Tmp_body_server.desactive (old_body_id)
							Tmp_rep_feat_server.desactive (old_body_id)

debug ("REPLICATION")
	io.error.putstring ("following feature AST was NOT equiv to previous%N")
end
						else
							new_body_id := old_body_id
debug ("REPLICATION")
	io.error.putstring ("following feature AST was equiv to previous%N")
end
						end
					
						--	System.body_index_table.force (new_body_id, new_feat.body_index)
					end
					rep_table.force (new_feat_as, new_body_id)
debug ("ACTUAL_REPLICATION", "REPLICATION")
	new_feat.trace
end
					rep_features.forth
				end
				rep_class_info.forth
			end
			update_rep_feat_server (rep_table)
		end

	update_rep_feat_server (rep_table: REP_FEATURES) is
				-- Update the rep_feat_server with body_id
				-- and its corresponding read_info
		local
			index: EXTEND_TABLE [READ_INFO, FEATURE_AS_ID]
			read_info: READ_INFO
			rep_body_table: EXTEND_TABLE [READ_INFO, BODY_ID]
		do
				-- Clear index
			Tmp_rep_server.clear_index

				-- Put formulates read info index
			Tmp_rep_server.put (rep_table)
			index := Tmp_rep_server.index
			-- Clear index for next class

			from
				!!rep_body_table.make (rep_table.count)
				rep_table.start
			until
				rep_table.after
			loop
					-- `rep_table.item_for_iteration' contains a FEATURE_AS
				read_info := index.item (rep_table.item_for_iteration.id)

					-- Place the read_info for the feature's body id
				rep_body_table.force (read_info, rep_table.key_for_iteration)
				rep_table.forth
			end

			-- Update read info in rep_feat servers
			Tmp_rep_feat_server.merge (rep_body_table)
			Tmp_rep_server.clear_index
		end

	insert_changed_assertion (a_feature: FEATURE_I) is
			-- Insert `a_feature' in the melted set
		local
			melted_info: FEAT_MELTED_INFO
		do
			--! Give a new body id so it is greater
			--! than the frozen level
			a_feature.change_body_id
			if melted_set = Void then
				!! melted_set.make
				melted_set.compare_objects
			end
			!! melted_info.make (a_feature)
			melted_set.put (melted_info)
			System.melted_set.put (Current)
			set_must_be_recompiled (True)
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
			same_class: id.is_equal (other.id)
		local
			classes, desc: LINKED_LIST [CLASS_C]
			class_c: CLASS_C
		do
			is_used_as_expanded := is_used_as_expanded or other.is_used_as_expanded
			is_used_as_separate := is_used_as_separate or other.is_used_as_separate
			filters.append (other.filters)

			from 
				classes := other.clients
				classes.start
				clients.finish
			until 
				classes.after 
			loop
				class_c := System.class_of_id (classes.item.id)
				if not clients.has (class_c) then
					clients.extend (class_c)
					clients.forth
				end
				classes.forth
			end

			from 
				classes := other.descendants
				classes.start 
				desc := descendants
				desc.finish
			until 
				classes.after 
			loop
				class_c  := System.class_of_id (classes.item.id)
				if not desc.has (class_c) then
					desc.extend (class_c)
					desc.forth
				end
				classes.forth
			end

			types.append (other.types)
				--| `syntactical_clients' is used when removing classes.
				--| Since a precompiled class cannot be removed, it
				--| doesn't matter if `syntactical_clients' is out-of-date.
		end

end -- class CLASS_C
