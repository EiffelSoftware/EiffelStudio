indexing
	description: "Stone that has a file name associated with it."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	FILED_STONE 

inherit
	STONE
		undefine
			header
		redefine
			is_valid
		end
	
feature -- Access

	file_name: STRING is 
			-- Name of the file which parsing led 
			-- to the creation of current AST node
		deferred
		end;

	origin_text: STRING is
			-- Content of the file named `file_name';
			-- Void if unreadable file
		require else
			true
		local
			a_file: RAW_FILE
		do
			if is_valid then
				!!a_file.make (file_name);
				if a_file.exists and then a_file.is_readable then
					a_file.open_read;
					a_file.readstream (a_file.count);
					a_file.close;
					Result := a_file.laststring
				end
			end
		end

feature -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		deferred
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := file_name /= Void
		ensure then
			Result implies file_name /= Void
		end

end -- class FILED_STONE
