-- Creation of a like feature.

class CREATE_FEAT 

inherit

	CREATE_INFO
		redefine
			gen_type_string, make_gen_type_byte_code
		end
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	SHARED_GENERATION_CONSTANTS;
	COMPILER_EXPORTER

feature 

	feature_id: INTEGER;
			-- Feature ID to create

	feature_name: STRING;
			-- Feature name to create

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i;
		end;

	set_feature_name (n: STRING) is
			-- Assign `n' to `feature_name'
		do
			feature_name := n;
		end;

	rout_id: ROUTINE_ID is
			-- Routine ID of the feature to be created
		do
			Result := context.current_type.base_class.feature_table.
						item (feature_name).rout_id_set.first;
		ensure
			routine_id_not_void: Result /= Void
		end;

	analyze is
			-- We need Dtype(Current).
		local
			entry: POLY_TABLE [ENTRY];
		do
			if context.final_mode then
				entry := Eiffel_table.poly_table (rout_id);
				if not entry.has_one_type or else is_generic then
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
			gen_file: INDENT_FILE
		do
			gen_file := context.generated_file;
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id);
				if table.has_one_type then
						-- There is a table, but with only one type id
					gen_type ?= table.first.type

					if gen_type /= Void then
						gen_file.putstring ("typres")
					else
						gen_file.putint (table.first.feature_type_id - 1)
					end
				else
						-- Attribute is polymorphic
					table_name := rout_id.type_table_name;

					gen_file.putstring ("RTFCID(")
					gen_file.putint (context.current_type.generated_id (context.final_mode))
					gen_file.putchar (',')
					gen_file.putchar ('(');
					gen_file.putstring (table_name);
					gen_file.putchar ('-');
					gen_file.putint (table.min_type_id - 1);
					gen_file.putstring ("), (");

					gen_file.putstring (table_name);
					gen_file.putstring ("_gen_type");
					gen_file.putchar ('-');
					gen_file.putint (table.min_type_id - 1);
					gen_file.putstring ("), ");
					gen_file.putstring (context.Current_register.register_name)
					gen_file.putchar (')')

						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used (rout_id);
						-- Remember extern declaration
					Extern_declarations.add_type_table (clone (table_name));
				end;
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					gen_file.putstring ("RTWPCT(");
					gen_file.putstring (context.class_type.id.generated_id)
					gen_file.putstring (gc_comma)
					rout_info := System.rout_info_table.item (rout_id);
					gen_file.putstring (rout_info.origin.generated_id);
					gen_file.putstring (gc_comma);
					gen_file.putint (rout_info.offset)
				else
					gen_file.putstring ("RTWCT(");
					gen_file.putint
						(context.current_type.associated_class_type.id.id - 1);
					gen_file.putstring (gc_comma);
					gen_file.putint (feature_id);
				end;
				gen_file.putstring (gc_comma);
				gen_file.putstring (context.Current_register.register_name)
				gen_file.putchar (')');
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an anchored creation type.
		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append (Bc_pclike);
				rout_info := System.rout_info_table.item (rout_id);
				ba.append_integer (rout_info.origin.id);
				ba.append_integer (rout_info.offset);
			else
				ba.append (Bc_clike);
				ba.append_short_integer
					(context.current_type.associated_class_type.id.id - 1);
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

	gen_type_string (final_mode : BOOLEAN) : STRING is

		local
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
			rout_info: ROUT_INFO;
			gen_type: GEN_TYPE_I;
		do
			!!Result.make (0)
			Result.append ("-13, ")
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id)
				if table.has_one_type then
						-- There is a table, but with only one type id
					gen_type ?= table.first.type

					if gen_type /= Void then
						Result.append ("-10, ")
						Result.append (gen_type.gen_type_string (final_mode, True))
					else
						Result.append_integer (table.first.feature_type_id - 1)
						Result.append (", ")
					end
				else
						-- Attribute is polymorphic
					table_name := rout_id.type_table_name

					Result.append ("RTFCID(")
					Result.append_integer (context.current_type.generated_id (context.final_mode))
					Result.append (",(")
					Result.append (table_name)
					Result.append ("-")
					Result.append_integer (table.min_type_id - 1)
					Result.append ("), (")

					Result.append (table_name)
					Result.append ("_gen_type")
					Result.append ("-")
					Result.append_integer (table.min_type_id - 1)
					Result.append ("), ")
					Result.append (context.Current_register.register_name)
					Result.append ("), ")

						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used (rout_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (clone (table_name))
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.base_class.is_precompiled
				then
					Result.append ("RTWPCT(")
					Result.append (context.class_type.id.generated_id)
					Result.append (gc_comma)
					rout_info := System.rout_info_table.item (rout_id)
					Result.append (rout_info.origin.generated_id)
					Result.append (gc_comma)
					Result.append_integer (rout_info.offset)
				else
					Result.append ("RTWCT(")
					Result.append_integer
						(context.current_type.associated_class_type.id.id - 1)
					Result.append (gc_comma)
					Result.append_integer (feature_id)
				end
				Result.append (gc_comma)
				Result.append (context.Current_register.register_name)
				Result.append ("), ")
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		local
			rout_info: ROUT_INFO
		do
			if context.current_type.base_class.is_precompiled then
				ba.append_short_integer (-13)
				rout_info := System.rout_info_table.item (rout_id)
				ba.append_integer (rout_info.origin.id)
				ba.append_integer (rout_info.offset)
			else
				ba.append_short_integer (-14)
				ba.append_short_integer
					(context.current_type.associated_class_type.id.id - 1)
				ba.append_integer (feature_id)
			end
		end

	type_to_create : CL_TYPE_I is

		local
			table : POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (rout_id);

				if table.has_one_type then
					Result ?= table.first.type
				end
			end;
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			io.error.putstring (feature_name);
			io.error.new_line;
		end


end
