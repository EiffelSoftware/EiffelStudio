-- Server file ids.

class FILE_ID

inherit

	COMPILER_ID

creation

	make

feature -- Access

	packet_number: INTEGER is
			-- Packet in which the file will be stored
		do
			Result := (internal_id // packet_size) + 1
		end

	file_name: STRING is
			-- Server file basename
		do
			!! Result.make (6)
			Result.extend ('E')
			Result.append_integer (internal_id)
		end

feature {NONE} -- Implementation

	counter: FILE_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.server_controler.file_counter.item (compilation_id)
		end

	packet_size: INTEGER is 100
			-- Packet size

end -- class FILE_ID
