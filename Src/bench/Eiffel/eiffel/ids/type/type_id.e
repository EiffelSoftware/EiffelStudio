-- Static type ids.

class TYPE_ID

inherit

	COMPILER_ID;
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
			buff := Buffer;
			eif000 ($buff, internal_id, feature_id);
			Result.append (buff)
		end

feature {NONE} -- Implementation

	counter: TYPE_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.static_type_id_counter.item (compilation_id)
		end

	prefix_name: STRING is
			-- Prefix for generated C function names
		do
			Result := counter.prefix_name
		end

end -- class TYPE_ID
