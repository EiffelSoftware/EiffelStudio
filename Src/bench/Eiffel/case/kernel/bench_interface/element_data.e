indexing

	description: 
		"Abstraction of data elements that make up an entity.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ELEMENT_DATA

inherit

	DATA
		undefine
			copy, is_equal
		end;

feature -- Properties

	stone (a_data: DATA): STONE is
			-- Stone representing Current data
		deferred
		end;

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with Current data
	--	deferred
	--	end;

	destroy_command (a_data: DATA): DESTROY is
			-- Destroy command for Current data
		deferred
		end;

feature -- Setting

--	setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup the namer window with Current
	--	deferred
	--	end;

feature -- Element change

	insert_before (data_cont: DATA; a_data: like Current) is
			-- Insert Current before `a_data' in data
			-- container `data_cont'.
		deferred
		end;

--	update_from_namer (namer: NAMER_WINDOW) is
	--		-- Update Current using information from `namer'
	--	deferred
	--	end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
			-- Is Current valid within `data'?
		deferred
		end;

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- does `tag' or `text' contain illegal characters?
		deferred
		end;

feature -- Output

	clickable_string: STRING is
			-- String displayed in clickable text
		deferred
		end;

	generate (text_area: TEXT_AREA; data: DATA ) is
			-- Generte Current into `text_area' using enclosing data `data'.
		require
			valid_text_area: text_area /= Void;
			valid_data: data /= Void
		do
			text_area.append_clickable_string (stone (data), clickable_string);
		end;

	generate_string (text_area: TEXT_AREA; data: DATA) is
			-- Generte Current into `text_area' using enclosing data `data'.
		require
			valid_text_area: text_area /= Void;
			valid_data: data /= Void
		do
			text_area.append_string ( clickable_string	)
		end;



feature -- Storage

	storage_info: S_ELEMENT_DATA is
			-- Storage information associated with Current
		deferred
		end;

end	-- class ELEMENT_DATA
