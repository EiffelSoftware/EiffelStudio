indexing
	description: "Representation of a compiled class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_C

inherit
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

	COMPILER_EXPORTER

	SHARED_GENERATION

	PART_COMPARABLE

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
			create conformance_table.make (0)
				-- Creation of the syntactical supplier list
			create syntactical_suppliers.make
				-- Creation of the syntactical client list
			create syntactical_clients.make
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
			Result := not is_precompiled
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

	conformance_table: PACKED_BOOLEANS
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

	changed_features: SEARCH_TABLE [INTEGER]
			-- Names of the changed features

	propagators: PASS3_CONTROL
			-- Set of class ids of the classes responsible for
			-- a type check of the current class
	
	creators: EXTEND_TABLE [EXPORT_I, STRING]
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
			Result := lace_class.changed
		end

	already_compiled: BOOLEAN is
			-- Has the class already been compiled before the current
			-- compilation ?
		do
			Result := Ast_server.has (class_id)
		end

feature -- Access: CLI implementation

	class_interface: CLASS_INTERFACE
			-- CLI corresponding interface of Current class.

feature -- Action

	remove_c_generated_files is
			-- Remove the C generated files when we remove `Current' from system.
		local
			retried, file_exists: BOOLEAN
			l_types: TYPE_LIST
			cl_type: CLASS_TYPE
			object_name: STRING
			generation_dir: DIRECTORY_NAME
			c_file_name, cpp_file_name: FILE_NAME
			packet_nb: INTEGER
			file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
			finished_file: PLAIN_TEXT_FILE
		do
			if not retried and System.makefile_generator /= Void and then not types.is_empty then
				!! generation_dir.make_from_string (Workbench_generation_path)
				
				from
					l_types := types
					l_types.start
				until
					l_types.after
				loop
					cl_type := l_types.item
					if not cl_type.is_precompiled then
						packet_nb := cl_type.packet_number
	
							-- Descriptor file removal
						create object_name.make (5)
						object_name.append_character (C_prefix)
						object_name.append_integer (packet_nb)
						!! c_file_name.make_from_string (generation_dir)
						c_file_name.extend (object_name)

						create object_name.make (12)
						object_name.append (base_file_name)
						object_name.append_character (Descriptor_file_suffix)
						object_name.append (Dot_c)
						finished_file_name := clone (c_file_name)
						c_file_name.set_file_name (object_name)
						!! file.make (c_file_name)
						file_exists := file.exists
						if file_exists and then file.is_writable then
							file.delete
						end
						if file_exists then
								-- We delete `finished' only if there was a file to delete
								-- If there was no file, maybe it was simply a melted class.
							finished_file_name.set_file_name (Finished_file_for_make)
							!! finished_file.make (finished_file_name)
							if finished_file.exists and then finished_file.is_writable then
								finished_file.delete
							end
						end
	
							-- C Code file removal
						!! c_file_name.make_from_string (generation_dir)
						create object_name.make (5)
						object_name.append_character (C_prefix)
						object_name.append_integer (packet_nb)
						c_file_name.extend (object_name)
						finished_file_name := clone (c_file_name)
						cpp_file_name := clone (c_file_name)
						create object_name.make (12)
						object_name.append (base_file_name)
						object_name.append (Dot_c)
						c_file_name.set_file_name (object_name)
						!! file.make (c_file_name)
						file_exists := file.exists
						if file_exists and then file.is_writable then
							file.delete
						else
							create object_name.make (12)
							object_name.append (base_file_name)
							object_name.append (Dot_cpp)
							cpp_file_name.set_file_name (object_name)
							create file.make (cpp_file_name)
							file_exists := file.exists
							if file_exists and then file.is_writable then
								file.delete
							end
						end
						if file_exists then
								-- We delete `finished' only if there was a file to delete
								-- If there was no file, maybe it was simply a melted class.
							finished_file_name.set_file_name (Finished_file_for_make)
							!! finished_file.make (finished_file_name)
							if finished_file.exists and then finished_file.is_writable then
								finished_file.delete
							end
						end
					end
					l_types.forth
				end

				if not is_precompiled then
					!! c_file_name.make_from_string (generation_dir)
					create object_name.make (5)
					object_name.append_character (C_prefix)
					object_name.append_integer (packet_number)
					c_file_name.extend (object_name)
					finished_file_name := clone (c_file_name)
					create object_name.make (12)
					object_name.append (base_file_name)
					object_name.append_integer (feature_table_file_id)
					object_name.append_character (Feature_table_file_suffix)
					object_name.append (Dot_c)
					c_file_name.set_file_name (object_name)
					!! file.make (c_file_name)
					file_exists := file.exists
					if file_exists and then file.is_writable then
						file.delete
					end
					if file_exists then
						finished_file_name.set_file_name (Finished_file_for_make)
						!! finished_file.make (finished_file_name)
						if finished_file.exists and then finished_file.is_writable then
							finished_file.delete
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	build_ast (save_copy: BOOLEAN): CLASS_AS is
			-- Parse file and generate AST.
			-- If `save_copy' a copy will be made in BACKUP
			-- directory of EIFGEN.
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
			if save_copy and Workbench.automatic_backup then
				!! f_name.make_from_string (cluster.backup_directory)
				f_name.extend (lace_class.name)
				f_name.add_extension ("e")
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

	record_precompiled_class_in_system is
		local
			ast_b: CLASS_AS
			supplier_list: LINKED_LIST [ID_AS]
			parent_list: EIFFEL_LIST [PARENT_AS]
		do
			if not is_in_system then
				set_is_in_system (True)
				ast_b := Ast_server.item (class_id)
				supplier_list := ast_b.suppliers.supplier_ids
				if not supplier_list.is_empty then
					check_suppliers (supplier_list)
				end
				parent_list := ast_b.parents
				if parent_list /= Void then
					check_parent_classes (parent_list)
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
			if not supplier_list.is_empty then
				check_suppliers (supplier_list)
			end
			parent_list := ast_b.parents
			if parent_list /= Void then

-- FIXME add incrementality check  Type check error d.add (Current) of type B not conform to A ...
				check_parent_classes (parent_list)
			end

				-- Process a compiled form of the parents
			class_info := ast_b.info
			class_info.set_class_id (class_id)

				-- Initialization of the current class
			init (ast_b, class_info, old_syntactical_suppliers)

				-- Check sum error
			Error_handler.checksum
			check
				No_error: not Error_handler.has_error
			end

				-- The class has not been removed (modification of the
				-- number of generics)
