-- Static type ids.

class TYPE_ID

inherit

	COMPILER_ID
		export
			{BODY_ID, COMPILER_EXPORTER} internal_id;
			{BODY_ID_SUBCOUNTER} compilation_id
		end;
	ENCODER
		export
			{NONE} all
		end

creation

	make

feature -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding 
			-- type will be generated
		do
			if System.in_final_mode then
				Result := id // System.makefile_generator.Packet_number + 1
			else
				Result :=
					internal_id // System.makefile_generator.Packet_number + 1
			end
		end

	address_table_name (feature_id: INTEGER): STRING is
			-- Name of a table of function pointers used by then
			-- $ operator
		local
			buff: STRING
		do
			Result := clone (prefix_name);
			buff := Address_table_buffer;
			eif000 ($buff, internal_id, feature_id);
			Result.append (buff)
		end

	generated_id (f: INDENT_FILE) is
			-- Generate textual representation of static type id
			-- in generated C code
		do
			f.putint (id - 1)
		end

	generated_id_string: STRING is
			-- Textual representation of static type id
			-- used in generated C code
		do
			!! Result.make (5)
			Result.append_integer (id - 1)
		ensure
			generated_id_not_void: Result /= Void
		end

	init_name: STRING is
			-- Name of the descriptors Init function associated
			-- with current type
		do
			!! Result.make (20);
			Result.append (prefix_name);
			Result.append ("Init");
			Result.append_integer (internal_id)
		end

	module_init_name: STRING is
			-- Name of the init procedure of the C module 
			-- associated with current type
		do
			!! Result.make (20);
			Result.append ("EIF_Minit");
			Result.append (prefix_name);
			Result.append_integer (internal_id)
		end

feature {BODY_ID} -- Access

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := counter.prefix_name
		end

feature {NONE} -- Implementation

	counter: TYPE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Static_type_id_counter.item (Normal_compilation)
		end

end -- class TYPE_ID
