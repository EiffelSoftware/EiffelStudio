indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.STD_FILES"

external class
	IMPLEMENTATION_STD_FILES

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	STD_FILES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.STD_FILES"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_default_output: PLAIN_TEXT_FILE is
		external
			"IL field signature :PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"$$default_output"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.STD_FILES"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.STD_FILES"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_to_next_line (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$to_next_line"
		end

	put_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.STD_FILES"
		alias
			"put_real"
		end

	frozen ec_illegal_36_ec_illegal_36_read_real (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_real"
		end

	putchar (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STD_FILES"
		alias
			"putchar"
		end

	put_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.STD_FILES"
		alias
			"put_character"
		end

	read_real is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_real"
		end

	frozen ec_illegal_36_ec_illegal_36_error (current_: STD_FILES): PLAIN_TEXT_FILE is
		external
			"IL static signature (STD_FILES): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"$$error"
		end

	put_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.STD_FILES"
		alias
			"put_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_readline (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readline"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_readreal (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readreal"
		end

	standard_default: PLAIN_TEXT_FILE is
		external
			"IL signature (): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"standard_default"
		end

	frozen ec_illegal_36_ec_illegal_36_readint (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readint"
		end

	putstring (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STD_FILES"
		alias
			"putstring"
		end

	frozen ec_illegal_36_ec_illegal_36_putint (current_: STD_FILES; i: INTEGER) is
		external
			"IL static signature (STD_FILES, System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"$$putint"
		end

	put_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"put_integer"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STD_FILES"
		alias
			"copy"
		end

	lastchar: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.STD_FILES"
		alias
			"lastchar"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"generating_type"
		end

	last_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STD_FILES"
		alias
			"last_integer"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_lastdouble (current_: STD_FILES): DOUBLE is
		external
			"IL static signature (STD_FILES): System.Double use Implementation.STD_FILES"
		alias
			"$$lastdouble"
		end

	frozen ec_illegal_36_ec_illegal_36_read_stream (current_: STD_FILES; nb_char: INTEGER) is
		external
			"IL static signature (STD_FILES, System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"$$read_stream"
		end

	frozen ec_illegal_36_ec_illegal_36_lastchar (current_: STD_FILES): CHARACTER is
		external
			"IL static signature (STD_FILES): System.Char use Implementation.STD_FILES"
		alias
			"$$lastchar"
		end

	frozen ec_illegal_36_ec_illegal_36_set_error_default (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$set_error_default"
		end

	readchar is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readchar"
		end

	frozen ec_illegal_36_ec_illegal_36_put_new_line (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$put_new_line"
		end

	put_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.STD_FILES"
		alias
			"put_double"
		end

	frozen ec_illegal_36_ec_illegal_36_readstream (current_: STD_FILES; nb_char: INTEGER) is
		external
			"IL static signature (STD_FILES, System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"$$readstream"
		end

	frozen ec_illegal_36_ec_illegal_36_last_character (current_: STD_FILES): CHARACTER is
		external
			"IL static signature (STD_FILES): System.Char use Implementation.STD_FILES"
		alias
			"$$last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_output (current_: STD_FILES): PLAIN_TEXT_FILE is
		external
			"IL static signature (STD_FILES): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"$$output"
		end

	frozen ec_illegal_36_ec_illegal_36_lastreal (current_: STD_FILES): REAL is
		external
			"IL static signature (STD_FILES): System.Single use Implementation.STD_FILES"
		alias
			"$$lastreal"
		end

	last_string: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"last_string"
		end

	set_output_default is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"set_output_default"
		end

	frozen ec_illegal_36_ec_illegal_36_putdouble (current_: STD_FILES; d: DOUBLE) is
		external
			"IL static signature (STD_FILES, System.Double): System.Void use Implementation.STD_FILES"
		alias
			"$$putdouble"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.STD_FILES"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STD_FILES"
		alias
			"GetHashCode"
		end

	new_line is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"new_line"
		end

	frozen ec_illegal_36_ec_illegal_36_new_line (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$new_line"
		end

	default_output: PLAIN_TEXT_FILE is
		external
			"IL signature (): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"default_output"
		end

	laststring: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"laststring"
		end

	readint is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readint"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.STD_FILES"
		alias
			"tagged_out"
		end

	to_next_line is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"to_next_line"
		end

	frozen ec_illegal_36_ec_illegal_36_put_real (current_: STD_FILES; r: REAL) is
		external
			"IL static signature (STD_FILES, System.Single): System.Void use Implementation.STD_FILES"
		alias
			"$$put_real"
		end

	frozen ec_illegal_36_ec_illegal_36_readchar (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readchar"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.STD_FILES"
		alias
			"default"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"same_type"
		end

	last_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.STD_FILES"
		alias
			"last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_standard_default (current_: STD_FILES): PLAIN_TEXT_FILE is
		external
			"IL static signature (STD_FILES): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"$$standard_default"
		end

	put_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.STD_FILES"
		alias
			"put_string"
		end

	putbool (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.STD_FILES"
		alias
			"putbool"
		end

	set_file_default (f: PLAIN_TEXT_FILE) is
		external
			"IL signature (PLAIN_TEXT_FILE): System.Void use Implementation.STD_FILES"
		alias
			"set_file_default"
		end

	read_character is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_character"
		end

	frozen ec_illegal_36_ec_illegal_36_lastint (current_: STD_FILES): INTEGER is
		external
			"IL static signature (STD_FILES): System.Int32 use Implementation.STD_FILES"
		alias
			"$$lastint"
		end

	frozen ec_illegal_36_ec_illegal_36_putbool (current_: STD_FILES; b: BOOLEAN) is
		external
			"IL static signature (STD_FILES, System.Boolean): System.Void use Implementation.STD_FILES"
		alias
			"$$putbool"
		end

	read_integer is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_last_double (current_: STD_FILES): DOUBLE is
		external
			"IL static signature (STD_FILES): System.Double use Implementation.STD_FILES"
		alias
			"$$last_double"
		end

	readdouble is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readdouble"
		end

	frozen ec_illegal_36_ec_illegal_36_readword (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readword"
		end

	error: PLAIN_TEXT_FILE is
		external
			"IL signature (): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"error"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_last_string (current_: STD_FILES): STRING is
		external
			"IL static signature (STD_FILES): STRING use Implementation.STD_FILES"
		alias
			"$$last_string"
		end

	a_set_default_output (default_output2: PLAIN_TEXT_FILE) is
		external
			"IL signature (PLAIN_TEXT_FILE): System.Void use Implementation.STD_FILES"
		alias
			"_set_default_output"
		end

	read_line is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_line"
		end

	frozen ec_illegal_36_ec_illegal_36_set_file_default (current_: STD_FILES; f: PLAIN_TEXT_FILE) is
		external
			"IL static signature (STD_FILES, PLAIN_TEXT_FILE): System.Void use Implementation.STD_FILES"
		alias
			"$$set_file_default"
		end

	frozen ec_illegal_36_ec_illegal_36_next_line (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$next_line"
		end

	frozen ec_illegal_36_ec_illegal_36_read_word (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_word"
		end

	putdouble (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.STD_FILES"
		alias
			"putdouble"
		end

	frozen ec_illegal_36_ec_illegal_36_putreal (current_: STD_FILES; r: REAL) is
		external
			"IL static signature (STD_FILES, System.Single): System.Void use Implementation.STD_FILES"
		alias
			"$$putreal"
		end

	put_new_line is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"put_new_line"
		end

	lastreal: REAL is
		external
			"IL signature (): System.Single use Implementation.STD_FILES"
		alias
			"lastreal"
		end

	frozen ec_illegal_36_ec_illegal_36_putstring (current_: STD_FILES; s: STRING) is
		external
			"IL static signature (STD_FILES, STRING): System.Void use Implementation.STD_FILES"
		alias
			"$$putstring"
		end

	frozen ec_illegal_36_ec_illegal_36_last_real (current_: STD_FILES): REAL is
		external
			"IL static signature (STD_FILES): System.Single use Implementation.STD_FILES"
		alias
			"$$last_real"
		end

	last_real: REAL is
		external
			"IL signature (): System.Single use Implementation.STD_FILES"
		alias
			"last_real"
		end

	frozen ec_illegal_36_ec_illegal_36_input (current_: STD_FILES): PLAIN_TEXT_FILE is
		external
			"IL static signature (STD_FILES): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"$$input"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"is_equal"
		end

	readword is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readword"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_put_character (current_: STD_FILES; c: CHARACTER) is
		external
			"IL static signature (STD_FILES, System.Char): System.Void use Implementation.STD_FILES"
		alias
			"$$put_character"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STD_FILES"
		alias
			"print"
		end

	set_error_default is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"set_error_default"
		end

	output: PLAIN_TEXT_FILE is
		external
			"IL signature (): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"output"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.STD_FILES"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_read_double (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_double"
		end

	frozen ec_illegal_36_ec_illegal_36_read_character (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_character"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"equal"
		end

	lastint: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.STD_FILES"
		alias
			"lastint"
		end

	frozen ec_illegal_36_ec_illegal_36_read_integer (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_integer"
		end

	read_word is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_word"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STD_FILES"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"standard_equal"
		end

	readreal is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readreal"
		end

	frozen ec_illegal_36_ec_illegal_36_put_string (current_: STD_FILES; s: STRING) is
		external
			"IL static signature (STD_FILES, STRING): System.Void use Implementation.STD_FILES"
		alias
			"$$put_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STD_FILES"
		alias
			"standard_copy"
		end

	input: PLAIN_TEXT_FILE is
		external
			"IL signature (): PLAIN_TEXT_FILE use Implementation.STD_FILES"
		alias
			"input"
		end

	frozen ec_illegal_36_ec_illegal_36_putchar (current_: STD_FILES; c: CHARACTER) is
		external
			"IL static signature (STD_FILES, System.Char): System.Void use Implementation.STD_FILES"
		alias
			"$$putchar"
		end

	frozen ec_illegal_36_ec_illegal_36_last_integer (current_: STD_FILES): INTEGER is
		external
			"IL static signature (STD_FILES): System.Int32 use Implementation.STD_FILES"
		alias
			"$$last_integer"
		end

	last_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.STD_FILES"
		alias
			"last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_laststring (current_: STD_FILES): STRING is
		external
			"IL static signature (STD_FILES): STRING use Implementation.STD_FILES"
		alias
			"$$laststring"
		end

	frozen ec_illegal_36_ec_illegal_36_set_output_default (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$set_output_default"
		end

	putreal (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.STD_FILES"
		alias
			"putreal"
		end

	read_stream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"read_stream"
		end

	next_line is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"next_line"
		end

	readline is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"readline"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.STD_FILES"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_put_boolean (current_: STD_FILES; b: BOOLEAN) is
		external
			"IL static signature (STD_FILES, System.Boolean): System.Void use Implementation.STD_FILES"
		alias
			"$$put_boolean"
		end

	frozen ec_illegal_36_ec_illegal_36_readdouble (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$readdouble"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STD_FILES"
		alias
			"standard_clone"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.STD_FILES"
		alias
			"internal_clone"
		end

	readstream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"readstream"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.STD_FILES"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STD_FILES"
		alias
			"internal_copy"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.STD_FILES"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_read_line (current_: STD_FILES) is
		external
			"IL static signature (STD_FILES): System.Void use Implementation.STD_FILES"
		alias
			"$$read_line"
		end

	frozen ec_illegal_36_ec_illegal_36_put_double (current_: STD_FILES; d: DOUBLE) is
		external
			"IL static signature (STD_FILES, System.Double): System.Void use Implementation.STD_FILES"
		alias
			"$$put_double"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.STD_FILES"
		alias
			"ToString"
		end

	lastdouble: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.STD_FILES"
		alias
			"lastdouble"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.STD_FILES"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_put_integer (current_: STD_FILES; i: INTEGER) is
		external
			"IL static signature (STD_FILES, System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"$$put_integer"
		end

	read_double is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"read_double"
		end

	putint (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.STD_FILES"
		alias
			"putint"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.STD_FILES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_STD_FILES
