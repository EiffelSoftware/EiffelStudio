

-- Internal representation of a system.

class SYSTEM_I 

inherit

	BASIC_SYSTEM_I;
	SHARED_WORKBENCH;
	SHARED_CONTEXT;
	SHARED_TMP_SERVER;
	SHARED_INSTANTIATOR;
	SHARED_EXPANDED_CHECKER;
	SHARED_TYPEID_TABLE;
	SHARED_TABLE;
	SHARED_FILES;
	SHARED_CODE_FILES;
	SHARED_GENERATOR;
	SHARED_ERROR_HANDLER;
	SHARED_TIME;
	SHARED_CECIL;
	SHARED_BODY_ID;
	SHARED_ENCODER;
	SHARED_GENERATOR;
	SHARED_USED_TABLE;
	SHARED_INHERITED
		rename
			Inherit_table as analyzer
		end;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;
	SHARED_ARRAY_BYTE;
	SHARED_DECLARATIONS;
	EXCEPTIONS;

feature 

	changed_classes: SORTED_TWO_WAY_LIST [CLASS_C];
			-- List of classes to recompile

	
	sorter: CLASS_SORTER;
			-- Topological sorter on classes

	class_counter: COUNTER;
			-- Counter of classes

	body_id_counter: BODY_ID_COUNTER;
			-- Counter for body ids

	body_index_counter: COUNTER;
			-- Body index counter

	feature_id_counter: COUNTER;
			-- Counter for feature ids

	routine_id_counter: ROUT_ID_COUNTER;
			-- Counter for routine ids

	type_id_counter: COUNTER;
			-- Counter of instance of CLASS_TYPE

	feature_counter: COUNTER;
			-- Counter of instances of FEATURE_AS

	feat_tbl_server: FEAT_TBL_SERVER;
			-- Server for feature tables

	body_server: BODY_SERVER;
			-- Server for instances of EIFFEL_FEAT

	ast_server: AST_SERVER;
			-- Server for abstract syntax trees

	byte_server: BYTE_SERVER;
			-- Server for byte code trees

	class_info_server: CLASS_INFO_SERVER;
			-- Server for class information produced bu first pass

	inv_ast_server: INV_AST_SERVER;
			-- Server for abstract syntax description of invariant clause

	inv_byte_server: INV_BYTE_SERVER;
			-- Server for invariant byte code

	depend_server: DEPEND_SERVER;
			-- Server for dependances for incremental type check

	m_feat_tbl_server: M_FEAT_TBL_SERVER;
			-- Server of byte code description of melted feature tables

	m_feature_server: M_FEATURE_SERVER;
			-- Server of melted feature byte code

	m_rout_tbl_server: M_ROUT_TBL_SERVER;
			-- Server for melted routine tables

	m_rout_id_server: M_ROUT_ID_SERVER;
			-- Server for  routine id array byte code

	poly_server: POLY_SERVER;
			-- Server of polymorphic unit tables

	id_array: ARRAY [CLASS_C];
			-- Array of classes indexed by their class ids

	class_types: ARRAY [CLASS_TYPE];
			-- Array of class types indexed by their type ids

	type_set: ROUT_ID_SET;
			-- Set of the routine ids for which a type table should
			-- be generated

	pattern_table: PATTERN_TABLE;
			-- Pattern table

	successfull: BOOLEAN;
			-- Was the last recompilation successfull ?

	nb_classes: INTEGER;
			-- Number of classes compiles within the system

	freeze: BOOLEAN;
			-- Has the system to be frozen again ?

	history_control: HISTORY_CONTROL;
			-- Routine table controler

	externals: EXTERNALS;
			-- Table of external names currently used by the system

	system_name: STRING;
			-- System name

	root_cluster: CLUSTER_I;
			-- Root class of the system

	root_class_name: STRING;
			-- Root class name

	creation_name: STRING;
			-- Creation procedure name

	c_file_names: FIXED_LIST [STRING];
			-- C file names to include

	object_file_names: FIXED_LIST [STRING];
			-- Object file names to link with the application

	makefile_name: STRING;
			-- Makefile name

	moved: BOOLEAN;
			-- Has the system potentially moved in terms of classes ?
			-- [Each time a new class is inserted/removed in/from the system
			-- a topological sort has to be done.]

	update_sort: BOOLEAN;
			-- Has the conformance table to be updated ?
			-- [A class id has changed beetween two recompilation.]

	max_class_id: INTEGER;
			-- Greater class id: computed by class CLASS_SORTER

	freeze_set1: LINKED_SET [INTEGER];
			-- List of class ids for which a source C compilation is
			-- needed when freezing.

	freeze_set2: LINKED_SET [INTEGER];
			-- List of class ids for which a hash table recompilation
			-- is needed when freezing

	is_conformance_table_melted: BOOLEAN;
			-- Is the conformance table melted ?

	melted_conformance_table: CHARACTER_ARRAY;
			-- Byte array representation of the melted conformance
			-- table.
			--| Once melted, it is kept in memory so it won't be re-processed
			--| each time

	melted_set: LINKED_SET [INTEGER];
			-- Set of class ids for which feature table needs to be updated
			-- when melting

	frozen_level: INTEGER;
			-- Frozen level

	body_index_table: BODY_INDEX_TABLE;
			-- Body index table
			--| Correspondance of generic body index and generic body
			--| id.

	original_body_index_table: BODY_INDEX_TABLE;
			-- Original body index table.
			-- | Since during second pass, correpondaces between body indexes
			-- | and body ids are changing, the second class must use a
			-- | duplicated one in order to compair versions of a same
			-- | feature.

	dispatch_table: DISPATCH_TABLE;
			-- Dispatch table

	execution_table: EXECUTION_TABLE;
			-- Execution table

	server_controler: SERVER_CONTROL;
			-- Controler of servers

	remover: REMOVER;
			-- Dead code removal control

	make is
			-- Create the system.
		do
			!!server_controler;
			server_controler.make;
				-- Creation of the list of changed classes
			!!changed_classes.make;
				-- Creation of the system hash table
			!!id_array.make (1, System_chunk);
			!!class_types.make (1, System_chunk);
				-- Creation of a topological sorter
			!!sorter.make;
				-- Creation of servers
			!!feat_tbl_server.make;
			!!body_server.make;
			!!byte_server.make;
			!!ast_server.make;
			!!class_info_server.make;
			!!inv_ast_server.make;
			!!inv_byte_server.make;
			!!depend_server.make;
			!!m_feat_tbl_server.make;
			!!m_feature_server.make;
			!!m_rout_tbl_server.make;
			!!m_rout_id_server.make;
			!!poly_server.make;
				-- Counter creation
			!!class_counter;
			!!feature_id_counter;
			!!body_id_counter.make;
			!!routine_id_counter.make;
			!!type_id_counter;
			!!body_index_counter;
			!!feature_counter;
				-- Routine table controler creation
			!!history_control.make;
				-- Type set creation
			!!type_set.make (100);
				-- External table creation
			!!externals.make;
				-- Pattern table creation
			!!pattern_table.make;
				-- Freeze control sets creation
			!!freeze_set1.make;
			!!freeze_set2.make;
				-- Body index table creation
			!!body_index_table.make (System_chunk);
			!!original_body_index_table.make (1);
				-- Run-time table creation
			!!dispatch_table.init;
			!!execution_table.init;
			!!melted_set.make;
		end;

	init is
			-- System initialization
		require
			general_class: general_class /= Void;
		do
				-- At the very beginning of a session, even class ANY is
				-- not compiled. So we must say to the workbench to compile
				-- classes ANY, DOUBLE... ARRAY
			Workbench.change_class (general_class);
			Workbench.change_class (any_class);
			Workbench.change_class
							(Universe.class_named ("numeric", root_cluster));
			Workbench.change_class
							(Universe.class_named ("double", root_cluster));
			Workbench.change_class
							(Universe.class_named ("real", root_cluster));
			Workbench.change_class
							(Universe.class_named ("integer", root_cluster));
			Workbench.change_class
							(Universe.class_named ("boolean", root_cluster));
			Workbench.change_class
							(Universe.class_named ("character", root_cluster));
			Workbench.change_class
							(Universe.class_named ("array", root_cluster));
			Workbench.change_class
							(Universe.class_named ("bit_ref", root_cluster));
			Workbench.change_class
							(Universe.class_named ("pointer", root_cluster));
			Workbench.change_class (root_class)
		end;

	insert_changed_class (cl: CLASS_C) is
			-- Insert a changed class in `changed_classes'. Do not insert
			-- it if already present.
		require
			good_argument: cl /= Void;
			good_id: cl.id > 0;
		local
			old_pos: INTEGER;
		do
				-- An insertion in `changed_classes' could happen during
				-- an iteration on it, so the position must be saved.
			old_pos := changed_classes.position;

				-- Insertion at the end of the list of a compiled class
				-- (i.e an instance of CLASS_C)
			if not changed_classes.empty then
				changed_classes.search_after (cl);
			end;
			if changed_classes.off or else changed_classes.item /= cl then
				changed_classes.add_left (cl);
			end;

				-- Retrieve the saved position
			changed_classes.go (old_pos);
		end;

	insert_new_class (c: CLASS_C) is
			-- Add new class `c' to the system.
		require
			good_argument: c /= Void;
		local
			new_id, id_array_count: INTEGER;
		do
debug ("ACTIVITY")
io.error.putstring ("%TInserting class ");
io.error.putstring (c.class_name);
io.error.new_line;
end;
			new_id := class_counter.next;
				-- Give a compiled class a frozen id
			c.set_id (new_id);

				-- Give a class id to class `c' which maybe changed 
				-- during the topological sort of a recompilation.
			c.set_class_id (new_id);
				-- Insert the class
			id_array_count := id_array.count;
			if new_id > id_array_count then
				id_array.resize (1, System_chunk + id_array_count);
			end;
			id_array.put (c, new_id);

				-- Update control flags of the topological sort
			moved := True;

				-- Update the freeze control list: the class can have no
				-- features written in it (like ANY) and then not be
				-- included in `freeze_set1' after the second pass and so
				-- not been generated. (we need a source file even if the
				-- class is empty in terms of features written in it.).
			freeze_set1.put (new_id);
			freeze_set2.put (new_id);

			melted_set.put (new_id);

		ensure
			c.id > 0;
		end;

	remove_old_class (a_class: CLASS_C) is
			-- Remove class `a_class' from the system
		require
			good_argument: a_class /= Void;
			no_clients: a_class.syntactical_clients.empty;
		local
			parents: FIXED_LIST [CL_TYPE_A];
			descendants, suppliers, clients: LINKED_LIST [CLASS_C];
			void_class, supplier: CLASS_C;
			supplier_clients: LINKED_LIST [CLASS_C];
			class_i: CLASS_I;
			id, pos: INTEGER;
			types: TYPE_LIST;
			Void_class_type: CLASS_TYPE;
			local_cursor: LINKABLE [SUPPLIER_CLASS];
			c: CURSOR;
		do
