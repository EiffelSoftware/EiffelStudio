-- Creation of a like feature.

class CREATE_FEAT 

inherit

	CREATE_INFO
		redefine
			generate_cid, make_gen_type_byte_code, generate_reverse,
			generate_cid_array, generate_cid_init
		end
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	SHARED_GENERATION
	COMPILER_EXPORTER
	SHARED_GEN_CONF_LEVEL

create
	make
	
feature {NONE} -- Initialization

	make (f_id, f_name_id: INTEGER) is
			-- Initialize Current with `f_id' and `f_name_id'.
		require
			valid_f_id: f_id > 0
			valid_f_name_id: f_name_id > 0
		do
			feature_id := f_id
			feature_name_id := f_name_id
		ensure
			feature_id_set: feature_id = f_id
			feature_name_id_set: feature_name_id = f_name_id
		end
		
feature -- Access

	feature_id: INTEGER;
			-- Feature ID to create.

	feature_name_id: INTEGER;
			-- Feature name index in NAMES_HEAP.

	is_array (type: TYPE_I): BOOLEAN is
			-- Is type we want to create an ARRAY one?
			-- Usefull only during IL generation.
		require
			type_not_void: type /= Void
			il_generation: System.il_generation
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= type
			check
				cl_type_not_void: cl_type /= Void
			end
			Result := cl_type.base_class.is_special
		end

	is_external (type: TYPE_I): BOOLEAN is
			-- Is type we want to create an external one?
			-- Usefull only during IL generation.
		require
			type_not_void: type /= Void
			il_generation: System.il_generation
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= type
			check
				cl_type_not_void: cl_type /= Void
			end
			Result := cl_type.base_class.is_external
		end

	rout_id: INTEGER is
			-- Routine ID of the feature to be created
		do
			Result := context.current_type.base_class.feature_table.
						item_id (feature_name_id).rout_id_set.first;
		ensure
			routine_id_not_void: Result > 0
		end;

	analyze is
			-- We need Dtype(Current).
		local
			entry: POLY_TABLE [ENTRY];
		do
			if context.final_mode then
				entry := Eiffel_table.poly_table (rout_id);
				if entry /= Void and then (not entry.has_one_type or else is_generic) then
					context.mark_current_used;
					context.add_dt_current;
				end;
			else
				context.mark_current_used;
				context.add_dt_current;
			end;
		end;

	generate is
			-- Generate the creation type of the feature.
		local
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
			rout_info: ROUT_INFO;
			gen_type: GEN_TYPE_I;
			buffer: GENERATION_BUFFER;
			type_set: ROUT_ID_SET
		do
			buffer := context.buffer;

			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id);

				if table = Void then
					-- Creation with `like feature' where
					-- feature is deferred and has no effective
					-- version anywhere.
					-- Create anything - cannot be called anyway

					buffer.putint (0)
				else
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putstring ("typres")
						else
							buffer.putint (table.first.feature_type_id - 1)
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (rout_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putchar (',')
						buffer.putchar ('(');
						buffer.putstring (table_name);
						buffer.putchar ('-');
						buffer.putint (table.min_type_id - 1);
						buffer.putstring ("), (");

						buffer.putstring (table_name);
						buffer.putstring ("_gen_type-");
						buffer.putint (table.min_type_id - 1);
						buffer.putstring ("), ");
						context.Current_register.print_register
						buffer.putchar (')')

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (rout_id);
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name);

						-- Make sure that `rout_id' is in type_set

						type_set := System.type_set

						if not type_set.has (rout_id) then
							-- We found a new routine id which was not in the
							-- table before, we have to insert it into `type_set'
							type_set.force (rout_id)
						end
					end;
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(");
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (rout_id);
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma);
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(");
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1);
					buffer.putstring (gc_comma);
					buffer.putint (feature_id);
				end;

				buffer.putstring (gc_comma);
				context.Current_register.print_register
				buffer.putchar (')');
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for an anchored creation type.
		local
			feat_tbl: FEATURE_TABLE
			feat: FEATURE_I
			target_type: CL_TYPE_I
		do
				-- FIXME: Manu 10/24/2001. Code is not efficient at all and could be
				-- improved if more data were stored in Current.
			feat_tbl := Context.class_type.associated_class.feature_table
			feat := feat_tbl.item_id (feature_name_id)
			feat_tbl := System.class_of_id (feat.implemented_in).feature_table
			feat := feat_tbl.item_id (feat.original_name_id)
			target_type := il_generator.implemented_type (feat.implemented_in,
				context.current_type)
			il_generator.create_attribute_object (target_type, feat.feature_id)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an anchored creation type.
		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append (Bc_pclike);
				ba.append_short_integer (context.class_type.static_type_id-1)
				rout_info := System.rout_info_table.item (rout_id);
				ba.append_integer (rout_info.origin);
				ba.append_integer (rout_info.offset);
			else
				ba.append (Bc_clike);
				ba.append_short_integer
					(context.current_type.associated_class_type.static_type_id - 1);
				ba.append_integer (feature_id);
			end
		end;

feature -- Genericity

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_to_create

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
			rout_info: ROUT_INFO;
			gen_type: GEN_TYPE_I;
			type_set: ROUT_ID_SET
		do
			buffer.putint (Like_pfeature_type)
			buffer.putstring (", ")
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.putint (Internal_type)
					buffer.putchar (',')
					buffer.putint (Internal_type)
					buffer.putchar (',')
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putint (Internal_type)
							buffer.putchar (',')
							gen_type.generate_cid (buffer, final_mode, True)
						else
							buffer.putint (table.first.feature_type_id - 1)
							buffer.putchar (',')
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (rout_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putstring (",(")
						buffer.putstring (table_name)
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), (")

						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), ")
						context.Current_register.print_register
						buffer.putstring ("), ")

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (rout_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)

						-- Make sure that `rout_id' is in type_set

						type_set := System.type_set

						if not type_set.has (rout_id) then
							-- We found a new routine id which was not in the
							-- table before, we have to insert it into `type_set'
							type_set.force (rout_id)
						end
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (rout_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring ("), ")
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			gen_type: GEN_TYPE_I
			type_set: ROUT_ID_SET
		do
			buffer.putint (Like_pfeature_type)
			buffer.putstring (", ")
			dummy := idx_cnt.next
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.putint (Internal_type)
					buffer.putchar (',')
					buffer.putint (Internal_type)
					buffer.putchar (',')
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							buffer.putint (Internal_type)
							buffer.putchar (',')
							dummy := idx_cnt.next
							gen_type.generate_cid_array (buffer, 
													final_mode, True, idx_cnt)
						else
							buffer.putint (table.first.feature_type_id - 1)
							buffer.putchar (',')
							dummy := idx_cnt.next
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (rout_id)

						buffer.putstring ("0, ")
						dummy := idx_cnt.next

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (rout_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)

						-- Make sure that `rout_id' is in type_set

						type_set := System.type_set

						if not type_set.has (rout_id) then
							-- We found a new routine id which was not in the
							-- table before, we have to insert it into `type_set'
							type_set.force (rout_id)
						end
					end
				end
			else
				buffer.putstring ("0, ")
				dummy := idx_cnt.next
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy: INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_I
		do
			dummy := idx_cnt.next
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)

				if table = Void then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type
						gen_type ?= table.first.type

						if gen_type /= Void then
							dummy := idx_cnt.next
							gen_type.generate_cid_init (buffer, final_mode, True, idx_cnt)
						else
							dummy := idx_cnt.next
						end
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (rout_id)

						buffer.putstring ("typarr[")
						buffer.putint (idx_cnt.value)
						buffer.putstring ("] = RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putstring (",(")
						buffer.putstring (table_name)
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), (")

						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), ")
						context.Current_register.print_register
						buffer.putstring (");")
						buffer.new_line
						dummy := idx_cnt.next
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("typarr[")
					buffer.putint (idx_cnt.value)
					buffer.putstring ("] = RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (rout_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("typarr[")
					buffer.putint (idx_cnt.value)
					buffer.putstring ("] = RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring (");")
				buffer.new_line
				dummy := idx_cnt.next
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append_short_integer (Like_pfeature_type)
				ba.append_short_integer (context.class_type.static_type_id-1)
				rout_info := System.rout_info_table.item (rout_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append_short_integer (Like_feature_type)
				ba.append_short_integer
					(context.current_type.associated_class_type.static_type_id - 1)
				ba.append_integer (feature_id)
			end
		end

	type_to_create : CL_TYPE_I is

		local
			table : POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)

				if table /= Void and then table.has_one_type then
					Result ?= table.first.type
				end
			end
		end

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
			rout_info: ROUT_INFO;
			type_set: ROUT_ID_SET
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)

				if table = Void then
					-- Creation with `like feature' where
					-- feature is deferred and has no effective
					-- version anywhere.
					-- Create anything - cannot be called anyway

					buffer.putstring ("0")
				else
					-- Feature has at least one effective version
					if table.has_one_type then
							-- There is a table, but with only one type

						buffer.putint (table.first.feature_type_id - 1)
					else
							-- Attribute is polymorphic
						table_name := Encoder.type_table_name (rout_id)

						buffer.putstring ("RTFCID(")
						buffer.putint (context.current_type.generated_id (context.final_mode))
						buffer.putstring (",(")
						buffer.putstring (table_name)
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), (")

						buffer.putstring (table_name)
						buffer.putstring ("_gen_type")
						buffer.putstring ("-")
						buffer.putint (table.min_type_id - 1)
						buffer.putstring ("), ")
						context.Current_register.print_register
						buffer.putstring (")")

							-- Side effect. This is not nice but
							-- unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used (rout_id)
							-- Remember extern declaration
						Extern_declarations.add_type_table (table_name)

							-- Make sure that `rout_id' is in type_set

						type_set := System.type_set

						if not type_set.has (rout_id) then
								-- We found a new routine id which was not in the
								-- table before, we have to insert it into `type_set'
							type_set.force (rout_id);
						end
					end
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					buffer.putstring ("RTWPCT(")
					buffer.generate_type_id (context.class_type.static_type_id)
					buffer.putstring (gc_comma)
					rout_info := System.rout_info_table.item (rout_id)
					buffer.generate_class_id (rout_info.origin)
					buffer.putstring (gc_comma)
					buffer.putint (rout_info.offset)
				else
					buffer.putstring ("RTWCT(")
					buffer.putint (context.current_type.associated_class_type.static_type_id - 1)
					buffer.putstring (gc_comma)
					buffer.putint (feature_id)
				end

				buffer.putstring (gc_comma)
				context.Current_register.print_register
				buffer.putstring (")")
			end
		end

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			io.error.putstring (System.names.item (feature_name_id));
			io.error.new_line;
		end
		
end
