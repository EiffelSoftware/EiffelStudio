indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.FILE"

deferred external class
	IMPLEMENTATION_FILE

inherit
	UNBOUNDED_CHAR
	CONTAINER_CHAR
	BAG_CHAR
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char
		end
	SEQUENCE_CHAR
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char
		end
	IO_MEDIUM
		rename
			extendible as extendible_boolean,
			readable as readable_boolean,
			handle_available as descriptor_available,
			handle as descriptor
		end
	STRING_HANDLER
	MEM_CONST
	TRAVERSABLE_CHAR
		rename
			item as item_char
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	LINEAR_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char
		end
	FINITE_CHAR
	FILE
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char,
			handle_available as descriptor_available,
			handle as descriptor
		end
	ACTIVE_CHAR
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char
		end
	MEMORY
	BILINEAR_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char
		end
	COLLECTION_CHAR
		rename
			extendible as extendible_boolean
		end
	BOX_CHAR

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_stream: FILE_STREAM is
		external
			"IL field signature :System.IO.FileStream use Implementation.FILE"
		alias
			"$$internal_stream"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_file: FILE_INFO is
		external
			"IL field signature :System.IO.FileInfo use Implementation.FILE"
		alias
			"$$internal_file"
		end

	frozen ec_illegal_36_ec_illegal_36_descriptor_available: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.FILE"
		alias
			"$$descriptor_available"
		end

	frozen ec_illegal_36_ec_illegal_36_separator: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.FILE"
		alias
			"$$separator"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_swrite: TEXT_WRITER is
		external
			"IL field signature :System.IO.TextWriter use Implementation.FILE"
		alias
			"$$internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_mode: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.FILE"
		alias
			"$$mode"
		end

	frozen ec_illegal_36_ec_illegal_36_last_double: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.FILE"
		alias
			"$$last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_last_character: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.FILE"
		alias
			"$$last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.FILE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_last_real: REAL is
		external
			"IL field signature :System.Single use Implementation.FILE"
		alias
			"$$last_real"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_sread: TEXT_READER is
		external
			"IL field signature :System.IO.TextReader use Implementation.FILE"
		alias
			"$$internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_last_integer: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.FILE"
		alias
			"$$last_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_last_string: STRING is
		external
			"IL field signature :STRING use Implementation.FILE"
		alias
			"$$last_string"
		end