--debug ("ACTIVITY");
	io.error.putstring ("%TRemoving class ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
--end;
				-- Update control flags of the topological sort
			moved := True;

				-- Remove type check relations
			a_class.remove_relations;

				-- Remove class `a_class' from the list of changed classes
			c := changed_classes.cursor;
			changed_classes.start;
			changed_classes.search_same (a_class);
			if not changed_classes.offright then
				changed_classes.remove;
			end;
			changed_classes.go_to (c);

				-- Mark the class to remove uncompiled
			a_class.lace_class.set_compiled_class (void_class);

				-- Remove its types
			from
				types := a_class.types;
				types.start
			until
				types.offright
			loop
				class_types.put (Void_class_type, types.item.type_id);
				types.forth;
			end;

				-- Remove if from the servers
			id := a_class.id;
			ast_server.remove (id);
			feat_tbl_server.remove (id);
			class_info_server.remove (id);
			inv_ast_server.remove (id);
			depend_server.remove (id);
			m_rout_id_server.remove (id);

			freeze_set1.remove_item (id);
			freeze_set2.remove_item (id);
			melted_set.remove_item (id);
			id_array.put (Void, id);

				-- Remove client/supplier syntactical relations
				-- and remove classes recursively
			from
				local_cursor := a_class.syntactical_suppliers.first_element
			until
				local_cursor = Void
			loop
				supplier := local_cursor.item.supplier;
				supplier_clients := supplier.syntactical_clients;
				supplier_clients.start;
				supplier_clients.search_same (a_class);
				check
					not_after: not supplier_clients.after
				end;
				supplier_clients.remove;
				if supplier_clients.empty then
					remove_old_class (supplier);
				end;
				local_cursor := local_cursor.right
			end;

		end;
	
	class_of_id (id: INTEGER): CLASS_C is
			-- Class of id `id'.
		require
			index_small_enough: id <= id_array.count;
		do
			Result := id_array.item (id);
		end;

	class_type_of_id (type_id: INTEGER): CLASS_TYPE is
			-- Class type of type id `type_id'.
		require
			index_small_enough: type_id <= class_types.count;
		do
			Result := class_types.item (type_id);
		end;

	insert_class_type (class_type: CLASS_TYPE) is
			-- Insert `class_type' in `class_types'.
		require
			good_argument: class_type /= Void;
			index_big_enough: class_type.type_id > 0;
		local
			type_id: INTEGER;
		do
			type_id := class_type.type_id;
			if type_id > class_types.count then
				class_types.resize (1, type_id + System_chunk);
			end;
			class_types.put (class_type, type_id);
		end;

	init_recompilation is
			-- Initialization before a recompilation.
		do
				-- Initialization of control flags of the topological
				-- sort.
			moved := False;
			update_sort := False;

				-- Recompilation of changed classes
			changed_classes.start;

				-- If first initialization, special initialization
			if not general_class.compiled then
				init;
			end;

			freeze := freeze or else frozen_level = 0;

				-- If status of compilation is successfull, copy
				-- a duplication of the body index table in
				-- `origin_body_index_table' and re-initialize the
				-- melted set of feature tables.
			if successfull then
				original_body_index_table.copy (body_index_table.twin);
				melted_set.wipe_out;
			end;

		end;

feature -- Recompilation 

	recompile is
			-- Incremetal recompilation of the system.	
		require
			no_error: not Error_handler.has_error;
		do
			do_recompilation;
			successfull := True;
		rescue
			if 	exception = Programmer_exception then
				successfull := False;
			end;
		end;

	do_recompilation is
			-- Incremetal recompilation of the system.
		do
				-- Recompilation initialization
			init_recompilation;

				-- First time stamp and removal of useless classes
			Time_checker.time_check;

				-- Syntax analysis: This maybe add new classes to
				-- the system
			pass1;

				-- Remove useless classes i.e classes without syntactical clients
			remove_useless_classes;

				-- Topological sort and building of the conformance
				-- table (if new classes have been added by first pass
debug ("ACTIVITY")
	io.error.putstring ("%Tmoved = ");
	io.error.putbool (moved);
	io.error.putstring ("%N%Tupdate_sort = ");
	io.error.putbool (update_sort);
	io.error.new_line;
end;
			update_sort := update_sort or else moved;
			if update_sort then
					-- New classes have been added: context must be
					-- modified for order relation of instances of
					-- CLASS_C
				context.set_topological_sort;
					-- Sort
				sorter.sort;
					-- Check sum error
				Error_handler.checksum;
					-- Reset context
				context.unset;
					-- Re-sort the list `changed_classes', because the
					-- topological sort modified the class ids, and the
					-- second pass needs it.
				if not changed_classes.empty then
					changed_classes.sort;
				end;

					-- Build conformance tables
				build_conformance_table;

					-- Clear the topo sorter
				sorter.clear;

					-- Mark the conformance table melted
				is_conformance_table_melted := True;
					-- Trigger the recompuation of the conformance table
					-- byte code 
				melted_conformance_table := Void;
			end;
				-- Inheritance analysis: list `changed_classes' is
				-- sorted by class ids so the parent come first the
				-- heirs after
			pass2;

				-- Byte code production and type checking
			pass3;

				-- Externals incrementality
			freeze := freeze or else not externals.equiv;

				-- Process the type system
			process_type_system;

				-- Process the skeleton of classes
			process_skeleton;

				-- Melt the changed features
			melt;

				-- Finalize a successfull compilation
			finalize;

				-- Produce the update file
			if freeze then
					-- Verbose
				io.error.putstring ("Freezing system%N");

				freeze_system;
				freeze := False;

					-- Empty update file
				Update_file.open_write;
					-- Nothing to update
				Update_file.putchar ('%U');
				Update_file.close;
			else
					-- Verbose
				io.error.putstring ("Melting changes%N");

				make_update;
			end;

		end;

	pass1 is
			-- Syntax anlysis on list `changed_classes'. During this process
			-- list `changed_classes' may be increase because on new
			-- supplier classses discovered durin parsing.
		local
			cur_class: CLASS_C;
		do
			from
					-- Iteration on the changed classes
				changed_classes.start
			until
				changed_classes.offright
			loop
				cur_class := changed_classes.item;

				if cur_class.make_pass1 then
						-- Parse class
					cur_class.pass1;

						-- No syntax error happened: set the compilation status
						-- of the current changed class.
					check
						No_error: not Error_handler.has_error;
					end;
					cur_class.set_pass1_done;
				end;
				
					-- Take next changed class from `changed_classes'.
				changed_classes.forth;
			end;
		end;

	remove_useless_classes is
			-- Remove useless classes
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
		do
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if	a_class /= Void -- Classes could be removed
					and then
					a_class.syntactical_clients.empty
					and then
					a_class.id > 12	-- Class of id less than 12 is protected
									-- See feature `init'
				then
					remove_old_class (a_class)
				end;
				i := i + 1
			end
		end;

	build_conformance_table is
			-- Build the conformance table
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
		do
			from
					-- Iteration on the class of the system
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since classes can be removed from the system,
					-- there can be "holes' in `id_array'.
				if a_class /= Void then
					a_class.fill_conformance_table;
				end;

				i := i + 1;
			end;
		end;

	pass2 is
			-- Inheritance anlysis on the changed classes. Since the
			-- classes contained in `changed_classes' are sorted by class
			-- id's, it ensures that a class will be treated here once
			-- the treatment of its parents is completed. That's why
			-- we re-sort the list `changed_class' after the topological
			-- sort in order to take advantage of it.
		local
			a_class: CLASS_C;
			id: INTEGER;
		do
			from
					-- Iteration on the changed classes
				changed_classes.start
			until
				changed_classes.offright
			loop
				a_class := changed_classes.item;

				if	(a_class.changed or else a_class.changed2)
					and then
					a_class.make_pass2
				then
						-- Analysis of inheritance for a class
					analyzer.set_a_class (a_class);
					analyzer.pass2;

						-- No error happened: set the compilation status
						-- of `a_class'
					check
						No_error: not Error_handler.has_error;
					end;
					a_class.set_pass2_done;
						
						-- Update the freeze list for changed hash tables.
					if a_class.changed2 then
						id := a_class.id;
						freeze_set2.put (id);
						melted_set.put (id);
					end;

					history_control.check_overload;
				end;

					-- Take next changed class from `changed_classes'.
				changed_classes.forth;
			end;

				-- Transfer history controler data on disk
			history_control.transfer;
		end;

	pass3 is
			-- Byte code production and type checking: list `changed_classes'
			-- contains classes marked `changed' and/or changed3. For
			-- the classes marked `changed', produce byte code and type
			-- check the features marked `melted'; if the class is also
			-- marked `changed3' type check also the other features. For
			-- classes marked `changed3' only, type check all the
			-- features.
		local
			cur_class: CLASS_C;
		do
			from
				changed_classes.start
			until
				changed_classes.offright
			loop
				cur_class := changed_classes.item;

				if cur_class.make_pass3 then
						-- Type checking and maybe byte code production
						-- for a class
					cur_class.pass3;
					
						-- No error happened: set the compilation status
						-- of class `cur_class'
					check
						No_error: not Error_handler.has_error;
					end;
					cur_class.set_pass3_done;
				end;

					-- Take the next class
				changed_classes.forth;

			end;
		end;

	process_type_system is
			-- Compute the type system
		local
			a_class: CLASS_C;
			old_value: INTEGER;
			local_cursor: BI_LINKABLE [CLASS_C];
		do
			old_value := type_id_counter.value;
			from
				local_cursor := changed_classes.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item;
				if a_class.changed and then a_class.generics = Void then
					if a_class.types.empty then
							-- For non generic classes, standard initialization
							-- of their attribute `types'.
						a_class.init_types;
					end;
				end;
				local_cursor := local_cursor.right;
			end;
				-- For generic classes, compute the types
			Instantiator.process;

				-- If first compilation, re-order dynamic types
			if old_value = 0 then
				process_dynamic_types;
			end;
		end;

	process_skeleton is
			-- Type skeleton processing: for a class marked `changed2', the
			-- feature table has changed so the skeleton of its class
			-- types must be re-processed and markged `is_changed' if different.
			-- For a class marked `changed4', inspection of the types (instance
			-- of CLASS_TYPE) looking for a new one (marked `is_changed also).
		local
			a_class: CLASS_C;
			local_cursor: BI_LINKABLE [CLASS_C];
			changed_skeletons: LINKED_LIST [CLASS_C];
			skeleton: SKELETON;
		do
			from
				!!changed_skeletons.make;
				local_cursor := changed_classes.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item;
					-- Process skeleton(s) for `a_class'.
				a_class.process_skeleton;

				check
					has_class_type: not a_class.types.empty
				end;
				if a_class.types.first.is_changed then
						-- Skeleton of the class has changed: the
						-- `changed_skeletons' list is sorted in reversal order
						-- i.e descendants first.
					changed_skeletons.start;
					changed_skeletons.add_left (a_class);
				end;
					-- Check valididty of special classes ARRAY, STRING,
					-- TO_SPECIAL, SPECIAL
				a_class.check_validity;

				local_cursor := local_cursor.right;
			end;

				-- Trigger recomputing off attribute offset tables of
				-- classes which skeleton has changed
			from
			until
				changed_skeletons.empty
			loop
				changed_skeletons.start;
				a_class := changed_skeletons.item;
					-- Change all attribute offset tables of `a_class'
				from
					skeleton := a_class.types.first.skeleton;
					skeleton.start
				until
					skeleton.after
				loop
					history_control.change_rout_id (skeleton.item.rout_id);
					skeleton.forth
				end;
					-- Remove all ancestors of `a_class' in `changed_skeletons'
				from
					changed_skeletons.remove
				until
					changed_skeletons.after
				loop
					check
						reverse_topo_order: 	a_class.class_id
												>
												changed_skeletons.item.class_id
					end;
					if a_class.conform_to (changed_skeletons.item) then
						changed_skeletons.remove;
					else
						changed_skeletons.forth
					end;
				end;
			end;
					
				-- Check expanded client relation
			check_expanded;

				-- Check sum error
			Error_handler.checksum;
		end;

	check_expanded is
			-- Check expanded client relation
		local
			class_type: CLASS_TYPE;
			types: TYPE_LIST;
			a_class: CLASS_C;
			local_cursor: BI_LINKABLE [CLASS_C];
			type_cursor: LINKABLE [CLASS_TYPE];
		do
			from
				local_cursor := changed_classes.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item;
				from
					types := a_class.types;
					type_cursor := types.first_element;
				until
					type_cursor = Void
				loop
					class_type := type_cursor.item;
					if class_type.is_changed then
						Expanded_checker.set_current_type (class_type);
						Expanded_checker.check_expanded;
						class_type.set_is_changed (False);
					end;
				
					type_cursor := type_cursor.right
				end;
				local_cursor := local_cursor.right
			end;
		end;

	melt is
			-- Melt the changed features and feature tables in the system.
		require
			no_error: not Error_handler.has_error
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [INTEGER];
			local_cursor: BI_LINKABLE [CLASS_C];
			id_cursor: LINKABLE [INTEGER];
		do
				-- Melt features
				-- Open the file for writing on disk feature byte code
			from
				local_cursor := changed_classes.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item;
				if a_class.has_features_to_melt then
						-- Verbose
					io.error.putstring ("Pass 4 on class ");
					io.error.putstring (a_class.class_name);
					io.error.new_line;
					a_class.melt;
				end;
				local_cursor := local_cursor.right
			end;

				-- The dispatch and execution tables are know updated.

			if not freeze then
					-- Melt the feature tables
					-- Open first the file for writing on disk melted feature
					-- tables
				from
					id_list := melted_set;
					id_cursor := id_list.first_element;
				until
					id_cursor = Void
				loop
					a_class := class_of_id (id_cursor.item);
						-- Verbose
					io.error.putstring ("Pass 5 on class ");
					io.error.putstring (a_class.class_name);
					io.error.new_line;
					a_class.melt_feature_table;
					id_cursor := id_cursor.right;
				end;
			
					-- Melt routine tables
				history_control.melt;
			end;
			melted_set.wipe_out;
		end;

	make_update is
			-- Produce the update file resulting of the consecutive
			-- melting process after the system has been frozen.
		
		local
			id_list: LINKED_LIST [INTEGER];
			a_class: CLASS_C;
			types: TYPE_LIST;
			feat_tbl: MELTED_FEATURE_TABLE;
			class_id, nb_tables: INTEGER;
			file_pointer: POINTER;
			id_cursor: LINKABLE [INTEGER];
			type_cursor: LINKABLE [CLASS_TYPE];
			cl_type: CLASS_TYPE;
		do
			Update_file.open_write;
			file_pointer := Update_file.file_pointer;

				-- There is something to update
			Update_file.putchar ('%/001/');

				-- Write first the number of class types now available
			write_int (file_pointer, type_id_counter.value);

				-- Count of feature tables to update
			from
				id_list := freeze_set2;
				id_cursor := id_list.first_element
			until
				id_cursor = Void
			loop
				a_class := class_of_id (id_cursor.item);
				nb_tables := nb_tables + a_class.types.count;
				id_cursor := id_cursor.right
			end;
				-- Write the number of feature tables to update
			write_int (file_pointer, nb_tables);

				-- Write then the byte code for feature tables to update.
				-- First, open the reading file associated to the melted
				-- feature table server.
			from
				id_cursor := id_list.first_element
			until
				id_cursor = Void
			loop
				a_class := class_of_id (id_cursor.item);
				from
					types := a_class.types;
					type_cursor := types.first_element
				until
					type_cursor = Void
				loop
					feat_tbl := m_feat_tbl_server.item
												(type_cursor.item.type_id);
