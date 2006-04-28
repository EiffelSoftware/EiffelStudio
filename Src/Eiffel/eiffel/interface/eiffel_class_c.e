indexing
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
			cluster, original_class,
			is_eiffel_class_c,
			eiffel_class_c,
			record_precompiled_class_in_system,
			pass4, melt, update_execution_table, has_features_to_melt,
			melt_all, check_generics, check_generic_parameters,
			check_creation_constraint_genericity,
			check_constraint_genericity
		end

create
	make

feature -- Access

	original_class: EIFFEL_CLASS_I
			-- Original class.

	is_eiffel_class_c: BOOLEAN is True
			-- Is `Current' an EIFFEL_CLASS_C?

	eiffel_class_c: EIFFEL_CLASS_C is
			-- `Current' as `EIFFEL_CLASS_C'.
		do
			Result := Current
		end

	cluster: CLUSTER_I is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end

feature -- Action

	remove_c_generated_files is
			-- Remove the C generated files when we remove `Current' from system.
		local
			retried, file_exists: BOOLEAN
			l_types: TYPE_LIST
			cl_type: CLASS_TYPE
			object_name: STRING
			generation_dir: DIRECTORY_NAME
			c_file_name: FILE_NAME
			file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
			finished_file: PLAIN_TEXT_FILE
		do
			if not retried and System.makefile_generator /= Void and then has_types then
				create generation_dir.make_from_string (Workbench_generation_path)

				from
					l_types := types
					l_types.start
				until
					l_types.after
				loop
					cl_type := l_types.item
					cl_type.remove_c_generated_files
					l_types.forth
				end

				if not is_precompiled then
					create c_file_name.make_from_string (generation_dir)
					create object_name.make (5)
					object_name.append_string (packet_name (C_prefix, packet_number))
					c_file_name.extend (object_name)
					finished_file_name := c_file_name.twin
					create object_name.make (12)
					object_name.append (base_file_name)
					object_name.append_integer (feature_table_file_id)
					object_name.append_character (Feature_table_file_suffix)
					object_name.append (Dot_c)
					c_file_name.set_file_name (object_name)
					create file.make (c_file_name)
					file_exists := file.exists
					if file_exists and then file.is_writable then
						file.delete
					end
					if file_exists then
						finished_file_name.set_file_name (Finished_file_for_make)
						create finished_file.make (finished_file_name)
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

	record_precompiled_class_in_system is
		local
			ast_b: CLASS_AS
			supplier_list: LINKED_LIST [ID_AS]
			parent_list: EIFFEL_LIST [PARENT_AS]
		do
			if not is_in_system then
				set_is_in_system (True)
				if has_ast then
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
		end

	build_ast (save_copy: BOOLEAN): CLASS_AS is
			-- Parse file and generate AST.
			-- If `save_copy' a copy will be made in BACKUP
			-- directory of EIFGEN.
		local
			parser: like eiffel_parser
			file: KL_BINARY_INPUT_FILE
			l_dir: KL_DIRECTORY
			l_dir_name: DIRECTORY_NAME
			l_fname: FILE_NAME
			vd21: VD21
		do
			create file.make (file_name)
			file.open_read

				-- Check if the file to parse is readable
			if not file.is_open_read then
					-- Need to check for existance for the quick melt operation
					-- since it doesn't remove unused classes.
				create vd21
				vd21.set_cluster (cluster)
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
					-- Cannot go on here
				Error_handler.raise_error
					--
					-- NOT REACHED
					--
				check
					False
				end
			else
				has_unique := False

					-- Call Eiffel parser
				parser := Eiffel_parser
				parser.set_has_syntax_warning (System.has_syntax_warning)
				parser.set_has_old_verbatim_strings (system.has_old_verbatim_strings)
				parser.set_has_old_verbatim_strings_warning (system.has_old_verbatim_strings_warning)
				Inst_context.set_group (cluster)
				parser.parse (file)
				Result := parser.root_node

					-- we need to readd the type informations to the ast
				set_need_type_check (True)

				file.close

					-- Save the source class in a Backup directory
				if save_copy and Workbench.automatic_backup then
					create l_dir_name.make_from_string (workbench.backup_subdirectory)
					l_dir_name.extend (lace_class.cluster.cluster_name)
					create l_dir.make (l_dir_name)
					l_dir.create_directory
					create l_fname.make_from_string (l_dir_name)
					l_fname.extend (lace_class.base_name)
					file.copy_file (l_fname)
				end

				Error_handler.checksum
			end
		ensure
			build_ast_not_void: Result /= Void
		rescue
			if Rescue_status.is_error_exception then
					-- Error happened
				if file /= Void and then not file.is_closed then
					file.close
				end
			end
		end


	end_of_pass1 (ast_b: CLASS_AS) is
				-- End of the first pass after syntax analysis
		local
			supplier_list: LINKED_LIST [ID_AS]
			parent_list: EIFFEL_LIST [PARENT_AS]
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
			create syntactical_suppliers.make (old_syntactical_suppliers.count)
			supplier_list := ast_b.suppliers.supplier_ids
			if not supplier_list.is_empty then
				check_suppliers (supplier_list)
			end
			parent_list := ast_b.parents
			if parent_list /= Void then

