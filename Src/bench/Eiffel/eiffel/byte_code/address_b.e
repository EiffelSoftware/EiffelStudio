class ADDRESS_B 

inherit

	EXPR_B
		redefine
			analyze, print_register, make_byte_code
		end;
	SHARED_C_LEVEL;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	
feature -- Attributes

	feature_id: INTEGER;
			-- Feature id of the addressed feature

	rout_id: ROUTINE_ID;
			-- Routine id of the feature

feature  -- Initialization

	init (class_id: CLASS_ID; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_id := f.feature_id;
			rout_id := f.rout_id_set.first;

			record_feature (class_id, feature_id);
		end; -- init

feature -- Address table

	record_feature (class_id: CLASS_ID; f_id: INTEGER) is
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
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if context.workbench_mode then
				buf.putstring ("(EIF_POINTER) RTWPP(");
				context.current_type.associated_class_type.id.generated_id (buf)
				buf.putstring (gc_comma);
				buf.putint (feature_id);
				buf.putchar (')');
			else
				entry := Eiffel_table.poly_table (rout_id);
				if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					buf.putstring ("(char *(*)()) 0");
				else
						-- Mark table used
					Eiffel_table.mark_used (rout_id);

					table_name := "f";
					table_name.append (context.current_type.
						associated_class_type.id.address_table_name (feature_id))

					buf.putstring ("(EIF_POINTER) ");
					buf.putstring (table_name);

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
			ba.append_short_integer (context.current_type.associated_class_type.id.id - 1);
				-- Use RTWPP
			ba.append_short_integer (0)
		end;
end