debug ("ACTIVITY")
	io.error.putstring ("melting class desc of ");
	type_cursor.item.type.trace;
	io.error.new_line;
end;
					feat_tbl.store (Update_file);
					type_cursor := type_cursor.right
				end;
				id_cursor := id_cursor.right
			end;

				-- Melted routine id array
			from
				m_rout_id_server.start
			until
				m_rout_id_server.offright
			loop
				class_id := m_rout_id_server.key_for_iteration;
				a_class := class_of_id (class_id);
debug ("ACTIVITY")
io.error.putstring ("melting routine id array of ");
io.error.putstring (a_class.class_name);
io.error.new_line;
end;
				write_int (file_pointer, class_id);
				m_rout_id_server.item (class_id).store (Update_file);
				from
					types := a_class.types;
					type_cursor := types.first_element
				until
					type_cursor = Void
				loop
					cl_type := type_cursor.item;
						-- Write dynamic type
					write_int (file_pointer, cl_type.type_id - 1);
						-- Write original dynamic type (forst freezing)
					write_int (file_pointer, cl_type.id - 1);
					type_cursor := type_cursor.right
				end;
				write_int (Update_file.file_pointer, -1);
				m_rout_id_server.forth;
			end;
			write_int (file_pointer, -1);

				-- Update the dispatch table
			dispatch_table.make_update (Update_file);	

				-- Open the file for reading byte code for melted features
				-- Update the execution table
			execution_table.make_update (Update_file);

				-- Update the routine tables
			history_control.make_update (Update_file);
			make_conformance_table_byte_code;

			make_option_table;

			Update_file.close;
		end;

	make_conformance_table_byte_code is
			-- Generates conformance tables byte code.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			to_append: CHARACTER_ARRAY;
		do
			Byte_array.clear;

			if is_conformance_table_melted then
				if melted_conformance_table = Void then
						-- Compute `melted_conformance_table'.
					Byte_array.append ('%/001/');
					from
						i := 1;
						nb := Type_id_counter.value;
					until
						i > nb
					loop
						cl_type := class_types.item (i);
						if cl_type /= Void then
								-- Classes could be removed
							cl_type.make_conformance_table_byte_code
																(Byte_array);
						end;
						i := i + 1;
					end;
		
						-- End mark
					Byte_array.append_short_integer (-1);
	
						-- Cecil structure
					make_cecil_tables;
					Cecil2.make_byte_code (Byte_array);
					Cecil3.make_byte_code (Byte_array);

					melted_conformance_table := Byte_array.character_array;
				end;
				to_append := melted_conformance_table;
			else
				Byte_array.append ('%U');
				to_append := Byte_array.character_array
			end;

				-- Put the condormance table in `Update_file'.
			to_append.store (Update_file);

		end;

	make_option_table is
			-- Generate byte code for the option table.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
		do
			Byte_array.clear;
			from
				i := 1;
				nb := Type_id_counter.value;		
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				if cl_type /= Void then
						-- Classes could be removed
					Byte_array.append_short_integer (cl_type.type_id - 1);
					a_class := cl_type.associated_class;
					a_class.assertion_level.make_byte_code (Byte_array);
					a_class.debug_level.make_byte_code (Byte_array);
				end;
				i := i + 1;
			end;
				-- End mark
			Byte_array.append_short_integer (-1);

				-- Put the byte code description of the option table
				-- in update file
			Byte_array.character_array.store (Update_file);
		end;

	finalize is
			-- Finalize a successfull recompilation and update the
			-- compilation files.
		local
			a_class: CLASS_C;
			local_cursor: BI_LINKABLE [CLASS_C];
		do
				-- Reset the classes as unchanged
			from
				local_cursor := changed_classes.first_element
			until
				local_cursor = Void
			loop
				a_class := local_cursor.item;
				a_class.set_changed (False);
				a_class.set_changed2 (False);
				-- FIXME: changed4, changed5, changed6
				a_class.changed_features.clear_all;
				a_class.propagators.wipe_out;

				local_cursor := local_cursor.right
			end;

				-- Update servers
			Feat_tbl_server.take_control (Tmp_feat_tbl_server);
			Tmp_body_server.finalize;
			Tmp_inv_ast_server.finalize;
			Ast_server.take_control (Tmp_ast_server);
			Class_info_server.take_control (Tmp_class_info_server);
			Byte_server.take_control (Tmp_byte_server);
			Inv_byte_server.take_control (Tmp_inv_byte_server);
			Depend_server.take_control (Tmp_depend_server);
			Poly_server.take_control (Tmp_poly_server);
			M_rout_id_server.take_control (Tmp_m_rout_id_server);

				-- Changed classes are empty now.
			changed_classes.wipe_out;

				-- Clear the instantiator
			Instantiator.wipe_out;
		end;

