-- Server file ids.

class FILE_ID

inherit
	COMPILER_ID

	PROJECT_CONTEXT

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
			!! Result.make (7)
			Result.extend ('E')
			Result.append_integer (internal_id)
		end

	directory_path: STRING is
			-- Server file directory path
		once
			if Compilation_modes.is_extending then
				Result := Extendible_path
			else
				Result := Compilation_path
			end
		end

feature {NONE} -- Implementation

	counter: FILE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := File_counter.item (Normal_compilation)
		end

	packet_size: INTEGER is 100
			-- Packet size

end -- class FILE_ID
