-- Internal representation of a compiled class.

class CLASS_C 

inherit

	TOPOLOGICAL
		rename
			successors as descendants
		end;
	IDABLE;
	SHARED_WORKBENCH;
	SHARED_SERVER;
	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end;
	SHARED_TYPES;
	SHARED_INSTANTIATOR;
	SHARED_TYPEID_TABLE;
	SHARED_ERROR_HANDLER;
	SHARED_CONSTRAINT_ERROR;
	SHARED_INST_CONTEXT;
	SHARED_CODE_FILES;
	SHARED_BODY_ID;
	SHARED_PASS;
	EXCEPTIONS;
	MEMORY;
	SK_CONST;

creation

	make
	
feature 

	lace_class: CLASS_I;
			-- Lace class

	obsolete_message: STRING;
			-- Obsolete message 
			-- (Void if Current is not obsolete)

	parents: FIXED_LIST [CL_TYPE_A];
			-- Parent classes

	descendants: LINKED_LIST [like Current];
			-- Direct descendants of the current class

	clients: LINKED_LIST [CLASS_C];
			-- Clients of the class

	suppliers: SUPPLIER_LIST;
			-- Suppliers of the class in terms of calls
			-- [Useful for incremental type check].

	syntactical_suppliers: LINKED_LIST [SUPPLIER_CLASS];
			-- Syntactical suppliers of the class
			--| Useful for time-stamp

	syntactical_clients: LINKED_LIST [CLASS_C];
			-- Syntactical clients of the class
			--| Useful for class removal

	generics: EIFFEL_LIST [FORMAL_DEC_AS];
			-- Formal generical parameters

	topological_id: INTEGER;
			-- Unique number for a class. Could change during a topological
			-- sort on classes.

	changed2: BOOLEAN;
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
			Result := propagators.make_pass3;
		end; -- changed3

	changed4: BOOLEAN;
			-- Has the class a new class type ?

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	conformance_table: ARRAY [BOOLEAN];
			-- Conformance table of the class;: once a class has changed
			-- it must be reprocessed and the conformance table of the
			-- recursive descendants also.

	types: TYPE_LIST;
			-- Meta-class types associated to the class: it contains
			-- only one type if the class is not generic

	filters: FILTER_LIST; 	-- ## FIXME 2.3 Patch: redefinition of equal in
							-- GEN_TYPE_I
			-- Filters associated to the class: useful for recalculating
			-- the type system: it is empty if the class is a non-generic
			-- one.

	feature_id_counter: COUNTER;
			-- Counter of feature ids

	unique_counter: COUNTER;
			-- Counter for unique features

	changed_features: SEARCH_TABLE [STRING];
			-- Names of the changed features

	propagators: PASS3_CONTROL;
			-- Set of class ids of the classes responsible for
			-- a type check of the current class
	
	id: INTEGER;
			-- Class id

	creators: EXTEND_TABLE [EXPORT_I, STRING];
			-- Creation procedure names

	creation_feature: FEATURE_I;
			-- Creation feature for expanded types

	date: INTEGER;
			-- Last modification sate of the associated file
			-- [Needed for time stamp]

	melted_set: SORTED_SET [MELTED_INFO];
			-- Melting information list
			-- [Processed by the third pass.]

	invariant_feature: INVARIANT_FEAT_I;
			-- Invariant feature

	skeleton: GENERIC_SKELETON;
			-- Attributes skeleton

	is_obsolete: BOOLEAN is
			-- Is the class obsolete ?
		do
			Result := obsolete_message /= Void
		end;

	changed: BOOLEAN is
			-- Is the class syntactically changed ?
		do	
			Result := lace_class.changed
		end;

	make (l: CLASS_I) is
			-- Creation
		require
			good_argument: l /= Void;
		do
			lace_class := l;
				-- Creation of the descendant list
			!!descendants.make;
				-- Creation of a conformance table
			!!conformance_table.make (1,1);
				-- Creation of the client list
			!!clients.make;
				-- Creation of the supplier list
			!!suppliers.make;
				-- Creation of the sytactical supplier list
			!!syntactical_suppliers.make;
				-- Creation of the syntactical client list
			!!syntactical_clients.make;
				-- Types list creation
			!!types.make;
				-- Filter list creation
			!!filters.make;
				-- Feature id counter creation
			!!feature_id_counter;
				-- Changed features list creation
			!!changed_features.make (20);
				-- Propagator set creation
			!!propagators.make;
				-- Unique counter creation
			!!unique_counter;
		end;

	already_compiled: BOOLEAN is
			-- Has the class already been compiled before the current
			-- compilation ?
		do
			Result := Ast_server.has (id);
		end;

	build_ast: CLASS_AS is
			-- Parse the file and generate the AST
		local
			file: UNIX_FILE;
			class_file_name: STRING;
			vd21: VD21;
		do
			!!file.make (file_name);
				-- Check if the file to parse is readable
			if not file.is_readable then
				!!vd21;
				vd21.set_cluster (cluster);
				vd21.set_file_name (file_name);
				Error_handler.insert_error (vd21);
					-- Cannot go on here
				Error_handler.raise_error;
					-- 
					-- NOT REACHED
					--
				check False end;
			end;
			check
				file.is_readable;
			end;

			file.open_read;
			check
				file.is_open_read;
			end;

				-- Call Yacc
			class_file_name := file_name;
			collection_off;
			Result := c_parse (file.file_pointer, $class_file_name);
			collection_on;
			file.close;
			Error_handler.checksum;
		rescue
			if exception = Programmer_exception then
					-- Error happened
				collection_on;
				if not (file = Void or else file.is_closed) then
					file.close;
				end;
			end;
		end;
	
	end_of_pass1 (ast: CLASS_AS) is
				-- End of the first pass after syntax analysis
		local
			supplier_list: LINKED_LIST [ID_AS];
			class_info: CLASS_INFO;
				-- Temporary structure to build about the current class
				-- which will be useful for second pass.
			parent_list: EIFFEL_LIST [PARENT_AS];
			invariant_info: READ_INFO;
			old_syntactical_suppliers: like syntactical_suppliers;
			file: UNIX_FILE;
			class_file_name: STRING;
			vd22: VD22;
		do
				-- Check suppliers of parsed class represented by `ast'.
				-- Supplier classes not present already in the system
				-- are introduced in it, after having verified that they
				-- are avaible in the universe.
				-- Empty syntactical supplier list from compilation
				-- to another one after duplicating it.
			old_syntactical_suppliers := syntactical_suppliers.twin;
			syntactical_suppliers.wipe_out;
			supplier_list := ast.suppliers.supplier_ids;
			if not supplier_list.empty then
				check_suppliers (supplier_list);
			end;
			parent_list := ast.parents;
			if parent_list /= Void then
				check_parent_classes (parent_list);
			end;

				-- Process a compiled form of the parents
			class_info := ast.info;
			class_info.set_id (id);

				-- Initialization of the current class
			init (ast, class_info, old_syntactical_suppliers);

				-- Check sum error
			Error_handler.checksum;
			check
				No_error: not Error_handler.has_error;
			end;

				-- The class has not been removed (modification of the
				-- number of generics)
			if System.class_of_id (id) /= Void then

				-- Update syntactical supplier/client relations and take
				-- care of removed classes
			update_syntactical_relations (old_syntactical_suppliers);

				-- Save the abstract syntax tree: the AST of a class
				-- (instance of CLASS_C) is retrieved through the feature
				-- `id' of CLASS_C and file ".TMP_AST".
			ast.set_id (id);
			Tmp_ast_server.put (ast);

				-- Save index left by the temporary ast server into the
				-- class information.
			class_info.set_index (Tmp_ast_server.index.twin);
			invariant_info := Tmp_ast_server.invariant_info;
			if invariant_info /= Void then
				class_info.set_invariant_info (Tmp_ast_server.invariant_info);
				Tmp_inv_ast_server.force (invariant_info, id);
			end;

				-- Put class information in class information table for
				-- feature `init'.
			Tmp_class_info_server.put (class_info);

				-- Clear index of the temporary ast server for next first
				-- pass
			Tmp_ast_server.clear_index;

				-- Clean the filters, i.e. remove all the obsolete types
			filters.clean;
			end;
		ensure
			No_error: not Error_handler.has_error;
		rescue
			if exception = Programmer_exception then
					-- Error happened
				if old_syntactical_suppliers /= Void then
					syntactical_suppliers.copy (old_syntactical_suppliers)
				end;
			end;
		end; -- end_of_pass1

feature -- Building conformance table

	fill_conformance_table is
			-- Fill the conformance table. All the class processed
			-- during second pass must see their conformance table
			-- processed/re-processed by this routine.
		require
			topological_id_processed: topological_id > 0;
		do
				-- Resize the table after the topological sort
			conformance_table.resize (1, topological_id);
			conformance_table.clear_all;
			build_conformance_table_of (Current);
		end;

	build_conformance_table_of (cl: CLASS_C) is
			-- Build recursively the conformance table of class `cl.
		require
			good_argument: cl /= Void;
			conformance_table_exists: cl.conformance_table /= Void;
			topological_id_processed: topological_id > 0;
			conformance: topological_id <= cl.topological_id;
		local
			a_parent: CLASS_C;
			a_table: ARRAY [BOOLEAN];
		do
			a_table := cl.conformance_table;
			if a_table.item (topological_id) = False then
					-- The parent has not been inserted yet
				a_table.put (True, topological_id);
				from
					parents.start;
				until
					parents.offright
				loop
					a_parent := parents.item.associated_class;
					a_parent.build_conformance_table_of (cl);
					parents.forth;
				end;
			end;
		end;

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
			feat_table: FEATURE_TABLE;
				-- Feature table of the class
			feature_i: FEATURE_I;
				-- A feature of the class
			feature_changed, not_empty: BOOLEAN;
				-- Is the current feature `feature_i' changed ?
			dependances: CLASS_DEPENDANCE;
			new_suppliers: like suppliers;
			feature_name: STRING;
			f_suppliers: FEATURE_DEPENDANCE;
			removed_features: SEARCH_TABLE [FEATURE_I];
			melted_info: FEAT_MELTED_INFO;
			melt_set: like melted_set;
			type_check_error: BOOLEAN;
		do
				-- Verbose
			io.error.putstring ("Pass 3 on class ");
			io.error.putstring (class_name);
			io.error.new_line;

			from
					-- Initialization for actual types evaluation
				Inst_context.set_cluster (cluster);

					-- For a changed class, the supplier list has
					-- to be updated
				if Tmp_depend_server.has (id) then
					dependances := Tmp_depend_server.item (id);
				elseif Depend_server.has (id) then
					dependances := Depend_server.item (id);
				else
					!!dependances.make (changed_features.count);
					dependances.set_id (id);
				end;
				if changed then
					new_suppliers := suppliers.same_suppliers;
				end;

				feat_table := Feat_tbl_server.item (id);

				ast_context.set_a_class (Current);

				!!melt_set.make;

				feat_table.start;
			until
				feat_table.offright
			loop
				feature_i := feat_table.item_for_iteration;
				feature_name := feature_i.feature_name;

				if feature_i.to_melt_in (Current) then

						-- For a feature written in the class
					feature_changed := 	changed_features.has (feature_name)
										and
										not feature_i.is_attribute;

					f_suppliers := dependances.item (feature_name);

						-- Feature is considered syntactically changed if
						-- some of the entities used by it have changed
						-- of nature (attribute/function versus incrementality).
					if not (	feature_changed
								or else
								f_suppliers = Void
							)
					then
						feature_changed := 
							(not propagators.melted_empty_intersection
																(f_suppliers));

						if not feature_changed then
							if f_suppliers.has_removed_id then
								feature_changed := True;
							end;
						end;

						if feature_changed then
								-- Automatic melting of the feature
							feature_i.change_body_id;
							if new_suppliers = Void then
								new_suppliers := suppliers.same_suppliers;
							end;
						end;
					end;
			
					if feature_i.is_attribute then	
							-- Redefinitions of functions into attributes are
							-- always melted
						feature_changed := True;
						feature_i.change_body_id;
					end;
	
					ast_context.set_a_feature (feature_i);

					if feature_i.in_pass3 then
						if
							-- No type check for constants and attributes.
							-- [It is done in second pass.]
							(feature_changed
							or else
							not (	f_suppliers = Void
									or else
									(propagators.empty_intersection (f_suppliers)
									and then
									propagators.changed_status_empty_intersection (f_suppliers.suppliers))
								))
						then
								-- Type check
debug ("ACTIVITY")
	io.error.putstring ("%Ttype check ");
	io.error.putstring (feature_name);
	io.error.new_line;
end;
							if feature_changed and then f_suppliers /= Void
							then
									-- Dependances update: remove old
									-- dependances for `feature_name'.
								new_suppliers.remove_occurence (f_suppliers);
								dependances.remove (feature_name);
							end;

							Error_handler.mark;