feature  -- Freeezing

	freeze_system is
			-- Worrkbench C code generation
		require
			root_class.compiled;
		local
			a_class: CLASS_C;
			id_list: LINKED_LIST [INTEGER];
			id_cursor: LINKABLE [INTEGER];
		do
				-- Re-process dynamic types
			process_dynamic_types;

				-- Process the C pattern table
			pattern_table.process;

				-- Clear the melted byte code servers
			m_feat_tbl_server.clear;
			m_feature_server.clear;
			m_rout_tbl_server.clear;
			m_rout_id_server.clear;
			history_control.freeze;

				-- Rebuild the dispatch table and the execution tables
			shake;

				-- Set the generation mode in workbench mode
			byte_context.set_workbench_mode;

			from
				id_list := freeze_set1;
				id_cursor := id_list.first_element;
			until
				id_cursor = Void
			loop
				a_class := id_array.item (id_cursor.item);
					-- Verbose
				io.error.putstring ("Pass 4 on class ");
				io.error.putstring (a_class.class_name);
				io.error.new_line;

				a_class.pass4;

				id_cursor := id_cursor.right;
			end;

			from
				id_list := freeze_set2;
				id_cursor := id_list.first_element
			until
				id_cursor = Void
			loop
				a_class := id_array.item (id_cursor.item);
					-- Verbose
				io.error.putstring ("Pass 5 on class ");
				io.error.putstring (a_class.class_name);
				io.error.new_line;

				a_class.generate_feature_table;

				id_cursor := id_cursor.right
			end;

			freeze_set1.wipe_out;
			freeze_set2.wipe_out;

			generate_routine_table;

			generate_skeletons;

			generate_cecil;

			generate_conformance_table;
			is_conformance_table_melted := False;
			melted_conformance_table := Void;

			generate_plug;

			generate_main_file;

			generate_option_file;

			pattern_table.generate;

			generate_make_file;

			generate_exec_tables;

		end;

	shake is
			-- Rebuild `dispatch_table' and `execution_table'
		local
			new_exec: like execution_table;
			new_dispatch: like dispatch_table;
			dispatch_unit: DISPATCH_UNIT;
			execution_unit: EXECUTION_UNIT;
			external_unit: EXT_EXECUTION_UNIT;
			info: EXTERNAL_INFO;		
		do
			from
				!!new_exec.init;
				!!new_dispatch.init;

				dispatch_table.start
			until
				dispatch_table.offright
			loop
				dispatch_unit := dispatch_table.item_for_iteration;
				if dispatch_unit.is_valid then
					execution_unit := dispatch_unit.execution_unit;

					new_dispatch.put (dispatch_unit);
					dispatch_unit := new_dispatch.last_unit;

					new_exec.put (execution_unit);
					execution_unit := new_exec.last_unit;

					dispatch_unit.set_execution_unit (execution_unit);				
					if execution_unit.is_external then
						external_unit ?= execution_unit;
						check
							externals.has (external_unit.external_name);
						end;
						info := externals.item (external_unit.external_name);
						info.set_execution_unit (external_unit);
					end;
				end;

				dispatch_table.forth;
			end;

			execution_table.copy (new_exec);
			dispatch_table.copy (new_dispatch);
	
				-- Reset the frozen level since the execution table
				-- is re-built now.
			frozen_level := execution_table.count;
		
				-- Freeze the external table: reset the real body ids,
				-- remove all unused externals and make the duplication
			externals.freeze;

		end;

	
