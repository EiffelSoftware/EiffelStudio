indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CONSOLE"

external class
	IMPLEMENTATION_CONSOLE

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
			item as item_char,
			index as position
		end
	IO_MEDIUM
		rename
			extendible as extendible_boolean,
			readable as readable_boolean,
			handle_available as descriptor_available,
			handle as descriptor
		end
	STRING_HANDLER
	CONSOLE
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char,
			index as position,
			handle_available as descriptor_available,
			handle as descriptor,
			make_open_write as make_open_stdout,
			make_open_read as make_open_stdin
		end
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
	PLAIN_TEXT_FILE
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char,
			index as position,
			handle_available as descriptor_available,
			handle as descriptor,
			make_open_write as make_open_stdout,
			make_open_read as make_open_stdin
		end
	FINITE_CHAR
	FILE
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char,
			index as position,
			handle_available as descriptor_available,
			handle as descriptor,
			make_open_write as make_open_stdout,
			make_open_read as make_open_stdin
		end
	ACTIVE_CHAR
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char
		end
	MEMORY
	LINEAR_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char,
			index as position
		end
	BILINEAR_CHAR
		rename
			occurrences as occurrences_char,
			item as item_char,
			index as position
		end
	COLLECTION_CHAR
		rename
			extendible as extendible_boolean
		end
	BOX_CHAR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.CONSOLE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_stream: FILE_STREAM is
		external
			"IL field signature :System.IO.FileStream use Implementation.CONSOLE"
		alias
			"$$internal_stream"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_file: FILE_INFO is
		external
			"IL field signature :System.IO.FileInfo use Implementation.CONSOLE"
		alias
			"$$internal_file"
		end

	frozen ec_illegal_36_ec_illegal_36_descriptor_available: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CONSOLE"
		alias
			"$$descriptor_available"
		end

	frozen ec_illegal_36_ec_illegal_36_separator: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.CONSOLE"
		alias
			"$$separator"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_swrite: TEXT_WRITER is
		external
			"IL field signature :System.IO.TextWriter use Implementation.CONSOLE"
		alias
			"$$internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_mode: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.CONSOLE"
		alias
			"$$mode"
		end

	frozen ec_illegal_36_ec_illegal_36_last_double: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.CONSOLE"
		alias
			"$$last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_last_character: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.CONSOLE"
		alias
			"$$last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CONSOLE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_last_real: REAL is
		external
			"IL field signature :System.Single use Implementation.CONSOLE"
		alias
			"$$last_real"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_sread: TEXT_READER is
		external
			"IL field signature :System.IO.TextReader use Implementation.CONSOLE"
		alias
			"$$internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_last_integer: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.CONSOLE"
		alias
			"$$last_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_last_string: STRING is
		external
			"IL field signature :STRING use Implementation.CONSOLE"
		alias
			"$$last_string"
		end

