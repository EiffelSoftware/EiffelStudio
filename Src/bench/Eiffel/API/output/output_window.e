indexing

	description: 
		"Window where output is generated to. ";
	date: "$Date$";
	revision: "$Revision $"

deferred class OUTPUT_WINDOW

feature -- Properties

	image: STRING is 
			-- Image of output 
			-- (By default is empty string)
		do 
			Result := "" 
		ensure
			non_void_result: Result /= Void
		end;

feature -- Ouput
	
	display is 
			-- Display the contents of window.
		do 
		end;

	clear_window is 		
			-- Clear the contents of window.
		do 
		end;

	new_line is 
			-- Put a new line at current position.
		deferred 
		end;

	put_string (s: STRING) is 
			-- Put string `s' at current position.
		require
			valid_s: s /= Void
		deferred 
		end;

	put_char (c: CHARACTER) is 
			-- Put a character `c' at current position.
		deferred 
		end;

	put_int (i: INTEGER) is
			-- Put a integer `i' at current position.
		do
			put_string (i.out);
		end;

	put_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end;

	put_class (e_class: E_CLASS; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end;

	put_classi (class_i: CLASS_I; str: STRING) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end;

	put_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		require
			valid_error: error /= Void;
			valid_str: str /= Void
		do
			put_string (str)
		end;

	put_feature (feat: E_FEATURE; e_class: E_CLASS; str: STRING) is
			-- Put feature `feat' defined in `e_class' with string 
			-- representation `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end;

	put_feature_name (f_name: STRING; e_class: E_CLASS) is
			-- Put feature name `f_name' defined in `e_class'.
		require
			valid_f_name: f_name /= Void;
		do
			put_string (f_name)
		end;

	put_address (address: STRING; e_class: E_CLASS) is
			-- Put `address' for `e_class'.
		require
			valid_address: address /= Void;
		do
			put_string (address)
		end;

	put_class_syntax (syn: SYNTAX_ERROR; eclass: E_CLASS; str: STRING) is
			-- Put `address' for `e_class'.
		require
			valid_syn: syn /= Void;
			valid_str: str /= Void;
		do
		end;

	put_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		require
			valid_syn: syn /= Void;
			valid_str: str /= Void;
		do
			put_string (str)
		end;

end -- class OUTPUT_WINDOW
