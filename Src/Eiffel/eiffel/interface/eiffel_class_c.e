note
	description: "Represent a compiled eiffel class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLASS_C

inherit
	CLASS_C
		rename
			group as cluster
		redefine
			apply_msil_application_optimizations,
			check_instance_free_usage,
			cluster, original_class,
			is_eiffel_class_c,
			eiffel_class_c,
			record_precompiled_class_in_system,
			pass4, melt, update_execution_table, has_features_to_melt,
			melt_all, check_generics, check_generic_parameters,
			check_creation_constraint_genericity,
			check_constraint_genericity, check_types_in_constraints,
			check_constraint_renaming,
			feature_of_feature_id,
			feature_of_rout_id,
			feature_of_name_id
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	SHARED_GENERATION

	SHARED_LOCALE

create
	make

feature -- Access

	new_byte_code_needed: BOOLEAN
			-- Should code be regenerated at degree 3 for all features to be generated in Current
			-- even if they did not change?

	original_class: EIFFEL_CLASS_I
			-- Original class.

	is_eiffel_class_c: BOOLEAN = True
			-- Is `Current' an EIFFEL_CLASS_C?

	eiffel_class_c: EIFFEL_CLASS_C
			-- `Current' as `EIFFEL_CLASS_C'.
		do
			Result := Current
		end

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end

	inline_agent_table: HASH_TABLE [FEATURE_I, INTEGER]
			-- Table of inline agents indexed by their alias names.
		do
			if internal_inline_agent_table = Void then
					--| FIXME IEK Replace when we have initializers.
				create internal_inline_agent_table.make (0)
			end
			Result := internal_inline_agent_table
		end

	has_inline_agents: BOOLEAN
			-- Does `Current' have inline agents?
		local
			l_internal_inline_agent_table: like internal_inline_agent_table
		do
			l_internal_inline_agent_table := internal_inline_agent_table
			Result := l_internal_inline_agent_table /= Void and then l_internal_inline_agent_table.count > 0
		end

	remove_inline_agents_of_feature (body_id: INTEGER; a_removed: HASH_TABLE [FEATURE_I, INTEGER])
			-- Removes all the inline agents of a given feature
		local
			l_feat: FEATURE_I
			l_inline_agent_table: HASH_TABLE [FEATURE_I, INTEGER]
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				from
					l_inline_agent_table.start
				until
					l_inline_agent_table.after
				loop
					l_feat := l_inline_agent_table.item_for_iteration
					if l_feat.enclosing_body_id_or_creator_position = body_id then
						if a_removed /= Void then
								-- for each removed inline-agent feature we save its
								-- routine id along with its inline_agent_nr
							a_removed.force (l_feat, l_feat.inline_agent_nr)
						end
						l_inline_agent_table.remove (l_inline_agent_table.key_for_iteration)
						system.execution_table.add_dead_function (l_feat.body_index)
					else
						l_inline_agent_table.forth
					end
				end
			end
		end

	feature_of_feature_id (a_feature_id: INTEGER): FEATURE_I
			-- Feature whose feature_id is a_feature_id.
			-- Look into feature_table, generic_features,
			-- anchored_features and inline agent table
		do
			Result := Precursor (a_feature_id)
			if Result = Void then
				Result := inline_agent_of_id (a_feature_id)
			end
		end

	feature_of_rout_id (rout_id: INTEGER_32): FEATURE_I
			-- <Precursor>. Also finds inline agent features
		do
			Result := Precursor (rout_id)
			if Result = Void then
					-- Might be an inline agent
				Result := inline_agent_of_rout_id (rout_id)
			end
		end

	feature_of_name_id (a_feature_name_id: INTEGER): FEATURE_I
			-- <Precursor>. Also finds inline agent features
		do
			Result := Precursor (a_feature_name_id)
			if Result = Void then
				Result := inline_agent_of_name_id (a_feature_name_id)
			end
		end

feature -- Settings

	set_new_byte_code_needed (v: like new_byte_code_needed)
			-- Set `new_byte_code_needed' with `v'.
		do
			new_byte_code_needed := v
		ensure
			new_byte_code_needed_set: new_byte_code_needed = v
		end