feature -- Fianl mode generation

	pass4 is
			-- Finalizer generation
		require
			root_class.compiled;
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
		do
				-- Set the generation mode in final mode
			byte_context.set_final_mode;
			Eiffel_table.init;

				-- Verbose
			io.error.putstring ("Pass 5 on system%N");

				-- Dead code removal
--			remove_dead_code;

			process_dynamic_types;

				-- Generation of C files associated to the classes of
				-- the system.
			from
				i := 1;
				nb := class_counter.value;
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since a clas can be removed, test if `a_class' is
					-- not Void.
				if a_class /= Void then
						-- Verbose
					io.error.putstring ("Pass 6 on class ");
					io.error.putstring (a_class.class_name);
					io.error.new_line;

					a_class.pass4;
				end;

				i := i + 1;
			end;

			generate_table;

				-- Generate makefile
			generate_make_file;

				-- Clean Eiffel table
			Eiffel_table.wipe_out;

				-- Generate main file
			generate_main_file;

			remover := Void;
		end;

feature -- Dead code removal

	remove_dead_code is
			-- Dead code removal
		local
			a_class: CLASS_C;
			root_feat: FEATURE_I;
			to_special_cl: TO_SPECIAL_B;
			i, nb: INTEGER;
		do
			!!remover.make;

				-- First, inspection of the Eiffel code
			if creation_name /= Void then
				a_class := root_class.compiled_class;
				root_feat := a_class.feature_table.item (creation_name);
				remover.record (root_feat, a_class);
			end;

			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if  a_class /= Void -- Classes could be removed
					and then
					a_class.visible_level.has_visible
				then
					a_class.remove_visible (remover)
				end;
				i := i + 1
			end;

				-- Protection of the attribute `area' in class TO_SPECIAL
			to_special_cl ?= to_special_class.compiled_class;
			to_special_cl.mark_area_used (remover);

				-- Protection of features written in basic reference classes
			character_ref_class.compiled_class.mark_all_used (remover);
			boolean_ref_class.compiled_class.mark_all_used (remover);
			integer_ref_class.compiled_class.mark_all_used (remover);
			real_ref_class.compiled_class.mark_all_used (remover);
			double_ref_class.compiled_class.mark_all_used (remover);
			pointer_ref_class.compiled_class.mark_all_used (remover);

				-- Protection of feature `make' of class STRING
			string_class.compiled_class.mark_all_used (remover);
		
		end;

	is_used (f: FEATURE_I): BOOLEAN is
			-- Is feature `f' used in the system ?
		require
			good_argument: f /= Void;
			remover_exists: remover /= Void;
		do
			Result := remover.is_alive (f)
		end;

feature -- Generation

	generate_table is
			-- Generation of all the tables needed by the finalized
			-- Eiffel executable
		do
				-- Generation of type size table
			generate_size_table;

				-- Generation of the reference number table
			generate_reference_table;

				-- Generation of the skeletons
			generate_skeletons;

				-- Cecil structures generation
			generate_cecil;

				-- Generation of the conformance table
			generate_conformance_table;

				-- Generate plug with run-time
			generate_plug;

				-- Routine table generation
			generate_routine_table;
		end;

	process_dynamic_types is
			-- Processing of the dynamic types
		local
			class_list: ARRAY [CLASS_C];
			a_class: CLASS_C;
			types: TYPE_LIST;
			class_type: CLASS_TYPE;
			old_type_id, new_type_id, i, nb: INTEGER;
			type_cursor: LINKABLE [CLASS_TYPE];
		do
				-- First re-process all the type id of instances of
				-- CLASS_TYPE available in attribute list `types' of
				-- instances of CLASS_C

				-- Sort the class_list by type id in `class_list'.
			from
				i := 1;
				nb := id_array.count;
				!!class_list.make (1, max_class_id);
			until
				i > nb
			loop
				a_class := id_array.item (i);
					-- Since classes can be removed from the system, test if
					-- `a_class' is not Void
				if a_class /= Void then
					class_list.put (a_class, a_class.class_id);
				end;
				i := i + 1;
			end;
			nb := max_class_id;

				-- Iteration on `class_list' in order to compute new type
				-- id's
			from
					-- Reset the type id counter
				type_id_counter.reset;
				i := 1;
			until
				i > nb
			loop
					-- Types of the class
				types := class_list.item (i).types;
				from
					type_cursor := types.first_element
				until
					type_cursor = Void
				loop
					class_type := type_cursor.item;
					old_type_id := class_type.type_id;
					new_type_id := type_id_counter.next;
					class_type.set_type_id (new_type_id);
debug ("ACTIVITY")
	io.error.putint (new_type_id);
	io.error.putstring (": ");
	class_type.type.trace;
	io.error.putstring (" [");
	io.error.putint (class_type.id);
	io.error.putstring ("]%N");