if System.class_of_id (class_id) /= Void then
				-- Update syntactical supplier/client relations and take
				-- care of removed classes
			update_syntactical_relations (old_syntactical_suppliers)

				-- Save the abstract syntax tree: the AST of a class
				-- (instance of CLASS_C) is retrieved through the feature
				-- `class_id' of CLASS_C and file ".TMP_AST".
			ast_b.set_class_id (class_id)
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
				Tmp_inv_ast_server.force (invariant_info, class_id)
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

	has_dep_class (a_class : CLASS_C) : BOOLEAN is
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
				-- Resize the table after the topological sort
			conformance_table.resize (topological_id)
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
			a_table: PACKED_BOOLEANS
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
				if creation_feature /= Void and then
							creation_feature.is_empty then
					-- Don't force a creation call if it does
					-- nothing.
					creation_feature := Void
				end
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
			feature_name_id: INTEGER
			f_suppliers: FEATURE_DEPENDANCE
			removed_features: SEARCH_TABLE [FEATURE_I]
			type_check_error: BOOLEAN
			check_local_names_needed: BOOLEAN
			byte_code_generated, has_default_rescue: BOOLEAN
			body_index: INTEGER
			rep_removed: BOOLEAN

				-- Invariant
			invar_clause: INVARIANT_AS
			invar_byte: INVARIANT_B
			invariant_changed: BOOLEAN

			old_invariant_body_index: INTEGER
			feature_body_index: INTEGER

				-- For Concurrent Eiffel
			def_resc_depend: DEPEND_UNIT
			type_checked: BOOLEAN
		do
			from
					-- Initialization for actual types evaluation
				Inst_context.set_cluster (cluster)
				
					-- For a changed class, the supplier list has
					-- to be updated
				if Tmp_depend_server.has (class_id) then
					dependances := Tmp_depend_server.item (class_id)
				elseif Depend_server.has (class_id) then
					dependances := Depend_server.item (class_id)
				else
					!!dependances.make (changed_features.count)
					dependances.set_class_id (class_id)
				end

				if Rep_depend_server.server_has (class_id) then
					rep_dep := Rep_depend_server.server_item (class_id)
				elseif Tmp_rep_depend_server.has (class_id) then
					rep_dep := Tmp_rep_depend_server.item (class_id)
				end

				if changed then
					new_suppliers := suppliers.same_suppliers
				end

				feat_table := Feat_tbl_server.item (class_id)
				def_resc := default_rescue_feature (feature_table)

				ast_context.set_a_class (Current)

				if melted_set /= Void then
					melted_set.clear_all
				end

				feat_table.start
			until
				feat_table.after
			loop
				feature_i := feat_table.item_for_iteration
				type_checked := False

debug ("SEP_DEBUG")
feature_name := feature_i.feature_name
io.error.putstring ("CLASS_C.PASS3 Feature ")
io.error.putstring (feature_name)
io.error.putstring (" whose FEATURE_ID: ")
io.error.putint (feature_i.feature_id)
io.error.new_line
end

				if feature_i.to_melt_in (Current) then
					feature_name_id := feature_i.feature_name_id
					feature_name := feature_i.feature_name

					has_default_rescue := False
					if
						def_resc /= Void
						and then not def_resc.is_empty
						and then def_resc.feature_name_id /= feature_name_id
					then
						feature_i.create_default_rescue (def_resc.feature_name)
						has_default_rescue := True
					end

debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%TTo melt_in true: ")
	io.error.putstring (feature_name)
	io.error.new_line
end
						-- For a feature written in the class
					feature_changed := 	changed_features.has (feature_name_id)
					
					if not feature_changed then
							-- Force a change on all feature of current class if line
							-- debugging is turned on. Not doing so could make obsolete
							-- line information on non-changed features.
						feature_changed := System.line_generation
					end

					feature_changed := feature_changed and not feature_i.is_attribute

debug ("SEP_DEBUG", "ACTIVITY")
	io.error.putstring ("%T%Tfeature_changed: ")
	io.error.putbool (feature_changed)
	io.error.new_line
end
			
					f_suppliers := dependances.item (feature_i.body_index)

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
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
						end
					end
			
					if feature_i.is_attribute then	
							-- Redefinitions of functions into attributes are
							-- always melted
						feature_changed := True
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
									new_suppliers.remove_occurrence (f_suppliers)
									dependances.remove (feature_i.body_index)
								end
										
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
									!!def_resc_depend.make (class_id, def_resc)
									f_suppliers.extend (def_resc_depend)
								end
								f_suppliers.set_feature_name_id (feature_name_id)
								dependances.put (f_suppliers, feature_i.body_index)
								if new_suppliers = Void then
									new_suppliers := suppliers.same_suppliers
								end
								new_suppliers.add_occurrence (f_suppliers)

									-- Byte code processing
debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%Tbyte code for ")
	io.error.putstring (feature_name)
	io.error.new_line
end
								feature_i.compute_byte_code (has_default_rescue)
								byte_code_generated := True
							end
						else
							-- Check the conflicts between local variable names
							-- and feature names
-- FIX ME
-- ONLY needed when new features are inserted in the feature table
							check_local_names_needed := True
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
						add_feature_to_melted_set (feature_i)
					end
					type_check_error := False
					byte_code_generated := False

					if not type_checked and then changed3 and then
						not (feature_i.is_attribute or else feature_i.is_constant) then
						-- Forced type check on the feature
						ast_context.set_a_feature (feature_i)

						feature_i.type_check
						check_local_names_needed := False
						ast_context.clear2
					end
					if check_local_names_needed then
						ast_context.set_a_feature (feature_i)
						feature_i.check_local_names
						ast_context.clear2
					end

				elseif
					((not feature_i.in_pass3)
							-- The feature is deferred and written in the current class
					or else (feature_i.is_deferred and then class_id = feature_i.written_in))
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
				old_invariant_body_index := invariant_feature.body_index
				f_suppliers := dependances.item (old_invariant_body_index)
			else
				f_suppliers := Void
			end

			if propagators.invariant_removed then
				if old_invariant_body_index /= 0 then
					dependances.remove (old_invariant_body_index)
				end
				if new_suppliers = Void then
					new_suppliers := suppliers.same_suppliers
				end
				if f_suppliers /= Void then
					new_suppliers.remove_occurrence (f_suppliers)
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
						create invariant_feature.make (Current)
						invariant_feature.set_body_index
											(Body_index_counter.next_id)
						invariant_feature.set_feature_id (feature_id_counter.next)
					end
				end
				if
					invariant_changed
					or else not	(f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
				then
					invar_clause := Inv_ast_server.item (class_id)
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
							new_suppliers.remove_occurrence (f_suppliers)
							if old_invariant_body_index /= 0 then
								dependances.remove (old_invariant_body_index)
							end
						end
						f_suppliers := clone (ast_context.supplier_ids)
						if invariant_feature /= Void then
							f_suppliers.set_feature_name_id (invariant_feature.feature_name_id)
							dependances.put (f_suppliers, invariant_feature.body_index)
						end
						if new_suppliers = Void then
							new_suppliers := suppliers.same_suppliers
						end
						new_suppliers.add_occurrence (f_suppliers)

debug ("SEP_DEBUG", "VERBOSE", "ACTIVITY")
	io.error.putstring ("%TByte code for invariant%N")
end

						ast_context.start_lines
						!!invar_byte
						invar_byte.set_class_id (class_id)
						invar_byte.set_byte_list (invar_clause.byte_node)
						Tmp_inv_byte_server.put (invar_byte)

						add_feature_to_melted_set (invariant_feature)
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
					feature_body_index := feature_i.body_index
					f_suppliers := dependances.item (feature_body_index)
					if f_suppliers /= Void then
						if new_suppliers = Void then
							new_suppliers := suppliers.same_suppliers
						end
						new_suppliers.remove_occurrence (f_suppliers)
					end
					dependances.remove (feature_body_index)
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
					body_index := feature_i.body_index
						-- Second pass desactive body id of changed
						-- features only. Deactive body ids of removed
						-- features.
					Tmp_body_server.desactive (body_index)

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

			if has_features_to_melt then
				Degree_1.insert_class (Current)
			elseif propagators.invariant_removed then
				Degree_1.insert_class (Current)
			end
		ensure
			No_error: not Error_handler.has_error
		rescue
			if Rescue_status.is_error_exception then
					-- Clean context if error
						-- FIXME call clear1 ????
				ast_context.clear2

					-- Clean the caches if error

					--| TMP_AST_SERVER is a SERVER, not a DELAY_SERVER
					--| Calling `wipe_out' on the cache won't remove anything
					--| from the server itself

					--| The other servers are READ_SERVERs.

				Tmp_ast_server.cache.wipe_out
				Tmp_body_server.cache.wipe_out
				Tmp_inv_ast_server.cache.wipe_out
			end
		end

	record_suppliers (feature_i: FEATURE_I; dependances: CLASS_DEPENDANCE) is
		local
			f_suppliers: FEATURE_DEPENDANCE
			body_index: INTEGER
		do
			body_index := feature_i.body_index
			if dependances.has (body_index) then
				dependances.remove (body_index)
			end
			!!f_suppliers.make
			f_suppliers.set_feature_name_id (feature_i.feature_name_id)
			feature_i.record_suppliers (f_suppliers)
			dependances.put (f_suppliers, body_index)
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
--			new_body_index: INTEGER
		do
