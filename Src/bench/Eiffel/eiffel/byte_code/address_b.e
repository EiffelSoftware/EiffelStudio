class ADDRESS_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code, generate_il
		end;
	SHARED_C_LEVEL;
	SHARED_TABLE;
	SHARED_DECLARATIONS
	SHARED_INCLUDE
	
feature -- Attributes

	feature_id: INTEGER;
			-- Feature id of the addressed feature

	rout_id: INTEGER;
			-- Routine id of the feature

	feature_type: TYPE_C
			-- Address type

feature  -- Initialization

	init (cl_id: INTEGER; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void;
		do
			feature_id := f.feature_id
			rout_id := f.rout_id_set.first
			feature_type := f.type.actual_type.type_i.c_type
			record_feature (cl_id, feature_id);
		end; -- init

feature -- Address table

	record_feature (cl_id: INTEGER; f_id: INTEGER) is
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
			internal_name	: STRING
			table_name		: STRING
			rout_table		: ROUT_TABLE
			buf				: GENERATION_BUFFER
			array_index		: INTEGER
			class_type		: CL_TYPE_I
			class_type_id	: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
				buf.putstring ("(EIF_POINTER) RTWPP(");
				buf.generate_type_id (context.current_type.associated_class_type.static_type_id)
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
					table_name.append (Encoder.address_table_name (feature_id,
								class_type.associated_class_type.static_type_id))

					buf.putstring ("(EIF_POINTER) ");
					buf.putstring (table_name);

						-- Remember extern declarations
					Extern_declarations.add_routine (feature_type, table_name);
				else
					rout_table ?= Eiffel_table.poly_table (rout_id)
					rout_table.goto_implemented (class_type_id)
					if rout_table.is_implemented then
						internal_name := rout_table.feature_name
						buf.putstring ("(EIF_POINTER) ")
						buf.putstring (internal_name)

						shared_include_queue.put (System.class_type_of_id (rout_table.item.written_type_id).header_filename)
					else
							-- Call to a deferred feature without implementation
						buf.putstring ("(char *(*)()) 0");
					end
				end;
			end;
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for function pointer address.
		do
			il_generator.generate_routine_address (context.current_type, feature_id)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a function pointer address
		do
			ba.append (Bc_addr);
			ba.append_integer (feature_id);
			ba.append_short_integer (context.current_type.associated_class_type.static_type_id - 1);
				-- Use RTWPP
			ba.append_short_integer (0)
		end;

end
