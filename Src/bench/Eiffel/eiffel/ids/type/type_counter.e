-- System level static type counter.

class TYPE_COUNTER

inherit
	COMPILER_COUNTER

creation
	make

feature -- Access

	packet_number (id: INTEGER): INTEGER is
			-- Packet in which the file for the corresponding 
			-- type will be generated
		do
			if System.in_final_mode then
				Result := id // System.makefile_generator.Final_packet_number + 1
			else
				Result := (id - precompiled_offset) // System.makefile_generator.Packet_number + 1
			end
		end

end -- class TYPE_COUNTER