--			f_suppliers := dependances.item ("_invariant")
--
--			if propagators.invariant_removed then
--				dependances.remove ("_invariant")
--				new_suppliers.remove_occurrence (f_suppliers)
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
--					new_body_index := Body_id_counter.next
--					System.body_index_table.force
--								(new_body_index, invariant_feature.body_index)
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
--					invar_clause := Tmp_inv_ast_server.item (class_id)
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
--							new_suppliers.remove_occurrence (f_suppliers)
--							dependances.remove ("_invariant")
--						end
--						f_suppliers := clone (ast_context.supplier_ids)
--						dependances.put (f_suppliers, "_invariant")
--						new_suppliers.add_occurrence (f_suppliers)
--
--debug ("ACTIVITY")
--	io.error.putstring ("%TByte code for invariant%N")
--end
--
--						ast_context.start_lines
--						!!invar_byte
--						invar_byte.set_class_id (class_id)
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
	
	update_execution_table is
			-- Update execution table.
		require
			good_context: has_features_to_melt
		do
			Inst_context.set_cluster (cluster)
			types.update_execution_table

				-- Forget melted list
			melted_set := Void
		end

	has_features_to_melt: BOOLEAN is
			-- Has the current class features to melt ?
		local
			melt_set: like melted_set
		do
			melt_set := melted_set
			Result := melt_set /= Void and then not melt_set.is_empty
		end

	melt_all is
			-- Melt all the features written in the class
		local
			c_dep: CLASS_DEPENDANCE
			tbl: FEATURE_TABLE
			feature_i: FEATURE_I
		do
			Inst_context.set_cluster (cluster)

				-- Melt feature written in the class
			from
				tbl := feature_table
				tbl.start
			until
				tbl.after
			loop
				feature_i := tbl.item_for_iteration
				if feature_i.to_generate_in (Current) then
					add_feature_to_melted_set (feature_i)
				end
				tbl.forth
			end
			c_dep := depend_server.item (class_id)
			depend_server.put (c_dep)

				-- Melt possible invariant clause
			if invariant_feature /= Void then
				add_feature_to_melted_set (invariant_feature)
			end

			if not Tmp_m_rout_id_server.has (class_id) then
					-- If not already done, Melt routine id array
				tbl.melt
			end
				-- Mark the class to be frozen later again.
			Degree_1.insert_class (Current)
			Degree_2.insert_new_class (Current)
		end

	melt_feature_and_descriptor_tables is
			-- Melt feature table.
			-- Melt descriptor tables of associated class types
		require
			good_context: Degree_1.has_class (Current)
		do
			System.set_current_class (Current)

				-- Melt feature table.
			if not types.is_empty then
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
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for Current generation
			buffer := generation_buffer
			buffer.clear_all
			buffer.putstring ("/*%N * Class ")
			buffer.putstring (external_class_name)
			buffer.putstring ("%N */%N%N")
			buffer.putstring ("#include %"eif_macros.h%"%N#include %"eif_struct.h%"%N%N")
			buffer.start_c_specific_code
			feature_table.generate (buffer)
			buffer.end_c_specific_code

			create file.make_c_code_file (feature_table_file_name)
			file.put_string (buffer)
			file.close
		end

	generate_workbench_files is
			-- replace generate_decriptor_table,
			-- generate_feature_table and pass4
			-- in case of first compilation.
			-- Just a problem of efficiency
		local
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
			feat_tbl: FEATURE_TABLE
		do
			System.set_current_class (Current)

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
			buffer.putstring ("/*%N * Class ")
			buffer.putstring (external_class_name)
			buffer.putstring ("%N */%N%N")
			buffer.putstring ("#include %"eif_macros.h%"%N#include %"eif_struct.h%"%N%N")
			buffer.start_c_specific_code
			feat_tbl.generate (buffer)
			buffer.end_c_specific_code

				-- Generation of workbench mode feature table for
				-- the current class
			create file.make_c_code_file (feature_table_file_name)
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
			System.set_current_class (Current)
			if has_types then
				feature_table.origin_table.generate (Current)
			end
		end

