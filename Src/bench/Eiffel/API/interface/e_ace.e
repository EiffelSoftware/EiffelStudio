indexing

	description: 
		"Ace description of System.";
	date: "$Date$";
	revision: "$Revision $"

class E_ACE

inherit

	SHARED_WORKBENCH

feature -- Properties

	file_name: STRING is
			-- Path to the universe/system description
		do
			Result := Lace.file_name
		end

	ace_options: ACE_OPTIONS is
			-- Option explicitly set in the Ace file
		do
			Result := Lace.ace_options
		end

feature -- Access

	date_has_changed: BOOLEAN is
			-- Has the date changed for the lace file
		do
			Result := Lace.date_has_changed
		end

	ast: ACE_SD is
			-- Ace AST description 
		do
			Result := Lace.root_ast
		end

	successful: BOOLEAN is
			-- Was the last compilation of the Ace file successful?
		do
			Result := Lace.successful
		end

	text: STRING is
			-- Text of the Lace file.
			-- Void if unreadable file
		require
			non_void_file_name: file_name /= Void
		local
			a_file: RAW_FILE
		do
			create a_file.make (file_name)
			if a_file.exists and then a_file.is_readable then
				a_file.open_read
				a_file.read_stream (a_file.count)
				a_file.close
				Result := a_file.last_string.twin
			end
		end

	click_list: CLICK_LIST is
			-- Click list for the lace file
		do
			if
				(Lace /= Void) and then (Lace.root_ast /= Void) and then
				Lace.not_first_parsing and then
				system.root_class_name /= Void
			then
				Result := Lace.root_ast.click_list
			end
		end

	valid_file_name (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name (i.e
			-- does it exist and is it readable)?
		require
			valid_f_name: f_name /= Void
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (f_name);
			Result := f.exists and then f.is_readable
		end

feature -- Setting

	set_file_name (f_name: STRING) is
			-- Set lace_file_name to `f_name'.
		do
			if f_name /= Void then
				Lace.set_file_name (f_name)
			end
		ensure
			file_name_set: f_name /= Void implies equal (f_name, file_name)
		end

end -- class E_ACE
