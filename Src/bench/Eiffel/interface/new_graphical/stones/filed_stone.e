indexing
	description: "Stone that has a file name associated with it."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	FILED_STONE 

inherit
	STONE
		redefine
			is_valid,
			synchronized_stone
		end
	
feature -- Access

	file_name: FILE_NAME is 
			-- Name of the file which parsing led 
			-- to the creation of current AST node.
		deferred
		end

	origin_text: STRING is
			-- Content of the file named `file_name'
			-- Void if unreadable file.
		require else
			true
		local
			a_file: RAW_FILE
		do
			if is_valid then
				create a_file.make (file_name)
				if a_file.exists and then a_file.is_readable then
					a_file.open_read
					a_file.readstream (a_file.count)
					a_file.close
					Result := a_file.laststring
				end
			end
		end

	is_valid: BOOLEAN is
			-- Does `Current' still represent a valid file?
		local
			testfile: RAW_FILE
		do
			create testfile.make (file_name)
			if testfile.exists then
				Result := True
			end
		end

	synchronized_stone: STONE is
			-- Valid stone corresponding to `Current' if `is_valid'
			-- or Void if not.
		do
			if is_valid then
				Result := Current
			end
		end
		
end -- class FILED_STONE
