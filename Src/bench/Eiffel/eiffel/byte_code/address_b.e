class ADDRESS_B 

inherit

	EXPR_B
		redefine
			analyze, print_register, make_byte_code
		end;
	SHARED_C_LEVEL;
	SHARED_TABLE;
	SHARED_ENCODER;
	SHARED_DECLARATIONS;
	
feature -- Attributes

	feature_id: INTEGER;
			-- Feature id of the addressed feature

	rout_id: INTEGER;
			-- Routine id of the feature

feature  -- Initialization

	init (class_id: INTEGER; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_id := f.feature_id;
			rout_id := f.rout_id_set.first;

			record_feature (class_id, feature_id);
		end; -- init

feature -- Address table

	record_feature (class_id, f_id: INTEGER) is
			-- Record the feature in the address table if it is not there.
			-- A refreezing will occur.
		local
			address_table: ADDRESS_TABLE
		do
			address_table := System.address_table

			if not address_table.has (class_id, f_id) then
					-- Record the feature
				address_table.record (class_id, f_id)
			end
		end

feature

	type: POINTER_I is
			-- Address type
		once
			!!Result;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

	analyze is
			-- Analyze operator
		do
			context.add_dt_current;
			context.mark_current_used;
		end;

	print_register is
			-- Generate feature address
		local
			entry: POLY_TABLE [ENTRY];
			internal_name, table_name: STRING;
			rout_table: ROUT_TABLE;
		do
			if context.workbench_mode then
				generated_file.putstring ("RTWPP(");
				generated_file.putint
					(context.current_type.associated_class_type.id - 1);
				generated_file.putstring (gc_comma);
				generated_file.putint (feature_id);
				generated_file.putchar (')');
			else
				entry := Eiffel_table.item_id (rout_id);
				if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					generated_file.putstring ("(char *(*)()) 0");
				else
						-- Mark table used
                    Eiffel_table.mark_used (rout_id);

					table_name := clone (dle_prefix);
					table_name.append (Encoder.address_table_name (context.current_type.type_id, feature_id))

                    generated_file.putstring (table_name);

                        -- Remember extern declarations
                    Extern_declarations.add_routine (type, table_name);
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a function pointer address
		do
			ba.append (Bc_addr);
			ba.append_integer (feature_id);
			ba.append_short_integer
					(context.current_type.associated_class_type.id - 1);
		end;

feature {NONE} -- DLE

	dle_prefix: STRING is
			-- Prefix for generated variable names
		once
			if System.is_dynamic then
				Result := "D"
			elseif System.extendible then
				Result := "S"
			else
				Result := "f"
			end
		end

end