feature -- Status report

	apply_msil_application_optimizations: BOOLEAN
			-- Should MSIL application optimizations be applied?
		do
				-- Optimizations will take place on non-deferfed classes that are tag with having optimizations
				-- applied. Optimizations will be performed on finalize or precompile (because wb precompiles can be uses
				-- as a single binary) and only when there are no descendants.
			Result := system.il_generation and then (not is_deferred and not is_expanded) and then
				lace_class.options.is_msil_application_optimize and then
				(system.byte_context.final_mode or universe.compilation_modes.is_precompiling) and then
				((direct_descendants = Void or else direct_descendants.is_empty) or is_frozen)
		end

	is_freeze_required_on_melt (a_feature: FEATURE_I): BOOLEAN
			-- Does `a_feature' require a freeze when melted?
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.is_external or else
				visible_level.is_visible (a_feature, class_id)
		end

feature -- Action

	remove_c_generated_files
			-- Remove the C generated files when we remove `Current' from system.
		local
			retried: BOOLEAN
			l_types: TYPE_LIST
		do
			if not retried and System.makefile_generator /= Void and then has_types then
				from
					l_types := types
					l_types.start
				until
					l_types.after
				loop
					l_types.item.remove_c_generated_files
					l_types.forth
				end
			end
		rescue
			retried := True
			retry
		end

	record_precompiled_class_in_system
		local
			ast_b: CLASS_AS
			supplier_list: SEARCH_TABLE [ID_AS]
			parent_list: EIFFEL_LIST [PARENT_AS]
		do
			if not is_in_system then
				set_is_in_system (True)
				if has_ast then
					ast_b := Ast_server.item (class_id)
					supplier_list := ast_b.suppliers.supplier_ids
					if supplier_list /= Void and then not supplier_list.is_empty then
						check_suppliers (supplier_list, False)
					end
					parent_list := ast_b.parents
					if parent_list /= Void then
						check_parent_classes (parent_list)
					end
				end
			end
		end

	build_ast (save_copy, is_warning_generated: BOOLEAN): CLASS_AS
			-- Parse file and generate AST.
			-- If `save_copy' a copy will be made in BACKUP
			-- directory of EIFGEN.
		local
			parser: like eiffel_parser
			file: KL_BINARY_INPUT_FILE
			l_dir: DIRECTORY
			l_dir_name: PATH
			vd21: VD21
			l_options: CONF_OPTION
			l_dummy_file: RAW_FILE
			l_uuid: STRING
			l_system: CONF_SYSTEM
			l_lace_class: like lace_class
			l_error_level: NATURAL_32
			u: GOBO_FILE_UTILITIES
		do
			file := u.make_binary_input_file (file_name)
			file.open_read

				-- Check if the file to parse is readable
			if not file.is_open_read then
					-- Need to check for existence for the quick melt operation
					-- since it doesn't remove unused classes.
				create vd21
				vd21.set_cluster (cluster)
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
			else
				has_unique := False
				l_error_level := error_handler.error_level

					-- Call Eiffel parser
				parser := Eiffel_parser
				l_lace_class := lace_class
				l_options := l_lace_class.options
				if is_warning_generated then
					parser.set_has_syntax_warning (l_options.is_warning_enabled (w_syntax))
					parser.set_warning_as_error (l_options.is_warning_as_error)
				else
					parser.set_has_syntax_warning (False)
					parser.set_warning_as_error (False)
				end
				inspect l_options.syntax.index
				when {CONF_OPTION}.syntax_index_obsolete then
					parser.set_syntax_version ({EIFFEL_SCANNER}.obsolete_syntax)
				when {CONF_OPTION}.syntax_index_transitional then
					parser.set_syntax_version ({EIFFEL_SCANNER}.transitional_syntax)
				when {CONF_OPTION}.syntax_index_provisional then
					parser.set_syntax_version ({EIFFEL_SCANNER}.provisional_syntax)
				else
					parser.set_syntax_version ({EIFFEL_SCANNER}.ecma_syntax)
				end
				parser.set_is_ignoring_attachment_marks (lace_class.is_void_unsafe)
				Inst_context.set_group (cluster)
				parser.parse_class_from_file (file, Current, Void)
				if l_error_level = error_handler.error_level then
					Result := parser.root_node
					check no_error_implies_not_void: Result /= Void end
						-- Update `date' attribute.
					Result.set_date (l_lace_class.file_date)
					if not Result.class_name.name.is_case_insensitive_equal (l_lace_class.name) then
							-- There is a mismatch, we force a full degree 6 rebuild.
						error_handler.insert_error (create {INTERNAL_ERROR}.make_class_name_mismatch)
							-- Simply discard result.
						Result := Void
					else
							-- Name matches, we can confirm the class.
						l_lace_class.confirm_class_name
					end
				end

					-- We need to readd the type information to the ast
				need_type_check := True

				file.close

					-- Save the source class in a Backup directory
				if save_copy and then system.automatic_backup then

						-- if this is the system of the application target, create an empty file with
						-- the uuid to make it easier to find the application configuration file.
					l_system := l_lace_class.cluster.target.system
					l_uuid := l_system.uuid.out
					if l_system = l_system.application_target.system then
						create l_dummy_file.make_with_path (workbench.backup_subdirectory.extended (l_uuid + ".txt"))
						if not l_dummy_file.exists and then l_dummy_file.is_creatable then
							l_dummy_file.create_read_write
							l_dummy_file.close
						end
					end

						-- Check if the directory for the system has been created
					l_dir_name := workbench.backup_subdirectory.extended (l_uuid)
					create l_dir.make_with_path (l_dir_name)
					if not l_dir.exists then
						u.create_directory_path (l_dir_name)
						adapt_and_copy_configuration (l_system, workbench.backup_subdirectory)
					end

						-- copy class
					copy_class (l_lace_class, l_dir_name)
				end
			end
		rescue
				-- Error happened
			if file /= Void and then not file.is_closed then
				file.close
			end
		end

	end_of_pass1 (ast_b: CLASS_AS)
				-- End of the first pass after syntax analysis
		require
			ast_b_not_void: ast_b /= Void
		local
			supplier_list, light_supplier_list: SEARCH_TABLE [ID_AS]
			parent_list: EIFFEL_LIST [PARENT_AS]
			old_syntactical_suppliers: like syntactical_suppliers
		do
				-- Check that routine classes have an expected number of formal generics.
			if attached system.routine_class as i and then attached i.compiled_class as c and then c.class_id = class_id then
				if attached ast_b.generics as g implies g.count /= 1 then
					error_handler.insert_error (create {SPECIAL_ERROR}.make ({SPECIAL_CONST}.routine_case_1, Current))
				end
			elseif attached system.predicate_class as i and then attached i.compiled_class as c and then c.class_id = class_id then
				if attached ast_b.generics as g implies g.count /= 1 then
					error_handler.insert_error (create {SPECIAL_ERROR}.make ({SPECIAL_CONST}.predicate_case_1, Current))
				end
			elseif attached system.procedure_class as i and then attached i.compiled_class as c and then c.class_id = class_id then
				if attached ast_b.generics as g implies g.count /= 1 then
					error_handler.insert_error (create {SPECIAL_ERROR}.make ({SPECIAL_CONST}.procedure_case_1, Current))
				end
			elseif attached system.function_class as i and then attached i.compiled_class as c and then c.class_id = class_id then
				if attached ast_b.generics as g implies g.count /= 2 then
					error_handler.insert_error (create {SPECIAL_ERROR}.make ({SPECIAL_CONST}.function_case_1, Current))
				end
			end
				-- Check suppliers of parsed class represented by `ast_b'.
				-- Supplier classes not present already in the system
				-- are introduced in it, after having verified that they
				-- are available in the universe.
				-- Empty syntactical supplier list from compilation
				-- to another one after duplicating it.
			old_syntactical_suppliers := syntactical_suppliers
			create syntactical_suppliers.make (old_syntactical_suppliers.count)
			supplier_list := ast_b.suppliers.supplier_ids
			if supplier_list /= Void and then not supplier_list.is_empty then
				check_suppliers (supplier_list, False)
			end
			if lace_class.options.is_warning_enabled (w_export_class_missing) then
				light_supplier_list := ast_b.suppliers.light_supplier_ids
				if light_supplier_list /= Void and then not light_supplier_list.is_empty then
					check_suppliers (light_supplier_list, True)
				end
			end
			parent_list := ast_b.parents
			if parent_list /= Void then
					-- FIXME add incrementality check  Type check error
					-- d.add (Current) of type B not conform to A ...
				check_parent_classes (parent_list)
			end

				-- Initialization of the current class
			init (ast_b, old_syntactical_suppliers)

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
			end
		rescue
			if
				Rescue_status.is_error_exception and then
				attached old_syntactical_suppliers
			then
					-- Error happened.
				syntactical_suppliers.copy (old_syntactical_suppliers)
			end
		end

feature -- Element change

	parsed_ast (after_save: BOOLEAN): CLASS_AS
			-- Parse the AST structure of current class.
			-- Note: Callers are responsible to clearing out any errors and warnings generated
			--       by the last parse!
			--
			--| Save the AST in the temporary server for later retrieval.
			--| if it happens after a save operation.
		require
			not_precompiled: not is_precompiled
			file_is_readable: file_is_readable
		local
			prev_class: CLASS_C
			l_error_level: NATURAL_32
			l_date: INTEGER
		do
			debug ("fixme")
				fixme ("[
						This is bad placement for this routine. It should be extract out to a general class analyzer with
						better error reporting functionality.
						
						There is nothing in this routine that performs any action on this class, only information from it is
						used.
					]")
			end

			l_error_level := error_handler.error_level
			prev_class := System.current_class
			System.set_current_class (Current)
				-- If we are saving, there will be a parse anyway because
				-- the date on file will have changed. We are saving us a
				-- few costly instructions in case the AST is not in memory.
			if not after_save then
				Result := ast
				l_date := lace_class.file_date
			end
			if Result = Void or else Result.date /= l_date then
					-- If there is no stored AST, or if the date stored in the AST
					-- is different from the one on disk, we rebuild the AST.
				Result := build_ast (False, False)
				if Result /= Void and then l_error_level = error_handler.error_level then
					Result.set_class_id (class_id)
				else
					Result := Void
				end
			end
			System.set_current_class (prev_class)
		rescue
			if prev_class /= Void then
					-- Restore context.
				System.set_current_class (prev_class)
			end
		end

feature -- Third pass: byte code production and type check

	pass3 (is_safe_to_check_ancestor: BOOLEAN)
			-- Third pass of the compiler on current class. Two cases:
			-- 1. the class is marked `changed': for all the features
			--	marked `melted', produce byte code and make a type check.
			--	If the class id also marked `changed3', make a type check
			--	for all the other features.
			-- 2. the class is marked `changed3' only, make a type check
			--	on all the features of the class.
			-- We only check ancestor code, only if `is_safe_to_check_ancestor' since
			-- if ancestor code as some degree 3 errors, we do not have enough information
			-- to properly check it.
		local
			feat_table: COMPUTED_FEATURE_TABLE
				-- Feature invariant_type_checktable of the class
			l_attribute_i: ATTRIBUTE_I
			feature_i, def_resc: FEATURE_I
				-- A feature of the class
			l_feature_written_in_current: BOOLEAN
			feature_changed: BOOLEAN
				-- Is the current feature `feature_i' changed ?
			dependances: CLASS_DEPENDANCE
			new_suppliers: like suppliers
			feature_name_id: INTEGER
			f_suppliers: FEATURE_DEPENDANCE
			removed_features: SEARCH_TABLE [INTEGER]
			type_check_error: BOOLEAN
			check_local_names_needed: BOOLEAN
			byte_code_generated: BOOLEAN
			inline_agent_byte_code: LINKED_LIST [BYTE_CODE]
			old_inline_agent_table: like inline_agent_table
			l_old_ast: FEATURE_AS

				-- Invariant
			invar_clause: INVARIANT_AS
			invariant_changed: BOOLEAN
			invariant_removed: BOOLEAN

			old_invariant_body_index: INTEGER
			body_index: INTEGER

				-- For Concurrent Eiffel
			type_checked: BOOLEAN

			l_class_error_level, l_error_level: NATURAL
			l_ast_context: AST_CONTEXT
			warning_level: NATURAL_32
			i: INTEGER
		do
				-- Initialization for actual types evaluation
			Inst_context.set_group (cluster)

				-- For a changed class, the supplier list has to be updated.
				-- We use `disk_item' because new dependencies are not stored if there is a
				-- compilation error, so all the modification we make to `dependances' are
				-- reused as is when recompiling. This fixes the `consistency' precondition of
				-- {SUPPLIER_LIST}.remove_occurrence and eweasel test#incr109.
				-- We look first in TMP_DEPEND_SERVER to address test#incr308 and test#fixed066.
			dependances := tmp_depend_server.item (class_id)
			if dependances = Void then
				dependances := depend_server.disk_item (class_id)
				if dependances = Void then
					create dependances.make (changed_features.count)
					dependances.set_class_id (class_id)
				end
			end

			if changed then
				new_suppliers := suppliers.same_suppliers
			end

			feat_table := feature_table.features
			def_resc := default_rescue_feature

			l_ast_context := ast_context
			l_ast_context.initialize (Current, actual_type)

			if melted_set /= Void then
				melted_set.clear_all
			end

			feature_checker.init (l_ast_context)

			if internal_inline_agent_table /= Void and then internal_inline_agent_table.count > 0 then
				old_inline_agent_table := internal_inline_agent_table.twin
			end

				-- Preprocess features
			l_error_level := Error_handler.error_level
			l_class_error_level := l_error_level
			from
				i := feat_table.count
			until
				i = 0
			loop
				feature_i := feat_table [i]
					-- Check validity of the types in signatures.
				l_ast_context.set_written_class (feature_i.written_class)
				l_ast_context.set_current_feature (feature_i)
				feature_i.check_type_validity (Current)
				i := i - 1
			end

			if error_handler.error_level = l_error_level then
					-- Now check the body.
				from
					i := feat_table.count
				until
					i = 0
				loop
					feature_i := feat_table [i]
					l_feature_written_in_current := feature_i.written_in = class_id
					l_ast_context.set_written_class (feature_i.written_class)
					l_ast_context.set_current_feature (feature_i)
					type_checked := False

					if feature_i.to_melt_in (Current) then
						feature_name_id := feature_i.feature_name_id

						if
							def_resc /= Void
							and then not def_resc.is_empty
							and then def_resc.feature_name_id /= feature_name_id
						then
							feature_i.create_default_rescue (def_resc.feature_name_id)
						end

							-- For a changed feature written in the class or for all
							-- features of the class when `new_byte_code_needed' is true
							-- (This fixes test#incr279 for which some nodes needed to
							-- be updated to reflect the change of generic parameters).
						feature_changed := 	changed_features.has (feature_name_id) or new_byte_code_needed

						if not feature_changed then
								-- Force a change on all feature of current class if line
								-- debugging is turned on. Not doing so could make obsolete
								-- line information on non-changed features.
								-- This should also be done for IL code generation, otherwise
								-- debug info is inconsistent.
							feature_changed := System.line_generation or System.il_generation
						end
						feature_changed := feature_changed and not feature_i.is_attribute

						f_suppliers := dependances.item (feature_i.body_index)

							-- Feature is considered syntactically changed if
							-- some of the entities used by it have changed
							-- of nature (attribute/function versus incrementality).
						if not (feature_changed or else f_suppliers = Void) then
							feature_changed :=
								not propagators.melted_empty_intersection (f_suppliers) or else
								f_suppliers.has_removed_id
							if
								feature_changed and then
								not attached new_suppliers
							then
									-- Automatic melting of the feature.
								new_suppliers := suppliers.same_suppliers
							end
						end

						if feature_i.is_attribute then
								-- We always generate a wrapper for attributes which requires
								-- a body, thus we mark it as changed.
							feature_changed := True
						end

							-- No type check for constants and attributes.
							-- [It is done in second pass.]
						if feature_i.has_code then
							if
								feature_changed
								or else
								not (f_suppliers = Void
									or else (propagators.empty_intersection (f_suppliers)
									and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
							then
									-- Type check
								l_error_level := Error_handler.error_level
								l_ast_context.old_inline_agents.wipe_out
								remove_inline_agents_of_feature (feature_i.body_index, l_ast_context.old_inline_agents)

								feature_checker.type_check_and_code (feature_i, is_safe_to_check_ancestor, feature_i.is_replicated_directly)

								type_checked := True
								type_check_error := Error_handler.error_level /= l_error_level

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
									f_suppliers := l_ast_context.supplier_ids

									if
										def_resc /= Void and then
										not feature_i.is_deferred and then
										not feature_i.is_external and then
										not feature_i.is_attribute and then
										not feature_i.is_constant
									then
											-- Make it dependent on `default_rescue'
										f_suppliers.extend (create {DEPEND_UNIT}.make (class_id, def_resc))
									end
										-- We need to duplicate `f_suppliers' now, otherwise
										-- we will be wiped out in `ast_context.clear_feature_context'.
									f_suppliers := f_suppliers.twin

									f_suppliers.set_feature_name_id (feature_name_id)
									dependances.put (f_suppliers, feature_i.body_index)
									if new_suppliers = Void then
										new_suppliers := suppliers.same_suppliers
									end
									new_suppliers.add_occurrence (f_suppliers)

										-- Byte code processing
									tmp_byte_server.put (feature_checker.byte_code)

									inline_agent_byte_code := feature_checker.inline_agent_byte_codes
									if inline_agent_byte_code /= Void then
										from
											inline_agent_byte_code.start
										until
											inline_agent_byte_code.after
										loop
											tmp_byte_server.put (inline_agent_byte_code.item)
											inline_agent_byte_code.forth
										end
									end
									byte_code_generated := True
								end
							else
								-- Check the conflicts between local variable names
								-- and feature names
								-- FIXME: ONLY needed when new features are inserted in the feature table
								check_local_names_needed := True
							end
						else
							record_suppliers (feature_i, dependances)
						end

						if
							(feature_changed or else byte_code_generated)
							and then not (type_check_error or else feature_i.is_deferred)
						then
								-- Remember the melted feature information
								-- if it is not deferred. If it is an external, then
								-- we need to trigger a freeze.
								-- If it is visible via CECIL, we need to trigger
								-- freeze as well.
							if
								not system.is_freeze_requested and then
								(feature_i.is_external or else
								visible_level.is_visible (feature_i, class_id))
							then
								system.request_freeze
							end
							add_feature_to_melted_set (feature_i)
							if
								feature_i.is_object_relative_once and then
								attached object_relative_once_infos as l_obj_once_info_table and then
								attached l_obj_once_info_table.items_intersecting_with_rout_id_set (feature_i.rout_id_set) as l_obj_once_info_list
							then
								from
									l_obj_once_info_list.start
								until
									l_obj_once_info_list.after
								loop
									if attached l_obj_once_info_list.item as l_obj_info then
										l_attribute_i := l_obj_info.called_attribute_i
										add_feature_to_melted_set (l_attribute_i)

										l_attribute_i := l_obj_info.exception_attribute_i
										add_feature_to_melted_set (l_attribute_i)

										if l_obj_info.has_result then
											l_attribute_i := l_obj_info.result_attribute_i
											add_feature_to_melted_set (l_attribute_i)
										end
									end
									l_obj_once_info_list.forth
								end
							end
						end
						type_check_error := False
						byte_code_generated := False

						if not type_checked and then changed3 and then (feature_i.has_code or else feature_i.has_class_postcondition) then
								-- Record warning level for the case when the warnings should be discarded.
							warning_level := error_handler.warning_level
								-- Forced type check on the feature
							feature_checker.type_check_only (feature_i, is_safe_to_check_ancestor, not l_feature_written_in_current, feature_i.is_replicated_directly)
							if feature_checker.is_ast_modified then
								if error_handler.error_level = l_error_level then
									l_old_ast := tmp_ast_server.body_item (class_id, feature_i.body_index)
										-- If there were not body before, or if it is not the same, we need to regenerate the code
										-- FIXME: Once per object do not reuse their IDs during code generation, therefore we need
										-- to regenerate them as well (see eweasel test#once001).
									if l_old_ast = Void or else not l_old_ast.is_equivalent (feature_i.body) or else feature_i.is_object_relative_once then
											-- Regenerate code for this feature only when there are no errors.
										changed_features.force (feature_name_id)
										i := i + 1
											-- Discard any warnings as they will be reported again at code generation time.
										error_handler.set_warning_level (warning_level)
									end
								end
									-- Regenerate code for descendants that have replicated features.
								debug ("to_implement")
									(create {REFACTORING_HELPER}).to_implement
										("Do finer-grained recompilation based on affected features only.")
								end
								recompile_descendants_with_replication (False)
							end
							check_local_names_needed := False
						elseif
							check_local_names_needed and then
								-- Check local names only for the first feature name alias.
							attached feature_i.body as b and then
							b.feature_name.name_id = feature_i.feature_name_id
						then
							;(create {AST_LOCAL_IDENTIFIER_CHECKER}.make (b, feature_table)).do_nothing
						end
					elseif not feature_i.has_code and then not feature_i.has_class_postcondition then
						record_suppliers (feature_i, dependances)
					elseif is_safe_to_check_ancestor and then (is_full_class_checking or else (need_type_check and then replicated_features_list /= Void and then replicated_features_list.count > 0)) then
							-- We check inherited routines in the context of current class only
							-- if its parents were properly type checked.
							-- 'need_type_check' may be true if `Current' has replicated features.
						feature_checker.type_check_only (feature_i,
							is_safe_to_check_ancestor, class_id /= feature_i.written_in, feature_i.is_replicated_directly)
					end

					l_ast_context.clear_feature_context
					i := i - 1
				end -- Main loop

					-- Recomputation of invariant clause
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
					if invariant_feature /= Void then
						l_ast_context.old_inline_agents.wipe_out
						remove_inline_agents_of_feature (invariant_feature.body_index, Void)
					end
					if f_suppliers /= Void then
						new_suppliers.remove_occurrence (f_suppliers)
					end
						-- Mark invariant to be reset at the end when no error has occurred
					invariant_removed := True
				else
					invariant_changed := propagators.invariant_changed
					if not (invariant_changed or else f_suppliers = Void) then
						invariant_changed := not propagators.melted_empty_intersection (f_suppliers)
					end

					if not invariant_changed then
							-- Force a change on invariant only if it still exist and if line
							-- debugging is turned on. Not doing so could make obsolete
							-- line information on non-changed features.
							-- This should also be done for IL code generation, otherwise
							-- debug info is inconsistent.
							-- We also do it if `new_byte_code_needed' has been set.
						invariant_changed := invariant_feature /= Void and then
							(System.line_generation or System.il_generation or new_byte_code_needed)
					end
					if invariant_changed then
							-- The invariant will be regenerated.
					elseif
						not (f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
					then
							-- The invariant has to be regenerated.
						invariant_changed := True
					elseif invariant_feature /= Void and degree_3_needed then
							-- Probably the invariant need not be regenerated, but it has to be type checked.
						invar_clause := Inv_ast_server.item (class_id)
						l_ast_context.set_written_class (invariant_feature.written_class)
						l_ast_context.set_current_feature (invariant_feature)
							-- Record warning level for the case when the invariant will be regenerated.
						warning_level := error_handler.warning_level
						feature_checker.invariant_type_check (invariant_feature, invar_clause, False)
							-- Regenerate code of a class invariant if its AST is modified.
						if feature_checker.is_ast_modified then
								-- Code generation is not required if there are errors.
							if error_handler.error_level = l_error_level then
									-- Discard warnings that will be reported again during code generation.
								error_handler.set_warning_level (warning_level)
									-- Request invariant regeneration.
								invariant_changed := True
							end
								-- Regenerate all descendants.
							regenerate_descendants
						end
							-- We need to reset the context (see eweasel test#incr351 where it would
							-- not reset the inline agent counter and thus creating below if `invariant_changed'
							-- is True a new inline agent with the wrong number).
						l_ast_context.clear_feature_context
					end
					if invariant_changed then
						if invariant_feature = Void then
							create invariant_feature.make (Current)
							invariant_feature.set_body_index (Body_index_counter.next_id)
							invariant_feature.set_feature_id (feature_id_counter.next)
						end
						invar_clause := Inv_ast_server.item (class_id)
						l_error_level := Error_handler.error_level

						l_ast_context.old_inline_agents.wipe_out
						l_ast_context.set_written_class (invariant_feature.written_class)
						l_ast_context.set_current_feature (invariant_feature)

						remove_inline_agents_of_feature (invariant_feature.body_index, l_ast_context.old_inline_agents)
						feature_checker.invariant_type_check (invariant_feature, invar_clause, True)

						if Error_handler.error_level = l_error_level then
							if f_suppliers /= Void then
								if new_suppliers = Void then
									new_suppliers := suppliers.same_suppliers
								end
								new_suppliers.remove_occurrence (f_suppliers)
								if old_invariant_body_index /= 0 then
									dependances.remove (old_invariant_body_index)
								end
							end
								-- We need to duplicate `f_suppliers' now, otherwise
								-- we will be wiped out in `ast_context.clear_feature_context'.
							f_suppliers := l_ast_context.supplier_ids.twin
							if invariant_feature /= Void then
								f_suppliers.set_feature_name_id (invariant_feature.feature_name_id)
								dependances.put (f_suppliers, invariant_feature.body_index)
							end
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
							new_suppliers.add_occurrence (f_suppliers)

							Tmp_inv_byte_server.put (feature_checker.invariant_byte_code)

							inline_agent_byte_code := feature_checker.inline_agent_byte_codes
							if inline_agent_byte_code /= Void then
								from
									inline_agent_byte_code.start
								until
									inline_agent_byte_code.after
								loop
									tmp_byte_server.put (inline_agent_byte_code.item)
									inline_agent_byte_code.forth
								end
							end

							add_feature_to_melted_set (invariant_feature)
						end
							-- Clean context
						l_ast_context.clear_feature_context
					end
				end

				if System.il_generation then
					process_custom_attributes
				end

				if error_handler.error_level = l_class_error_level then

						-- Remove dependances of removed features
						-- Removed features may be replicated from a parent
						-- so we have to check the removed list each time
						-- instead of checking prior whether 'checked' is True
					from
						removed_features := propagators.removed_features
						removed_features.start
					until
						removed_features.after
					loop
						body_index := removed_features.item_for_iteration

						remove_inline_agents_of_feature (body_index, Void)
						l_ast_context.old_inline_agents.wipe_out

						f_suppliers := dependances.item (body_index)
						if f_suppliers /= Void then
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers
							end
							new_suppliers.remove_occurrence (f_suppliers)
						end
						dependances.remove (body_index)
						removed_features.forth
					end

					if new_suppliers /= Void then
							-- Write new dependances in the dependances temporary
							-- server
						tmp_depend_server.put (dependances)

							-- Update the client/supplier relations for the current
							-- class
						update_suppliers (new_suppliers)
					end
					tmp_creation_server.update (class_id)

					if has_features_to_melt then
						Degree_1.insert_class (Current)
					elseif propagators.invariant_removed then
						Degree_1.insert_class (Current)
					end
				end
			end

			if error_handler.error_level /= l_class_error_level then
					-- Clean data to avoid improper handling at
					-- next compilation.
				l_ast_context.clear_feature_context
				tmp_ast_server.cache.wipe_out
				internal_inline_agent_table := old_inline_agent_table
			elseif invariant_removed then
					-- No error occurred and class was compiled successfully, we can
					-- remove the invariant. This fixes eweasel test#incr345.
				invariant_feature := Void
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Clean data to avoid improper handling at
					-- next compilation.
				ast_context.clear_feature_context
				Tmp_ast_server.cache.wipe_out
				internal_inline_agent_table := old_inline_agent_table
			end
		end

	process_custom_attributes
			-- Perform type checking and byte node generation on custom attributes.
		require
			il_generation: System.il_generation
		local
			l_ast: like ast
			l_ca_feature: INVARIANT_FEAT_I
			l_constructors: LIST [STRING]
			l_error: BOOLEAN
			l_cursor: CURSOR
			l_routine, l_other_routine: FEATURE_I
		do
				-- No need to initialize `context' because we are called from `pass3' which already
				-- initializes it.
			l_ast := ast
			if
				l_ast.custom_attributes /= Void or l_ast.interface_custom_attributes /= Void or
				l_ast.class_custom_attributes /= Void or l_ast.assembly_custom_attributes /= Void
			then
				create l_ca_feature.make (Current)
				l_ca_feature.set_feature_name ("class_custom_attributes")
				ast_context.set_current_feature (l_ca_feature)
				feature_checker.init (ast_context)
			end
			if attached l_ast.custom_attributes as ca then
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, ca)
				custom_attributes := {BYTE_LIST [BYTE_NODE]} / feature_checker.last_byte_node
			else
				custom_attributes := Void
			end
			if attached l_ast.interface_custom_attributes as ca then
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, ca)
				interface_custom_attributes := {BYTE_LIST [BYTE_NODE]} / feature_checker.last_byte_node
			else
				interface_custom_attributes := Void
			end
			if attached l_ast.class_custom_attributes as ca then
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, ca)
				class_custom_attributes := {BYTE_LIST [BYTE_NODE]} / feature_checker.last_byte_node
			else
				class_custom_attributes := Void
			end
			if
				system.is_compiled_root_class (Current) and then
				attached l_ast.assembly_custom_attributes as ca
			then
					-- We are processing the root class, let's figure out if there are some
					-- assembly custom attributes.
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, ca)
				assembly_custom_attributes := {BYTE_LIST [BYTE_NODE]} / feature_checker.last_byte_node
			else
				assembly_custom_attributes := Void
			end
			if l_ast.top_indexes /= Void then
				l_constructors := l_ast.top_indexes.dotnet_constructors
				if l_constructors /= Void then
					-- Check that all features listed in dotnet_contructors indexing clause
					-- correspond to a creation routine
					from
						l_constructors.start
					until
						l_constructors.after or l_error
					loop
						l_error := not creators.has (names_heap.id_of (l_constructors.item))
						if not l_error then
							l_constructors.forth
						end
					end
					if l_error then
						error_handler.insert_error (create {VICR}.make (Current, l_constructors.item))
					end

					-- Now check that there are no two creation routine with same
					-- signature in dotnet_constructors indexing clause
					from
						l_constructors.start
					until
						l_constructors.after or l_error
					loop
						l_cursor := l_constructors.cursor
						l_routine := feature_table.item (l_constructors.item)
						from
							l_constructors.start
						until
							l_constructors.after or l_error
						loop
							l_other_routine := feature_table.item (l_constructors.item)
							l_error := l_other_routine /= l_routine and l_other_routine.same_interface (l_routine)
							l_constructors.forth
						end
						if l_error then
							error_handler.insert_error (create {VISC}.make (Current, l_routine.feature_name, l_other_routine.feature_name))
						else
							l_constructors.go_to (l_cursor)
							l_constructors.forth
						end
					end
				end
			end
		end

