-- DC-set static type Ids

class DLE_TYPE_ID

inherit

	DLE_COMPILER_ID;
	TYPE_ID
		undefine
			is_dynamic, compilation_id
		redefine
			packet_number
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

end -- class DLE_TYPE_ID
