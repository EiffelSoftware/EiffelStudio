class
	XML_MEMBER

creation
	make
	
feature -- Initialization

	make is
			-- initialization
		do
			create name.make_empty
		ensure
			non_void_name: name /= Void
		end

feature -- Access

	name: STRING 
			-- Representation of a type in xml.

	pos_in_file: INTEGER		
			-- Position of the type in the xml file.

	number_of_char: INTEGER
			-- Number of char of the type in the xml file.
			
feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
			not_empty_a_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_pos_in_file (a_pos_in_file: like pos_in_file) is
			-- Set `pos_in_file' with `a_pos_in_file'.
		require
			positive_a_pos_in_file: a_pos_in_file > 0
		do
			pos_in_file := a_pos_in_file
		ensure
			pos_in_file_set: pos_in_file = a_pos_in_file
		end

	set_number_of_char (a_number_of_char: like number_of_char) is
			-- Set `number_of_char' with `a_number_of_char'.
		require
			positive_a_number_of_char: a_number_of_char >= 0
		do
			number_of_char := a_number_of_char
		ensure
			number_of_char_set: number_of_char = a_number_of_char
		end
		

invariant
	non_void_name: name /= Void

end -- class XML_MEMBER