feature -- Generation

	pass4
			-- Generation of C files for each type associated to the current
			-- class
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		do
			Inst_context.set_group (cluster)
			types.pass4
		end

feature -- Melting

	melt
			-- Melt changed features.
		do
			Inst_context.set_group (cluster)
			types.melt

				-- Forget melted list
			melted_set := Void
		end

	update_execution_table
			-- Update execution table.
		do
			Inst_context.set_group (cluster)
			types.update_execution_table

				-- Forget melted list
			melted_set := Void
		end

	has_features_to_melt: BOOLEAN
			-- Has the current class features to melt ?
		local
			melt_set: like melted_set
		do
			melt_set := melted_set
			Result := melt_set /= Void and then not melt_set.is_empty
		end

	melt_all
			-- Melt all the features written in the class
		local
			tbl: COMPUTED_FEATURE_TABLE
			feature_i: FEATURE_I
			l_old_group: CONF_GROUP
			l_old_current_class: CLASS_C
		do
			l_old_current_class := system.current_class
			l_old_group := inst_context.group

			Inst_context.set_group (cluster)
			System.set_current_class (Current)

				-- Melt feature written in the class
			from
				tbl := feature_table.features
				tbl.start
			until
				tbl.after
			loop
				feature_i := tbl.item_for_iteration
					-- External feature and inherited one don't need to be melted.
				if feature_i.to_generate_in (Current) then
					if not system.is_freeze_requested and then is_freeze_required_on_melt (feature_i) then
						system.request_freeze
					end
					add_feature_to_melted_set (feature_i)
				end
				tbl.forth
			end
			depend_server.put (depend_server.item (class_id))

				-- Melt possible invariant clause
			if invariant_feature /= Void then
				add_feature_to_melted_set (invariant_feature)
			end

				-- Mark the class to be frozen later again.
			Degree_1.insert_class (Current)
			Degree_2.insert_new_class (Current)

			system.set_current_class (l_old_current_class)
			inst_context.set_group (l_old_group)
		end

	melt_feature_and_descriptor_tables
			-- Melt feature table.
			-- Melt descriptor tables of associated class types
		require
			good_context: Degree_1.has_class (Current)
		do
			System.set_current_class (Current)

				-- Melt feature table.
			if not types.is_empty then
				Inst_context.set_group (cluster)
				types.melt_feature_table
			end

				-- Melt descriptor tables
			feature_table.descriptors (Current).melt
		end

