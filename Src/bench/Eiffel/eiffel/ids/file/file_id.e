-- Server file ids.

class FILE_ID

inherit
	COMPILER_ID

	PROJECT_CONTEXT

creation

	make

feature -- Access

	packet_number: INTEGER is
			-- Packet in which the file will be stored (100 is the default_size)
		do
			Result := (internal_id // 100) + 1
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
			Result := Compilation_path
		end

feature {NONE} -- Implementation

	counter: FILE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := File_counter.item (Normal_compilation)
		end

end -- class FILE_ID
