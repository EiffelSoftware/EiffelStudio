class ADDRESS_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code
		end;
	SHARED_C_LEVEL;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	
feature -- Attributes

	feature_id: INTEGER;
			-- Feature id of the addressed feature

	rout_id: ROUTINE_ID;
			-- Routine id of the feature

	feature_type: TYPE_C
			-- Address type

	class_id: CLASS_ID
			-- Id of class where addressed feature is written.

feature  -- Initialization

	init (cl_id: CLASS_ID; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_id := f.feature_id
			rout_id := f.rout_id_set.first
			feature_type := f.type.actual_type.type_i.c_type
			class_id := f.written_in

			record_feature (cl_id, feature_id);
		end; -- init

feature -- Address table

	record_feature (cl_id: CLASS_ID; f_id: INTEGER) is
			-- Record the feature in the address table if it is not there.
			-- A refreezing will occur.
		local
			address_table: ADDRESS_TABLE
		do
			address_table := System.address_table

			if not address_table.has (cl_id, f_id) then
					-- Record the feature
				address_table.record (cl_id, f_id)
			end
		end

feature

	type: POINTER_I is
			-- Expression type of $ operator.
		once
			!! Result
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end;

	print_register is
			-- Generate feature address
		local
			entry: POLY_TABLE [ENTRY];
			internal_name, table_name: STRING;
			rout_table: ROUT_TABLE;
			buf: GENERATION_BUFFER
			array_index: INTEGER
			class_type: CL_TYPE_I
			class_type_id: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
				buf.putstring ("(EIF_POINTER) RTWPP(");
				context.current_type.associated_class_type.id.generated_id (buf)
				buf.putstring (gc_comma);
				buf.putint (feature_id);
				buf.putchar (')');
			else
				class_type := context.current_type
				class_type_id := class_type.type_id
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type_id, True)
				if array_index = -2 then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					buf.putstring ("(char *(*)()) 0");
				elseif array_index >= 0 then
						-- Mark table used
					Eiffel_table.mark_used (rout_id);

					table_name := "f";
					table_name.append (class_type.associated_class_type.
								id.address_table_name (feature_id))

					buf.putstring ("(EIF_POINTER) ");
					buf.putstring (table_name);

						-- Remember extern declarations
					Extern_declarations.add_routine (feature_type, table_name);
				else
					rout_table ?= Eiffel_table.poly_table (rout_id)
					if rout_table.is_implemented (class_type_id) then
						internal_name := clone (rout_table.feature_name (class_type_id))
						buf.putstring ("(EIF_POINTER) ")
						buf.putstring (internal_name)

						if not equal (class_id, class_type.base_id) then
								-- Current addressed feature has not been generated in
								-- current generated class, so we need to 
								-- remember extern declarations
							Extern_declarations.add_routine (feature_type, internal_name);
						end
					else
							-- Call to a deferred feature without implementation
						buf.putstring ("(char *(*)()) 0");
					end
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