feature -- Workbench feature and descriptor table generation

	generate_workbench_files
			-- Collect calls to generate_decriptor_table and pass4
			-- in case of first compilation.
		do
				-- Generation of workbench mode descriptor tables
				-- of associated class types.
				--|Note: when precompiling a system a class might
				--|have no generic derivations
			System.set_current_class (Current)
			if has_types then
				feature_table.descriptors (Current).generate
			end

				-- C code generation for each generic derivation
			pass4
 		end

feature

	base_file_name: STRING
			-- Generated base file name prefix. Keep first two letters
			-- of class `name'.
			--| Once per object: meaning that even if `name' changes
			--| we keep same C generated file name.
		do
			Result := private_base_file_name
			if Result = Void then
				Result := name.substring (1, name.count.min (2))
				Result.to_lower
				if Result.count = 1 then
						-- To prevent an issue where you might have a class A
						-- with an id of 36 (thus a name of "a36") and a class
						-- A3 with an id of 6 (thus the same name of "a36")
						-- which generate the same CLASS_TYPE.base_file_name and
						-- we do not want that.
						-- Found after slightly changing eweasel test `ccomp043'
					Result.append_character ('_')
				end
				private_base_file_name := Result
			end
		ensure
			base_file_name_not_void: Result /= Void
			base_file_name_not_empty: not Result.is_empty
		end

	packet_number: INTEGER
			-- Packet in which the file will be generated
		require
			has_types: has_types
		do
			Result := System.static_type_id_counter.packet_number (feature_table_file_id)
		ensure
			packet_number_positive: Result > 0
		end

	feature_table_file_id: INTEGER
			-- Number added at end of C file corresponding to generated
			-- feature table. Initialized by default to -1.
		require
			has_types: has_types
		do
			if internal_feature_table_file_id = -1 then
				Result := types.first.static_type_id
				internal_feature_table_file_id := Result
			else
				Result := internal_feature_table_file_id
			end
		ensure
			feature_table_file_id_positive: Result > 0
		end

feature -- Type checking

	check_instance_free_usage (c: AST_INSTANCE_FREE_CHECKER)
			-- <Precursor>
		local
			features: COMPUTED_FEATURE_TABLE
			f: FEATURE_I
			i: INTEGER
		do
			features := feature_table.features
			from
				i := features.count
			until
				i <= 0
			loop
				f := features [i]
				if f.is_class then
					c.verify_class_feature (f, Current)
				elseif f.has_non_object_call then
					c.verify_non_object_calls (f, Current)
				end
				i := i - 1
			end
		end

feature {NONE} -- Class initialization	

	init (ast_b: CLASS_AS; old_suppliers: like syntactical_suppliers)
			-- Initialization of the class with AST produced by yacc
		require
			good_argument: ast_b /= Void
		local
			old_generics: like generics
			old_is_expanded: BOOLEAN
			old_is_deferred: BOOLEAN
			old_is_once: BOOLEAN
			new_is_frozen: BOOLEAN
			l_class: CLASS_C
			is_first_compilation, changed_status: BOOLEAN
			changed_generics, changed_expanded: BOOLEAN
			gens: like generics
			l_is_code_regeneration_needed: BOOLEAN
		do
				-- Assign external name clause
			if System.il_generation then
				if ast_b.top_indexes /= Void then
					private_external_name := ast_b.top_indexes.external_name
					set_is_enum (ast_b.top_indexes.enum_type /= Void)
				elseif ast_b.bottom_indexes /= Void then
					private_external_name := ast_b.bottom_indexes.external_name
					set_is_enum (ast_b.bottom_indexes.enum_type /= Void)
				else
					private_external_name := Void
				end
				if private_external_name = Void then
					if ast_b.external_class_name /= Void then
						private_external_name := ast_b.external_class_name.value
					else
						private_external_name := Void
					end
				end
			else
				private_external_name := Void
			end

				-- Record the storable_version if one specified.
			if ast_b.top_indexes /= Void then
				set_storable_version (ast_b.top_indexes.storable_version)
			elseif ast_b.bottom_indexes /= Void then
				set_storable_version (ast_b.bottom_indexes.storable_version)
			else
				set_storable_version (Void)
			end

				-- Check if obsolete clause was present.
				-- (Void if none was present)
			if attached ast_b.obsolete_message as l_msg then
				set_obsolete_message (l_msg.value)
			else
				set_obsolete_message (Void)
			end

				-- Find out if this is the first time we compile the current class
			is_first_compilation := parents_classes = Void

				-- We set `need_new_parents' so that we trigger a
				-- recomputation of `parents' and `computed_parents' in
				-- `fill_parents'.
			need_new_parents := True

			if not is_first_compilation then
					-- Class was compiled before so we have to update
					-- parent/descendant relation.
					-- [Note that the client/supplier relations will be
					-- updated by the third pass].
				remove_parent_relations
			end

				-- Indexing note
			if attached ast_b.top_indexes as l_top_notes then
				set_is_hidden_in_debugger_call_stack (l_top_notes.is_hidden_in_debugger_call_stack)
			end

				-- Deferred mark
			old_is_deferred := is_deferred
			set_is_deferred (ast_b.is_deferred)
			if not is_first_compilation and old_is_deferred /= is_deferred then
				Degree_4.set_deferred_modified (Current)
				changed_status := True
			end

				-- Expanded mark
			old_is_expanded := is_expanded
			set_is_expanded (ast_b.is_expanded)

			if is_expanded and not is_basic then
					-- Record the fact that an expanded is in the system, but only
					-- if it is not a known basic type. This is necessary as some
					-- extra checks must be done after pass2.
				System.set_has_expanded
			end

			if not is_first_compilation and old_is_expanded /= is_expanded then
					-- The expanded status has been modifed
				Degree_4.set_expanded_modified (Current)
				changed_status := True
				changed_expanded := True
				l_is_code_regeneration_needed := True
			end

				-- Once mark.
			old_is_once := is_once
			set_is_once (ast_b.is_once)

			if not is_first_compilation and old_is_once /= is_once then
					-- The once status has been changed.
				Degree_4.set_once_modified (Current)
				changed_status := True
				changed_expanded := True
				l_is_code_regeneration_needed := True
			end

				-- Class status
			is_external := (System.il_generation and is_basic) or ast_b.is_external

				-- Process `frozen' mark.
			new_is_frozen := ast_b.is_frozen or ast_b.is_once
			changed_status := changed_status or (not is_first_compilation and new_is_frozen)
			is_frozen := new_is_frozen

			if changed_status then
				Degree_4.add_changed_status (Current)
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					l_class := syntactical_clients.item
					if l_is_code_regeneration_needed then
							-- `changed' is set to True so that a complete
							-- pass2 is done on the client. `feature_unit'
							-- will find the type changes
						if not l_class.changed then
							l_class.set_changed (True)
								-- The ast is in the temporary server
								-- so Degree 4 can be done the same way
							Degree_5.insert_class (l_class)
						end
						if changed_expanded then
								-- We do not know if `l_class' is using the current class
								-- as a parent, but we have to reset it even just to be sure.
								-- This fixes eweasel test#incr315 and test#incr361.
							l_class.set_changed (True)
							degree_5.insert_class (l_class)
						end
							-- We need to recompile the features because their code might still
							-- contain reference to the type and because it switched from
							-- expanded to non and vice versa, the type description have to change.
							-- This fixes eweasel test#incr306, test#incr316 and test#final069.
						if attached {EIFFEL_CLASS_C} l_class as l_eiffel_class then
							l_eiffel_class.set_new_byte_code_needed (True)
						end
					else
						l_class.set_changed2 (True)
					end
					Degree_4.set_supplier_status_modified (l_class)
					Degree_3.insert_new_class (l_class)
					Degree_2.insert_new_class (l_class)
					syntactical_clients.forth
				end

				if changed_expanded then
						-- We need to reset its `types' so that they are recomputed.
					remove_types
				end
			end

				-- Init generics
			old_generics := generics

			gens := ast_b.generics

			set_generics (gens)

			if attached gens then
					-- Check generic parameter declaration rule
				check_generics
			end
			initialize_actual_type

			if not is_first_compilation then
				if gens /= Void then
						-- Sometime we retrieve twice the same `generics' because the
						-- AST is still in memory, in which case if `gens' and `old_generics'
						-- point to the same object reference, `changed_generics' is False.
					if gens /= old_generics then
						if old_generics = Void or else old_generics.count /= generics.count then
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
					end
				elseif old_generics /= Void then
					changed_generics := True
				end
			end
			if changed_generics then
				invalidate_caches_related_to_generics

					-- Here we check `syntactical_clients' because we only need
					-- to check that declarations are valid.
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					l_class := syntactical_clients.item
					Workbench.add_class_to_recompile (l_class.original_class)
					l_class.set_changed (True)
					l_class.set_changed3a (True)
					l_class.set_need_type_check (True)
						-- The code below will force a recompilation of features written in
						-- all syntactical clients whereas we only wanted to do that for `descendants'.
						-- Unfortunately `descendants' is reset at degree 5 and thus we have to do it for
						-- all syntactical clients.
						-- We need to recompile the features because their code might still contain
						-- reference to the former generics. This fixes eweasel test#incr279.
					if attached {EIFFEL_CLASS_C} l_class as l_eiffel_class then
						l_eiffel_class.set_new_byte_code_needed (True)
					end
					syntactical_clients.forth
				end

					-- We need to reset its `types' so that they are recomputed.
				remove_types

					-- All the routines need to be regenerated.
				set_new_byte_code_needed (True)

					-- We need to get rid of content of `filters' since it may contain
					-- incorrect data using Formals that are not there anymore.
				filters.wipe_out
			end
		end

	check_generics
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG (page 52)
		local
			generic_dec, next_dec: FORMAL_DEC_AS
			generic_name: ID_AS
			vcfg1: VCFG1
			vcfg2: VCFG2
			vgcp3: VGCP3
			error: BOOLEAN
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, j, nb: INTEGER
			duplicate_name: SEARCH_TABLE [like {ID_AS}.name_id]
			name_id: like {ID_AS}.name_id
			f_list: EIFFEL_LIST [FEAT_NAME_ID_AS]
		do
			from
				l_area := generics.area
				nb := generics.count
			until
				error or else i = nb
			loop
				generic_dec := l_area.item (i)
				generic_name := generic_dec.name

					-- First, check if the formal generic name is not the
					-- a name of a class in the surrounding universe.
				if Universe.class_named (generic_name.name, cluster) /= Void then
					create vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name.name)
					vcfg1.set_location (generic_name)
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
					if
						next_dec /= generic_dec and then
						next_dec.name.is_equal (generic_name)
					then
						create vcfg2
						vcfg2.set_class (Current)
						vcfg2.set_formal_name (generic_name.name)
						vcfg2.set_location (generic_name)
						Error_handler.insert_error (vcfg2)
						error := True
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
						name_id := f_list.item.feature_name.name_id
						if duplicate_name.has (name_id) then
							create vgcp3
							vgcp3.set_class (Current)
							vgcp3.set_feature_name (f_list.item.feature_name.name)
							vgcp3.set_location (f_list.item.start_location)
							Error_handler.insert_error (vgcp3)
						else
							duplicate_name.put (name_id)
						end
						f_list.forth
					end
				end
				i := i + 1
			end
		end

	check_generic_parameters
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG1 (page 52)
		local
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
				generic_name := l_area [i].name
				if Universe.class_named (generic_name.name, cluster) /= Void then
					create vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name.name)
					vcfg1.set_location (generic_name)
					Error_handler.insert_error (Vcfg1)
				end
				i := i + 1
			end
		end

	check_creation_constraint_genericity
			-- Check validity of creation constraint genericity
			-- I.e. that the specified creation procedures does exist
			-- in the constraint class.
		local
			l_area: SPECIAL [FORMAL_DEC_AS]
			i, nb: INTEGER
		do
			Inst_context.set_group (cluster)
			from
				l_area := generics.area
				nb := generics.count
			until
				i = nb
			loop
				if attached {FORMAL_CONSTRAINT_AS} l_area.item (i) as generic_dec then
					if generic_dec.has_constraint and then generic_dec.has_creation_constraint then
							-- `check_constraint_genericity' has already been called in degree4
						generic_dec.check_constraint_creation (Current)
					end
				else
					check
						is_formal_constraint_as: False
					end
				end
				i := i + 1
			end
		end

	check_types_in_constraints
			-- Check simple validity of constraints: not anchors, generics with proper number
			-- of actual generics. No validity check.
		local
			l_type: TYPE_A
			l_vtgc1: VTGC1
			l_vtug: VTUG
			l_constraint_type: TYPE_AS
		do
			Inst_context.set_group (cluster)
			across generics as l_formal_generic loop
				across l_formal_generic.item.constraints as l_constraint loop
					l_constraint_type := l_constraint.item.type
					l_type := type_a_generator.evaluate_type (l_constraint_type, Current)
					if l_type.has_like or not l_type.is_class_valid then
						create l_vtgc1
						l_vtgc1.set_class (Current)
						l_vtgc1.set_location (l_constraint_type.start_location)
						error_handler.insert_error (l_vtgc1)
					elseif not l_type.good_generics then
						l_vtug := l_type.error_generics
						l_vtug.set_class (Current)
						l_vtug.set_location (l_constraint_type.start_location)
						l_vtug.set_is_in_class_constraint (True)
						error_handler.insert_error (l_vtug)
					end
				end
			end
		end

	check_constraint_genericity
			-- Check validity of constraint genericity
		local
			l_constraint_type: TYPE_AS
		do
			Inst_context.set_group (cluster)
			across generics as l_formal_generic loop
				if is_expanded and then l_formal_generic.item.constraints.count > 1 then
					Error_handler.insert_error (create {NOT_SUPPORTED}.make_from_string
						(locale.translation_in_context ("Multiple constraints are not permitted in an expanded generic class", "compiler.error"),
						ast_context,
						l_formal_generic.item.start_location))
				else
					across l_formal_generic.item.constraints as l_constraint loop
						l_constraint_type := l_constraint.item.type
						type_a_checker.check_constraint_type (Current, l_constraint_type, error_handler)
					end
				end
			end
		end


	check_constraint_renaming
			-- Check validity of constraint renaming
		do
			Inst_context.set_group (cluster)
			across
				generics as g
			loop
				if
					attached {FORMAL_CONSTRAINT_AS} g.item as f and then
					f.has_constraint
				then
					f.check_constraint_renaming (Current)
				end
			end
		end

feature -- Supplier checking

	check_suppliers_and_parents
			-- Check the suppliers and the parents before a recompilation
			-- of a system
		local
			a_class: CLASS_C
			other_class: CLASS_I
			recompile: BOOLEAN
			l_syntactical_suppliers: like syntactical_suppliers
		do
			from
				l_syntactical_suppliers := syntactical_suppliers
				l_syntactical_suppliers.start
			until
				l_syntactical_suppliers.after or else recompile
			loop
				a_class := l_syntactical_suppliers.item
				other_class := Universe.class_named (a_class.name, cluster)
				if other_class /= a_class.original_class then
						-- one of the suppliers has changed (different CLASS_I)
						-- recompile the client (Current class)
					a_class := original_class.compiled_class
					if a_class = Void or else not a_class.is_precompiled then
						recompile := True
						Workbench.add_class_to_recompile (original_class)
						a_class.set_changed (True)
					end
				end
				l_syntactical_suppliers.forth
			end
		end

	check_suppliers (supplier_list: SEARCH_TABLE [ID_AS]; a_light_suppliers: BOOLEAN)
			-- Check the supplier ids of the current parsed class
			-- and add perhaps classes to the system.
			--
			-- `supplier_list' a list of suppliers to check.
			-- `a_light_suppliers' indicates that we only record classes that are already compiled and in the system.
		require
			good_argument: not
				(supplier_list = Void or else supplier_list.is_empty)
		do
			from
				supplier_list.start
			until
				supplier_list.after
			loop
					-- Check supplier class_name `supplier_list.item_for_iteration' of the class
				check_one_supplier (supplier_list.item_for_iteration, a_light_suppliers)
				supplier_list.forth
			end
		end

	check_parent_classes (parent_list: EIFFEL_LIST [PARENT_AS])
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
				check_one_supplier (l_area.item (i).type.class_name, False)
				i := i + 1
			end
		end

	check_one_supplier (class_name: ID_AS; a_light_supplier: BOOLEAN)
			-- Check if supplier class named `class_name' is in the
			-- universe.
			-- `a_light_supplier' indicates that we only record it if it is already compiled but don't add it.
			-- We also only generate a warning if the class cannot be found.
		require
			class_name_attached: class_name /= Void
		local
			class_name_id: INTEGER
			supplier_class: CLASS_I
			comp_class: CLASS_C
			l_syntactical_suppliers: like syntactical_suppliers
		do
			class_name_id := class_name.name_id
				-- 1.	Check if the supplier class is in the universe
				--		associated to `cluster'.
				-- 2.	Check if the supplier class is a new class
				--		for the system.
			supplier_class := Universe.class_named (class_name.name, cluster)
			if supplier_class /= Void and then class_name_id /= {PREDEFINED_NAMES}.none_class_name_id then
					-- The supplier class is in the universe associated
					-- to `cluster'.
				if not a_light_supplier then
					if not supplier_class.is_compiled then
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
				end
				comp_class := supplier_class.compiled_class
				check
					not_light_implies_compiled: not a_light_supplier implies comp_class /= Void
				end
				if comp_class /= Current and comp_class /= Void then
					l_syntactical_suppliers := syntactical_suppliers
					l_syntactical_suppliers.start
					l_syntactical_suppliers.search (comp_class)
					if l_syntactical_suppliers.after then
						l_syntactical_suppliers.extend (comp_class)
					end
				end
			elseif a_light_supplier then
				if class_name_id /= {PREDEFINED_NAMES}.none_class_name_id then
					system.record_potential_vtcm_warning (Current, class_name)
				end
			else
					-- We could not find class of name `class_name', but it does not mean
					-- that we actually need the class, as maybe, at the end of
					-- the compilation, Current might not be needed anymore.
				system.record_potential_vtct_error (Current, class_name)
			end
		end

feature -- Inline agents

	put_inline_agent (a_feature: FEATURE_I)
			-- adds a new inline agent to this eiffel class.
		require
			valid_feature: a_feature /= Void
		do
			inline_agent_table.force (a_feature, a_feature.feature_name_id)
		ensure
			agent_added: inline_agent_table.has (a_feature.feature_name_id)
		end

	inline_agent_of_name_id (a_feature_name_id: INTEGER): FEATURE_I
			-- Returns the inline agent with the given `a_feature_name_id'.
		require
			valid_feature_name_id: a_feature_name_id > 0
		local
			l_inline_agent_table: like inline_agent_table
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				Result := l_inline_agent_table.item (a_feature_name_id)
			end
		ensure
			valid_agent_found: Result /= Void implies Result.feature_name_id = a_feature_name_id
		end

	inline_agent_of_id (a_feature_id: INTEGER): FEATURE_I
			-- Returns the inline agent with the feature_id `a_feature_id'.
		require
			valid_feature_id: a_feature_id > 0
		local
			feat: FEATURE_I
			old_cursor: CURSOR
			l_inline_agent_table: like inline_agent_table
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				from
					old_cursor := l_inline_agent_table.cursor
					l_inline_agent_table.start
				until
					Result /= Void or else l_inline_agent_table.after
				loop
					feat := l_inline_agent_table.item_for_iteration
					if feat.feature_id = a_feature_id  then
						Result := feat
					else
						l_inline_agent_table.forth
					end
				end
				if l_inline_agent_table.valid_cursor (old_cursor) then
					l_inline_agent_table.go_to (old_cursor)
				end
			end
		ensure
			valid_agent_found: Result /= Void implies Result.feature_id = a_feature_id
		end

	inline_agent_of_rout_id (a_rout_id: INTEGER): FEATURE_I
			-- Returns the inline agent with the routine id `a_rout_id'.
		require
			valid_rout_id: a_rout_id > 0
		local
			feat: FEATURE_I
			old_cursor: CURSOR
			l_inline_agent_table: like internal_inline_agent_table
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				from
					old_cursor := l_inline_agent_table.cursor
					l_inline_agent_table.start
				until
					Result /= Void or else l_inline_agent_table.after
				loop
					feat := l_inline_agent_table.item_for_iteration
					check
						feat.rout_id_set.count = 1
					end
					if feat.rout_id_set.first = a_rout_id then
						Result := feat
					else
						l_inline_agent_table.forth
					end
				end
				if l_inline_agent_table.valid_cursor (old_cursor) then
					l_inline_agent_table.go_to (old_cursor)
				end
			end
		ensure
			valid_agent_found: Result /= Void implies Result.rout_id_set.first = a_rout_id
		end

	has_inline_agent_with_body_index (body_index: INTEGER): BOOLEAN
		require
			valid_body_index: body_index > 0
		local
			l_inline_agent_table: like internal_inline_agent_table
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				from
					l_inline_agent_table.start
				until
					Result or else l_inline_agent_table.after
				loop
					Result := l_inline_agent_table.item_for_iteration.body_index = body_index
					l_inline_agent_table.forth
				end
			end
		end

	inline_agent_with_nr (a_enclosing_body_id: INTEGER; a_inline_agent_nr: INTEGER): FEATURE_I
			-- Searches for the inline agent with number `a_inline_agent_nr'.
		local
			l_feat: FEATURE_I
			l_old_cursor: CURSOR
			l_inline_agent_table: like internal_inline_agent_table
		do
			l_inline_agent_table := internal_inline_agent_table
			if l_inline_agent_table /= Void and then l_inline_agent_table.count > 0 then
				from
					l_old_cursor := l_inline_agent_table.cursor
					l_inline_agent_table.start
				until
					Result /= Void or else l_inline_agent_table.after
				loop
					l_feat := l_inline_agent_table.item_for_iteration
					if l_feat.enclosing_body_id_or_creator_position = a_enclosing_body_id and then l_feat.inline_agent_nr = a_inline_agent_nr then
						Result := l_feat
					else
						l_inline_agent_table.forth
					end
				end
				if l_inline_agent_table.valid_cursor (l_old_cursor) then
					l_inline_agent_table.go_to (l_old_cursor)
				end
			end
		ensure
			valid_agent_found: Result /= Void implies
				Result.enclosing_body_id_or_creator_position = a_enclosing_body_id and
				Result.inline_agent_nr = a_inline_agent_nr
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Inline agents

	api_inline_agent_of_name (n: STRING): E_FEATURE
			-- API feature for the inline agent named by `n'
		require
			n_not_void: n /= Void
		local
			fi: FEATURE_I
			fid: INTEGER_32
		do
			fid := names_heap.id_of (n)
			if fid > 0 then
				fi := inline_agent_of_name_id (fid)
				if fi /= Void then
					Result := fi.api_feature (class_id)
				end
			end
		ensure
			Result_has_same_name: Result /= Void implies Result.name.is_equal (n)
		end

