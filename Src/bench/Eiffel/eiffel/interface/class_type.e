class CLASS_TYPE 

inherit

	SHARED_WORKBENCH;
	SHARED_GENERATOR;
	SHARED_CODE_FILES;
	SHARED_SERVER;
	SHARED_ENCODER;
	SHARED_BODY_ID;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;
	SHARED_ARRAY_BYTE;
	SHARED_EXEC_TABLE;
	SHARED_DECLARATIONS;
	SHARED_TABLE;

creation

	make
	
feature 

	id: INTEGER;
			-- Unique id for current class type
			--| Useful to set the name of the associated generated file
			--| which has to be dynamic type (`type_id') independant.
			--| Remeber that after during each freezing, dynamic types
			--| are reprocessed.

	type: CL_TYPE_I;
			-- Type of the class: it includes meta-instantiation of
			-- possible generic parameters

	type_id: INTEGER;
			-- Identification of the class type

	skeleton: SKELETON;
			-- Skeleton of the class type

	is_changed: BOOLEAN;
			-- Is the attribute list changed ? [has the skeleton of
			-- attributes to be re-generated ?]

	set_is_changed (b: BOOLEAN) is
			-- Assign `b' to `is_changed' ?
		do
			is_changed := b;
		end;

	set_skeleton (s: like skeleton) is
			-- Assign `s' to `skeleton'.
		do
			skeleton := s;
		end;

	make (t: CL_TYPE_I) is
		require
			good_argument: t /= Void;
			not t.has_formal;
		do
			type := t;
			!!skeleton.make;
			is_changed := True;
			type_id := System.type_id_counter.next;
			id := System.static_type_id_counter.next;
		end;

feature -- Conveniences

	set_type (t: CL_TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

	associated_class: CLASS_C is
			-- Associated class
		require
			type_exists: type /= Void;
		do
			Result := System.class_of_id (type.base_id);
		end;

	written_type (a_class: CLASS_C): CL_TYPE_I is
			-- Class type associated to class `a_class' in the context
			-- of Current
		require
			good_argument: a_class /= Void;
			consistency: associated_class.conform_to (a_class);
		do
			Result := a_class.meta_type (type);
		end;

	written_type_id (a_class: CLASS_C): INTEGER is
			-- Type id of the type associated to class `a_class' in the
			-- context of Current
		require
			good_argument: a_class /= Void;
			consistency: associated_class.conform_to (a_class);
		do
			Result := written_type (a_class).type_id;
		end;

	parent_types: LINKED_LIST [CLASS_TYPE] is
			-- List of parent types used for checking the invariant
		local
			parents: FIXED_LIST [CL_TYPE_A];
			parent_type: CL_TYPE_I;
			already_in: BOOLEAN;
			parent_class_type: CLASS_TYPE;
			gen_type: GEN_TYPE_I;
		do
			from
				!!Result.make;
				parents := associated_class.parents;
				parents.start;
			until
				parents.offright
			loop
				parent_type := parents.item.type_i;
				if parent_type.has_formal then
					gen_type ?= type;
					parent_type := parent_type.instantiation_in (gen_type);
				end;
				from
						-- Check if the parent type is not already in
						-- the list (repeated inheritance ...).
					already_in := False;
					Result.start
				until
					Result.offright or else already_in
				loop
					already_in := Result.item.type.same_as (parent_type);
					Result.forth;
				end;
				if not already_in then
					Result.start;
					parent_class_type := System.class_type_of_id
												(parent_type.type_id);
					Result.put_right (parent_class_type);
				end;
			
				parents.forth;
			end;
		end;

feature -- Generation

	pass4 is
			-- Generation of the C file
		local
			feature_table: FEATURE_TABLE;
			current_class: CLASS_C;
			current_class_id, body_id: INTEGER;
			feature_i: FEATURE_I;
			file: INDENT_FILE;
			inv_byte_code: INVARIANT_B;
			final_mode: BOOLEAN;
			generate_c_code: BOOLEAN;
		do
			final_mode := byte_context.final_mode;

			current_class := associated_class;
			current_class_id := current_class.id;

			feature_table := current_class.feature_table;

			if final_mode then
					-- Check to see if there is really something to generate

				generate_c_code := has_creation_routine or else
					(	associated_class.has_invariant and then
						associated_class.assertion_level.check_invariant);
				from
					feature_table.start
				until
					feature_table.offright or else generate_c_code
				loop
					feature_i := feature_table.item_for_iteration;
					if feature_i.to_generate_in (current_class) and then
							feature_i.used then
						generate_c_code := True;
					end;
					feature_table.forth;
				end;
			else
				generate_c_code := not is_precompiled;
			end;

			if generate_c_code then

			file := generation_file;
			file.open_write;
				-- Write header
			file.putstring ("/*");
			file.new_line;
			file.putstring (" * Code for class ");
			file.putstring (current_class.class_name);
			file.new_line;
			file.putstring (" */");
			file.new_line;
			file.new_line;
				-- Includes wanted
			file.putstring ("#include %"eiffel.h%"");
			file.new_line;
			if final_mode then
				file.putstring ("#include %"");
				file.putstring (base_file_name);
				file.putstring (".h%"%N");
				file.new_line;
			end;
			file.new_line;

			byte_context.set_generated_file (file);

			if final_mode and then has_creation_routine then
					-- Generate the creation routine in final mode
				generate_creation_routine (file);
			end;

			from
				feature_table.start;
				byte_context.init (Current);
				--byte_context.set_class_type (Current);
			until
				feature_table.offright
			loop
				feature_i := feature_table.item_for_iteration;
				if feature_i.to_generate_in (current_class) then
					generate_feature (feature_i, file);
				end;
				feature_table.forth;
			end;

			if 	associated_class.has_invariant
				and then
					((not final_mode)
					or else
					associated_class.assertion_level.check_invariant)
			then
				inv_byte_code := Inv_byte_server.disk_item
													(associated_class.id);
				inv_byte_code.generate_invariant_routine;
				byte_context.clear_all;
			end;

			if final_mode then
				Extern_declarations.generate (extern_declaration_filename);
				Extern_declarations.wipe_out;
			end;
			file.close;

			else
					-- The file hasn't been generated
				System.makefile_generator.record_empty_class_type (id)
			end;
		end;

	generate_feature (f: FEATURE_I; file: INDENT_FILE) is
			-- Generate feature `feat' in Current class type
		require
			good_argument: f /= Void;
			to_generate_in: f.to_generate_in (associated_class);
		do
			f.generate (Current, file);
		end;

	generation_file: INDENT_FILE is
			-- File for generating class code of the current class type
		local
			file_name: STRING;
		do
			file_name := full_file_name;
			if byte_context.final_mode then
				file_name.append (".x")
			else
				file_name.append (".c");
			end;
			!!Result.make (file_name);
		end;

	descriptor_file: UNIX_FILE is
			-- File for generating descriptor table
		require
			Workbench_mode: not byte_context.final_mode
		local
			file_name: STRING;
		do
			file_name := full_file_name;
			file_name.append ("D.c");
			!!Result.make (file_name);
		end;

	extern_declaration_filename: STRING is
			-- File for external declarations in final mode
		do
			Result := full_file_name;
			Result.append (".h");
		end;

	full_file_name: STRING is
			-- Generated file name prefix
		local
			fname: STRING;
		do
			Result := associated_class.full_file_name;
			Result.append_integer (id);
		end;

	base_file_name: STRING is
			-- Generated base file name prefix
		do
			Result := associated_class.base_file_name;
			Result.append_integer (id);
		end;
	
	has_creation_routine: BOOLEAN is
			-- Does the class type need an initialization routine ?
			--| i.e has the skeleton a bit or an expanded attribute at least ?
		do
			skeleton.go_bits;
			Result := not skeleton.offright;
		end;

	dispose_feature: FEATURE_I is
			-- Feature for dispose routine; 
			-- Void if dispose routine does not exist.
		local
			feature_table: FEATURE_TABLE;
			item: FEATURE_I
		do
			feature_table := associated_class.feature_table; 
			if (System.memory_class /= Void) then
				from
					feature_table.start
				until
					feature_table.offright or (Result /= Void) 
				loop
					item := feature_table.item_for_iteration;
					if (item.rout_id_set.first = System.memory_dispose_id) then
						Result := item
					end;
					feature_table.forth
				end
			end
		end;

	generate_creation_routine (file: INDENT_FILE) is
			-- Creation routine, if necessary (i.e. if the object is
			-- composite and has expanded we must initialize, as well
			-- as some special header flags).
		require
			has_creation_routine
		local
			sub_skel: SKELETON;
			i, nb_ref: INTEGER;
			exp_desc: EXPANDED_DESC;
			class_type, sub_class_type: CLASS_TYPE;
			saved_pos: INTEGER;
			c_name, creat_name: STRING;
			bits_desc: BITS_DESC;
			creation_feature: FEATURE_I
		do
			c_name := init_procedure_name;
			nb_ref := skeleton.nb_reference;
			skeleton.go_bits;
				-- There are some expandeds here...
				-- Generate a procedure which will be in charge of all the
				-- initialisation bulk.
			file.putstring ("void ");
			file.putstring (c_name);
			file.putstring ("(Current, parent)");
			file.new_line;
			file.putstring ("char *Current, *parent;");
			file.new_line;
			file.putchar ('{');
			file.new_line;
			file.indent;
			file.putstring ("RTLD;");
			file.new_line;
			file.new_line;
			file.putstring ("RTLI(2);%N");
			file.putstring ("l[0] = Current;");
			file.new_line;
			file.putstring ("l[1] = parent;");
			file.new_line;
			from
			until
				skeleton.offright or else not skeleton.item.is_bits
			loop
					-- Initialize dynamic type of the bit attribute
				file.putstring ("HEADER(l[0] + ");
				skeleton.generate(file);
				file.putstring(")->ov_flags = bit_dtype;");
				file.new_line;
				file.putstring ("*(uint32 *) (l[0] + ");
				bits_desc ?= skeleton.item; 	-- Cannot fail
				skeleton.generate(file);
				file.putstring(") = ");
				file.putint (bits_desc.value);
				file.putchar (';');
				file.new_line;
				skeleton.forth
			end;
				-- Current class type is composite
			file.putstring ("HEADER(l[0])->ov_flags |= EO_COMP;");
			file.new_line;
			from
				i := 0;
			until
				skeleton.offright
			loop
				file.putstring ("*(char **) (l[0] + REFACS(");
				file.putint (nb_ref + i);
				file.putstring (")) =");
				file.new_line;
				file.indent;
				file.putstring("l[0] + ");
					-- There is a side effect with generation
				saved_pos := skeleton.position;
				skeleton.generate(file);
				skeleton.go (saved_pos);
				file.putchar (';');
				file.new_line;
				file.exdent;

				exp_desc ?= skeleton.item;		-- Cannot fail
					-- Initialize dynaminc type of the expanded object
				file.putstring ("HEADER(l[0] + ");
				skeleton.generate(file);
				skeleton.go (saved_pos);
				file.putstring(")->ov_flags = ");
				file.putint(exp_desc.type_id - 1);
				file.putchar (';');
				file.new_line;

					-- Mark expanded object
				file.putstring ("HEADER(l[0] + ");
				skeleton.generate(file);
				skeleton.go (saved_pos);
				file.putstring(")->ov_flags |= EO_EXP;");
				file.new_line;
				file.putstring ("HEADER(l[0] + ");
				skeleton.generate(file);
				skeleton.go (saved_pos);
				file.putstring(")->ov_size = ");
				skeleton.generate(file);
				skeleton.go (saved_pos);
				file.putstring (" + (l[0] - l[1]);");
				file.new_line;

					-- Call creation of expanded if there is one
				class_type := exp_desc.class_type;
				creation_feature := 
						class_type.associated_class.creation_feature;
            	if creation_feature /= Void then
					creat_name := 
						Encoder.feature_name (class_type.id, creation_feature.body_id).duplicate;
					file.putstring (creat_name);
					file.putchar ('(');
					file.putstring ("l[0] + ");
					skeleton.generate(file);
					skeleton.go (saved_pos);
					file.putstring (");");	
					file.new_line;
				end;
					-- If the expanded object also has expandeds, we need
					-- to call the initialization routine too.
				sub_class_type := exp_desc.class_type;
				sub_skel := sub_class_type.skeleton;
				sub_skel.go_expanded;
				if not sub_skel.offright then
					file.putstring (sub_class_type.init_procedure_name);
					file.putchar ('(');
					file.putstring("l[0] + ");
					skeleton.generate(file);
					file.putstring(", l[1]);");
					file.new_line;
				end;
				skeleton.forth;
				i := i + 1;
			end;
			file.putstring ("RTLE;");
			file.new_line;
			file.exdent;
			file.putchar ('}');
			file.new_line;
			file.new_line;
		end;

	init_procedure_name: STRING is
			-- C name of the procedure used to initialize the object
		do
			Result := Encoder.feature_name (id, Initialization_id);
		end;

feature -- Byte code generation

	melt is
			-- Generate byte code for changed features of Current class
			-- type
		require
			good_context: associated_class.has_features_to_melt;
			Not_precompiled: not is_precompiled
		local
			melted_list: SORTED_TWO_WAY_LIST [MELTED_INFO];
			feat_tbl: FEATURE_TABLE;
		do
			from
					-- Iteration on the melted list of the associated class
					-- processed during third pass of the compilation.
				melted_list := associated_class.melted_set;
				melted_list.start;

					-- Initialization of the byte code context
				byte_context.init (Current);
				--byte_context.set_class_type (Current);

				feat_tbl := associated_class.feature_table;
			until
				melted_list.offright
			loop
					-- Generation of byte code
				melted_list.item.melt (Current, feat_tbl);

				melted_list.forth;
			end;
		end;

	melt_feature_table is
			-- Melt the feature table of the associated class
		local
			melted_feat_tbl: MELTED_FEATURE_TABLE;
		do
			melted_feat_tbl := melted_feature_table;
			melted_feat_tbl.set_type_id (type_id);
			Tmp_m_feat_tbl_server.put (melted_feat_tbl);
		end;

feature -- Skeleton generation

	generate_skeleton1 is
			-- Generate skeleton names and types of Current class type
		require
			skeleton_exists: skeleton /= Void;
			skeleton_file_is_open: Skeleton_file.is_open_write;
		local
			parent_list: like parent_types;
		do
			if not skeleton.empty then
					-- Generate attribute names sequence
				Skeleton_file.putstring ("static char *names");
				Skeleton_file.putint (type_id);
				Skeleton_file.putstring (" [] =%N");
				skeleton.generate_name_array;

					-- Generate attribute types sequence
				Skeleton_file.putstring ("uint32 types");
				Skeleton_file.putint (type_id);
				Skeleton_file.putstring (" [] =%N");
				skeleton.generate_type_array;

				if byte_context.final_mode then	
	
						-- Generate attribute offset table pointer array
					Skeleton_file.putstring ("static long *offsets");
					Skeleton_file.putint (type_id);
					Skeleton_file.putstring (" [] =%N");
					skeleton.generate_offset_array
				else
						-- Generate attribute rout id array
					Skeleton_file.putstring ("static int32 cn_attr");
					Skeleton_file.putint (type_id);
					Skeleton_file.putstring (" [] =%N");
					skeleton.generate_rout_id_array
				end;
			end;

				-- Generate parent dynamic type array
			parent_list := parent_types;
			Skeleton_file.putstring ("static int cn_parents");
			Skeleton_file.putint (type_id);
			Skeleton_file.putstring (" [] = {");
			from
				parent_list.start
			until
				parent_list.offright
			loop
				Skeleton_file.putint (parent_list.item.type_id - 1);
				Skeleton_file.putstring (", ");
				parent_list.forth;
			end;
			Skeleton_file.putstring ("-1};%N%N");

			if	byte_context.final_mode
				and
				associated_class.has_invariant
				and
				associated_class.assertion_level.check_invariant
			then
					-- Generate extern declaration for invariant
					-- routine of the current class type
				Skeleton_file.putstring ("extern void ");
				Skeleton_file.putstring (
					Encoder.feature_name (id, Invariant_id));
				Skeleton_file.putstring ("();%N%N");
			end;
		end;

	generate_skeleton2 is
			-- Generate skeleton of Current class type
		require
			skeleton_file_is_open: Skeleton_file.is_open_write;
		local
			upper_class_name: STRING;
			skeleton_empty: BOOLEAN;
			a_class: CLASS_C;
			creation_feature: FEATURE_I;
		do
			a_class := associated_class;
			skeleton_empty := skeleton.empty;
			Skeleton_file.putstring ("{%N(long) ");
			Skeleton_file.putint (skeleton.count);
			Skeleton_file.putstring (",%N%"");
			upper_class_name := a_class.class_name.duplicate;
			upper_class_name.to_upper;
			Skeleton_file.putstring (upper_class_name);
			Skeleton_file.putstring ("%",%N");
			if not skeleton_empty then
				Skeleton_file.putstring ("names");
				Skeleton_file.putint (type_id);
				Skeleton_file.putstring (",%N");
			else
				Skeleton_file.putstring ("(char **) 0,%N");
			end;
			Skeleton_file.putstring ("cn_parents");
			Skeleton_file.putint (type_id);
			Skeleton_file.putstring (",%N");
			if not skeleton_empty then
				Skeleton_file.putstring ("types");
				Skeleton_file.putint (type_id);
				Skeleton_file.putstring (",%N");
			else
				Skeleton_file.putstring ("(uint32 *) 0,%N");
			end;

			if byte_context.final_mode then
				if 	a_class.has_invariant
					and
					a_class.assertion_level.check_invariant
				then
					Skeleton_file.putstring (
						Encoder.feature_name (id, Invariant_id));
				else
					Skeleton_file.putstring ("(void (*)()) 0");
				end;
				Skeleton_file.putstring (",%N");

				if not skeleton_empty then
					Skeleton_file.putstring ("offsets");
					Skeleton_file.putint (type_id);
					Skeleton_file.new_line;
				else
					Skeleton_file.putstring
						("(long **) 0%N");
				end;
			else
					-- Routine id array of attributes
				if not skeleton_empty then
					Skeleton_file.putstring ("cn_attr");
					Skeleton_file.putint (type_id);
				else
					Skeleton_file.putstring ("(int32 *) 0");
				end;
				Skeleton_file.putstring (",%N");
						
					-- Skeleton size
				skeleton.generate_workbench_size (Skeleton_file);
				Skeleton_file.putstring (",%N");

					-- Skeleton number of references
				Skeleton_file.putint
						(skeleton.nb_reference + skeleton.nb_expanded);
				Skeleton_file.putstring ("L,%N");

					-- Deferred class type flag
				if a_class.is_deferred then
					Skeleton_file.putstring ("'\01',%N");
				else
					Skeleton_file.putstring ("'\0',%N");
				end;

					-- Composite class type flag
				if has_creation_routine then
					Skeleton_file.putstring ("'\01',%N");
				else
					Skeleton_file.putstring ("'\0',%N");
				end;

					-- Creation feature id if any.
				Skeleton_file.putstring ("(int32) ");
				creation_feature := a_class.creation_feature;
				if not (creation_feature = Void) then
					Skeleton_file.putint (creation_feature.feature_id);
				else
					Skeleton_file.putint (0);
				end;
				Skeleton_file.putstring (",%N");

					-- Class id 
				Skeleton_file.putstring ("(int32) ");
				Skeleton_file.putint (id - 1);
				Skeleton_file.putstring (",%N");
				
					-- Dispose routine id
				if System.memory_descendants.has (associated_class) then
					Skeleton_file.putstring ("'\01',%N");
				else
					Skeleton_file.putstring ("'\0',%N");
				end;

					-- Generate reference on routine id array
				Skeleton_file.putstring ("ra");
				Skeleton_file.putint (associated_class.id);
				Skeleton_file.putstring (",%N");

					-- Generate cecil structure if any
				generate_cecil (Skeleton_file);
			end;

			Skeleton_file.putchar ('}');
		end;

feature -- Cecil generation

	generate_cecil (file: FILE) is
			-- Generation of the Cecil table
		local
			final_mode: BOOLEAN;
		do
			final_mode := byte_context.final_mode;
			if associated_class.has_visible then
				file.putchar ('{');
				file.putstring ("(int32) ");
				file.putint (associated_class.visible_table_size);
				if final_mode then
					file.putstring (", sizeof(char *(*)()), cl");
				else
					file.putstring (", sizeof(int32), cl");
				end;
				file.putint (associated_class.id);
				file.putstring (", (char *) cr");
				if final_mode then
					file.putint (type_id);
				else
					file.putint (associated_class.id);
				end;
				file.putchar ('}');
			else
				file.putstring
					("{(int32) 0, (int) 0, (char **) 0, (char *) 0}");
			end;
		end;

feature -- Conformance table generation

	generate_conformance_table is
			-- Generate conformance table
		require
			Conformance_file.is_open_write;
		do
			Conf_table.init (type_id);
			Conf_table.mark (type_id);
			associated_class.make_conformance_table (Conf_table);
			Conf_table.generate;
		end;

	make_conformance_table_byte_code (ba: BYTE_ARRAY) is
			-- Generate conformance table
		require
			good_argument: ba /= Void
		do
			Conf_table.init (type_id);
			Conf_table.mark (type_id);
			associated_class.make_conformance_table (Conf_table);
			Conf_table.make_byte_code (ba);
		end;

	Conf_table: CONFORM_TABLE is
			-- Buffer for conformance table generation
		once
			!!Result.make (System.type_id_counter.value);
		end;

feature -- Byte code generation

	melted_feature_table: MELTED_FEATURE_TABLE is
		local
			parent_list: like parent_types;
			ba: BYTE_ARRAY;
			class_name: STRING;
			creation_feature: FEATURE_I;
			a_class: CLASS_C;
		do
			ba := Byte_array;
			ba.clear;

				-- 1. dynamic type
			ba.append_short_integer (type_id - 1);

				-- 2. generator string
			class_name := associated_class.class_name.duplicate;
			class_name.to_upper;
			ba.append_string (class_name);

				-- 3. number of attributes
			ba.append_integer (skeleton.count);

				-- 4. attribute names and meta-types
			skeleton.make_names_byte_code (ba);
			skeleton.make_type_byte_code (ba);

				-- 5. Parent list
			from
				parent_list := parent_types;
					-- 5.1: parent count
				ba.append_short_integer (parent_list.count);
				parent_list.start
			until
				parent_list.offright
			loop
					-- 5.2: parent dynamic type
				ba.append_short_integer (parent_list.item.type_id - 1);
				parent_list.forth;
			end;

				-- 6. Routine ids of attributes
			skeleton.make_rout_id_array (ba);

				-- 7. Reference number
			ba.append_integer (skeleton.nb_reference + skeleton.nb_expanded);
			
				-- 8. Skeleton size
			skeleton.make_size_byte_code (ba);

				-- Deferred class type flag
			a_class := associated_class;
			if a_class.is_deferred then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;

				-- Composite class type flag
			if has_creation_routine then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;

				-- Creation feature id if any.
			creation_feature := a_class.creation_feature;
			if creation_feature /= Void then
				ba.append_int32_integer (creation_feature.feature_id);
			else
				ba.append_int32_integer (0);
			end;

				-- Class id
			ba.append_int32_integer (id - 1);

				-- Dispose routine id of dispose
			if System.memory_descendants.has (associated_class) then
				ba.append ('%/001/');
			else
				ba.append ('%U');
			end;

			Result := ba.feature_table;
		end;

feature -- Precompilation

	is_precompiled: BOOLEAN is
		do
			Result := id <= System.max_precompiled_type_id
		end;

end
