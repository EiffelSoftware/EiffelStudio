-- Creation of a like feature.

class CREATE_FEAT 

inherit

	CREATE_INFO;
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
				if not entry.has_one_type then
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
			entry: POLY_TABLE [ENTRY];
			create_table_name: STRING;
			gen_file: INDENT_FILE;
			dyn_type: INTEGER;
			rout_info: ROUT_INFO
		do
			gen_file := context.generated_file;
			if context.final_mode then
				entry := Eiffel_table.poly_table (rout_id);
				if entry.has_one_type then
						-- There is a table, but with only one type id
					dyn_type := entry.first.feature_type_id - 1;
					gen_file.putint (dyn_type);
				else
						-- Attribute is polymorphic
					create_table_name := rout_id.type_table_name;
					gen_file.putchar ('(');
					gen_file.putstring (create_table_name);
					gen_file.putchar ('-');
					gen_file.putint (entry.min_type_id - 1);
					gen_file.putstring (")[");
					context.generate_current_dtype;
					gen_file.putchar (']');
						-- Mark routine id used
					Eiffel_table.mark_used (rout_id);
						-- Remember extern declaration
					Extern_declarations.add_type_table (clone (create_table_name));
				end;
			else
				if
					Compilation_modes.is_precompiling or else
					context.current_type.base_class.is_precompiled
				then
					gen_file.putstring ("RTWPT(");
					rout_info := System.rout_info_table.item (rout_id);
					gen_file.putstring (rout_info.origin.generated_id);
					gen_file.putstring (gc_comma);
					gen_file.putint (rout_info.offset)
				else
					gen_file.putstring ("RTWT(");
					gen_file.putint (context.current_type.associated_class_type.id.id - 1);
					gen_file.putstring (gc_comma);
					gen_file.putint (feature_id);
				end;
				gen_file.putstring (gc_comma);
				context.generate_current_dtype;
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

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			io.error.putstring (feature_name);
			io.error.new_line;
		end


end