debug ("ACTIVITY");
	if f_suppliers /= Void then
	io.error.putstring ("Feature_suppliers%N");
	f_suppliers.trace;
	io.error.new_line;
	end;
end;
							feature_i.type_check;
							type_check_error := Error_handler.new_error;

							if 	feature_changed
								and then
								not type_check_error
							then
									-- Dependances update: add new
									-- dependances for `feature_name'.
								f_suppliers := ast_context.supplier_ids.twin;
								dependances.put (f_suppliers, feature_name);
								new_suppliers.add_occurence (f_suppliers);
		
									-- Byte code processing
--								if feature_i.is_deferred then
--										-- No byte code and melted info for
--										-- deferred features
--									feature_changed := False;
--								else
debug ("ACTIVITY")
	io.error.putstring ("%Tbyte code for ");
	io.error.putstring (feature_name);
	io.error.new_line;
end;
									feature_i.compute_byte_code;
--								end;

							end;
						else
							-- Check the conflicts between local variable names
							-- and feature names
-- FIX ME
-- ONLY needed when new features are inserted in the feature table
							feature_i.check_local_names
						end;
					else
							-- in_pass3 = False
						if dependances.has (feature_name) then
							dependances.remove (feature_name);
						end;
						!!f_suppliers.make;
						feature_i.record_suppliers (f_suppliers);
						dependances.put (f_suppliers, feature_name);
					end;

					ast_context.clear2;

					if	feature_changed
						and then
						not (type_check_error or else feature_i.is_deferred)
					then
							-- Remember the melted feature information
							-- if it is not deferred.
						!!melted_info.make (feature_i);
						melt_set.put (melted_info);
					end;
					type_check_error := False;

				elseif not feature_i.in_pass3 then
					if dependances.has (feature_name) then
						dependances.remove (feature_name);
					end;
					!!f_suppliers.make;
					feature_i.record_suppliers (f_suppliers);
					dependances.put (f_suppliers, feature_name);
				end;

				feat_table.forth;
			end;

				-- Recomputation of invariant clause
			invariant_pass3 (dependances, new_suppliers, melt_set);

				-- Check sum error
			Error_handler.checksum;

			if changed then

					-- Remove dependances of removed features
				from
					removed_features := propagators.removed_features;
					removed_features.start
				until
					removed_features.offright
				loop
					feature_i := removed_features.item_for_iteration;
					feature_name := feature_i.feature_name;
					f_suppliers := dependances.item (feature_name);
					if f_suppliers /= Void then
						new_suppliers.remove_occurence (f_suppliers);
					end;
					dependances.remove (feature_name);

						-- Second pass desactive body id of changed
						-- features only. Deactive body ids of removed
						-- features.
					Tmp_body_server.desactive (feature_i.body_id);

					removed_features.forth;
				end;
			end;

			if new_suppliers /= Void then
					-- Write new dependances in the dependances temporary
					-- server
				Tmp_depend_server.put (dependances);

					-- Update the client/supplier relations for the current
					-- class
				update_suppliers (new_suppliers);

			end;

				-- Update `melted_set'.
			if melted_set = Void then
				melted_set := melt_set;
			else
				melted_set.merge (melt_set)
			end;
			not_empty := not melt_set.empty;
			if not_empty then
					-- If features have been changed, then byte code
					-- must be reproduced
				System.freeze_set1.put (id);
				System.melted_set.put (id);
			end;
			if not_empty or else propagators.invariant_removed then
					-- If code has been melted or else if invariant
					-- has been removed, hash table must be updated
				System.freeze_set2.put (id);
				System.melted_set.put (id);
			end;

		ensure
			No_error: not Error_handler.has_error;
		rescue
			if exception = Programmer_exception then
					-- Clean context if error
				ast_context.clear2;
			end;
		end;

	print_clients is
		do
			io.error.putstring ("Clients of ");
			io.error.putstring (class_name);
			io.error.new_line;
			from
				clients.start
			until
				clients.after
			loop
				io.error.putstring ("%T");
				io.error.putstring (clients.item.class_name);
				io.error.new_line;
				clients.forth
			end;
			io.error.new_line;
			io.error.putstring ("Syntactical clients of ");
			io.error.putstring (class_name);
			io.error.new_line;
			from
				syntactical_clients.start
			until
				syntactical_clients.after
			loop
				io.error.putstring ("%T");
				io.error.putstring (syntactical_clients.item.class_name);
				io.error.new_line;
				syntactical_clients.forth
			end;
			io.error.new_line;
		end;

	invariant_pass3 (	dependances: CLASS_DEPENDANCE;
						new_suppliers: like suppliers;
						melt_set: like melted_set) is
			-- Recomputation of invariant clause
		require
			good_argument1: dependances /= Void;
			good_argument2: changed implies new_suppliers /= Void;
			good_argument3: melt_set /= Void;
		local
			invar_clause: INVARIANT_AS;
			invar_byte: INVARIANT_B;
			f_suppliers: FEATURE_DEPENDANCE;
			invariant_changed: BOOLEAN;
			melted_info: INV_MELTED_INFO;
			new_body_id: INTEGER;
		do
			f_suppliers := dependances.item ("_inv_");

			if propagators.invariant_removed then
				dependances.remove ("_inv_");
				new_suppliers.remove_occurence (f_suppliers);
				invariant_feature := Void;
			else
				invariant_changed := propagators.invariant_changed;
				if not (invariant_changed or else f_suppliers = Void) then
					invariant_changed := 
						not propagators.melted_empty_intersection (f_suppliers);
				end;
				if invariant_changed then
					if invariant_feature = Void then
						!!invariant_feature.make (Current);
						invariant_feature.set_body_index
											(System.body_index_counter.next);
					end;
					new_body_id := System.body_id_counter.next;
					System.body_index_table.force
								(new_body_id, invariant_feature.body_index);
				end;
				if	(	invariant_changed
						or else
						not	(	f_suppliers = Void
								or else
								(propagators.empty_intersection (f_suppliers)
								and then
								propagators.changed_status_empty_intersection (f_suppliers.suppliers))
							)
					)
				then
					if invariant_changed and then f_suppliers /= Void then
						new_suppliers.remove_occurence (f_suppliers);
						dependances.remove ("_inv_");
					end;

					invar_clause := Tmp_inv_ast_server.item (id);
					Error_handler.mark;
					invar_clause.type_check;

					if	invariant_changed
						and then
						not Error_handler.new_error
					then
						f_suppliers := ast_context.supplier_ids.twin;
						dependances.put (f_suppliers, "_inv_");
						new_suppliers.add_occurence (f_suppliers);

						ast_context.start_lines;
						!!invar_byte;
						invar_byte.set_id (id);
						invar_byte.set_byte_list (invar_clause.byte_node);
						Tmp_inv_byte_server.put (invar_byte);

						!!melted_info;
						melt_set.put (melted_info);

					end;
						-- Clean context
					ast_context.clear2;
				end;
			end;
		end;

	update_suppliers (new_suppliers: like suppliers) is
			-- Update the supplier list with `new_suppliers'.
		require
			good_argument: new_suppliers /= Void;
		local
			supplier: CLASS_C;
			supplier_clients: like clients;
			local_cursor: LINKABLE [SUPPLIER_INFO];
		do
			from
				local_cursor := suppliers.first_element
			until
				local_cursor = Void
			loop
				supplier := local_cursor.item.supplier;
				supplier_clients := supplier.clients;
				supplier_clients.start;
				supplier_clients.search (Current);
				supplier_clients.remove;
				local_cursor := local_cursor.right
			end;
			from
				local_cursor := new_suppliers.first_element
			until
				local_cursor = Void
			loop
				supplier := local_cursor.item.supplier;
				supplier_clients := supplier.clients;
				supplier_clients.add_front (Current);
				local_cursor := local_cursor.right
			end;
			suppliers := new_suppliers;
		end;

feature -- Generation

	pass4 is
			-- Generation of C files for each type associated to the current
			-- class
		local
			local_cursor: LINKABLE [CLASS_TYPE]
		do
			Inst_context.set_cluster (cluster);
			from
				local_cursor := types.first_element
			until
				local_cursor = Void
			loop
				local_cursor.item.pass4;
				local_cursor := local_cursor.right
			end;
		end;

feature -- Melting

	melt is
			-- Melt changed features.
		require
			good_context: has_features_to_melt
		local
			local_cursor: LINKABLE [CLASS_TYPE]
		do
			Inst_context.set_cluster (cluster);
			from
				local_cursor := types.first_element
			until
				local_cursor = Void
			loop
				if not local_cursor.item.is_precompiled then
					local_cursor.item.melt;			
				end;
				local_cursor := local_cursor.right
			end;
	
				-- Forget melted list
			melted_set := Void;
		end;

	has_features_to_melt: BOOLEAN is
			-- Has the current class features to melt ?
		do
			Result := not (	melted_set = Void
							or else
							melted_set.empty);
		end;

	melt_all is
			-- Melt all the features written in the class
		local
			tbl: FEATURE_TABLE;
			melted_info: FEAT_MELTED_INFO;
			inv_melted_info: INV_MELTED_INFO;
			new_body_id: INTEGER;
			feature_i: FEATURE_I;
		do
			Inst_context.set_cluster (cluster);
			if melted_set = Void then
				!!melted_set.make;
			end;

				-- Melt feature written in the class
			from
				tbl := feature_table;
				tbl.start
			until
				tbl.offright
			loop
				feature_i := tbl.item_for_iteration;
				if feature_i.to_generate_in (Current) then
					!!melted_info.make (feature_i);
					if not melted_set.has (melted_info) then
						melted_set.put (melted_info);
						feature_i.change_body_id;
					end;
				end;
				tbl.forth
			end;
				-- Melt possible invariant clause
			if invariant_feature /= Void then
				!!inv_melted_info;
				if not melted_set.has (inv_melted_info) then
					melted_set.put (inv_melted_info);
					new_body_id := System.body_id_counter.next;
					System.body_index_table.force
									(new_body_id, invariant_feature.body_index);
				end;
			end;

			if not Tmp_m_rout_id_server.has (id) then
					-- If not already done, Melt routine id array
				tbl.melt;
			end;
				-- Mark the class to be frozen later again.
			System.freeze_set1.put (id);
			System.freeze_set2.put (id);
				-- Mark the class melted
			System.melted_set.put (id);
			pass4_controler.insert_new_class (Current);
		end;

	melt_feature_table is
			-- Melt feature table
		require
			good_context: System.melted_set.has (id);
		local
			local_cursor: LINKABLE [CLASS_TYPE]
		do
			if not types.empty then
				from
					Inst_context.set_cluster (cluster);
					local_cursor := types.first_element
				until
					local_cursor = Void
				loop
					if not local_cursor.item.is_precompiled then
						local_cursor.item.melt_feature_table;
					end;
					local_cursor := local_cursor.right
				end;
			end;
		end;

	melt_descriptor_tables is
			-- Melt descriptor tables of associated class types
		local
			sel_tbl: SELECT_TABLE
		do
			sel_tbl := feature_table.origin_table;
			sel_tbl.melt (Current);
		end;

feature -- Workbench feature and descriptor table generation

	generate_feature_table is
			-- Generation of workbench mode feature table for 
			-- the current class
		local
			table_file_name: STRING;
			feat_tbl: FEATURE_TABLE;
			file: UNIX_FILE;
		do
			feat_tbl := feature_table;
			table_file_name := full_file_name;
			table_file_name.append_integer (id);
			table_file_name.append ("F.c");
			!!file.make (table_file_name);
			file.open_write;
			file.putstring ("%
				%#include %"macros.h%"%N%
				%#include %"struct.h%"%N%N");
			feature_table.generate (file);
			file.close;
		end;

	generate_descriptor_tables is
			-- Generation of workbench mode descriptor tables
			-- of associated class types.
			--|Note: when precompiling a system a class might
			--|have no generic derivations
		local
			sel_tbl: SELECT_TABLE
		do
			if has_types then
				sel_tbl := feature_table.origin_table;
				sel_tbl.generate (Current);
			end;
		end;

	full_file_name: STRING is
			-- Generated file name prefix
		local
			fname: STRING;
		do
			fname := base_file_name;
			!!Result.make (Generation_path.count + fname.count + 1);
			Result.append (Generation_path);
			Result.append ("/");
			Result.append (fname);
		end;

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			!!Result.make (11);
			if class_name.count > 7 then
				Result.append (class_name.substring (1, 7));
			else
				Result.append (class_name);
			end;
		end;

feature -- Skeleton processing

	process_skeleton is
			-- Process the skeleton of class types in `types'.
			-- For a class marked `changed2' or else `changed3', the class
			-- types must be all reprocessed and mark `is_changed' if needed
			-- so a new skeleton must be generated.
			-- For class marked `changed4' only, a new type was introduced.
		local
			feature_table_changed: BOOLEAN;
			class_type: CLASS_TYPE;
			type_i: CL_TYPE_I;
			new_skeleton, old_skeleton: SKELETON;
			local_cursor: LINKABLE [CLASS_TYPE]
		do
			from
				feature_table_changed := changed2;
				local_cursor := types.first_element
			until
				local_cursor = Void
			loop
				class_type := local_cursor.item;
				if 	feature_table_changed
					or else
					(changed4 and then class_type.is_changed)
				then
					old_skeleton := class_type.skeleton;
					new_skeleton := skeleton.instantiation_in (class_type);
					if 	old_skeleton = Void
						or else
						not new_skeleton.equiv (old_skeleton)
					then
						class_type.set_is_changed (True);
						class_type.set_skeleton (new_skeleton);

						System.freeze_set2.put (id);
						System.melted_set.put (id);
					else
					end;
				end;
				local_cursor := local_cursor.right
			end;
