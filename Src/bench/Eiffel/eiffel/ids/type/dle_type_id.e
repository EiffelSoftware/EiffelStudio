-- DC-set static type Ids

class DLE_TYPE_ID

inherit

	DLE_COMPILER_ID;
	TYPE_ID
		undefine
			is_dynamic, compilation_id
		redefine
			packet_number, counter, prefix_name
		end

creation

	make

feature -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding
			-- type will be generated
		do
			Result := internal_id // System.makefile_generator.Packet_number + 1
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
			Result := Static_type_id_counter.item (Dle_compilation)
		end

end -- class DLE_TYPE_ID