feature

	feature_table_file_name: FILE_NAME is
			-- Generated file name prefix
			-- Side effect: Create the corresponding subdirectory if it
			-- doesnot exist yet.
		local
			subdirectory, base_name: STRING
			dir: DIRECTORY
			dir_name: DIRECTORY_NAME
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
			if System.in_final_mode then
				dir_name := clone (Final_generation_path)
			else
				dir_name := clone (Workbench_generation_path)
			end

			create subdirectory.make (5)
			subdirectory.append_character (C_prefix)
			subdirectory.append_integer (packet_number)

			dir_name.extend (subdirectory)
			create dir.make (dir_name)
			if not dir.exists then	
				dir.create_dir
			end
				
			create base_name.make (12)
			base_name.append (base_file_name)
			base_name.append_integer (feature_table_file_id)
			base_name.append_character (feature_table_file_suffix)
			base_name.append (Dot_c)
			create Result.make_from_string (dir_name)
			Result.set_file_name (base_name)

			create finished_file_name.make_from_string (dir_name)
			finished_file_name.set_file_name (Finished_file_for_make)
			create finished_file.make (finished_file_name)
			if finished_file.exists and then finished_file.is_writable then
				finished_file.delete	
			end
		end

	base_file_name: STRING is
			-- Generated base file name prefix. Keep first two letters
			-- of class `name'. 
			--| Once per object: meaning that even if `name' changes
			--| we keep same C generated file name.
		do
			Result := private_base_file_name
			if Result = Void then
				Result := name.substring (1, name.count.min (2))
				private_base_file_name := Result
			end
		end

	packet_number: INTEGER is
			-- Packet in which the file will be generated
		do
			Result := System.static_type_id_counter.packet_number (feature_table_file_id)
		end

	feature_table_file_id: INTEGER is
			-- Number added at end of C file corresponding to generated
			-- feature table. Initialized by default to -1.
		require
			types_not_void: types /= Void
			types_not_empty: not types.is_empty
		do
			if internal_feature_table_file_id = -1 then
				Result := types.first.static_type_id
				internal_feature_table_file_id := Result
			else
				Result := internal_feature_table_file_id
			end
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

						Degree_1.insert_class (Current)
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
			vhpr1: VHPR1
			dummy_list: LINKED_LIST [INTEGER]
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
			ancestor_id: INTEGER
		do
				-- Assign external name clause
			if System.il_generation then
				if ast_b.top_indexes /= Void then
					private_external_name := ast_b.top_indexes.external_name
					set_is_enum (ast_b.top_indexes.enum_type /= Void)
				elseif ast_b.bottom_indexes /= Void then
					private_external_name := ast_b.bottom_indexes.external_name
					set_is_enum (ast_b.bottom_indexes.enum_type /= Void)
				end
				if private_external_name = Void then
					private_external_name := ast_b.external_class_name
				end
			else
				private_external_name := Void
			end

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
				Degree_4.set_deferred_modified (Current)
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
					Current /= System.integer_8_class.compiled_class and then
					Current /= System.integer_16_class.compiled_class and then
					Current /= System.integer_32_class.compiled_class and then
					Current /= System.integer_64_class.compiled_class and then
					Current /= System.real_class.compiled_class and then
					(not System.il_generation and then
					Current /= System.wide_char_class.compiled_class and then
					Current /= System.pointer_class.compiled_class)
				then
					System.set_has_expanded
				end
			end

			if (is_exp /= old_is_expanded and then old_parents /= Void) then
					-- The expanded status has been modifed
					-- (`old_parents' is Void only for the first compilation of the class)
				Degree_4.set_expanded_modified (Current)
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

				-- Class status
			is_external := ast_b.is_external
			is_frozen := ast_b.is_frozen

			if (is_separate /= old_is_separate and then old_parents /= Void) then
				Degree_4.set_separate_modified (Current)
				changed_status := True
				changed_separate := True
			end

			if changed_status then
				Degree_4.add_changed_status (Current)
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
								-- so Degree 4 can be done the same way
							Degree_5.insert_changed_class (a_client)
						end
					else
						set_changed2 (True)
					end
					Degree_4.set_supplier_status_modified (a_client)
					Degree_3.insert_new_class (a_client)
					Degree_2.insert_new_class (a_client)
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
					cl_type.type.set_is_true_expanded (is_expanded)
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

			ancestor_id := System.ancestor_class_to_all_classes_id
			if parents_as /= Void and then not parents_as.is_empty then
				if class_id = ancestor_id then
					create vhpr1
					create dummy_list.make
					dummy_list.extend (class_id)
					vhpr1.set_involved_classes (dummy_list)
					Error_handler.insert_error (vhpr1)
						-- Cannot go on here
					Error_handler.raise_error
				end

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
							-- Cannot go on here
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
			elseif not (class_id = ancestor_id) then
					-- No parents are syntactiaclly specified: ANY is
					-- the default parent for Eiffel classes, but not for CLI
					-- classes which inherits from SYSTEM_OBJECT. And ANY
					-- also inherits from SYSTEM_OBJECT.
				create pars.make (1)

				if is_external or else class_id = System.any_id then
					pars.extend (System_object_type)
						-- Add a descendant to class SYSTEM_OBJECT
					System.system_object_class.compiled_class.add_descendant (Current)
						-- Fill parent list of corresponding class info
					parent_list.put_i_th (System_object_parent, 1)
				else
					pars.extend (Any_type)
						-- Add a descendant to class SYSTEM_OBJECT
					System.any_class.compiled_class.add_descendant (Current)
						-- Fill parent list of corresponding class info
					parent_list.put_i_th (Any_parent, 1)
				end
			else
					-- In case of the ancestor class to all classes, just create an empty
					-- parent structure.
				create pars.make (0)
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

						-- Take care of signature conformance for redefinion of
						-- f(p:PARENT) in f(c: CHILD). If CHILD does not inherit
						-- from PARENT anymore, the redefinition of f is not valid
					if removed_parent (old_parents) then
						from
							syntactical_clients.start
						until
							syntactical_clients.after
						loop
							a_client := syntactical_clients.item
							a_client.set_changed2 (True)
							Degree_4.insert_new_class (a_client)
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
			parents /= Void
		end

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

feature {NONE} -- Private access

	Any_type: CL_TYPE_A is
			-- Default parent type
		once
			create Result
			Result.set_base_class_id (System.any_id)
		end

	Any_parent: PARENT_C is
			-- Default compiled parent
		once
			create Result
			Result.set_parent_type (Any_type)
		end

	System_object_type: CL_TYPE_A is
			-- Default parent type
		once
			create Result
			Result.set_base_class_id (System.system_object_id)
		end

	System_object_parent: PARENT_C is
			-- Default compiled parent
		once
			create Result
			Result.set_parent_type (System_object_type)
		end

feature

	update_syntactical_relations
		(old_syntactical_suppliers: like syntactical_suppliers) is
			-- Remove syntactical client/supplier relations and take
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

	mark_class (marked_classes: SEARCH_TABLE [INTEGER]) is
			-- Mark the class as used in the system
			-- and propagate to the suppliers
			-- Used by remove_useless_classes in SYSTEM_I
		do
			if not marked_classes.has (class_id) then
				marked_classes.put (class_id)
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
			generics_exists: is_generic
		local
			generic_dec, next_dec: FORMAL_DEC_AS
			generic_name: ID_AS
			vcfg1: VCFG1
			vcfg2: VCFG2
			vgcp3: VGCP3
			error: BOOLEAN
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, j, nb: INTEGER
			duplicate_name: SEARCH_TABLE [STRING]
			f_list: EIFFEL_LIST [FEATURE_NAME]
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

					-- Third, check that if there is a creation routine specified in
					-- constraint, it does not appear twice in list.
				if generic_dec.has_creation_constraint then
					if duplicate_name /= Void then
						duplicate_name.wipe_out
					else
						create duplicate_name.make (5)
					end

					from
						f_list := generic_dec.creation_feature_list
						f_list.start
					until
						f_list.after
					loop
						if duplicate_name.has (f_list.item.internal_name) then
							create vgcp3
							vgcp3.set_class (Current)
							vgcp3.set_feature_name (f_list.item.internal_name)
							Error_handler.insert_error (vgcp3)
						else
							duplicate_name.put (f_list.item.internal_name)
						end
						f_list.forth
					end
				end
				i := i + 1
			end
		end

	check_generic_parameters is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG1 (page 52)
		require
			generics_exists: is_generic
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
			-- Check validity of creation constraint genericity
			-- I.e. that the specified creation procedures does exist
			-- in the constraint class.
		require
			generics_exists: is_generic
		local
			generic_dec: FORMAL_DEC_AS
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
			generics_exists: is_generic
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
			il_inherit_error: IL_INHERIT_ERROR
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
					parent_actual_type.reset_constraint_error_list
					parent_actual_type.check_constraints (Current)
					if not parent_actual_type.constraint_error_list.is_empty then
						!!vtcg4
						vtcg4.set_class (Current)
						vtcg4.set_error_list (parent_actual_type.constraint_error_list)
						vtcg4.set_parent_type (parent_actual_type)
						Error_handler.insert_error (vtcg4)
					end
				end

				if parent_actual_type.associated_class.is_frozen then
						-- Error which occurs only during IL generation.
					check
						il_generation: System.il_generation
					end
					create il_inherit_error.make (Current)
					il_inherit_error.set_parent_class (parent_actual_type.associated_class)
					Error_handler.insert_error (il_inherit_error)
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
				(supplier_list = Void or else supplier_list.is_empty)
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
				else
					if
						supplier_class.compiled_class.is_precompiled and then
						not Compilation_modes.is_precompiling
					then
							-- Mark precompiled class as part of system.
						supplier_class.compiled_class.record_precompiled_class_in_system
					end
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
			create string_type
			string_type.set_base_class_id (System.string_id)
			create array_generics.make (1, 1)
			array_generics.put (string_type, 1)
			create Result.make (array_generics)
			Result.set_base_class_id (System.array_id)
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

	set_is_in_system (v: BOOLEAN) is
			-- Set `is_in_system' to `v'.
		require
			not_precompiling: not Compilation_modes.is_precompiling
		do
			is_in_system := v
		ensure
			is_in_system_set: TRUE
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

	set_visible_table_size (i: INTEGER) is
			-- Assign `i' to `visible_table_size'
		require
			i_positive: i >= 0
		do
			visible_table_size := i
		ensure
			visible_table_size_set: visible_table_size = i
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
					create Result.make_no
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
			actual_generic: ARRAY [FORMAL_A]
			formal: FORMAL_A
		do
			if generics = Void then
				!!Result
			else
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
					create {GEN_TYPE_A} Result.make (actual_generic)
				until
					i > count
				loop
					!! formal
					formal.set_position (i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			end
			Result.set_base_class_id (class_id)
			Result.set_is_true_expanded (is_expanded)
		end
		
	insert_changed_feature (feature_name_id: INTEGER) is
			-- Insert feature `feature_name_id' in `changed_features'.
		require
			good_argument: feature_name_id > 0
		do
debug ("ACTIVITY")
	io.error.putstring ("CLASS_C: ")
	io.error.putstring (name)
	io.error.putstring ("%NChanged_feature: ")
	io.error.putstring (Names_heap.item (feature_name_id))
	io.error.new_line
end
			changed_features.put (feature_name_id)
		end
	
	constraint (i: INTEGER): TYPE_A is
			-- I-th constraint of the class
		require
			positive_argument: i > 0
			generics_exists: is_generic
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
			no_generic: not is_generic
		local
			class_type: CLASS_TYPE
			type_i: CL_TYPE_I
		do
			!!type_i
			type_i.set_base_id (class_id)
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
			if not derivations.has_derivation (class_id, data) then
					-- The recursive update is done only once
				derivations.insert_derivation (class_id, data)
				
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

					if System.address_table.class_has_dollar_operator (class_id) then
						System.set_freeze
					end

						-- Mark the class `changed4' because there is a new
						-- type
					changed4 := True
					Degree_2.insert_new_class (Current)
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
			-- Is class SPECIAL or TO_SPECIAL ?
		do
			-- Do nothing
		end

	is_special_array: BOOLEAN is
			-- Is class SPECIAL?
		do
		end

	is_native_array: BOOLEAN is
			-- Is class a NATIVE_ARRAY class?
		do
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
											(actual_class_type, class_id)
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

	default_rescue_feature (ftab: FEATURE_TABLE): FEATURE_I is
			-- The version of `default_rescue' from ANY.
			-- Void if ANY has not been compiled yet or
			-- does not posess the feature.
		local
			item: FEATURE_I
			pos, id: INTEGER
		do
			if (System.any_class /= Void) then
				from
					pos  := ftab.iteration_position
					id := System.default_rescue_id
					ftab.start
				until
					ftab.after or (Result /= Void)
				loop
					item := ftab.item_for_iteration

					if item.rout_id_set.first = id then
						Result := item
					end

					ftab.forth
				end

				ftab.go (pos)
			end
		end

feature -- default_create routine

	default_create_feature : FEATURE_I is
			-- The version of `default_create' from ANY.
			-- Void if ANY has not been compiled yet or
			-- does not posess the feature or class is deferred.
		require
			any_class_compiled: System.any_class /= Void
		do
			if not is_deferred then
				Result := feature_table.feature_of_rout_id (System.default_create_id)
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
				Result := dcr_feat /= Void and then (
					(creators = Void) or else (not creators.is_empty and then creators.has (dcr_feat.feature_name)))
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
					if item.rout_id_set.first = System.memory_dispose_id then
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

	visible_table_size: INTEGER
			-- Size of hash table for visible features of Current class.

feature -- Cecil

	generate_cecil is
			-- Generate cecil table for a class having visible features
		require
			has_visible: has_visible
		do
				-- Reset hash-table size which will be computed during
				-- generation. 
			set_visible_table_size (0)
			visible_level.generate_cecil_table (Current)
		end

	generate_cecil_value is
			-- Generate Cecil type value for a non generic class
		require
			no_generics: not is_generic
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
			no_generics: not is_generic
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
			System.set_current_class (Current)
			feature_table.origin_table.add_units (class_id)
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
			
feature -- Process the creation feature

	process_creation_feature (tbl: like feature_table) is
			-- Assign the first creation procedure (if any) to
			-- `creation_feature'.
		do
			if creators /= Void then
				if not creators.is_empty then
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
			cid: INTEGER
			found: BOOLEAN
		do
			from
				feat_dep.start
			until
				feat_dep.after
			loop
				unit := feat_dep.item
				cid := unit.class_id
				class_c := System.class_of_id (cid)
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
						Degree_4.insert_new_class (class_c)
						if Rep_depend_server.server_has (cid) then
							rep_depend := Rep_depend_server.server_item (cid)
							found := True
						elseif Tmp_rep_depend_server.has (cid) then
							rep_depend := Tmp_rep_depend_server.item (cid)
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
									Tmp_rep_depend_server.remove (cid)
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

	insert_changed_assertion (a_feature: FEATURE_I) is
			-- Insert `a_feature' in the melted set
		do
			add_feature_to_melted_set (a_feature)
			Degree_1.insert_class (Current)
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
			same_class: class_id = other.class_id
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
				class_c := System.class_of_id (classes.item.class_id)
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
				class_c  := System.class_of_id (classes.item.class_id)
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

feature {NONE} -- Implementation

	add_feature_to_melted_set (f: FEATURE_I) is
		local
			melt_set: like melted_set
			melted_info: MELTED_INFO
			ext: EXTERNAL_I
		do
			melt_set := melted_set
			if melt_set = Void then
				create melt_set.make (melted_set_chunk)
				melted_set := melt_set
			end

			if f.is_external then
				ext ?= f
				if ext.is_cpp or ext.is_special or ext.encapsulated then
					create {FEAT_MELTED_INFO} melted_info.make (f, Current)
				else
					create {EXT_FEAT_MELTED_INFO} melted_info.make (f, Current)
				end
			elseif f = invariant_feature then
				create {INV_MELTED_INFO} melted_info.make (f, Current)
			else
				create {FEAT_MELTED_INFO} melted_info.make (f, Current)
			end
			melt_set.force (melted_info)
		end

	Melted_set_chunk: INTEGER is 20
			-- Size of `melted_set' which contains melted features.

feature -- Initialization

	initialize (l: CLASS_I) is
			-- Initialization of Current.
		require
			good_argument: l /= Void
		do
			lace_class := l
				-- Set `is_class_any' and `is_class_none'
			is_class_any := name_in_upper.is_equal ("ANY")
			is_class_none := name_in_upper.is_equal ("NONE")
				-- Creation of the descendant list
			!! descendants.make
				-- Creation of the supplier list
			!! suppliers.make
				-- Creation of the client list
			!! clients.make
				-- Types list creation
			!! types.make
		end

feature -- Properties

	lace_class: CLASS_I
			-- Lace class 

	parents: FIXED_LIST [CL_TYPE_A]
			-- Parent classes

	descendants: LINKED_LIST [CLASS_C]
			-- Direct descendants of the current class

	clients: LINKED_LIST [CLASS_C]
			-- Clients of the class

	suppliers: SUPPLIER_LIST
			-- Suppliers of the class in terms of calls
			-- [Useful for incremental type check].

	generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Formal generical parameters

	generic_features: HASH_TABLE [FORMAL_ATTRIBUTE_I, INTEGER]
			-- Collect all possible generic derivations inherited or current.
			-- Indexed by `rout_id' of formal generic parmater.
			-- Updated during `pass2' of INHERIT_TABLE.

	topological_id: INTEGER
			-- Unique number for a class. Could change during a topological
			-- sort on classes.

	reverse_engineered: BOOLEAN
			-- Does the Storage mechanism for EiffelCase need
			-- to regenerate the EiffelCase description for Current class?

	is_deferred: BOOLEAN
			-- Is class deferred ?

	is_expanded: BOOLEAN
			-- Is class expanded?

	is_enum: BOOLEAN
			-- Is class an IL enum type?
			-- Useful to perform call optimization on enum type in FEATURE_B.

	is_basic: BOOLEAN is
			-- Is class basic?
		do
		end

	is_separate: BOOLEAN
			-- Is the class separate ?

	is_frozen: BOOLEAN
			-- Is class frozen, ie we cannot inherit from it?

	is_external: BOOLEAN
			-- Is class an external one?
			-- If yes, we do not generate it.

	obsolete_message: STRING
			-- Obsolete message
			-- (Void if Current is not obsolete)

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
				Result := clone (name)
				Result.to_upper
			end
		end

	text: STRING is
			-- Class text
		require
			valid_file_name: file_name /= Void
		do
			Result := lace_class.text
		end

feature -- status

	hash_code: INTEGER is
			-- Hash code value corresponds to `class_id'.
		do
			Result := class_id
		end

feature {CLASS_I} -- Settings

	set_lace_class (cl: CLASS_I) is
			-- Assign `cl' to `lace_class'.
		require
			cl_not_void: cl /= Void
			cl_different_from_current_lace_class: cl /= lace_class
		do
			lace_class := cl
		ensure
			lace_class_set: lace_class = cl
		end

feature -- Access

	is_fully_deferred: BOOLEAN is
			-- Are parents of current class either ANY or a fully deferred class?
			-- Does current class contain only deferred features?
		require
			has_feature_table: has_feature_table
		local
			feat: FEATURE_I
			feat_tbl: FEATURE_TABLE
			written_in: INTEGER
			par: like parents
		do
			Result := True
			if not is_class_any then
				Result := is_deferred
				if Result then
					from
						par := parents
					  	par.start
					until
						par.after or else not Result
					loop
						Result := Result and then par.item.associated_class.is_fully_deferred
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
			Result := clone (name)
			Result.to_upper
		end

	ast: CLASS_AS is
			-- Associated AST structure
		do
			if Ast_server.has (class_id) then
				Result := Ast_server.item (class_id)
			elseif Tmp_ast_server.has (class_id) then
				Result := Tmp_ast_server.item (class_id)
			end
		ensure
			non_void_result_if: has_ast implies Result /= Void 
		end

	most_recent_ast: CLASS_AS is
			-- Last stored AST structure.
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

	feature_with_name (n: STRING): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_n: n /= Void
			has_feature_table: has_feature_table
		local
			f: FEATURE_I
		do
			f := feature_table.item (n)
			if f /= Void then
				Result := f.api_feature (class_id)
			end
		end

	feature_with_body_index (bid: INTEGER): E_FEATURE is
			-- Feature whose body id `bid'.
		require
			valid_body_index: bid /= 0
			has_feature_table: has_feature_table
		local
			feat: FEATURE_I
		do
			feat := feature_table.feature_of_body_index (bid)
			if feat /= Void then
				Result := feat.api_feature (class_id)
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
			-- List of once functions
		local
			f_table: FEATURE_TABLE
			feat: FEATURE_I
			cid: INTEGER
		do
			cid := class_id
			!! Result.make
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

	is_valid: BOOLEAN is
			-- Is the current class valid?
			-- (After a compilation Current may become 
			-- invalid)
		do
			Result := class_id > 0 and then class_id <= System.classes.array_count
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

	click_list: CLICK_LIST is
			-- Associated click list
		local
			l_ast: like ast
		do
			l_ast := most_recent_ast
			if l_ast /= Void then
				Result := l_ast.click_list
			end
		ensure
			valid_result: Result /= Void implies has_ast
		end

	cluster: CLUSTER_I is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end

	hidden: BOOLEAN is
			-- Is the class hidden in the precompilation sets?
		do
			Result := lace_class.hidden
		ensure
			hide_only_when_precompiled: Result implies is_precompiled
		end

	file_name: STRING is
			-- File name of the class
		do
			Result := lace_class.file_name
		end

	file_is_readable: BOOLEAN is
			-- Is file with `file_name' readable?
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (file_name)
			Result := f.is_readable	
		end

	has_syntax_error: BOOLEAN is
			-- Does class have a syntax error (after calling `parse_ast')?
		do
			Result := last_syntax_error /= Void
		ensure
			ok_result: Result = (last_syntax_error /= Void)
		end

	last_syntax_error: SYNTAX_ERROR is
			-- Last syntax error generated after calling
			-- routine `parse_ast'
		do
			Result := last_syntax_cell.item
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Order relation on classes
		do
			Result := topological_id < other.topological_id
		end

feature -- Element change

	parse_ast is
			-- Parse the AST structure of current class if it has changed.
			-- Set `last_syntax_error' if a syntax error ocurred.
			--| Save the AST in the temporary server and add it to the
			--| pass one controller (need to still do the end of pass1 process).
		require
			not_precompiled: not is_precompiled
			file_is_readable: file_is_readable
		local
			class_ast: CLASS_AS
			error: BOOLEAN
			syntax_error: SYNTAX_ERROR
			compiled_info: CLASS_C
			prev_class: CLASS_C
		do
			if not error then
				prev_class := System.current_class
				compiled_info ?= Current
				System.set_current_class (compiled_info)
				last_syntax_cell.put (Void)
				class_ast := build_ast (False)
				class_ast.set_class_id (class_id)
					-- Mark the class if it has syntactically changed
					--| Improvement: We can retrieve the previous version of
					--| the AST and compare the new one with the old one.
					--| If they are different, we should put the new one in the
					--| server and make the old one obsolete (so that it can be
					--| removed from the server and avoided a growing EIFGEN).
				set_changed (True)
				Tmp_ast_server.put (class_ast)
					-- Clear index of the temporary ast server for next first pass.
				Tmp_ast_server.clear_index
				Degree_5.insert_parsed_class (compiled_info)
				Degree_4.insert_new_class (compiled_info)
				Degree_3.insert_new_class (compiled_info)
				Degree_2.insert_new_class (compiled_info)
				lace_class.set_date
			else
				syntax_error ?= Error_handler.error_list.first
				check
					syntax_error_not_void: syntax_error /= Void
				end
				Error_handler.error_list.wipe_out
				last_syntax_cell.put (syntax_error)
				error := False
			end
			System.set_current_class (prev_class)
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False)
				error := True
				retry
			end
		end

feature -- Output

	class_signature: STRING is
			-- Signature of class
		local
			formal_dec: FORMAL_DEC_AS
			old_cluster: CLUSTER_I
			gens: like generics
		do
			!!Result.make (50)
			Result.append (name)
			Result.to_upper
			gens := generics
			if gens /= Void then
				old_cluster := Inst_context.cluster
				Inst_context.set_cluster (cluster)
				Result.append (" [")
				from
					gens.start
				until
					gens.after
				loop
					formal_dec ?= gens.item
					Result.append (formal_dec.constraint_string)
					gens.forth
					if not gens.after then
						Result.append (", ")
					end
				end
				Inst_context.set_cluster (old_cluster)
				Result.append ("]")
			end
		end

	append_header (st: STRUCTURED_TEXT) is
			-- Append class header to `st'.
		do
			if is_expanded then
				st.add (ti_Expanded_keyword)
				st.add_space
			elseif is_deferred then
				st.add (ti_Deferred_keyword)
				st.add_space
			end
			st.add (ti_Class_keyword)
			st.add_new_line
			st.add_indent
			append_signature (st)
			st.add_new_line
		end

	append_signature (st: STRUCTURED_TEXT) is
			-- Append the signature of current class in `st'
		require
			non_void_st: st /= Void
		local
			formal_dec: FORMAL_DEC_AS
			old_cluster: CLUSTER_I
			gens: like generics
		do
			append_name (st)
			gens := generics
			if gens /= Void then
				old_cluster := Inst_context.cluster
				Inst_context.set_cluster (cluster)
				st.add_space
				st.add (ti_L_bracket)
				from
					gens.start
				until
					gens.after
				loop
					formal_dec ?= gens.item
					formal_dec.append_signature (st)
					gens.forth
					if not gens.after then
						st.add (ti_Comma)
						st.add_space
					end
				end
				st.add (ti_R_bracket)
				Inst_context.set_cluster (old_cluster)
			end
		end

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name ot the current class in `st'
		require
			non_void_st: st /= Void
		do
			st.add_classi (lace_class, name_in_upper)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_topological_id (i: INTEGER) is
			-- Assign `i' to `topological_id'.
		do
			topological_id := i
		end

	set_is_deferred (b: BOOLEAN) is
			-- Assign `b' to `is_deferred'.
		do
			is_deferred := b
		end

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
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

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		end

	set_parents (p: like parents) is
			-- Assign `p' to `parents'.
		do
			parents := p
		end

	set_suppliers (s: like suppliers) is
			-- Assign `s' to `suppliers'.
		do
			suppliers := s
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g
		end

	set_reverse_engineered (b: BOOLEAN) is
			-- Set reversed_engineered to `b'.
		do
			reverse_engineered := b
		ensure
			reverse_engineered_set: reverse_engineered = b
		end

	set_obsolete_message (m: like obsolete_message) is
			-- Set `obsolete_message' to `m'.
		do
			obsolete_message := m
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

feature -- Removal

	clear_syntax_error is
			-- Clear the syntax error information.
		do
			last_syntax_cell.put (Void)
		ensure
			not_has_syntax: not has_syntax_error
		end

feature -- Genericity

	formal_at_position (n: INTEGER): FORMAL_ATTRIBUTE_I is
			-- Find first FORMAL_ATTRIBUTE_I in `generic_features' that
			-- matches position `n'.
		require
			has_formal: is_generic
		local
			l_formals: like generic_features
			l_formal: FORMAL_A
		do
			from
				l_formals := generic_features
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
		ensure
			result_not_void: Result /= Void
		end

	update_generic_features is
			-- Update `generic_features' with information of Current.
		local
			l_parents: like parents
			l_formal, l_parent_formal: FORMAL_ATTRIBUTE_I
			l_formal_type: FORMAL_A
			l_generic_features, l_old: like generic_features
			l_inherited_formals: SEARCH_TABLE [INTEGER]
			l_rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
		do
				-- Cleaned previously stored information.
			l_old := generic_features
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
						create l_formal_type
						l_formal_type.set_position (i)
						
						create l_formal
						l_formal.set_feature_name ("_" + name_in_upper + "_Formal#" + i.out)
						l_formal.set_type (l_formal_type)
						l_formal.set_written_in (class_id)
						l_formal.set_origin_class_id (class_id)
					
						create l_rout_id_set.make (1)
						l_rout_id_set.put (l_formal.new_rout_id)
						l_formal.set_rout_id_set (l_rout_id_set)
						l_formal.set_is_origin (True)
						l_formal.set_position (i)

						if l_old /= Void and then l_old.has (l_rout_id_set.first) then
							l_formal.set_feature_id (
								l_old.item (l_formal.rout_id_set.first).feature_id)
						else
							l_formal.set_feature_id (feature_id_counter.next)
						end
						l_formal.set_origin_feature_id (l_formal.feature_id)

						l_generic_features.put (l_formal, l_rout_id_set.first)
					end
					i := i + 1
				end
			else
					-- FIXME: Manu 01/02/2002. Add assertion that shows
					-- that all FORMAL_ATTRIBUTE_I.type of `l_generic_features'
					-- are not instances of FORMAL_I.
			end
		
 			debug ("FORMAL_GENERIC")
				if l_generic_features /= Void then
					print ("%NFor class " + name_in_upper + ": " + l_generic_features.count.out)
					print (" local + inherited generic parameters%N")
				end
 			end
		end
		
feature {NONE} -- Genericity

	extend_generic_features (an_item: FORMAL_ATTRIBUTE_I) is
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
						-- well implemented by compiler?
					check
						same_type: l_generic_features.item (l_rout_id).type.same_as (an_item.type)
					end
				end

				i := i + 1	
			end
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
		local
			ftbl: like feature_table
		do
			if not n.is_empty then
				ftbl := feature_table
				if ftbl /= Void then
					Result := ftbl.item (n)
				end
			end
		end

feature -- Implementation

	feature_table: FEATURE_TABLE is
			-- Compiler feature table
		require
			has_feature_table: has_feature_table
		do
			Result := Feat_tbl_server.item (class_id)
		ensure
			valid_result: Result /= Void
		end

	has_feature_table: BOOLEAN is
			-- Has Current a feature table
		do
			Result := Feat_tbl_server.has (class_id)
		end

feature {NONE} -- Implementation

	private_external_name: STRING
			-- Store class alias name clause value.

	private_base_file_name: STRING
			-- Base file name used in code generation.

	last_syntax_cell: CELL [SYNTAX_ERROR] is
			-- Stored value of last generated syntax error generated calling
			-- routine `parse_ast'
		once
			!! Result.put (Void)
		end

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

feature {DEGREE_4} -- Degree 4

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
			separate_modified := False
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

	separate_modified: BOOLEAN
			-- Has the separate status of current
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

	set_separate_modified is
			-- Set `separate_modified' to True.
		do
			separate_modified := True
		ensure
			separate_modified_set: separate_modified
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
		do
			degree_3_needed := True
			finalization_needed := True
		ensure
			added: degree_3_needed
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

feature {DEGREE_MINUS_1} -- Degree -1

	add_to_degree_minus_1 is
			-- Add current class to Degree -1.
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
			l_name := name_in_upper
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

invariant

	lace_class_exists: lace_class /= Void
	descendants_exists: descendants /= Void
	suppliers_exisis: suppliers /= Void
	clients_exists: clients /= Void

end -- class CLASS_C