changed2 := False;
changed4 := False;
		end;

feature -- Class initialization

	init (ast: CLASS_AS; class_info: CLASS_INFO; old_suppliers: like syntactical_suppliers) is
			-- Initialization of the class with AST produced by yacc
		require
			good_argument: ast /= Void;
		local
			old_parents: like parents;
			old_generics: like generics;
			parents_as: EIFFEL_LIST [PARENT_AS];
			p: ARRAY [PARENT_AS];
			lower, upper: INTEGER;
			raw_type: CLASS_TYPE_AS;
			cl_type: CLASS_TYPE;
			parent_type: CL_TYPE_A;
			parent_class: CLASS_C;
			parent_list: PARENT_LIST;
			parent_c: PARENT_C;
			ve04: VE04;
			old_is_expanded: BOOLEAN;
			old_is_deferred: BOOLEAN;
			a_client: CLASS_C;
			changed_status: BOOLEAN;
			class_i: CLASS_I;
			changed_generics: BOOLEAN
		do
				-- Check if obsolete clause was present.
				-- (Void if none was present)
			if ast.obsolete_message /= Void then
				obsolete_message := ast.obsolete_message.value;
			else
				obsolete_message := Void
			end;

			old_parents := parents;

			if old_parents /= Void then
					-- Class was compiled before so we have to update
					-- parent/descendant relation.
					-- [Note that the client/supplier relations will be
					-- updated by the third pass].
				remove_parent_relations;
			end;

				-- Deferred mark
			old_is_deferred := is_deferred;
			is_deferred := ast.is_deferred;
			if (old_is_deferred /= is_deferred and then old_parents /= Void) then
				pass2_controler.set_deferred_modified (Current);
				changed_status := True;
			end;

				-- Expanded mark
			old_is_expanded := is_expanded;
			is_expanded := ast.is_expanded;
			if (is_expanded /= old_is_expanded and then old_parents /= Void) then
					-- The expanded status has been modifed
					-- (`old_parents' is Void only for the first compilation of the class)
				pass2_controler.set_expanded_modified (Current);
				changed_status := True;
			end;

			if changed_status then

				pass2_controler.add_changed_status (Current);
				from
					syntactical_clients.start
				until
					syntactical_clients.after
				loop
					a_client := syntactical_clients.item;
					a_client.set_changed2 (True);
					pass2_controler.set_supplier_status_modified (a_client);
					pass3_controler.insert_new_class (a_client);
					pass4_controler.insert_new_class (a_client);
					syntactical_clients.forth;
				end;

					-- All the skeletons must be processed
				changed4 := True;
				from
					types.start
				until
					types.after
				loop
					cl_type := types.item;
					cl_type.set_is_changed (True);
					cl_type.type.set_is_expanded (is_expanded);
					types.forth
				end;
			end;

				-- Initialization of the parent types `parents': put
				-- the default paretn HERE if needed. Calculates also the
				-- lists `descendants'. Since the routine `check_suppliers'
				-- has been called before, all the instances of CLASS_C
				-- corresponding to the parents of the current class are
				-- in the system (even if a parent is not already parsed).

			Inst_context.set_cluster (cluster);
			parents_as := ast.parents;
			parent_list := class_info.parents;
			if not (parents_as = Void) then
					-- Take the structure produced by Yacc
				from
					p := parents_as;
					check p.lower = 1 end;
					lower := 1;
					upper := p.upper;
					!!parents.make (upper);
				until
					lower > upper
				loop
						-- Evaluation of the parent type
					raw_type := p.item (lower).type;
						-- Check if there is no anchor in the parent type
					if	raw_type.has_like then
						!!ve04;
						ve04.set_class_id (id);
						ve04.set_parent_type (parent_type);
						Error_handler.insert_error (ve04);
							-- Cannot ge on here
						Error_handler.raise_error;
					end;
						-- Fill attribute `parents' of class CLASS_INFO
					parent_c := p.item (lower).parent_c;
					parent_list.put_i_th (parent_c, lower);
						-- Insertion of a new descendant for the parent class
					parent_type := parent_c.parent_type;
					parent_class := parent_type.associated_class;
					check
						parent_class_exists: parent_class /= Void;
							-- This ensures that routine `check_suppliers'
							-- has been called before.
					end;
					parent_class.add_descendant (Current);
					parents.put_i_th (parent_type, lower);
					lower := lower + 1;
				end;
			elseif id /= System.general_id then
					-- No parents are syntactiaclly specified: ANY is
					-- the default parent, except for class GENERAL which has
					-- no parent at all (we don't want a cycle in the
					-- inheritance graph, otherwise the topological sort
					-- on the classes will fail...).
				!!parents.make (1);
				parents.put_i_th (Any_type, 1);
					-- Add a descendant to class ANY
				System.any_class.compiled_class.add_descendant (Current);
					-- Fill parent list of corresponding class info
				parent_list.put_i_th (Any_parent, 1);
			else
					-- In case of the GENERAL class, just create an empty
					-- parent structure
				!!parents.make (0);
			end;
				-- Init generics
			old_generics := generics;

			generics := ast.generics;

			if generics /= Void then
					-- Check generic parameter declaration rule
				check_generics;
			end;

			if old_parents /= Void then
				-- Recompilation of the class
				if generics /= Void then
					if
						old_generics = Void
					or else
						old_generics.count /= generics.count
					then
						changed_generics := True
					else
						from
							old_generics.start;
							generics.start
						until
							changed_generics or else generics.after
						loop
							if not generics.item.equiv (old_generics.item) then	
								changed_generics := True
							end;
							generics.forth;
							old_generics.forth;
						end;
					end;
				elseif old_generics /= Void then
					changed_generics := True
				end;
			end;
			if changed_generics then
				from
					syntactical_clients.start
				until
					syntactical_clients.offright
				loop
					Workbench.add_class_to_recompile (syntactical_clients.item.lace_class);
					syntactical_clients.item.set_changed (True);
					syntactical_clients.forth
				end;
					-- The syntactical client/supplier relation must be consistent before
					-- the removal
				update_syntactical_relations (old_suppliers);
				class_i := lace_class;
				System.remove_class (Current);
				Workbench.change_class (class_i);
			end;

			if old_parents /= Void then
				if not same_parents (old_parents) then
						-- Conformance tables incrementality
					set_changed (True);
					System.set_update_sort (True);
				end;
				if not changed then
						-- If the class is not changed, it is marked `changed2'
					changed2 := True
				end;
			else
				-- First compilation of the class
				System.set_update_sort (True)
			end;

				-- Conformance tables incrementality
			if 	(not System.update_sort)	-- Topological sort not already
				and then					-- set on.
				(	old_parents = Void		-- First compilation of the class
					or else
					not same_parents (old_parents))	-- Parent changed from the
			then									-- inheritance graph point
													-- of view
				System.set_update_sort (True);
			end;
		ensure
			parents /= Void;
		end;

	same_parents (old_parents: like parents): BOOLEAN is
			-- Are `old_parents' the same as `parents' ?
			-- [Incrementality for conformance tables building.]
		require
			good_argument: old_parents /= Void;
		local
			pos: INTEGER;
			parent_class: CLASS_C;
		do
			pos := parents.position;
			from
				Result := True;
				parents.start;
			until
				parents.offright or else not Result
			loop
				parent_class := parents.item.associated_class;
				from
					old_parents.start;
					Result := False;
				until
					old_parents.offright or else Result
				loop
					Result := 	parent_class =
								old_parents.item.associated_class;
					old_parents.forth;
				end;
				parents.forth;
			end;
			parents.go_i_th (pos);
		end;

	Any_type: CL_TYPE_A is
			-- Default parent type
		once
			!!Result;
			Result.set_base_type (System.any_id);
		end;

	Any_parent: PARENT_C is
			-- Default compiled parent
		once
			!!Result;
			Result.set_parent_type (Any_type);
		end;

feature 

	update_syntactical_relations
		(old_syntactical_suppliers: like syntactical_suppliers) is
			-- Remove syntactical client/supplier relations ans take
			-- care of possible removed classes
		local
			local_cursor: LINKABLE [SUPPLIER_CLASS];
			a_class: CLASS_C;
			supplier_clients: like syntactical_clients;
		do
				-- Remove old syntactical supplier/client relations
			from
				local_cursor := old_syntactical_suppliers.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item.supplier;
				if a_class /= Current then
					supplier_clients := a_class.syntactical_clients;
					supplier_clients.start;
					supplier_clients.search (Current);
					if not supplier_clients.after then
						supplier_clients.remove;	
					end;
				end;
				local_cursor := local_cursor.right
			end;
				-- Add new syntactical supplier/client relations
			from
				local_cursor := syntactical_suppliers.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item.supplier;
				if a_class /= Current then
					supplier_clients := a_class.syntactical_clients;
					supplier_clients.add_front (Current);
				end;
				local_cursor := local_cursor.right
			end;
		end;

	remove_relations is
			-- Remove client/supplier and parent/descendant relations
			-- of the current class.
		require
			parents_exists: parents /= Void;
		local
			cl: like clients;
			local_cursor: LINKABLE [SUPPLIER_INFO]
		do
			remove_parent_relations;
			from
				local_cursor := suppliers.first_element
			until
				local_cursor = Void
			loop
				cl := local_cursor.item.supplier.clients;
				cl.start;
				cl.search_same (Current);
				if not cl.after then
					cl.remove
				end;
				local_cursor := local_cursor.right
			end;
			suppliers.wipe_out;
		end;

	remove_parent_relations is
			-- Remove parent/descendant relations of the Current class
		require
			parents_exists: parents /= Void;
		local
			des: like descendants;
			c: CLASS_C;
		do
			from
				parents.start;
			until
				parents.offright
			loop
				c := parents.item.associated_class;
				if c /= Void then
					des := c.descendants;
					des.start;
					des.search_same (Current);
					if not des.offright then
						des.remove;
					end;
				end;
				parents.forth;
			end;
		end;

	mark_class (marked_classes: ARRAY [BOOLEAN]) is
			-- Mark the class as used in the system
			-- and propagate to the suppliers
			-- Used by remove_useless_classes in SYSTEM_I
		do
			if marked_classes.item (id) = False then
				marked_classes.put (True, id);
				from
					syntactical_suppliers.start
				until
					syntactical_suppliers.after
				loop
					syntactical_suppliers.item.supplier.mark_class (marked_classes);
					syntactical_suppliers.forth
				end;
			end;
		end;

	check_generics is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG (page 52)
		require
			generics_exists: generics /= Void;
		local
			generic_dec, next_dec: FORMAL_DEC_AS;
			generic_name: ID_AS;
			pos: INTEGER;
			vcfg1: VCFG1;
			vcfg2: VCFG2;
		do
			from
				generics.start
			until
				generics.offright
			loop
				generic_dec := generics.item;
				generic_name := generic_dec.formal_name;

					-- First, check if the formal generic name is not the
					-- anme of a class in the surrounding universe.
				if Universe.class_named (generic_name, cluster) /= Void then
					!!vcfg1;
					vcfg1.set_class_id (id);
					vcfg1.set_formal_name (generic_name);
					Error_handler.insert_error (Vcfg1);
				end;

					-- Second, check if the formal generic name doen't 
					-- appear twice in `generics'.
				pos := generics.position;
				from
					generics.start
				until
					generics.offright
				loop
					next_dec := generics.item;
					if next_dec /= generic_dec then
						if next_dec.formal_name.is_equal (generic_name) then
							!!vcfg2;
							vcfg2.set_class_id (id);
							vcfg2.set_formal_name1 (generic_name);
							vcfg2.set_formal_name2 (next_dec.formal_name);
							Error_handler.insert_error (vcfg2);
						end;
					end;
					generics.forth;
				end;
				generics.go_i_th (pos);

				generics.forth;
			end;
		end;

	check_generic_parameters is
			-- Check validity formal generic parameter declaration.
			-- Validity rule VCFG1 (page 52)
		require
			generics_exists: generics /= Void;
		local
			generic_dec: FORMAL_DEC_AS;
			generic_name: ID_AS;
			vcfg1: VCFG1;
		do
			from
				generics.start
			until
				generics.offright
			loop
				generic_dec := generics.item;
				generic_name := generic_dec.formal_name;

				if Universe.class_named (generic_name, cluster) /= Void then
					!!vcfg1;
					vcfg1.set_class_id (id);
					vcfg1.set_formal_name (generic_name);
					Error_handler.insert_error (Vcfg1);
				end;
				generics.forth;
			end;
		end;

feature -- Parent checking

	check_parents is
			-- Check generical parents
		local
			vtug4: VTUG4;
			vtgg4: VTGG4;
			parent_actual_type: CL_TYPE_A;
		do
			from
				parents.start
			until
				parents.offright
			loop
				parent_actual_type := parents.item;
				if not parent_actual_type.good_generics then
						-- Wrong number of geneneric parameters in parent
					!!vtug4;
					vtug4.set_class_id (id);
					vtug4.set_type (parent_actual_type);
					Error_handler.insert_error (vtug4);
						-- Cannot go on ...
					Error_handler.raise_error;
				end;

				if parent_actual_type.generics /= Void then
						-- Check constrained genericity validity rule
					parent_actual_type.check_constraints (Current);
					if not Constraint_error_list.empty then
						!!vtgg4;
						vtgg4.set_class_id (id);
						vtgg4.set_error_list
										(deep_clone (Constraint_error_list));
						vtgg4.set_parent_type (parents.item);
						Error_handler.insert_error (vtgg4);
					end;
				end;

				parents.forth;
			end;
		end;

feature -- Supplier checking

	check_suppliers_and_parents is
			-- Check the suppliers and the parents before a recompilation
			-- of a system
		local
			a_class: CLASS_C;
			recompile: BOOLEAN;
		do
			from
				syntactical_suppliers.start
			until
				syntactical_suppliers.offright or else recompile
			loop
				a_class := syntactical_suppliers.item.supplier;
				Universe.compute_last_class (a_class.class_name, cluster);
				if Universe.last_class /= a_class.lace_class then
						-- one of the suppliers has changed (different CLASS_I)
						-- recompile the client (Current class)

					recompile := True;
					Workbench.add_class_to_recompile (lace_class);
				end;
				syntactical_suppliers.forth
			end;
		end;

	check_suppliers (supplier_list: LINKED_LIST [ID_AS]) is
			-- Check the supplier ids of the current parsed class
			-- and add perhaps classes to the system.
		require
			good_argument: not
				(supplier_list = Void or else supplier_list.empty);
		local
			cl_name: STRING;
			local_cursor: LINKABLE [ID_AS];
		do
			from
				local_cursor := supplier_list.first_element
			until
				local_cursor = Void
			loop
				cl_name := local_cursor.item;
					-- Check supplier `cl_name' of the class
				check_one_supplier (cl_name);
				local_cursor := local_cursor.right
			end;
		end;

	check_parent_classes (parent_list: EIFFEL_LIST [PARENT_AS]) is
			-- Check the parents of the current parsed class
			-- and add perhaps classes to the system.
		require
			good_argument: parent_list /= Void;
		local
			cl_name: STRING;
		do
			from
				parent_list.start
			until
				parent_list.offright
			loop
				cl_name := parent_list.item.type.class_name;
				check_one_supplier (cl_name);
				parent_list.forth
			end;
		end;

	check_one_supplier (cl_name: STRING) is
			-- Check if supplier class named `cl_name' is in the
			-- universe.
		require
			good_argument: cl_name /= Void;
		local
			supplier_class: CLASS_I;
			vtct: VTCT;
			supplier: SUPPLIER_CLASS;
			comp_class: CLASS_C;
		do
				-- 1. Check if the supplier class is in the universe
				--	  associated to `cluster'.
				-- 2. Check if the supplier class is a new class
				--  for the system.
			Universe.compute_last_class (cl_name, cluster);
			supplier_class := Universe.last_class;
			if supplier_class /= Void then
					-- The supplier class is in the universe associated
					-- to `cluster'.
				if not supplier_class.compiled then
						-- Class is not in the system yet: ask the
						-- workbench to mark it `changed'.
						-- Mark the class `changed'.
					Workbench.change_class (supplier_class);
						-- Insertion the new compiler class (instance of
						-- CLASS_C) in the system.
				end;
				comp_class := supplier_class.compiled_class;
				if comp_class /= Current then
					!!supplier.make (comp_class, cl_name);
					syntactical_suppliers.start;
					syntactical_suppliers.search_equal (supplier);
					if syntactical_suppliers.offright then
						syntactical_suppliers.add_front (supplier);
					end;
				end;
			else
					-- ERROR: Cannot find a supplier class
				!!vtct;
				vtct.set_class_id (id);
				vtct.set_class_name (cl_name);
				Error_handler.insert_error (vtct);
					-- Cannot go on here
				Error_handler.raise_error;
			end;
		end;

	check_non_genericity_of_root_class is
		-- Check non-genericity of root class
		require
			is_root_class: Current = System.root_class.compiled_class
		local
			vsrc1: VSRC1;
		do
			if
				generics /= Void
			then
				!!vsrc1;
				vsrc1.set_class_id (id);
				Error_handler.insert_error (vsrc1);
				Error_handler.checksum;
			end;
		end;

	check_root_class_creators is
			-- Check creation procedures of root class
		require
			is_root: Current = System.root_class.compiled_class;
		local
			feat_tbl: like feature_table;
			creation_proc: FEATURE_I;
			creation_name, system_creation: STRING;
			error: BOOLEAN;
			vsrc2: VSRC2;
			arg_type: TYPE_A;
			vd27: VD27;
		do
			feat_tbl := feature_table;
			if creators /= Void then
				from
					creators.start
				until
					creators.offright
				loop
					creation_name := creators.key_for_iteration;
					creation_proc := feat_tbl.item (creation_name);
					inspect
						creation_proc.argument_count
					when 0 then
						error := False;
					when 1 then
						arg_type ?= creation_proc.arguments.first;
						error := not deep_equal (arg_type, Array_of_string);
					else
						error := True;
					end;
					if error then
						!!vsrc2;
						vsrc2.set_class_id (id);
						vsrc2.set_creation_name (creation_name);
						Error_handler.insert_error (vsrc2);
					end;
					creators.forth;
				end;
			end;
			system_creation := System.creation_name;
			if 	system_creation /= Void
				and then
				(	creators = Void
					or else
					not creators.has (system_creation)
				)
			then
				!!vd27;
				Error_handler.insert_error (vd27);
			end;
			Error_handler.checksum;
		end;

	Array_of_string: GEN_TYPE_A is
			-- Type ARRAY [STRING]
		local
			array_generics: ARRAY [TYPE_A];
			string_type: CL_TYPE_A;
		once
			!!Result;
			Result.set_base_type (System.array_id);
			!!string_type;
			string_type.set_base_type (System.string_id);
			!!array_generics.make (1, 1);
			array_generics.put (string_type, 1);
			Result.set_generics (array_generics);
		end;

feature -- Order relation for inheritance and topological sort

	infix "<" (other: like Current): BOOLEAN is
			-- Order relation on classes
		do
			Result := topological_id < other.topological_id;
		end;

	nb_heirs: INTEGER is
			-- Number of heirs
		local
			local_cursor: LINKABLE [CLASS_C]
		do
			from
				Result := descendants.count;
				local_cursor := descendants.first_element
			until
				local_cursor = Void
			loop
				Result := Result + local_cursor.item.nb_heirs;
				local_cursor := local_cursor.right
			end;
		end;

	conform_to (other: CLASS_C): BOOLEAN is
			-- Is `other' an ancestor of Current ?
		require
			good_argument: other /= Void;
			conformance_table_exists: conformance_table /= Void;
		do
			Result := 	other.topological_id <= topological_id
							-- A parent has necessarily a class id
							-- less or equal than the one of the heir class
						and then
							-- Check conformance table
						conformance_table.item (other.topological_id);
		end;

	valid_creation_procedure (fn: STRING): BOOLEAN is
			-- Is `fn' a valid creation procedure ?
		require
			good_argument: fn /= Void;
		do
			if creators /= Void then
				Result := creators.has (fn);
			end;
		end;

feature -- Convenience features

	set_topological_id (i: INTEGER) is
			-- Assign `i' to `topological_id'.
		do
			topological_id := i;
		end;

	set_changed (b: BOOLEAN) is
			-- Mark the associated lace class changed.
		do
			lace_class.set_changed (b)
		end;

	set_changed2 (b: BOOLEAN) is
			-- Assign `b' to `changed2'.
		do
			changed2 := b;
		end;

	set_changed4 (b: BOOLEAN) is
			-- Assign `b' to `changed4'.
		do
			changed4 := b;
		end;

	set_is_deferred (b: BOOLEAN) is
			-- Assign `b' to `is_deferred'.
		do
			is_deferred := b;
		end;

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b;
		end;

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	set_date is
			-- Update `date'.
		local
			str: ANY;
		do
			str := file_name.to_c;
			date := eif_date ($str);
		end;

	set_skeleton (s: GENERIC_SKELETON) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s
		end;

	set_creators (c: like creators) is
			-- Assign `c' to `creators'.
		do
			creators := c;
		end;

	add_descendant (c: CLASS_C) is
			-- Insert class `c' into the descendant list
		require
			good_argument: c /= Void;
		do
			if not descendants.has (c) then
				descendants.add_front (c);	
			end;
		end;

	class_name: STRING is
			-- Raw class name
		do
			Result := lace_class.class_name
		end;

	visible_name: STRING is
			-- Visible name
		do
			Result := lace_class.visible_name
		end;

	external_name: STRING is
			-- External name
		do
			Result := lace_class.external_name
		end;

	cluster: CLUSTER_I is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end;

	assertion_level: ASSERTION_I is
			-- Assertion level of the class
		do
			Result := lace_class.assertion_level
		end;

	trace_level: TRACE_I is
			-- Trace level of the class
		do
			Result := lace_class.trace_level
		end;

	optimize_level: OPTIMIZE_I is
			-- Optimization level
		do
			Result := lace_class.optimize_level
		end;

	debug_level: DEBUG_I is
			-- Debug level
		do
			Result := lace_class.debug_level
		end;

	file_name: STRING is
			-- FIle name of the class
		do
			Result := lace_class.file_name
		end;

	visible_level: VISIBLE_I is
			-- Visible level
		do
			Result := lace_class.visible_level
		end;

feature -- Actual class type

	actual_type: CL_TYPE_A is
			-- Actual type of the class
		local
			i, count: INTEGER;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [FORMAL_A];
			formal: FORMAL_A;
		do
			if generics = Void then
				!!Result;
			else
				!!gen_type;
				Result := gen_type;
				from
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
				until
					i > count
				loop
					!!formal;
					formal.set_base_type (i);
					actual_generic.put (formal, i);
					i := i + 1;
				end;
			end;
			Result.set_base_type (id);
		end;
		
	insert_changed_feature (feature_name: STRING) is
			-- Insert feature `feature_name' in `changed_features'.
		require
			good_argument: feature_name /= Void;
		do
			changed_features.put (feature_name);
		end;
	
	constraint (i: INTEGER): TYPE_A is
			-- I-th constraint of the class
		require
			positive_argument: i > 0;
			has_generics: generics /= Void;
			index_small_enough: i <= generics.count;
		do
			Result := generics.i_th (i).constraint_type;
		end;

	feature_table: FEATURE_TABLE is
			-- Feature table of the clas
		do
			Result := Feat_tbl_server.item (id);
		end;

	update_instantiator1 is
			-- Look for generic types in the inheritance clause of
			-- a syntactically changed class
		require
			is_syntactically_changed: changed;
		local
			generic_parent: GEN_TYPE_A;
			parent_type: CL_TYPE_A;
		do
			from
				parents.start
			until
				parents.offright
			loop
				parent_type := parents.item;
				if parent_type.generics /= Void then
						-- Found a generic type in the inheritance clause
					generic_parent ?= parent_type;
					Instantiator.dispatch (generic_parent, Current);
				end;
				parents.forth;
			end;
		end;

	init_types is
			-- Standard initialization of attribute `types' for non
			-- generic classes.
		require
			no_generic: generics = Void;
		local
			class_type: CLASS_TYPE;
			type_i: CL_TYPE_I;
		do
			!!type_i;
			type_i.set_base_id (id);
			class_type := new_type (type_i);
			types.add_front (class_type);
			System.insert_class_type (class_type);
		end;

	update_types (data: GEN_TYPE_I) is
			-- Update `types' with `data'.
		require
			good_argument: data /= Void;
			good_context: not data.has_formal;
			consistency: data.base_class = Current;
		local
			filter: GEN_TYPE_I;
			new_class_type: CLASS_TYPE;
			base_c: CLASS_C;
			base_id: INTEGER;
			local_cursor: LINKABLE [GEN_TYPE_I]
		do
			if not derivations.has_derivation (id, data) then
					-- The recursive update is done only once
				derivations.insert_derivation (id, data);
				
debug ("GENERICITY")
	io.error.putstring ("Update_types%N");
	io.error.putstring (class_name);
	data.dump (io.error);
end;
			if not types.has_type (data) then
					-- Found a new type for the class
debug ("GENERICITY")
	io.error.putstring ("new type%N");
end;
				new_class_type := new_type (data);
					-- If class is TO_SPECIAL or else SPECIAL
					-- then freeze system.
				if is_special then
					System.set_freeze (True);
				end;
					-- Mark the class `changed4' because there is a new
					-- type
				changed4 := True;
				pass4_controler.insert_new_class (Current);
					-- Insertion of the new class type
				types.add_front (new_class_type);
				System.insert_class_type (new_class_type);
				if already_compiled then
						-- Melt all the code written in the associated class of
						-- the new class type
					melt_all;
				end;
			end;
					-- Propagation along the filters since we have a new type
			from
				local_cursor := filters.first_element
			until
				local_cursor = Void
			loop
					-- Instantiation of the filter with `data'
				filter := local_cursor.item.instantiation_in (data);
				base_c := filter.base_class;
				base_id := base_c.id;
debug ("GENERICITY")
	io.error.putstring ("propagation to ");
	io.error.putstring (base_c.class_name);
	io.error.new_line;
end;
				base_c.update_types (filter);
				local_cursor := local_cursor.right
			end;
			end;
		end;

	derivations: DERIVATIONS is
		once
			Result := instantiator.derivations
		end;

	new_type (data: CL_TYPE_I): CLASS_TYPE is
			-- New class type for current class
		do
			!!Result.make (data);
		end;

	is_special: BOOLEAN is
			-- Is the class SPECIAL or TO_SPECIAL ?
		do
			-- Do nothing
		end;

feature -- Meta-type

	meta_type (class_type: CL_TYPE_I): CL_TYPE_I is
			-- Meta type of the class in the context of `class_type'.
		require
			good_argument: class_type /= Void;
			conformance: class_type.base_class.conform_to (Current);
		local
			actual_class_type, written_actual_type: CL_TYPE_A;
			gen_type: GEN_TYPE_I;
		do
			if generics = Void then
					-- No instantiation for non-generic class
				Result := types.first.type;
			else
				actual_class_type := class_type.base_class.actual_type;
					-- General instantiation of the actual class type where
				  -- the feature is written in the context of the actual
					-- type of the base class of `class_type'.
				written_actual_type ?= actual_type.instantiation_in
											  (actual_class_type, id);
					-- Ask for the meta-type
				Result := written_actual_type.type_i;
					-- Meta instantiation
				if Result.has_formal then
					gen_type ?= class_type;
					Result ?= Result.instantiation_in (gen_type);
				end;
			end;
		end;

feature -- Validity class

	check_validity is
			-- Special classes validity check.
		do
			-- Do nothing
		end;

feature -- Dead code removal
		
	mark_visible (remover: REMOVER) is
			-- Dead code removal from the visible features
		require
			visible_level.has_visible;
		do
			visible_level.mark_visible (remover, feature_table);
		end;

	mark_all_used (remover: REMOVER) is
			-- Mark all the features written in the Current class used.
			-- [Useful for basic class like INTEGER_REF, etc...].
		local
			tbl: FEATURE_TABLE;
			a_feature: FEATURE_I;
			pos: INTEGER;
		do
			from
				tbl := feature_table;
				tbl.start;
			until
				tbl.offright
			loop
				a_feature := tbl.item_for_iteration;
				pos := tbl.position_for_iteration;
				if a_feature.written_class = Current then
					remover.record (a_feature, Current)
				end;
				tbl.go (pos);
				tbl.forth;
			end;
		end;

	has_visible: BOOLEAN is
			-- Has the class some visible features
		do
			Result := visible_level.has_visible
		end;

	nb_visible: INTEGER is
			-- Number of visible features from the class
		require
			visible_level /= Void;
		do
			Result := visible_level.nb_visible (Current);
		end;

	visible_table_size: INTEGER is
			-- Size of the hash table for the visible features
		require
			visible_level /= Void;
		do
			Result := visible_level.visible_table_size (Current);
		end;

feature -- Cecil

	generate_cecil is
			-- Generate cecil table for a class having visible features
		require
			has_visible: has_visible
		do
			visible_level.generate_cecil_table (Current)
		end;

	generate_cecil_value is
			-- Generate Cecil type value for a non generic class
		require
			no_generics: generics = Void;
			Cecil_file.is_open_write;
		do
			if is_expanded then
				Cecil_file.putstring ("SK_EXP + ");
			end;
			Cecil_file.putstring ("(uint32) ");
			Cecil_file.putint (types.first.type_id - 1);
		end;

	cecil_value: INTEGER is
			-- Cecil type value for a non generic class
		require
			no_generics: generics = Void;
			one_type_only: types.count = 1;
		do
			if is_expanded then
				Result := Sk_exp;
			end;
			Result := Result + types.first.type_id - 1;
		end;

	is_ancestor (other: CLASS_C): BOOLEAN is
			-- Is `other' a heir of Current ?
		require
			good_argument: other /= Void;
		local
			local_cursor: LINKABLE [CLASS_C];
		do
			if other = Current then
				Result := True;
			elseif other.conform_to (Current) then
				from
					local_cursor := descendants.first_element
				until
					local_cursor = Void or else Result
				loop
					Result := local_cursor.item.is_ancestor (other);
					local_cursor := local_cursor.right
				end;
			end;
		end;

feature -- Conformance table generation

 	process_polymorphism is
		local
			ftab: FEATURE_TABLE;
			stab: SELECT_TABLE;
		do
			ftab := feature_table;
			stab := ftab.origin_table;
			stab.add_units (id);
		end; 

	make_conformance_table (t: CONFORM_TABLE) is
			-- Make final conformance table
		require
			good_argument: t /= Void;
		local
			local_cursor: LINKABLE [CLASS_C];
			type_cursor: LINKABLE [CLASS_TYPE];
		do
				-- Mark conformance table `t' first.
			from
				type_cursor := types.first_element
			until
				type_cursor = Void
			loop
				t.mark (type_cursor.item.type_id);
				type_cursor := type_cursor.right
			end;
				-- Recursion on descendants
			from
				local_cursor := descendants.first_element
			until
				local_cursor = Void
			loop
				local_cursor.item.make_conformance_table (t);
				local_cursor := local_cursor.right
			end;
		end;

feature -- Redeclaration valididty

	valid_redeclaration (precursor: TYPE_A; redeclared: TYPE_A): BOOLEAN is
			-- Is the redeclaration of `precursor' into `redeclared' valid
			-- in the current class ?
		require
			good_argument: not (precursor = Void or else redeclared = Void)
		do
			Result := redeclared.redeclaration_conform_to (precursor);
		end;

feature -- Invariant feature

	has_invariant: BOOLEAN is
			-- Has the current class an invariant clause ?
		do
			Result := invariant_feature /= Void
		end;
			
	is_basic: BOOLEAN is
			-- Is the current class a basic class ?
		do
			-- Do nothing
		end;

feature -- Process the creation feature

	process_creation_feature (tbl: like feature_table) is
			-- Assign the first creation procedure (if any) to
			-- `creation_feature'.
		do
			if creators /= Void then
				creators.start;
				creation_feature := tbl.item (creators.key_for_iteration);
			else
				creation_feature := Void
			end;
		end;

feature {NONE} -- External features

	c_parse (f: POINTER; s: STRING): CLASS_AS is
		external
			"C"
		end;

	eif_date (s: ANY): INTEGER is
		external
			"C"
		end;

feature -- PS

	signature: STRING is
		obsolete "Use append_clickable_signature"
		local
			formal_dec: FORMAL_DEC_AS;
			constraint_type: TYPE_A;
			error: BOOLEAN;
		do
			if not error then
			!!Result.make (50);
			Result.append (class_name);
			if generics /= Void then
				Result.append (" [");
				from
					generics.start
				until
					generics.offright
				loop
					formal_dec := generics.item;
					Result.append (formal_dec.formal_name);
					if formal_dec.constraint /= Void then
						Result.append (" -> ");
						constraint_type := formal_dec.constraint.actual_type;
							--constraint_type := constraint_type.instantiation_in (actual_type, id);
						-- Result.append (constraint_type.signature)
						Result.append (constraint_type.dump)
					end;
					generics.forth;
					if not generics.offright then
						Result.append (", ")
					end
				end;
				Result.append ("]")
			end;
			Result.to_upper;
			end;
		rescue
			-- FIX ME ?
			!!Result.make (50);
			Result.append (class_name);
			if generics /= Void then
				Result.append (" [ ... ]");
			end;
			Result.to_upper;
			error := True;
			retry;
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
			-- Append the signature of current class in `a_clickable'
		local
			formal_dec: FORMAL_DEC_AS;
			constraint_type: TYPE_A;
			c_name: STRING;
		do
			append_clickable_name (a_clickable);
			if generics /= Void then
				a_clickable.put_string (" [");
				from
					generics.start
				until
					generics.after
				loop
					formal_dec := generics.item;
					c_name := formal_dec.formal_name;
					c_name.to_upper;
					a_clickable.put_string (c_name);
					if formal_dec.constraint /= Void then
						a_clickable.put_string (" -> ");
						constraint_type := formal_dec.constraint.actual_type;
io.error.putstring ("Clickable signature change dump%N");
						a_clickable.put_string (constraint_type.dump)
					end;
					generics.forth;
					if not generics.after then
						a_clickable.put_string (", ");
					end;
				end;
			end;
		end;

	append_clickable_name (a_clickable: CLICK_WINDOW) is
			-- Append the name ot the current class in `a_clickable'
		local
			c_name: STRING;
		do
			c_name := class_name.duplicate;
			c_name.to_upper;
			a_clickable.put_clickable_string (stone, c_name);
		end;

	stone: CLASSC_STONE is
		do
			!!Result.make (Current)
		end;

	feature_named (n: STRING): FEATURE_I is
			-- Feature whose internal name is `n'
		do
			if 
				Tmp_feat_tbl_server.has (id)
			then
				Result := Tmp_feat_tbl_server.item (id).item (n)
			else
				Result := Feat_tbl_server.item (id).item (n)
			end
		end;

	click_list: ARRAY [CLICK_STONE] is
		local
			ast_clicks: CLICK_LIST
		do
			--if Error_handler.has_error then
				--ast_clicks := Tmp_ast_server.item (id).click_list
			--else
			if not Tmp_ast_server.has (id) then
				ast_clicks := Ast_server.item (id).click_list
			else
				ast_clicks := Tmp_ast_server.item (id).click_list
			end;
			Result := ast_clicks.clickable_stones (Current)
		end;

feature -- Dino stuff

	insert_changed_assertion (a_feature: FEATURE_I) is
			-- Insert `a_feature' in the melted set
		local
			melted_info: FEAT_MELTED_INFO;
		do
			--! Give a new body id so it is greater
			--! than the frozen level
			a_feature.change_body_id;
			if melted_set = Void then
				!!melted_set.make;
			end;
			!!melted_info.make (a_feature);
			melted_set.put (melted_info);
		end;


	has_types: BOOLEAN is
			-- Are there any generic instantiations of Current
			-- in the system or is Current a non generic class?
		do
			Result :=
					(types /= Void) and then (not types.empty)
		end;

feature -- Precompilation

	is_precompiled: BOOLEAN is
		do	
			Result := id <= System.max_precompiled_id
		end;

	nb_precompiled_class_types: INTEGER is
		do
			from
				types.start
			until
				types.after
			loop
				if types.item.is_precompiled then
					Result := Result + 1
				end;
				types.forth
			end;
		end;

invariant

	lace_class_exists: lace_class /= Void

end