feature -- Basic Operations

	recede (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"recede"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"conforms_to"
		end

	c_write: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_write"
		end

	go_to (r: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.CONSOLE"
		alias
			"go_to"
		end

	last_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"last_integer"
		end

	copy_to (file: FILE) is
		external
			"IL signature (FILE): System.Void use Implementation.CONSOLE"
		alias
			"copy_to"
		end

	last_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.CONSOLE"
		alias
			"last_double"
		end

	is_open_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_open_read"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"full_coalesce"
		end

	put_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"put_integer"
		end

	a_set_last_double (last_double2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CONSOLE"
		alias
			"_set_last_double"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"object_comparison"
		end

	putstring (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"putstring"
		end

	fd_open_read_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"fd_open_read_write"
		end

	read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"read_file"
		end

	readline is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readline"
		end

	is_access_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_access_writable"
		end

	last_string: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"last_string"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONSOLE"
		alias
			"____class_name"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"prune"
		end

	move (offset: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"move"
		end

	open_write is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"open_write"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_memory"
		end

	touch is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"touch"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"is_equal"
		end

	put_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONSOLE"
		alias
			"put_boolean"
		end

	c_open_modifier: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_open_modifier"
		end

	is_fifo: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_fifo"
		end

	is_access_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_access_readable"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"incremental_collector"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"changeable_comparison_criterion"
		end

	reopen_read (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reopen_read"
		end

	c_append: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_append"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"collection_on"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"same_type"
		end

	close is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"close"
		end

	is_device: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_device"
		end

	replace (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"replace"
		end

	putbool (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONSOLE"
		alias
			"putbool"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"sequential_search"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"after"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"GetHashCode"
		end

	set_write_mode is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"set_write_mode"
		end

	extendible_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"extendible"
		end

	make_open_stderr (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_stderr"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"default_create"
		end

	open_read_append is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"open_read_append"
		end

	change_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"change_date"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CONSOLE"
		alias
			"io"
		end

	end_of_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"end_of_file"
		end

	is_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_owner"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"enable_time_accounting"
		end

	reader: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.CONSOLE"
		alias
			"reader"
		end

	stamp (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"stamp"
		end

	frozen ec_illegal_36_ec_illegal_36_end_of_file (current_: CONSOLE): BOOLEAN is
		external
			"IL static signature (CONSOLE): System.Boolean use Implementation.CONSOLE"
		alias
			"$$end_of_file"
		end

	a_set_mode (mode2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"_set_mode"
		end

	read_real is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_real"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"total_memory"
		end

	putint (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"putint"
		end

	c_basic_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.CONSOLE"
		alias
			"c_basic_store"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONSOLE"
		alias
			"gc_monitoring"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.CONSOLE"
		alias
			"linear_representation"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"compare_objects"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_max_mem"
		end

	fd_open_read (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"fd_open_read"
		end

	lastint: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"lastint"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_stderr (current_: CONSOLE; fn: STRING) is
		external
			"IL static signature (CONSOLE, STRING): System.Void use Implementation.CONSOLE"
		alias
			"$$make_open_stderr"
		end

	is_block: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_block"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"exhausted"
		end

	readdouble is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readdouble"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"compare_references"
		end

	support_storable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"support_storable"
		end

	general_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"general_store"
		end

	a_set_last_real (last_real2: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CONSOLE"
		alias
			"_set_last_real"
		end

	mode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"mode"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"true_string"
		end

	new_line is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"new_line"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"generation_object_limit"
		end

	a_set_internal_swrite (internal_swrite2: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use Implementation.CONSOLE"
		alias
			"_set_internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_stdin (current_: CONSOLE; fn: STRING) is
		external
			"IL static signature (CONSOLE, STRING): System.Void use Implementation.CONSOLE"
		alias
			"$$make_open_stdin"
		end

	file_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"file_writable"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"memory_threshold"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CONSOLE"
		alias
			"operating_environment"
		end

	internal_separators: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"internal_separators"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CONSOLE"
		alias
			"there_exists"
		end

	closed_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"closed_file"
		end

	internal_swrite: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.CONSOLE"
		alias
			"internal_swrite"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"allocate_fast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"writable"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CONSOLE"
		alias
			"is_inserted"
		end

	change_mode (mask: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"change_mode"
		end

	last_real: REAL is
		external
			"IL signature (): System.Single use Implementation.CONSOLE"
		alias
			"last_real"
		end

	readreal is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readreal"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"allocate_compact"
		end

	file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.CONSOLE"
		alias
			"file_info"
		end

	readable_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"readable"
		end

	c_readwrite: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_readwrite"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.CONSOLE"
		alias
			"do_all"
		end

	is_character: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_character"
		end

	lastdouble: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.CONSOLE"
		alias
			"lastdouble"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CONSOLE"
		alias
			"default_pointer"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.CONSOLE"
		alias
			"mem_free"
		end

	set_read_mode is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"set_read_mode"
		end

	a_set_descriptor_available (descriptor_available2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONSOLE"
		alias
			"_set_descriptor_available"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"default_rescue"
		end

	owner_name: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"owner_name"
		end

	reopen_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reopen_read_write"
		end

	retrieved: ANY is
		external
			"IL signature (): ANY use Implementation.CONSOLE"
		alias
			"retrieved"
		end

	is_open_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_open_write"
		end

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_in_final_collect"
		end

	file_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"file_readable"
		end

	internal_stream: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use Implementation.CONSOLE"
		alias
			"internal_stream"
		end

	item_char: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CONSOLE"
		alias
			"item"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"collect"
		end

	independent_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"independent_store"
		end

	reopen_read_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reopen_read_append"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"tagged_out"
		end

	make_open_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_append"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.CONSOLE"
		alias
			"referers"
		end

	change_owner (new_owner_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"change_owner"
		end

	fd_open_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"fd_open_write"
		end

	last_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CONSOLE"
		alias
			"last_character"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"start"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"scavenge_zone_size"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"collection_off"
		end

	date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"date"
		end

	file_prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"file_prunable"
		end

	user_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"user_id"
		end

	make (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make"
		end

	put_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CONSOLE"
		alias
			"put_double"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"free"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"name"
		end

	change_name (new_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"change_name"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.CONSOLE"
		alias
			"memory_statistics"
		end

	make_open_stdin (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_stdin"
		end

	frozen ec_illegal_36_ec_illegal_36_dispose (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$dispose"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.CONSOLE"
		alias
			"fill"
		end

	c_independent_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.CONSOLE"
		alias
			"c_independent_store"
		end

	is_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_writable"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_coalesce_period"
		end

	link (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"link"
		end

	make_open_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_read_write"
		end

	access_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"access_exists"
		end

	separator: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CONSOLE"
		alias
			"separator"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONSOLE"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"deep_copy"
		end

	reset (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reset"
		end

	frozen ec_illegal_36_ec_illegal_36_read_integer (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$read_integer"
		end

	put_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"put_string"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"wipe_out"
		end

	open_read_write is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"open_read_write"
		end

	file_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CONSOLE"
		alias
			"file_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_make_open_stdout (current_: CONSOLE; fn: STRING) is
		external
			"IL static signature (CONSOLE, STRING): System.Void use Implementation.CONSOLE"
		alias
			"$$make_open_stdout"
		end

	frozen ec_illegal_36_ec_illegal_36_read_double (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$read_double"
		end

	frozen ec_illegal_36_ec_illegal_36_readdouble (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$readdouble"
		end

	go (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"go"
		end

	is_access_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_access_executable"
		end

	change_group (new_group_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"change_group"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CONSOLE"
		alias
			"internal_clone"
		end

	is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_closed"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"do_nothing"
		end

	protection: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"protection"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"prune_all"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"largest_coalesced_block"
		end

	c_read: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"c_read"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONSOLE"
		alias
			"clone"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.CONSOLE"
		alias
			"do_if"
		end

	a_set_internal_file (internal_file2: FILE_INFO) is
		external
			"IL signature (System.IO.FileInfo): System.Void use Implementation.CONSOLE"
		alias
			"_set_internal_file"
		end

	readchar is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readchar"
		end

	a_set_separator (separator2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"_set_separator"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"equal"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"dispose"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"chunk_size"
		end

	read_line is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_line"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"find_referers"
		end

	frozen ec_illegal_36_ec_illegal_36_is_empty (current_: CONSOLE): BOOLEAN is
		external
			"IL static signature (CONSOLE): System.Boolean use Implementation.CONSOLE"
		alias
			"$$is_empty"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"full_collect"
		end

	remove_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.CONSOLE"
		alias
			"remove_permission"
		end

	read_character is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_character"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.CONSOLE"
		alias
			"has"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONSOLE"
		alias
			"ToString"
		end

	write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"write_file"
		end

	a_set_last_character (last_character2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"_set_last_character"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"disable_time_accounting"
		end

	set_buffer is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"set_buffer"
		end

	add_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.CONSOLE"
		alias
			"add_permission"
		end

	is_open_append: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_open_append"
		end

	links: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"links"
		end

	writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.CONSOLE"
		alias
			"writer"
		end

	put_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CONSOLE"
		alias
			"put_real"
		end

	read_integer is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_integer"
		end

	is_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_executable"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"out"
		end

	readint is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readint"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"collecting"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"force"
		end

	delete is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"delete"
		end

	is_sticky: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_sticky"
		end

	is_creatable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_creatable"
		end

	open_append is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"open_append"
		end

	frozen ec_illegal_36_ec_illegal_36_back (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$back"
		end

	c_general_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.CONSOLE"
		alias
			"c_general_store"
		end

	internal_file: FILE_INFO is
		external
			"IL signature (): System.IO.FileInfo use Implementation.CONSOLE"
		alias
			"internal_file"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.CONSOLE"
		alias
			"occurrences"
		end

	laststring: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"laststring"
		end

	basic_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"basic_store"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"deep_equal"
		end

	lastchar: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.CONSOLE"
		alias
			"lastchar"
		end

	is_setgid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_setgid"
		end

	set_access (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_access"
		end

	readstream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"readstream"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"search"
		end

	put_new_line is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"put_new_line"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"standard_copy"
		end

	access_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"access_date"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.CONSOLE"
		alias
			"for_all"
		end

	buffered_file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.CONSOLE"
		alias
			"buffered_file_info"
		end

	append_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"append_file"
		end

	is_symlink: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_symlink"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"off"
		end

	internal_sread: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.CONSOLE"
		alias
			"internal_sread"
		end

	reopen_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reopen_append"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONSOLE"
		alias
			"deep_clone"
		end

	read_stream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"read_stream"
		end

	fd_open_read_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"fd_open_read_append"
		end

	next_line is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"next_line"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONSOLE"
		alias
			"standard_equal"
		end

	putchar (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"putchar"
		end

	is_plain_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_plain_text"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.CONSOLE"
		alias
			"index_of"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"position"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"coalesce_period"
		end

	is_access_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_access_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_close (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$close"
		end

	putdouble (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.CONSOLE"
		alias
			"putdouble"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"put"
		end

	is_setuid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_setuid"
		end

	exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"exists"
		end

	fd_open_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"fd_open_append"
		end

	frozen ec_illegal_36_ec_illegal_36_next_line (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$next_line"
		end

	is_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_readable"
		end

	frozen ec_illegal_36_ec_illegal_36_count (current_: CONSOLE): INTEGER is
		external
			"IL static signature (CONSOLE): System.Int32 use Implementation.CONSOLE"
		alias
			"$$count"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"full_collector"
		end

	putreal (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.CONSOLE"
		alias
			"putreal"
		end

	make_create_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_create_read_write"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"before"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"extend"
		end

	group_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"group_id"
		end

	read_double is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_double"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CONSOLE"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"generating_type"
		end

	lastreal: REAL is
		external
			"IL signature (): System.Single use Implementation.CONSOLE"
		alias
			"lastreal"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.CONSOLE"
		alias
			"gc_statistics"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"finish"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"remove"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_memory_threshold"
		end

	inode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"inode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CONSOLE"
		alias
			"Equals"
		end

	append_read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"append_read_file"
		end

	read_word is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"read_word"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"collection_period"
		end

	recreate_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"recreate_read_write"
		end

	frozen ec_illegal_36_ec_illegal_36_exists (current_: CONSOLE): BOOLEAN is
		external
			"IL static signature (CONSOLE): System.Boolean use Implementation.CONSOLE"
		alias
			"$$exists"
		end

	flush is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"flush"
		end

	a_set_last_string (last_string2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"_set_last_string"
		end

	is_socket: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_socket"
		end

	a_set_internal_stream (internal_stream2: FILE_STREAM) is
		external
			"IL signature (System.IO.FileStream): System.Void use Implementation.CONSOLE"
		alias
			"_set_internal_stream"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"max_mem"
		end

	is_directory: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_directory"
		end

	put_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.CONSOLE"
		alias
			"put_character"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"full"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"count"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONSOLE"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"print"
		end

	a_set_last_integer (last_integer2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"_set_last_integer"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"allocate_tiny"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"false_string"
		end

	readword is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"readword"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_collection_period"
		end

	c_retrieved (file_handle: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.CONSOLE"
		alias
			"c_retrieved"
		end

	reopen_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"reopen_write"
		end

	a_set_internal_sread (internal_sread2: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use Implementation.CONSOLE"
		alias
			"_set_internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_readint (current_: CONSOLE) is
		external
			"IL static signature (CONSOLE): System.Void use Implementation.CONSOLE"
		alias
			"$$readint"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"copy"
		end

	open_read is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"open_read"
		end

	set_date (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.CONSOLE"
		alias
			"set_date"
		end

	make_open_read_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_read_append"
		end

	is_plain: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_plain"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONSOLE"
		alias
			"internal_copy"
		end

	create_read_write is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"create_read_write"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"back"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"eiffel_memory"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"is_empty"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.CONSOLE"
		alias
			"append"
		end

	get_fd (hdl: INTEGER; omode: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.CONSOLE"
		alias
			"get_fd"
		end

	make_open_stdout (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.CONSOLE"
		alias
			"make_open_stdout"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"tenure"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CONSOLE"
		alias
			"generator"
		end

	read_write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"read_write_file"
		end

	descriptor: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONSOLE"
		alias
			"descriptor"
		end

	descriptor_available: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONSOLE"
		alias
			"descriptor_available"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CONSOLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CONSOLE