-- FIXME add incrementality check  Type check error d.add (Current) of type B not conform to A ...
				check_parent_classes (parent_list)
			end

				-- Initialization of the current class
			init (ast_b, old_syntactical_suppliers)

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
				create unique_counter
				create unique_values.make (7)

					-- Compute the values of the unique constants
				ast_b.assign_unique_values (unique_counter, unique_values)
				Tmp_ast_server.unique_values_put (unique_values, class_id)
			end

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
			new_suppliers: like suppliers
			feature_name_id: INTEGER
			f_suppliers: FEATURE_DEPENDANCE
			removed_features: SEARCH_TABLE [FEATURE_I]
			type_check_error: BOOLEAN
			check_local_names_needed: BOOLEAN
			byte_code_generated: BOOLEAN

				-- Invariant
			invar_clause: INVARIANT_AS
			invariant_changed: BOOLEAN

			old_invariant_body_index: INTEGER
			body_index: INTEGER

				-- For Concurrent Eiffel
			def_resc_depend: DEPEND_UNIT
			type_checked: BOOLEAN

		do
			from
					-- Initialization for actual types evaluation
				Inst_context.set_group (cluster)

					-- For a changed class, the supplier list has
					-- to be updated
				if Tmp_depend_server.has (class_id) then
					dependances := Tmp_depend_server.item (class_id)
				elseif Depend_server.has (class_id) then
					dependances := Depend_server.item (class_id)
				else
					create dependances.make (changed_features.count)
					dependances.set_class_id (class_id)
				end

				if changed then
					new_suppliers := suppliers.same_suppliers
				end

				feat_table := Feat_tbl_server.item (class_id)
				def_resc := default_rescue_feature

				ast_context.initialize (Current, actual_type, feat_table)

				if melted_set /= Void then
					melted_set.clear_all
				end

				feature_checker.init (ast_context)
				feat_table.start
			until
				feat_table.after
			loop
				feature_i := feat_table.item_for_iteration
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

						-- For a feature written in the class
					feature_changed := 	changed_features.has (feature_name_id)

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
						feature_changed := (not propagators.melted_empty_intersection (f_suppliers))
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

					ast_context.set_current_feature (feature_i)

						-- No type check for constants and attributes.
						-- [It is done in second pass.]
					if feature_i.is_routine then
						if
							feature_changed
							or else
							not (f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
						then
								-- Type check
							Error_handler.mark
							feature_checker.type_check_and_code (feature_i)
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
								f_suppliers := ast_context.supplier_ids

								if
									def_resc /= Void and then
									not feature_i.is_deferred and then
									not feature_i.is_external and then
									not feature_i.is_attribute and then
									not feature_i.is_constant
								then
										-- Make it dependant on `default_rescue'
									create def_resc_depend.make (class_id, def_resc)
									f_suppliers.extend (def_resc_depend)
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
								byte_code_generated := True
							end
						else
							-- Check the conflicts between local variable names
							-- and feature names
							-- FIX ME: ONLY needed when new features are inserted in the feature table
							check_local_names_needed := True
						end
					else
							-- is_routine = False
						record_suppliers (feature_i, dependances)
					end

					ast_context.clear_feature_context

					if
						(feature_changed or else byte_code_generated)
						and then not (type_check_error or else feature_i.is_deferred)
					then
							-- Remember the melted feature information
							-- if it is not deferred. If it is an external, then
							-- we need to trigger a freeze.
						if feature_i.is_external then
							system.set_freeze
						end
						add_feature_to_melted_set (feature_i)
					end
					type_check_error := False
					byte_code_generated := False

					if not type_checked and then changed3 and then feature_i.is_routine then
							-- Forced type check on the feature
						ast_context.set_current_feature (feature_i)
						feature_checker.type_check_only (feature_i, False)
						check_local_names_needed := False
						ast_context.clear_feature_context
					elseif check_local_names_needed then
						ast_context.set_current_feature (feature_i)
						feature_i.check_local_names
						ast_context.clear_feature_context
					end

				elseif not feature_i.is_routine then
					if feature_i.body_index /= 0 then
						ast_context.set_current_feature (feature_i)
						if
							feature_changed
							or else
							not (f_suppliers = Void
								or else (propagators.empty_intersection (f_suppliers)
								and then propagators.changed_status_empty_intersection (f_suppliers.suppliers)))
						then
							error_handler.mark
							feature_checker.type_check_and_code (feature_i)
							type_checked := True
							type_check_error := error_handler.new_error
							if
								not type_check_error and then
								(feature_checker.byte_code.property_name /= Void or else
								feature_checker.byte_code.property_custom_attributes /= Void)
							then
									-- Save byte code
								tmp_byte_server.put (feature_checker.byte_code)
								byte_code_generated := True
							end
						else
							feature_checker.type_check_only (feature_i, False)
						end
						ast_context.clear_feature_context
					end
					record_suppliers (feature_i, dependances)
				elseif feature_i.is_deferred and then class_id = feature_i.written_in then
						-- Just type check it. See if VRRR or
						-- VMRX error has occurred.
					ast_context.set_current_feature (feature_i)
					feature_checker.type_check_only (feature_i, False)
					ast_context.clear_feature_context
					record_suppliers (feature_i, dependances)
				end
				feat_table.forth
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

				if not invariant_changed then
						-- Force a change on invariant only if it still exist and if line
						-- debugging is turned on. Not doing so could make obsolete
						-- line information on non-changed features.
						-- This should also be done for IL code generation, otherwise
						-- debug info is inconsistent.
					invariant_changed := invariant_feature /= Void and then
						(System.line_generation or System.il_generation)
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

					feature_checker.invariant_type_check_and_code (invariant_feature, invar_clause)

					if not Error_handler.new_error then
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
						f_suppliers := ast_context.supplier_ids.twin
						if invariant_feature /= Void then
							f_suppliers.set_feature_name_id (invariant_feature.feature_name_id)
							dependances.put (f_suppliers, invariant_feature.body_index)
						end
						if new_suppliers = Void then
							new_suppliers := suppliers.same_suppliers
						end
						new_suppliers.add_occurrence (f_suppliers)

						Tmp_inv_byte_server.put (feature_checker.invariant_byte_code)

						add_feature_to_melted_set (invariant_feature)
					end
						-- Clean context
					ast_context.clear_feature_context
				elseif invariant_feature /= Void and degree_3_needed then
						-- we have to type check again to get the types into the ast
					invar_clause := Inv_ast_server.item (class_id)
					feature_checker.invariant_type_check_and_code (invariant_feature, invar_clause)
				end
			end

			if System.il_generation then
				process_custom_attributes
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
					body_index := feature_i.body_index
					f_suppliers := dependances.item (body_index)
					if f_suppliers /= Void then
						if new_suppliers = Void then
							new_suppliers := suppliers.same_suppliers
						end
						new_suppliers.remove_occurrence (f_suppliers)
					end
					dependances.remove (body_index)

						-- Second pass desactive body id of changed
						-- features only. Deactive body ids of removed
						-- features.
					Tmp_ast_server.desactive (body_index)

					removed_features.forth
				end
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
						-- FIXME call `clear_all' ????
				ast_context.clear_feature_context

					-- Clean the caches if error

					--| TMP_AST_SERVER is a SERVER, not a DELAY_SERVER
					--| Calling `wipe_out' on the cache won't remove anything
					--| from the server itself

					--| The other servers are READ_SERVERs.

				Tmp_ast_server.cache.wipe_out
			end
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
--						create invariant_feature.make (Current)
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
--	io.error.put_string ("%TType check for invariant%N")
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
--						f_suppliers := ast_context.supplier_ids.twin
--						dependances.put (f_suppliers, "_invariant")
--						new_suppliers.add_occurrence (f_suppliers)
--
--debug ("ACTIVITY")
--	io.error.put_string ("%TByte code for invariant%N")
--end
--
--						create invar_byte
--						invar_byte.set_class_id (class_id)
--						invar_byte.set_byte_list (invar_clause.byte_node)
--						Tmp_inv_byte_server.put (invar_byte)
--
--						create melted_info
--						melt_set.put (melted_info)
--
--					end
--						-- Clean context
--					ast_context.clear_feature_context
--				end
--			end
		end

	process_custom_attributes is
			-- Perform type checking and byte node generation on custom attributes.
		require
			il_generation: System.il_generation
		local
			l_ast: like ast
			l_ca_feature: INVARIANT_FEAT_I
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
			if l_ast.custom_attributes /= Void then

				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, l_ast.custom_attributes)
				custom_attributes ?= feature_checker.last_byte_node
			else
				custom_attributes := Void
			end
			if l_ast.interface_custom_attributes /= Void then
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature, l_ast.interface_custom_attributes)
				interface_custom_attributes ?= feature_checker.last_byte_node
			else
				interface_custom_attributes := Void
			end
			if l_ast.class_custom_attributes /= Void then
				feature_checker.custom_attributes_type_check_and_code (l_ca_feature,
					l_ast.class_custom_attributes)
				class_custom_attributes ?= feature_checker.last_byte_node
			else
				class_custom_attributes := Void
			end
			if System.root_class /= Void and then System.root_class.compiled_class = Current then
					-- We are processing the root class, let's figure out if there are some
					-- assembly custom attributes.
				if l_ast.assembly_custom_attributes /= Void then
					feature_checker.custom_attributes_type_check_and_code (l_ca_feature,
						l_ast.assembly_custom_attributes)
					assembly_custom_attributes ?= feature_checker.last_byte_node
				end
			else
				assembly_custom_attributes := Void
			end
		end

feature -- Generation

	pass4 is
			-- Generation of C files for each type associated to the current
			-- class
			--|Don't forget to modify also `generate_workbench_files' when modifying
			--|this function
		do
			Inst_context.set_group (cluster)
			types.pass4
		end

feature -- Melting

	melt is
			-- Melt changed features.
		do
			Inst_context.set_group (cluster)
			types.melt

				-- Forget melted list
			melted_set := Void
		end

	update_execution_table is
			-- Update execution table.
		do
			Inst_context.set_group (cluster)
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
			Inst_context.set_group (cluster)
			System.set_current_class (Current)

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
				Inst_context.set_group (cluster)
				types.melt_feature_table
			end

				-- Melt descriptor tables
			feature_table.origin_table.melt (Current)
		end

feature -- Workbench feature and descriptor table generation

	generate_feature_table is
			-- Generation of workbench mode feature table for
			-- the current class
		local
			file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
			if not is_precompiled and has_types then
					-- Clear buffer for Current generation
				buffer := generation_buffer
				buffer.clear_all
				buffer.put_string ("/*%N * Class ")
				buffer.put_string (external_class_name)
				buffer.put_string ("%N */%N%N")
				buffer.put_string ("#include %"eif_macros.h%"%N#include %"eif_struct.h%"%N%N")
				buffer.start_c_specific_code
				feature_table.generate (buffer)
				buffer.end_c_specific_code

					-- Generation of workbench mode feature table for
					-- the current class
				create file.make_c_code_file (feature_table_file_name)
				buffer.put_in_file (file)
				file.close
			end
		end

	generate_workbench_files is
			-- Collect calls to generate_decriptor_table, generate_feature_table and pass4
			-- in case of first compilation.
		do
			generate_descriptor_tables
			generate_feature_table

				-- Generation of C files for each type associated to the current
				-- class
			Inst_context.set_group (cluster)
			types.pass4
 		end

	generate_descriptor_tables is
			-- Generation of workbench mode descriptor tables
			-- of associated class types.
			--|Note: when precompiling a system a class might
			--|have no generic derivations
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
		require
			has_types: has_types
		local
			subdirectory, base_name: STRING
			dir: DIRECTORY
			dir_name: DIRECTORY_NAME
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
			if System.in_final_mode then
				dir_name := Final_generation_path.twin
			else
				dir_name := Workbench_generation_path.twin
			end

			create subdirectory.make (5)
			subdirectory.append_string (packet_name (C_prefix, packet_number))

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
		ensure
			feature_table_file_name_not_void: Result /= Void
			feature_table_file_name_not_empty: not Result.is_empty
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

	packet_number: INTEGER is
			-- Packet in which the file will be generated
		require
			has_types: has_types
		do
			Result := System.static_type_id_counter.packet_number (feature_table_file_id)
		ensure
			packet_number_positive: Result > 0
		end

	feature_table_file_id: INTEGER is
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

feature {NONE} -- Class initialization	

	init (ast_b: CLASS_AS; old_suppliers: like syntactical_suppliers) is
			-- Initialization of the class with AST produced by yacc
		require
			good_argument: ast_b /= Void
		local
			old_generics: like generics
			old_is_expanded: BOOLEAN
			old_is_deferred: BOOLEAN
			old_is_frozen: BOOLEAN
			old_parents: like parents_classes
			a_client: CLASS_C
			changed_status, changed_frozen: BOOLEAN
			is_exp, changed_generics, changed_expanded: BOOLEAN
			gens: like generics
			obs_msg: like obsolete_message
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
					if ast_b.external_class_name /= Void then
						private_external_name := ast_b.external_class_name.value
					else
						private_external_name := Void
					end
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
			old_parents := parents_classes

				-- We set `need_new_parents' so that we trigger a
				-- recomputation of `parents' and `computed_parents' in
				-- `fill_parents'.
			need_new_parents := True

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

			if is_exp and not is_basic then
					-- Record the fact that an expanded is in the system, but only
					-- if it is not a known basic type. This is necessary as some
					-- extra checks must be done after pass2.
				System.set_has_expanded
			end

			if (is_exp /= old_is_expanded and then old_parents /= Void) then
					-- The expanded status has been modifed
					-- (`old_parents' is Void only for the first compilation of the class)
				Degree_4.set_expanded_modified (Current)
				changed_status := True
				changed_expanded := True
			end

				-- Class status
			if System.il_generation then
				is_external := is_basic or ast_b.is_external
			else
				is_external := ast_b.is_external
			end
			has_externals := ast_b.has_externals
			old_is_frozen := is_frozen
			is_frozen := ast_b.is_frozen

			if (old_parents /= Void and then old_is_frozen /= is_frozen) then
				changed_status := True
				changed_frozen := True
			end

			if changed_status then
				Degree_4.add_changed_status (Current)
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					a_client := syntactical_clients.item
					if changed_expanded then
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

				if changed_expanded then
						-- We need to reset its `types' so that they are recomputed.
					remove_types
				end
			end

				-- Init generics
			old_generics := generics

			gens := ast_b.generics

			set_generics (gens)

			if gens /= Void then
					-- Check generic parameter declaration rule
				check_generics
			end

			if old_parents /= Void then
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
					-- Here we check `syntactical_clients' because we only need
					-- to check that declarations are valid.
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					a_client := syntactical_clients.item
					Workbench.add_class_to_recompile (a_client.lace_class)
					a_client.set_changed (True)
					a_client.set_changed3a (True)
					a_client.set_need_type_check (True)
					syntactical_clients.forth
				end
					-- We need to reset its `types' so that they are recomputed.
				remove_types

					-- We need to get rid of content of `filters' since it may contain
					-- incorrect data using Formals that are not there anymore.
				filters.make

				fixme ("[
					Manu: 01/12/2004:
					This is not complete. We also need to type check and regenerate
					the byte code for all the routines of descendants classes as even
					though they haven't changed their code may refer to the former
					generic type.
					]")
			end

			if changed_frozen then
					-- Here we do not check the `syntactical_clients' because we
					-- need to recompile all classes that are using current indirectly
					-- through a feature call where the type is not mentioned.
				from
					clients.start
				until
					clients.after
				loop
					a_client := clients.item
					Workbench.add_class_to_recompile (a_client.lace_class)
					a_client.set_changed (True)
					clients.forth
				end
					-- We need to reset its `types' so that they are recomputed.
				remove_types
			end
		end

	check_generics is
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
				generic_name := generic_dec.name

					-- First, check if the formal generic name is not the
					-- anme of a class in the surrounding universe.
				if Universe.class_named (generic_name, cluster) /= Void then
					create vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name)
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
					if next_dec /= generic_dec then
						if next_dec.name.is_equal (generic_name) then
							create vcfg2
							vcfg2.set_class (Current)
							vcfg2.set_formal_name (generic_name)
							vcfg2.set_location (generic_name)
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
							vgcp3.set_location (f_list.item.start_location)
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
				generic_name := generic_dec.name

				if Universe.class_named (generic_name, cluster) /= Void then
					create vcfg1
					vcfg1.set_class (Current)
					vcfg1.set_formal_name (generic_name)
					vcfg1.set_location (generic_name)
					Error_handler.insert_error (Vcfg1)
				end
				i := i + 1
			end
		end

	check_creation_constraint_genericity is
			-- Check validity of creation constraint genericity
			-- I.e. that the specified creation procedures does exist
			-- in the constraint class.
		local
			generic_dec: FORMAL_CONSTRAINT_AS
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
				generic_dec ?= l_area.item (i)
				check
					generic_dec_not_void: generic_dec /= Void
				end
				if generic_dec.has_constraint and then generic_dec.has_creation_constraint then
					generic_dec.check_constraint_creation (Current)
				end
				i := i + 1
			end
		end

	check_constraint_genericity is
			-- Check validity of constraint genericity
		local
			generic_dec: FORMAL_DEC_AS
			constraint_type: TYPE_AS
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
				generic_dec := l_area.item (i)
				constraint_type := generic_dec.constraint
				if constraint_type /= Void then
					type_a_checker.check_constraint_type (Current, constraint_type, error_handler)
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
				if other_class /= a_class.lace_class then
						-- one of the suppliers has changed (different CLASS_I)
						-- recompile the client (Current class)
					a_class := lace_class.compiled_class
					if a_class = Void or else not a_class.is_precompiled then
						recompile := True
						Workbench.add_class_to_recompile (lace_class)
					end
				end
				l_syntactical_suppliers.forth
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
			comp_class: CLASS_C
		do
				-- 1.	Check if the supplier class is in the universe
				--		associated to `cluster'.
				-- 2.	Check if the supplier class is a new class
				--		for the system.
			supplier_class := Universe.class_named (cl_name, cluster)
			if supplier_class /= Void and then not cl_name.is_equal ("NONE") then
					-- The supplier class is in the universe associated
					-- to `cluster'.
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
				comp_class := supplier_class.compiled_class
				if comp_class /= Current then
					syntactical_suppliers.start
					syntactical_suppliers.search (comp_class)
					if syntactical_suppliers.after then
						syntactical_suppliers.extend (comp_class)
					end
				end
			else
					-- We could not find class of name `cl_name', but it does not mean
					-- that we actually need the class, as maybe, at the end of
					-- the compilation, Current might not be needed anymore.
				system.record_potential_vtct_error (Current, cl_name)
			end
		end

feature -- Conformance table generation

	process_polymorphism is
		do
			System.set_current_class (Current)
			feature_table.origin_table.add_units (class_id)
		end


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
end