end;
						-- Update `class_types'
					insert_class_type (class_type);
					type_cursor := type_cursor.right
				end;
				i := i + 1
			end;

		end;

	generate_routine_table is
			-- Generate routine tables
		local
			array_ids1, array_ids2: ARRAY [INTEGER];
			final_mode: BOOLEAN;
			rout_id: INTEGER;
			table: POLY_TABLE [ENTRY];
		do
			Attr_generator.make;
			Rout_generator.make;

			final_mode := byte_context.final_mode;
			if not final_mode then
				!!array_ids1.make (0, routine_id_counter.value);
				!!array_ids2.make (0, routine_id_counter.value);
			end;
			from
				poly_server.start
			until
				poly_server.offright
			loop
				rout_id := poly_server.key_for_iteration;
				if final_mode then
					if Eiffel_table.is_used (rout_id) then
						table := poly_server.item (rout_id).poly_table;
						table.write;
					end;
				else
					table := poly_server.item (rout_id).poly_table;
					table.write_workbench;
					if table.is_routine_table then
						array_ids1.put (1, rout_id);
					else
						array_ids1.put (-1, rout_id);
					end;
					array_ids2.put (table.min_type_id - 1, rout_id);
				end;
				poly_server.forth;
			end;

			if final_mode then
				generate_initialization_table;
				generate_dispose_table;
			else
				generate_history_table (array_ids1, array_ids2);
			end;

			Attr_generator.finish;
			Rout_generator.finish;
		end;

	generate_history_table (desc1, desc2: ARRAY [INTEGER]) is
			-- Generate history table.
		local
			i, nb, kind: INTEGER;
			file: FILE;
		do
			file := History_file;
			History_file.open_write;
			History_file.putstring ("%
				%#include %"macros.h%"%N%
				%#include %"struct.h%"%N%N");

			from
				i := desc1.lower;
				nb := desc1.upper;
			until
				i > nb
			loop
				kind := desc1.item (i);
				if kind /= 0 then
					if kind = 1 then
						file.putstring ("extern struct ca_info");
					else
						file.putstring ("extern long");
					end;
					file.putstring (" r");
					file.putint (i);
					file.putstring ("[];%N");
					if type_set.has (i) then
						file.putstring ("extern int16 t");
						file.putint (i);
						file.putstring ("[];%N");
					end;
				end;
				i := i + 1
			end;

			file.putstring ("%Nchar *ftable[] = {%N");
			from
				i := desc1.lower;
				nb := desc1.upper;
			until
				i > nb
			loop
				kind := desc1.item (i);
				if kind /= 0 then
					file.putstring ("(char *) (r");
					file.putint (i);
					file.putstring (" - ");
					file.putint (desc2.item (i));
					file.putstring ("),%N");
				else
					file.putstring ("(char *) 0,%N");
				end;
				i := i + 1
			end;
			file.putstring ("};%N");
			
			file.putstring ("%Nint16 *ftypes[] = {%N");
			from
				i := desc1.lower;
				nb := desc1.upper;
			until
				i > nb
			loop
				kind := desc1.item (i);
				if kind /= 0 and then type_set.has (i) then
					file.putstring ("(int16 *) (t");
					file.putint (i);
					file.putstring (" - ");
					file.putint (desc2.item (i));
					file.putstring ("),%N");
				else
					file.putstring ("(int16 *) 0,%N");
				end;
				i := i + 1
			end;
			file.putstring ("};%N");

			file.close;
		end;

	generate_size_table is
			-- Generate the size table.
		local
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
		do
			from
				i := 1;
				nb := type_id_counter.value;
				Size_file.open_write;
				Size_file.putstring ("#include %"macros.h%"%N%N");
				Size_file.putstring ("long esize[] = {%N");
			until
				i > nb
			loop
				class_type := class_types.item (i);
				class_type.skeleton.generate_size (Size_file);
				Size_file.putstring (",");
				Size_file.new_line;
				i := i + 1;
			end;
			Size_file.putstring ("};%N");
			Size_file.close;
		end;

	generate_reference_table is
			-- Generate the table of reference numer per type.
		local
			i, nb, nb_ref, nb_exp: INTEGER;
			class_type: CLASS_TYPE;
			skeleton: SKELETON;
		do
			from
				i := 1;
				nb := type_id_counter.value;
				Reference_file.open_write;
				Reference_file.putstring ("long nbref[] = {%N");
			until
				i > nb
			loop
				class_type := class_types.item (i);
				skeleton := class_type.skeleton;
				nb_ref := skeleton.nb_reference;
				nb_exp := skeleton.nb_expanded;
				Reference_file.putint (nb_ref + nb_exp);
				Reference_file.putchar (',');
				Reference_file.new_line;
				i := i + 1;
			end;
			Reference_file.putstring ("};%N");
			Reference_file.close;
		end;

	generate_skeletons is
			-- Generate skeletons of class types
		local
			i, nb, nb_class: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			has_attribute, final_mode: BOOLEAN;
			types: TYPE_LIST;
			type_cursor: LINKABLE [CLASS_TYPE];
			f_name: STRING;
			cltype_array: ARRAY [CLASS_TYPE];
		do
			nb := Type_id_counter.value;
			final_mode := byte_context.final_mode;

				-- Open skeleton file
			Skeleton_file.open_write;

			Skeleton_file.putstring ("#include %"struct.h%"%N");
			if final_mode then
				Skeleton_file.putstring ("#include %"Eskelet.h%"%N%N");
				from
                    i := 1
                until
                    i > nb
                loop
                    class_types.item (i).skeleton.make_extern_declarations;
                   i := i + 1;
                end;
                f_name := generation_path.twin;
                f_name.append ("/Eskelet.h");
                Extern_declarations.generate (f_name);
                Extern_declarations.wipe_out;
			else
					-- Hash table extern declaration in workbench mode
				Skeleton_file.putstring ("#include %"macros.h%"%N");
				Skeleton_file.new_line;
				from
					i := 1;
					nb_class := id_array.count;
				until
					i > nb_class
				loop
					a_class := class_of_id (i);
					if a_class /= Void then
							-- Classes could be removed
						Skeleton_file.putstring ("%
							%extern int32 ra");
						Skeleton_file.putint (i);
						Skeleton_file.putstring ("[];%N");
						if a_class.has_visible then
							Skeleton_file.putstring ("extern char *cl");
							Skeleton_file.putint (i);
							Skeleton_file.putstring ("[];%N");
							Skeleton_file.putstring ("extern uint32 cr");
							Skeleton_file.putint (i);
							Skeleton_file.putstring ("[];%N");
						end;
						if not a_class.skeleton.empty then
							from
								types := a_class.types;
								type_cursor := types.first_element;
							until
								type_cursor = Void
							loop
								Skeleton_file.putstring ("extern uint32 types");
								Skeleton_file.putint (types.item.type_id);
								Skeleton_file.putstring ("[];%N");
								type_cursor := type_cursor.right;
							end;
						end;
					end;

					i := i + 1;
				end;
				Skeleton_file.new_line;

				!!cltype_array.make (1, nb);
			end;

			from
				i := 1;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
					-- Classes could be removed
				cl_type.generate_skeleton1;
				if not final_mode then
					cltype_array.put (cl_type, cl_type.id);
				end;
				i := i + 1;
			end;

			if byte_context.final_mode then
				Skeleton_file.putstring ("struct cnode esystem[] = {");
			else
				Skeleton_file.putstring ("struct cnode fsystem[] = {");
			end;
			Skeleton_file.new_line;
			from
				i := 1;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				cl_type.generate_skeleton2;
				Skeleton_file.putstring (",%N");
				i := i + 1;
			end;
			Skeleton_file.putstring ("};%N%N");

			if not final_mode then
					-- Generate the array of routine id arrays
				Skeleton_file.putstring ("int32 *fcall[] = {%N");
				from
					i := 1
				until
					i > nb
				loop
					cl_type := cltype_array.item (i);
					if cl_type /= Void then
						Skeleton_file.putstring ("ra");
						Skeleton_file.putint (cl_type.associated_class.id);
					else
						Skeleton_file.putstring ("(int32 *) 0");
					end;
					Skeleton_file.putchar (',');
					Skeleton_file.new_line;
					i := i + 1
				end;
				Skeleton_file.putstring ("};%N%N");
					-- Generate the correspondances stable between original
					-- dynamic types and new dynamic types
				Skeleton_file.putstring ("int16 fdtypes[] = {%N");
				from
                    i := 1
                until
                    i > nb
                loop
                    cl_type := cltype_array.item (i);
					Skeleton_file.putstring ("(int16) ");
                    if cl_type /= Void then
						Skeleton_file.putint (cl_type.type_id - 1);
                    else
						Skeleton_file.putint (0);
                    end;
					Skeleton_file.putchar (',');
					Skeleton_file.new_line;
                    i := i + 1
                end;
				Skeleton_file.putstring ("};%N");
			end;
				-- Close skeleton file
			Skeleton_file.close;
		end;

	generate_cecil is
			-- Generate Cecil structures
		local
			i, nb, generic, no_generic: INTEGER;
			cl_type: CLASS_TYPE;
			a_class: CLASS_C;
			final_mode: BOOLEAN;
			f_name: STRING;
		do
			final_mode := byte_context.final_mode;

			Cecil_file.open_write;
			Cecil_file.putstring ("#include %"cecil.h%"%N");
			if final_mode then
				Cecil_file.putstring ("#include %"Ececil.h%"%N");
			end;
			Cecil_file.putstring ("#include %"struct.h%"%N%N");

			from
				i := 1;
				nb := class_counter.value;
			until
				i > nb
			loop
				a_class := class_of_id (i);
				if a_class /= Void and then a_class.has_visible then
					a_class.generate_cecil;
				end;
				i := i + 1;
			end;

			if byte_context.final_mode then
					-- Extern declarations for previous file
                f_name := generation_path.twin;
                f_name.append ("/Ececil.h");
                Extern_declarations.generate (f_name);
                Extern_declarations.wipe_out;
				Cecil_file.putstring ("%Nstruct ctable ce_rname[] = {%N");
				from
					i := 1;
					nb := Type_id_counter.value;
				until
					i > nb
				loop
					class_types.item (i).generate_cecil (Cecil_file);
					Cecil_file.putstring (",%N");
					i := i + 1;
				end;
				Cecil_file.putstring ("};%N%N");
			end;

			make_cecil_tables;
			Cecil2.generate;
			Cecil3.generate;

			Cecil_file.close;
		end;

	make_cecil_tables is
			-- Prepare cecil tables
		local
			i, nb, generic, no_generic: INTEGER;
			a_class: CLASS_C;
			upper_class_name: STRING;
		do
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					if a_class.generics = Void then
						no_generic := no_generic + 1;
					else
						generic := generic + 1;
					end;
				end;
				i := i + 1;
			end;
			from
				i := 1;
				Cecil2.init (no_generic);
				Cecil3.init (generic);
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					upper_class_name := a_class.external_name.twin;
					upper_class_name.to_upper;
					if a_class.generics = Void then
						Cecil2.put (a_class, upper_class_name);
					else
						Cecil3.put (a_class, upper_class_name);
					end;
				end;
				i := i + 1;
			end;
		end;

	generate_conformance_table is
			-- Generates conformance tables.
		local
			i, nb: INTEGER;
			cl_type: CLASS_TYPE;
		do
			Conformance_file.open_write;

			Conformance_file.putstring ("#include %"struct.h%"%N%N");

			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				cl_type.generate_conformance_table;
				i := i + 1;
			end;

			if byte_context.final_mode then
				Conformance_file.putstring
								("struct conform *co_table[] = {%N");
			else
				Conformance_file.putstring
								("struct conform *fco_table[] = {%N");
			end;
			from
				i := 1;
			until
				i > nb
			loop
				cl_type := class_types.item (i);
				Conformance_file.putstring ("&conf");
				Conformance_file.putint (cl_type.type_id);
				Conformance_file.putstring (",%N");
				i := i + 1;
			end;
			Conformance_file.putstring ("};%N");
			Conformance_file.close;

		end;

	generate_initialization_table is
			-- Generate table of initialization routines
		local
			rout_table: SPECIAL_TABLE;
			rout_entry: SPECIAL_ENTRY;
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
		do
			from
				!!rout_table;
				rout_table.set_rout_id (Initialization_id);
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				class_type := class_types.item (i);
				if class_type.has_creation_routine then
					!!rout_entry;
					rout_entry.set_type_id (i);
					rout_entry.set_written_type_id (i);
					rout_entry.set_kind (Initialization_id);
					rout_table.put (rout_entry);
				end;
				i := i + 1;
			end;
			rout_table.write;
		end;

	generate_dispose_table is
			-- Generate dispose table
		local
			rout_table: SPECIAL_TABLE;
			rout_entry: SPECIAL_ENTRY;
			i, nb: INTEGER;
			class_type: CLASS_TYPE;
		do
			from
				!!rout_table;
				rout_table.set_rout_id (Dispose_id);
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				class_type := class_types.item (i);
				if class_type.has_dispose then
					!!rout_entry;
					rout_entry.set_type_id (i);
					rout_entry.set_written_type_id (i);
					rout_entry.set_kind (Dispose_id);
					rout_table.put (rout_entry);
				end;
				i := i + 1;
			end;
			rout_table.write;
		end;

	generate_plug is
			-- Generate plug with run-time
		local
			string_cl, bit_cl: CLASS_C;
			type_id, str_id: INTEGER;
			set_count_feat, creation_feature: FEATURE_I;
			creators: EXTEND_TABLE [EXPORT_I, STRING];
			dispose_name, make_name, init_name, set_count_name: STRING;
			special_cl: SPECIAL_B;
			cl_type: CLASS_TYPE;
		do
			Plug_file.open_write;

			Plug_file.putstring ("#include %"portable.h%"%N%N");

				-- Extern declarations
			string_cl := class_of_id (string_id);
			cl_type := string_cl.types.first;
			str_id := cl_type.id;
			type_id := cl_type.type_id;
			creators := string_cl.creators;
			creators.start;
			creation_feature := string_cl.feature_table.item
											(creators.key_for_iteration);
			set_count_feat := string_cl.feature_table.item ("set_count");
			make_name := Encoder.feature_name
							(str_id, creation_feature.body_id).duplicate;
			set_count_name := Encoder.feature_name
							(str_id, set_count_feat.body_id).duplicate;
			Plug_file.putstring ("extern void ");
			Plug_file.putstring (make_name);
			Plug_file.putstring ("();%N");
			Plug_file.putstring ("extern void ");
			Plug_file.putstring (set_count_name);
			Plug_file.putstring ("();%N");

			if byte_context.final_mode then
				init_name :=
						Encoder.table_name (Initialization_id).duplicate;
				dispose_name := 
						Encoder.table_name (Dispose_id).duplicate;
	
				Plug_file.putstring ("extern char *(*");
				Plug_file.putstring (init_name);
				Plug_file.putstring ("[])();%N");
				Plug_file.putstring ("extern char *(*");
				Plug_file.putstring (dispose_name);
				Plug_file.putstring ("[])();%N%N");
			end;

				-- Pointer on creation feature of class STRING
			Plug_file.putstring ("void (*strmake)() = ");
			Plug_file.putstring (make_name);
			Plug_file.putstring (";%N");
			
				--Pointer on `set_count' of class STRING
			Plug_file.putstring ("void (*strset)() = ");
			Plug_file.putstring (set_count_name);
			Plug_file.putstring (";%N");

				-- Dynamic type of class STRING
			Plug_file.putstring ("int str_dtype = ");
			Plug_file.putint (type_id - 1);
			Plug_file.putstring (";%N");

				-- Dynamic type of class BIT_REF
			bit_cl := class_of_id (bit_id);
			type_id := bit_cl.types.first.type_id;
			Plug_file.putstring ("int bit_dtype = ");
			Plug_file.putint (type_id - 1);
			Plug_file.putstring (";%N");

			if byte_context.final_mode then
					-- Initialization routines
				Plug_file.putstring ("char *(**ecreate)() = ");
				Plug_file.putstring (init_name);
				Plug_file.putstring (";%N");

					-- Dispose routines
				Plug_file.putstring ("void (**edispose)() = ");
				Plug_file.putstring ("(void (**)()) ");
				Plug_file.putstring (dispose_name);
				Plug_file.putstring (";%N");

			end;

			special_cl ?= special_class.compiled_class;
			special_cl.generate_dynamic_types;

			Plug_file.close;
		end;

	generate_make_file is
			-- Generate make file
		local
			makefile_generator: MAKEFILE_GENERATOR;
		do
			!!makefile_generator.make;
			makefile_generator.generate;
		end;