feature -- Conformance table generation

	process_polymorphism
		do
			System.set_current_class (Current)
			feature_table.select_table.add_units (Current)
		end

feature {NONE} -- Backup implementation

	copy_class (a_class: CONF_CLASS; a_location: PATH)
			-- Make a backup of `a_class' in `a_location'.
		require
			a_class_not_void: a_class /= Void
			a_location_ok: a_location /= Void and then not a_location.is_empty
		local
			l_dir_name, l_fname: PATH
			l_dir: DIRECTORY
			l_over: ARRAYED_LIST [CONF_CLASS]
			u: GOBO_FILE_UTILITIES
		do
				-- create cluster directory if necessary
			l_dir_name := a_location.extended (a_class.group.name)
			u.create_directory_path (l_dir_name)

				-- copy file using as target the eiffel class name, as in a cluster/library there
				-- cannot be two classes with the same name, but you can have two classes with the same
				-- file name.
			l_fname := l_dir_name.extended (a_class.name.as_lower + ".e")
			u.copy_file_path (a_class.full_file_name, l_fname)

				-- if the class does override, also copy the overriden classes
			if a_class.does_override then
				from
					l_over := a_class.overrides
					l_over.start
				until
					l_over.after
				loop
						-- Compute actual location of cluster where overriden class is located.
					l_dir_name := workbench.backup_subdirectory.extended (
						l_over.item.group.target.system.uuid.out)
					create l_dir.make_with_path (l_dir_name)
					if not l_dir.exists then
							-- We need to create the directory.
						u.create_directory_path (l_dir_name)
							-- But also to copy the config files.
						adapt_and_copy_configuration (l_over.item.group.target.system, workbench.backup_subdirectory)
					end
					copy_class (l_over.item, l_dir_name)
					l_over.forth
				end
			end
		end

	adapt_and_copy_configuration (a_system: CONF_SYSTEM; a_location: PATH)
			-- Adapt `a_system' for backup locations and copy the adapted configuration file and assemblies into `a_location'.
		require
			a_system_not_void: a_system /= Void
			a_location_ok: a_location /= Void and then not a_location.is_empty
		local
			l_file_name: PATH
			l_load: CONF_LOAD
			l_system: CONF_SYSTEM
			l_vis: CONF_BACKUP_VISITOR
			u: FILE_UTILITIES
		do
				-- copy original configuration file
			l_file_name := a_location.extended (a_system.uuid.out).extended (backup_config_file)
			u.copy_file_path (a_system.file_path, l_file_name)

				-- adapt configuration file
			create l_load.make (create {CONF_COMP_FACTORY})
			l_load.retrieve_configuration (l_file_name.name)
			if not l_load.is_error then
				l_system := l_load.last_system
				create l_vis.make (a_location)
				l_vis.set_is_il_generation (system.il_generation)
				l_system.process (l_vis)
				l_file_name := a_location.extended (a_system.uuid.out).extended (backup_adapted_config_file)
				l_system.set_file_name (l_file_name.name)
				l_system.store
			end
		end

feature {NONE} -- Implementation

	internal_inline_agent_table: like inline_agent_table
			-- Internal storage for 'inline_agent_table'.

invariant
	inline_agent_table_not_void: inline_agent_table /= Void

note
	ca_ignore: "CA033", "CA033: very long class"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
