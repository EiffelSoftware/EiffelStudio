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

	init (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_id := f.feature_id;
			rout_id := f.rout_id_set.first;
		end; -- init

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
				generated_file.putstring ("RTWP(");
				generated_file.putint
					(context.current_type.associated_class_type.id - 1);
				generated_file.putstring (gc_comma);
				generated_file.putint (feature_id);
				generated_file.putstring (gc_comma);
				context.generate_current_dtype;
				generated_file.putchar (')');
			else
				entry := Eiffel_table.item_id (rout_id);
				if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					generated_file.putstring ("(char *(*)()) 0");
--				elseif entry.is_polymorphic (context.current_type.type_id) then
				elseif True then
					table_name := clone (Encoder.table_name (rout_id));
					generated_file.putchar ('(');
                    generated_file.putstring (table_name);
                    generated_file.putchar ('-');
                    generated_file.putint (entry.min_used - 1);
                    generated_file.putchar (')');
                    generated_file.putchar ('[');
					context.generate_current_dtype;
                    generated_file.putchar (']');
						-- Mark table used
                    Eiffel_table.mark_used (rout_id);
                        -- Remember extern declarations
                    Extern_declarations.add_routine_table (table_name);
				else
					rout_table ?= entry;
					internal_name := rout_table.feature_name
						(context.current_type.type_id);
					generated_file.putstring (internal_name);
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

end