feature -- Basic Operations

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_before (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$before"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_set_access (current_: FILE; time: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$set_access"
		end

	a_set_last_character (last_character2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"_set_last_character"
		end

	file_prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"file_prunable"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"full"
		end

	last_real: REAL is
		external
			"IL signature (): System.Single use Implementation.FILE"
		alias
			"last_real"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE"
		alias
			"same_type"
		end

	lastreal: REAL is
		external
			"IL signature (): System.Single use Implementation.FILE"
		alias
			"lastreal"
		end

	frozen ec_illegal_36_ec_illegal_36_stamp (current_: FILE; time: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$stamp"
		end

	frozen ec_illegal_36_ec_illegal_36_open_read_write (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$open_read_write"
		end

	next_line is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"next_line"
		end

	frozen ec_illegal_36_ec_illegal_36_independent_store (current_: FILE; object: ANY) is
		external
			"IL static signature (FILE, ANY): System.Void use Implementation.FILE"
		alias
			"$$independent_store"
		end

	frozen ec_illegal_36_ec_illegal_36_is_readable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_readable"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_finish (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$finish"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.FILE"
		alias
			"default"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"enable_time_accounting"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$forth"
		end

	internal_separators: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"internal_separators"
		end

	read_word is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"read_word"
		end

	frozen ec_illegal_36_ec_illegal_36_make_create_read_write (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_create_read_write"
		end

	is_character: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_character"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"coalesce_period"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"full_collector"
		end

	a_set_last_integer (last_integer2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"_set_last_integer"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"copy"
		end

	lastint: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"lastint"
		end

	independent_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"independent_store"
		end

	frozen ec_illegal_36_ec_illegal_36_link (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$link"
		end

	frozen ec_illegal_36_ec_illegal_36_reopen_write (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reopen_write"
		end

	readstream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"readstream"
		end

	frozen ec_illegal_36_ec_illegal_36_flush (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$flush"
		end

	frozen ec_illegal_36_ec_illegal_36_set_read_mode (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$set_read_mode"
		end

	frozen ec_illegal_36_ec_illegal_36_open_read_append (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$open_read_append"
		end

	add_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.FILE"
		alias
			"add_permission"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"scavenge_zone_size"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_separators (current_: FILE): STRING is
		external
			"IL static signature (FILE): STRING use Implementation.FILE"
		alias
			"$$internal_separators"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"prune"
		end

	c_write: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"c_write"
		end

	frozen ec_illegal_36_ec_illegal_36_go (current_: FILE; abs_position: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$go"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.FILE"
		alias
			"fill"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_change_owner (current_: FILE; new_owner_id: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$change_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_basic_store (current_: FILE; object: ANY) is
		external
			"IL static signature (FILE, ANY): System.Void use Implementation.FILE"
		alias
			"$$basic_store"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_max_mem"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"eiffel_memory"
		end

	buffered_file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.FILE"
		alias
			"buffered_file_info"
		end

	read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"read_file"
		end

	reopen_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reopen_write"
		end

	file_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"file_writable"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE"
		alias
			"gc_monitoring"
		end

	new_line is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"new_line"
		end

	frozen ec_illegal_36_ec_illegal_36_set_write_mode (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$set_write_mode"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"generating_type"
		end

	read_stream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"read_stream"
		end

	internal_sread: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.FILE"
		alias
			"internal_sread"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"collection_on"
		end

	frozen ec_illegal_36_ec_illegal_36_after (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$after"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.FILE"
		alias
			"do_all"
		end

	frozen ec_illegal_36_ec_illegal_36_read_character (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$read_character"
		end

	frozen ec_illegal_36_ec_illegal_36_is_fifo (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_fifo"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$start"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"c_memory"
		end

	frozen ec_illegal_36_ec_illegal_36_false_string (current_: FILE): STRING is
		external
			"IL static signature (FILE): STRING use Implementation.FILE"
		alias
			"$$false_string"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$count"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.FILE"
		alias
			"append"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make"
		end

	set_read_mode is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"set_read_mode"
		end

	frozen fbzd346 (hdl: INTEGER; omode: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32, System.Int32): System.Int32 use Implementation.FILE"
		alias
			"Fbzd346"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"changeable_comparison_criterion"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$remove"
		end

	frozen ec_illegal_36_ec_illegal_36_is_sticky (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_sticky"
		end

	frozen ec_illegal_36_ec_illegal_36_is_closed (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_closed"
		end

	is_creatable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_creatable"
		end

	frozen ec_illegal_36_ec_illegal_36_put_new_line (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$put_new_line"
		end

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_in_final_collect"
		end

	put_new_line is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"put_new_line"
		end

	frozen ec_illegal_36_ec_illegal_36_c_read (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$c_read"
		end

	read_line is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"read_line"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.FILE"
		alias
			"io"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.FILE"
		alias
			"internal_clone"
		end

	file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.FILE"
		alias
			"file_info"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.FILE"
		alias
			"has"
		end

	replace (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"replace"
		end

	make_open_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_open_append"
		end

	recreate_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"recreate_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_name (current_: FILE): STRING is
		external
			"IL static signature (FILE): STRING use Implementation.FILE"
		alias
			"$$name"
		end

	is_open_append: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_open_append"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"default_create"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"allocate_fast"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_empty"
		end

	open_read is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"open_read"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"incremental_collector"
		end

	delete is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"delete"
		end

	copy_to (file: FILE) is
		external
			"IL signature (FILE): System.Void use Implementation.FILE"
		alias
			"copy_to"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"collection_period"
		end

	internal_file: FILE_INFO is
		external
			"IL signature (): System.IO.FileInfo use Implementation.FILE"
		alias
			"internal_file"
		end

	touch is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"touch"
		end

	a_set_internal_sread (internal_sread2: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use Implementation.FILE"
		alias
			"_set_internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_end_of_file (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$end_of_file"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_append (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_open_append"
		end

	append_read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"append_read_file"
		end

	frozen ec_illegal_36_ec_illegal_36_writer (current_: FILE): TEXT_WRITER is
		external
			"IL static signature (FILE): System.IO.TextWriter use Implementation.FILE"
		alias
			"$$writer"
		end

	frozen ec_illegal_36_ec_illegal_36_recreate_read_write (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$recreate_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_is_owner (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_owner"
		end

	laststring: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"laststring"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.FILE"
		alias
			"operating_environment"
		end

	is_block: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_block"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_collection_period"
		end

	is_symlink: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_symlink"
		end

	putchar (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"putchar"
		end

	user_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"user_id"
		end

	frozen ec_illegal_36_ec_illegal_36_append_read_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$append_read_file"
		end

	frozen ec_illegal_36_ec_illegal_36_true_string (current_: FILE): STRING is
		external
			"IL static signature (FILE): STRING use Implementation.FILE"
		alias
			"$$true_string"
		end

	frozen ec_illegal_36_ec_illegal_36_change_mode (current_: FILE; mask: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$change_mode"
		end

	frozen ec_illegal_36_ec_illegal_36_readword (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$readword"
		end

	frozen ec_illegal_36_ec_illegal_36_c_retrieved (current_: FILE; file_handle: INTEGER): ANY is
		external
			"IL static signature (FILE, System.Int32): ANY use Implementation.FILE"
		alias
			"$$c_retrieved"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"allocate_tiny"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: FILE; v: CHARACTER) is
		external
			"IL static signature (FILE, System.Char): System.Void use Implementation.FILE"
		alias
			"$$replace"
		end

	frozen ec_illegal_36_ec_illegal_36_create_read_write (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$create_read_write"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"disable_time_accounting"
		end

	frozen ec_illegal_36_ec_illegal_36_access_exists (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$access_exists"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$off"
		end

	frozen ec_illegal_36_ec_illegal_36_links (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$links"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"generator"
		end

	open_read_append is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"open_read_append"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"tenure"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$prunable"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_is_character (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_character"
		end

	stamp (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"stamp"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"out"
		end

	a_set_last_string (last_string2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"_set_last_string"
		end

	frozen ec_illegal_36_ec_illegal_36_group_id (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$group_id"
		end

	frozen ec_illegal_36_ec_illegal_36_append_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$append_file"
		end

	create_read_write is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"create_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_is_symlink (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_symlink"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"forth"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.FILE"
		alias
			"for_all"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"search"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"object_comparison"
		end

	internal_swrite: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.FILE"
		alias
			"internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_read_append (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_open_read_append"
		end

	frozen ec_illegal_36_ec_illegal_36_change_group (current_: FILE; new_group_id: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$change_group"
		end

	frozen ec_illegal_36_ec_illegal_36_c_write (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$c_write"
		end

	recede (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"recede"
		end

	frozen ec_illegal_36_ec_illegal_36_general_store (current_: FILE; object: ANY) is
		external
			"IL static signature (FILE, ANY): System.Void use Implementation.FILE"
		alias
			"$$general_store"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$back"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_writable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_access_writable"
		end

	flush is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"flush"
		end

	go (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"go"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_reopen_append (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reopen_append"
		end

	frozen ec_illegal_36_ec_illegal_36_is_setgid (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_setgid"
		end

	make_open_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_open_read_write"
		end

	access_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"access_exists"
		end

	frozen ec_illegal_36_ec_illegal_36_is_device (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_device"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_access_date (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$access_date"
		end

	mode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"mode"
		end

	is_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_readable"
		end

	frozen ec_illegal_36_ec_illegal_36_delete (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$delete"
		end

	end_of_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"end_of_file"
		end

	frozen ec_illegal_36_ec_illegal_36_set_date (current_: FILE; time: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$set_date"
		end

	last_string: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"last_string"
		end

	is_socket: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_socket"
		end

	item_char: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.FILE"
		alias
			"item"
		end

	frozen ec_illegal_36_ec_illegal_36_reader (current_: FILE): TEXT_READER is
		external
			"IL static signature (FILE): System.IO.TextReader use Implementation.FILE"
		alias
			"$$reader"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"name"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.FILE"
		alias
			"linear_representation"
		end

	last_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.FILE"
		alias
			"last_character"
		end

	go_to (r: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.FILE"
		alias
			"go_to"
		end

	general_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"general_store"
		end

	set_buffer is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"set_buffer"
		end

	fd_open_read (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"fd_open_read"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"full_coalesce"
		end

	is_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_owner"
		end

	basic_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"basic_store"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"start"
		end

	frozen ec_illegal_36_ec_illegal_36_is_creatable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_creatable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_setuid (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_setuid"
		end

	frozen ec_illegal_36_ec_illegal_36_reopen_read (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reopen_read"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: FILE; v: CHARACTER) is
		external
			"IL static signature (FILE, System.Char): System.Void use Implementation.FILE"
		alias
			"$$extend"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"count"
		end

	frozen ec_illegal_36_ec_illegal_36_c_readwrite (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$c_readwrite"
		end

	put_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"put_character"
		end

	reopen_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reopen_append"
		end

	frozen ec_illegal_36_ec_illegal_36_reset (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reset"
		end

	descriptor: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"descriptor"
		end

	make (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"prune_all"
		end

	frozen ec_illegal_36_ec_illegal_36_open_append (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$open_append"
		end

	remove_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.FILE"
		alias
			"remove_permission"
		end

	a_set_internal_stream (internal_stream2: FILE_STREAM) is
		external
			"IL signature (System.IO.FileStream): System.Void use Implementation.FILE"
		alias
			"_set_internal_stream"
		end

	put_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"put_string"
		end

	change_group (new_group_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"change_group"
		end

	frozen ec_illegal_36_ec_illegal_36_set_buffer (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$set_buffer"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE"
		alias
			"_set_object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_copy_to (current_: FILE; file: FILE) is
		external
			"IL static signature (FILE, FILE): System.Void use Implementation.FILE"
		alias
			"$$copy_to"
		end

	is_access_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_access_executable"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"prunable"
		end

	protection: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"protection"
		end

	c_append: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"c_append"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"chunk_size"
		end

	is_access_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_access_writable"
		end

	frozen ec_illegal_36_ec_illegal_36_exists (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$exists"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"compare_references"
		end

	link (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"link"
		end

	frozen ec_illegal_36_ec_illegal_36_putstring (current_: FILE; s: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$putstring"
		end

	group_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"group_id"
		end

	frozen ec_illegal_36_ec_illegal_36_descriptor (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$descriptor"
		end

	retrieved: ANY is
		external
			"IL signature (): ANY use Implementation.FILE"
		alias
			"retrieved"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.FILE"
		alias
			"do_if"
		end

	a_set_internal_file (internal_file2: FILE_INFO) is
		external
			"IL signature (System.IO.FileInfo): System.Void use Implementation.FILE"
		alias
			"_set_internal_file"
		end

	frozen ec_illegal_36_ec_illegal_36_readline (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$readline"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_readable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_access_readable"
		end

	is_access_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_access_readable"
		end

	is_access_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_access_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_put_string (current_: FILE; s: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$put_string"
		end

	frozen ec_illegal_36_ec_illegal_36_readchar (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$readchar"
		end

	frozen ec_illegal_36_ec_illegal_36_c_basic_store (current_: FILE; file_handle: INTEGER; object: POINTER) is
		external
			"IL static signature (FILE, System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"$$c_basic_store"
		end

	frozen ec_illegal_36_ec_illegal_36_putchar (current_: FILE; c: CHARACTER) is
		external
			"IL static signature (FILE, System.Char): System.Void use Implementation.FILE"
		alias
			"$$putchar"
		end

	frozen ec_illegal_36_ec_illegal_36_user_id (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$user_id"
		end

	frozen ec_illegal_36_ec_illegal_36_buffered_file_info (current_: FILE): UNIX_FILE_INFO is
		external
			"IL static signature (FILE): UNIX_FILE_INFO use Implementation.FILE"
		alias
			"$$buffered_file_info"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"GetHashCode"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_protection (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$protection"
		end

	frozen ec_illegal_36_ec_illegal_36_retrieved (current_: FILE): ANY is
		external
			"IL static signature (FILE): ANY use Implementation.FILE"
		alias
			"$$retrieved"
		end

	fd_open_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"fd_open_append"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.FILE"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_recede (current_: FILE; abs_position: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$recede"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"back"
		end

	frozen ec_illegal_36_ec_illegal_36_inode (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$inode"
		end

	a_set_last_real (last_real2: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.FILE"
		alias
			"_set_last_real"
		end

	a_set_last_double (last_double2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.FILE"
		alias
			"_set_last_double"
		end

	read_write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"read_write_file"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.FILE"
		alias
			"standard_clone"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_coalesce_period"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"allocate_compact"
		end

	links: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"links"
		end

	set_date (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_date"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_memory_threshold"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"before"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"collection_off"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.FILE"
		alias
			"mem_free"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_read_write (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_open_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_next_line (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$next_line"
		end

	is_plain_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_plain_text"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"true_string"
		end

	change_mode (mask: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"change_mode"
		end

	a_set_internal_swrite (internal_swrite2: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use Implementation.FILE"
		alias
			"_set_internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_file_writable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$file_writable"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.FILE"
		alias
			"is_inserted"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_read_word (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$read_word"
		end

	c_retrieved (file_handle: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.FILE"
		alias
			"c_retrieved"
		end

	frozen ec_illegal_36_ec_illegal_36_fd_open_read_write (current_: FILE; fd: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$fd_open_read_write"
		end

	change_name (new_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"change_name"
		end

	frozen ec_illegal_36_ec_illegal_36_is_plain (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_plain"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"full_collect"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"finish"
		end

	frozen ec_illegal_36_ec_illegal_36_is_executable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_executable"
		end

	separator: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.FILE"
		alias
			"separator"
		end

	is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_closed"
		end

	a_set_descriptor_available (descriptor_available2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.FILE"
		alias
			"_set_descriptor_available"
		end

	lastdouble: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.FILE"
		alias
			"lastdouble"
		end

	change_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"change_date"
		end

	descriptor_available: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"descriptor_available"
		end

	frozen ec_illegal_36_ec_illegal_36_add_permission (current_: FILE; who: STRING; what: STRING) is
		external
			"IL static signature (FILE, STRING, STRING): System.Void use Implementation.FILE"
		alias
			"$$add_permission"
		end

	set_write_mode is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"set_write_mode"
		end

	lastchar: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.FILE"
		alias
			"lastchar"
		end

	internal_stream: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use Implementation.FILE"
		alias
			"internal_stream"
		end

	frozen ec_illegal_36_ec_illegal_36_append (current_: FILE; f: FILE) is
		external
			"IL static signature (FILE, FILE): System.Void use Implementation.FILE"
		alias
			"$$append"
		end

	read_character is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"read_character"
		end

	frozen ec_illegal_36_ec_illegal_36_move (current_: FILE; offset: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$move"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"writable"
		end

	frozen ec_illegal_36_ec_illegal_36_file_pointer (current_: FILE): POINTER is
		external
			"IL static signature (FILE): System.IntPtr use Implementation.FILE"
		alias
			"$$file_pointer"
		end

	c_general_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"c_general_store"
		end

	frozen ec_illegal_36_ec_illegal_36_read_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$read_file"
		end

	frozen ec_illegal_36_ec_illegal_36_fd_open_read (current_: FILE; fd: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$fd_open_read"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.FILE"
		alias
			"standard_is_equal"
		end

	is_open_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_open_write"
		end

	c_basic_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"c_basic_store"
		end

	fd_open_read_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"fd_open_read_write"
		end

	is_sticky: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_sticky"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"generation_object_limit"
		end

	frozen ec_illegal_36_ec_illegal_36_is_writable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_writable"
		end

	readline is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"readline"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_executable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_access_executable"
		end

	readchar is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"readchar"
		end

	access_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"access_date"
		end

	is_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_executable"
		end

	make_open_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_open_write"
		end

	make_open_read (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_open_read"
		end

	frozen ec_illegal_36_ec_illegal_36_readstream (current_: FILE; nb_char: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$readstream"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"free"
		end

	make_open_read_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_open_read_append"
		end

	append_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"append_file"
		end

	reset (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reset"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"force"
		end

	closed_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"closed_file"
		end

	last_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.FILE"
		alias
			"last_double"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"collecting"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"collect"
		end

	frozen ec_illegal_36_ec_illegal_36_read_line (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$read_line"
		end

	frozen ec_illegal_36_ec_illegal_36_is_open_append (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_open_append"
		end

	frozen ec_illegal_36_ec_illegal_36_reopen_read_write (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reopen_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_fd_open_write (current_: FILE; fd: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$fd_open_write"
		end

	frozen ec_illegal_36_ec_illegal_36_change_name (current_: FILE; new_name: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$change_name"
		end

	frozen ec_illegal_36_ec_illegal_36_file_info (current_: FILE): UNIX_FILE_INFO is
		external
			"IL static signature (FILE): UNIX_FILE_INFO use Implementation.FILE"
		alias
			"$$file_info"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_put_character (current_: FILE; c: CHARACTER) is
		external
			"IL static signature (FILE, System.Char): System.Void use Implementation.FILE"
		alias
			"$$put_character"
		end

	frozen ec_illegal_36_ec_illegal_36_reopen_read_append (current_: FILE; fname: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$reopen_read_append"
		end

	reopen_read (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reopen_read"
		end

	c_independent_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"c_independent_store"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"largest_coalesced_block"
		end

	c_read: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"c_read"
		end

	fd_open_read_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"fd_open_read_append"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: FILE): CHARACTER is
		external
			"IL static signature (FILE): System.Char use Implementation.FILE"
		alias
			"$$item"
		end

	c_readwrite: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"c_readwrite"
		end

	is_open_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_open_read"
		end

	frozen ec_illegal_36_ec_illegal_36_wipe_out (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$wipe_out"
		end

	frozen ec_illegal_36_ec_illegal_36_open_read (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$open_read"
		end

	open_append is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"open_append"
		end

	reopen_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reopen_read_write"
		end

	open_read_write is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"open_read_write"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"print"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FILE"
		alias
			"____class_name"
		end

	is_plain: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_plain"
		end

	frozen ec_illegal_36_ec_illegal_36_c_independent_store (current_: FILE; file_handle: INTEGER; object: POINTER) is
		external
			"IL static signature (FILE, System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"$$c_independent_store"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$extendible"
		end

	frozen ec_illegal_36_ec_illegal_36_fd_open_read_append (current_: FILE; fd: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$fd_open_read_append"
		end

	frozen ec_illegal_36_ec_illegal_36_file_readable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$file_readable"
		end

	open_write is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"open_write"
		end

	frozen ec_illegal_36_ec_illegal_36_open_write (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$open_write"
		end

	frozen ec_illegal_36_ec_illegal_36_date (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$date"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"empty"
		end

	is_directory: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_directory"
		end

	fd_open_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"fd_open_write"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.FILE"
		alias
			"index_of"
		end

	readword is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"readword"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_position (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$position"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_permission (current_: FILE; who: STRING; what: STRING) is
		external
			"IL static signature (FILE, STRING, STRING): System.Void use Implementation.FILE"
		alias
			"$$remove_permission"
		end

	inode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"inode"
		end

	frozen ec_illegal_36_ec_illegal_36_change_date (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$change_date"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_owner (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_access_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_read (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_open_read"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.FILE"
		alias
			"there_exists"
		end

	owner_name: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"owner_name"
		end

	move (offset: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"move"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE"
		alias
			"deep_equal"
		end

	writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.FILE"
		alias
			"writer"
		end

	a_set_separator (separator2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"_set_separator"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"exhausted"
		end

	frozen ec_illegal_36_ec_illegal_36_closed_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$closed_file"
		end

	frozen ec_illegal_36_ec_illegal_36_is_socket (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_socket"
		end

	reopen_read_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"reopen_read_append"
		end

	get_fd (hdl: INTEGER; omode: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.FILE"
		alias
			"get_fd"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: FILE; v: CHARACTER) is
		external
			"IL static signature (FILE, System.Char): System.Void use Implementation.FILE"
		alias
			"$$prune"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.FILE"
		alias
			"referers"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$full"
		end

	is_device: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_device"
		end

	is_setgid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_setgid"
		end

	frozen ec_illegal_36_ec_illegal_36_read_write_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$read_write_file"
		end

	frozen ec_illegal_36_ec_illegal_36_read_stream (current_: FILE; nb_char: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$read_stream"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"standard_copy"
		end

	extendible_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"extendible"
		end

	frozen ec_illegal_36_ec_illegal_36_c_append (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$c_append"
		end

	frozen ec_illegal_36_ec_illegal_36_owner_name (current_: FILE): STRING is
		external
			"IL static signature (FILE): STRING use Implementation.FILE"
		alias
			"$$owner_name"
		end

	frozen ec_illegal_36_ec_illegal_36_close (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$close"
		end

	file_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"file_readable"
		end

	write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"write_file"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.FILE"
		alias
			"occurrences"
		end

	change_owner (new_owner_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"change_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: FILE; r: CURSOR) is
		external
			"IL static signature (FILE, CURSOR): System.Void use Implementation.FILE"
		alias
			"$$go_to"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"deep_copy"
		end

	is_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_writable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_open_write (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_open_write"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.FILE"
		alias
			"put"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.FILE"
		alias
			"memory_statistics"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"wipe_out"
		end

	is_setuid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_setuid"
		end

	file_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.FILE"
		alias
			"file_pointer"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"do_nothing"
		end

	close is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"close"
		end

	a_set_mode (mode2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"_set_mode"
		end

	is_fifo: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"is_fifo"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"memory_threshold"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.FILE"
		alias
			"false_string"
		end

	frozen ec_illegal_36_ec_illegal_36_write_file (current_: FILE): INTEGER is
		external
			"IL static signature (FILE): System.Int32 use Implementation.FILE"
		alias
			"$$write_file"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.FILE"
		alias
			"ToString"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.FILE"
		alias
			"find_referers"
		end

	reader: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.FILE"
		alias
			"reader"
		end

	frozen ec_illegal_36_ec_illegal_36_c_general_store (current_: FILE; file_handle: INTEGER; object: POINTER) is
		external
			"IL static signature (FILE, System.Int32, System.IntPtr): System.Void use Implementation.FILE"
		alias
			"$$c_general_store"
		end

	make_create_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"make_create_read_write"
		end

	readable_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"readable"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"total_memory"
		end

	date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"date"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.FILE"
		alias
			"gc_statistics"
		end

	frozen ec_illegal_36_ec_illegal_36_file_prunable (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$file_prunable"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"position"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"after"
		end

	frozen ec_illegal_36_ec_illegal_36_is_block (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_block"
		end

	putstring (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.FILE"
		alias
			"putstring"
		end

	frozen ec_illegal_36_ec_illegal_36_touch (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$touch"
		end

	frozen ec_illegal_36_ec_illegal_36_new_line (current_: FILE) is
		external
			"IL static signature (FILE): System.Void use Implementation.FILE"
		alias
			"$$new_line"
		end

	frozen ec_illegal_36_ec_illegal_36_is_open_read (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_open_read"
		end

	set_access (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.FILE"
		alias
			"set_access"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_write (current_: FILE; fn: STRING) is
		external
			"IL static signature (FILE, STRING): System.Void use Implementation.FILE"
		alias
			"$$make_open_write"
		end

	frozen ec_illegal_36_ec_illegal_36_fd_open_append (current_: FILE; fd: INTEGER) is
		external
			"IL static signature (FILE, System.Int32): System.Void use Implementation.FILE"
		alias
			"$$fd_open_append"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.FILE"
		alias
			"equal"
		end

	last_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"last_integer"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.FILE"
		alias
			"max_mem"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.FILE"
		alias
			"internal_copy"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"dispose"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.FILE"
		alias
			"Equals"
		end

	exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.FILE"
		alias
			"exists"
		end

	frozen ec_illegal_36_ec_illegal_36_is_directory (current_: FILE): BOOLEAN is
		external
			"IL static signature (FILE): System.Boolean use Implementation.FILE"
		alias
			"$$is_directory"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.FILE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_FILE
