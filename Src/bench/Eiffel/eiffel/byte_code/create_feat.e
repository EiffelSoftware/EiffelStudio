-- Creation of a like feature.

class CREATE_FEAT 

inherit

	CREATE_INFO;
	SHARED_ENCODER;
	SHARED_TABLE;
	SHARED_DECLARATIONS;

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

	rout_id: INTEGER is
			-- Routine ID of the feature to be created
		local
			a_class: CLASS_C;
		do
			a_class := context.current_type.base_class;
			Result := a_class.feature_table.item
				(feature_name).rout_id_set.first;
			if Result < 0 then
				Result := -Result;
			end;
		ensure
			positive_routine_id: Result > 0;
		end;

	analyze is
			-- We need Dtype(Current).
		local
			entry: POLY_TABLE [ENTRY];
		do
			if context.final_mode then
				entry := Eiffel_table.item_id (rout_id);
				if not entry.has_one_type then
					context.add_dt_current;
				end;
			else
				context.add_dt_current;
			end;
		end;

	generate is
			-- Generate the creation type of the feature.
		local
			entry: POLY_TABLE [ENTRY];
			create_table_name: STRING;
			gen_file: UNIX_FILE;
			dyn_type: INTEGER;
		do
			gen_file := context.generated_file;
			if context.final_mode then
				entry := Eiffel_table.item_id (rout_id);
				if entry.has_one_type then
						-- There is a table, but with only one type id
					dyn_type := entry.first.feature_type_id - 1;
					gen_file.putint (dyn_type);
				else
						-- Attribute is polymorphic
					create_table_name := Encoder.type_table_name (rout_id);
					gen_file.putchar ('(');
                    gen_file.putstring (create_table_name);
                    gen_file.putchar ('-');
                    gen_file.putint (entry.min_type_id - 1);
                    gen_file.putchar (')');
					gen_file.putchar ('[');
					if context.dt_current > 1 then
						gen_file.putstring ("dtype");
					else
						gen_file.putstring ("Dtype(Current)");
					end;
					gen_file.putchar (']');
						-- Remember extern declaration
                    Extern_declarations.add_type_table (clone (create_table_name));
				end;
			else
				gen_file.putstring ("RTWT(");
				gen_file.putint
					(context.current_type.associated_class_type.id - 1);
				gen_file.putstring (", ");
				gen_file.putint (feature_id);
				gen_file.putstring (", ");
				if context.dt_current > 1 then
					gen_file.putstring ("dtype)");
				else
					gen_file.putstring ("Dtype(Current))");
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an anchored creation type.
		do
			ba.append (Bc_clike);
			ba.append_short_integer (context.current_type.associated_class_type.id - 1);
			ba.append_integer (feature_id);
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