feature -- Dispatch and execution tables generation

	generate_exec_tables is
			-- Generate `dispatch_table' and `execution_table'.
		do
			Dispatch_file.open_write;
			dispatch_table.generate (Dispatch_file);
			dispatch_table.freeze;
			Dispatch_file.close;

			Frozen_file.open_write;
			execution_table.generate (Frozen_file);
			execution_table.freeze;
			Frozen_file.close;

				-- The melted list of the dispatch and execution tables
				-- are now empty
		end

feature -- Main file generation

	generate_main_file is
			-- Generation of the main file
		local
			root_cl: CLASS_C;
			root_feat: FEATURE_I;
			type_id: INTEGER;
			c_name: STRING;
			dtype: INTEGER;
			final_mode: BOOLEAN;
			cl_type: CLASS_TYPE;
		do

			final_mode := byte_context.final_mode;

			Main_file.open_write;

			Main_file.putstring ("%
				%#include <macros.h>%N%
				%#include <struct.h>%N%N");
			
			Main_file.putstring ("%
				%void emain(args)%N%
				%char *args;%N%
				%{%N%
				%%Textern char *root_obj;%N");

			root_cl := root_class.compiled_class;
			cl_type := root_cl.types.first;
			type_id := cl_type.type_id;
			dtype := type_id - 1;

			if 	creation_name /= Void then
				root_feat := root_cl.feature_table.item (creation_name);
				if byte_context.final_mode then
					c_name := Encoder.feature_name
										(cl_type.id, root_feat.body_id);
					Main_file.putstring ("%Textern void ");
					Main_file.putstring (c_name);
					Main_file.putstring (" ();%N%N");
				end;
			end;

			-- Set C variable `scount'.
			if final_mode then
            	Main_file.putstring ("%Tscount = ");
            	Main_file.putint (type_id_counter.value);
				Main_file.putstring (";%N");
			end;

			Main_file.putstring ("%Troot_obj = RTLN(");
			if final_mode then
	            Main_file.putint (dtype);
			else
				Main_file.putstring ("RTUD(");
				Main_file.putint (cl_type.id - 1);
				Main_file.putchar (')');
			end;
            Main_file.putstring (");%N");
	
			if creation_name /= Void then
				Main_file.putchar ('%T');
				if final_mode then
					Main_file.putstring (c_name);
				else
					Main_file.putstring ("((void (*)()) RTWF(");
					Main_file.putint (cl_type.id - 1);
					Main_file.putchar (',');
					Main_file.putint (root_feat.feature_id);
					Main_file.putchar (',');
					Main_file.putint (dtype);
					Main_file.putstring ("))");
				end;
				Main_file.putstring ("(root_obj");

				if root_feat.has_arguments then
					Main_file.putstring (", args");
				end;

				Main_file.putstring (");%N");
			end;

			Main_file.putstring ("}%N");

			-- Generation of einit(). Only for workbench
			-- mode.

			if not final_mode then
				Main_file.putstring ("%Nvoid einit()%N{%N");

					-- Set C variable `scount'.
				Main_file.putstring ("%Tscount = ");
				Main_file.putint (type_id_counter.value);
					-- Set C variable `dcount'.
				Main_file.putstring (";%N%Tdcount = ");
				Main_file.putint (dispatch_table.count);
					-- Set the frozen level
				Main_file.putstring (";%N%Tzeroc = ");
				Main_file.putint (frozen_level);
					-- Set the history table size
				Main_file.putstring (";%N%Ttbcount = ");
				Main_file.putint (routine_id_counter.value);	

				Main_file.putstring (";%N}");
			end;

			Main_file.close;
		end;

feature --Workbench option file generation

	generate_option_file is
			-- Generate compialtion option file
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			partial_debug: DEBUG_TAG_I;
			class_type: CLASS_TYPE;
		do
			Option_file.open_write;

			Option_file.putstring ("#include %"struct.h%"%N%N");

				-- First debug keys
			from
				i := 1;
				nb := id_array.count;
			until
				i > nb
			loop
				a_class := id_array.item (i);
				if a_class /= Void then
					partial_debug ?= a_class.debug_level;
					if partial_debug /= Void then
						partial_debug.generate_keys (Option_file, a_class.id);
					end;
				end;
				i := i + 1;
			end;

				-- Then option C array
			Option_file.putstring ("struct eif_opt foption[] = {%N");
			from
				i := 1;
				nb := Type_id_counter.value;
			until
				i > nb
			loop
				class_type := class_types.item (i);
				Option_file.putchar ('{');
				if class_type /= Void then
						-- Classes could be removed
					a_class := class_type.associated_class;
					a_class.assertion_level.generate (Option_file);
					Option_file.putstring (", ");
					a_class.trace_level.generate (Option_file);
					Option_file.putstring (", ");
					a_class.debug_level.generate (Option_file, a_class.id);
				else
					Option_file.putstring ("%
						%(int16) 0, (int16) 0,%
							%{(int16) 0, (int16) 0, (char **) 0}");
				end;
				Option_file.putstring ("},%N");
				i := i + 1;
			end;
			Option_file.putstring ("};%N");

			Option_file.close;
		end;

feature 

	current_class: CLASS_C is
			-- Current compiled class
		require
			not_off: not changed_classes.off;
		do
			Result := changed_classes.item;
		end;

	clear is
				-- Clear the servers
		do
			Tmp_ast_server.clear;
			Tmp_feat_tbl_server.clear;
			Tmp_body_server.clear;
			Tmp_class_info_server.clear;
			Tmp_byte_server.clear;
			Tmp_inv_byte_server.clear;
			Tmp_inv_ast_server.clear;
			Tmp_depend_server.clear;
		end;

	System_chunk: INTEGER is 500;

feature -- Purge of compilation files

	purge is
			-- Purge compilation files and delete useless datas.
		require
			successfull
		do
			server_controler.remove_useless_files;

				-- Transfer datas from servers to temporary servers
			feat_tbl_server.purge;
			depend_server.purge;
			class_info_server.purge;
			inv_byte_server.purge;
			byte_server.purge;
			ast_server.purge;
			m_feat_tbl_server.purge;
			m_feature_server.purge;
			m_rout_tbl_server.purge;
			poly_server.purge;
			m_rout_id_server.purge;

		end;
	
feature -- Conveniences

	set_nb_classes (i: INTEGER) is
			-- Assign `i' to `nb_classes'.
		do
			nb_classes := i;
		end;

	set_system_name (s: STRING) is
			-- Assign `s' to `system_name'.
		do
			system_name := s;
		end;

	set_root_cluster (c: CLUSTER_I) is
			-- Assign `c' to `root_cluster'.
		do
			root_cluster := c;
		end;

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	set_creation_name (s: STRING) is
			-- Assign `s' to `creation_name'.
		do
			creation_name := s;
		end;

	set_c_file_names (l: like c_file_names) is
			-- Assign `l' to `c_file_names'.
		do
			c_file_names := l;
		end;

	set_object_file_names (l: like object_file_names) is
			-- Assign `l' to `object_file_names'.
		do
			object_file_names := l;
		end;

	set_makefile_name (s: STRING) is
			-- Assign `s' to `makefile_name'.
		do
			makefile_name := s;
		end;

	set_id_array (a: like id_array) is
			-- Assign `a' to `id_array'.
		do
			id_array := a;
		end;

	set_freeze (b: BOOLEAN) is
			-- Assign `b' to `freeze'.
		do
			freeze := b;
		end;

	set_update_sort (b: BOOLEAN) is
			-- Assign `b' to `update_sort'.
		do
			update_sort := b;
		end;

	set_max_class_id (i: INTEGER) is
			-- Assign `i' to `max_class_id'.
		do
			max_class_id := i;
		end;

	root_class: CLASS_I is
			-- Root class of the system
		require
			root_cluster /= Void;
			root_class_name /= Void;
			root_cluster.classes.has (root_class_name);
		do
			Result := root_cluster.classes.item (root_class_name);
		end;

feature -- Debug purpose

	trace is
			-- Trace the list `changed_classes'.
		local
			a_class: CLASS_C;
		do
			from
				changed_classes.start
			until
				changed_classes.offright
			loop
				a_class := changed_classes.item;
				io.error.putstring (a_class.class_name);
				io.error.putstring ("%N%Tpass1 = ");
				io.error.putbool (a_class.make_pass1);
				io.error.putstring ("%N%Tpass2 = ");
				io.error.putbool (a_class.make_pass2);
				io.error.putstring ("%N%Tpass3 = ");
				io.error.putbool (a_class.make_pass3);
				io.error.putstring ("%N%Tchanged = ");
				io.error.putbool (a_class.changed);
				io.error.putstring ("%N%Tchanged2 = ");
				io.error.putbool (a_class.changed2);
				io.error.new_line;
				changed_classes.forth;
			end;
		end;

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end;

end
