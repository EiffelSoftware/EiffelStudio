indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.RAW_FILE"

external class
	IMPLEMENTATION_RAW_FILE

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
	RAW_FILE
		rename
			extendible as extendible_boolean,
			occurrences as occurrences_char,
			readable as readable_boolean,
			item as item_char,
			index as position,
			handle_available as descriptor_available,
			handle as descriptor,
			writer as text_writer,
			reader as text_reader
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
			writer as text_writer,
			reader as text_reader
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
			"IL creator use Implementation.RAW_FILE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_internal_stream: FILE_STREAM is
		external
			"IL field signature :System.IO.FileStream use Implementation.RAW_FILE"
		alias
			"$$internal_stream"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_file: FILE_INFO is
		external
			"IL field signature :System.IO.FileInfo use Implementation.RAW_FILE"
		alias
			"$$internal_file"
		end

	frozen ec_illegal_36_ec_illegal_36_descriptor_available: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.RAW_FILE"
		alias
			"$$descriptor_available"
		end

	frozen ec_illegal_36_ec_illegal_36_separator: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.RAW_FILE"
		alias
			"$$separator"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_swrite: TEXT_WRITER is
		external
			"IL field signature :System.IO.TextWriter use Implementation.RAW_FILE"
		alias
			"$$internal_swrite"
		end

	frozen ec_illegal_36_ec_illegal_36_mode: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.RAW_FILE"
		alias
			"$$mode"
		end

	frozen ec_illegal_36_ec_illegal_36_last_double: DOUBLE is
		external
			"IL field signature :System.Double use Implementation.RAW_FILE"
		alias
			"$$last_double"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_bwriter: BINARY_WRITER is
		external
			"IL field signature :System.IO.BinaryWriter use Implementation.RAW_FILE"
		alias
			"$$internal_bwriter"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.RAW_FILE"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_last_real: REAL is
		external
			"IL field signature :System.Single use Implementation.RAW_FILE"
		alias
			"$$last_real"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_sread: TEXT_READER is
		external
			"IL field signature :System.IO.TextReader use Implementation.RAW_FILE"
		alias
			"$$internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_last_integer: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.RAW_FILE"
		alias
			"$$last_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_last_character: CHARACTER is
		external
			"IL field signature :System.Char use Implementation.RAW_FILE"
		alias
			"$$last_character"
		end

	frozen ec_illegal_36_ec_illegal_36_last_string: STRING is
		external
			"IL field signature :STRING use Implementation.RAW_FILE"
		alias
			"$$last_string"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_breader: BINARY_READER is
		external
			"IL field signature :System.IO.BinaryReader use Implementation.RAW_FILE"
		alias
			"$$internal_breader"
		end

feature -- Basic Operations

	recede (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"recede"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"conforms_to"
		end

	c_write: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_write"
		end

	go_to (r: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.RAW_FILE"
		alias
			"go_to"
		end

	last_integer: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"last_integer"
		end

	copy_to (file: FILE) is
		external
			"IL signature (FILE): System.Void use Implementation.RAW_FILE"
		alias
			"copy_to"
		end

	frozen ec_illegal_36_ec_illegal_36_reader (current_: RAW_FILE): BINARY_READER is
		external
			"IL static signature (RAW_FILE): System.IO.BinaryReader use Implementation.RAW_FILE"
		alias
			"$$reader"
		end

	last_double: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.RAW_FILE"
		alias
			"last_double"
		end

	is_open_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_open_read"
		end

	full_coalesce is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"full_coalesce"
		end

	put_integer (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"put_integer"
		end

	a_set_last_double (last_double2: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.RAW_FILE"
		alias
			"_set_last_double"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_put_data (current_: RAW_FILE; p: POINTER; size: INTEGER) is
		external
			"IL static signature (RAW_FILE, System.IntPtr, System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"$$put_data"
		end

	putstring (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"putstring"
		end

	fd_open_read_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"fd_open_read_write"
		end

	read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"read_file"
		end

	readline is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readline"
		end

	is_access_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_access_writable"
		end

	last_string: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"last_string"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RAW_FILE"
		alias
			"____class_name"
		end

	prune (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"prune"
		end

	move (offset: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"move"
		end

	open_write is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"open_write"
		end

	c_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_memory"
		end

	touch is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"touch"
		end

	frozen ec_illegal_36_ec_illegal_36_putdouble (current_: RAW_FILE; d: DOUBLE) is
		external
			"IL static signature (RAW_FILE, System.Double): System.Void use Implementation.RAW_FILE"
		alias
			"$$putdouble"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_equal"
		end

	put_boolean (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"put_boolean"
		end

	c_open_modifier: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_open_modifier"
		end

	is_fifo: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_fifo"
		end

	is_access_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_access_readable"
		end

	frozen ec_illegal_36_ec_illegal_36_putreal (current_: RAW_FILE; r: REAL) is
		external
			"IL static signature (RAW_FILE, System.Single): System.Void use Implementation.RAW_FILE"
		alias
			"$$putreal"
		end

	incremental_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"incremental_collector"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"changeable_comparison_criterion"
		end

	reopen_read (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reopen_read"
		end

	c_append: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_append"
		end

	collection_on is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"collection_on"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"same_type"
		end

	close is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"close"
		end

	is_device: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_device"
		end

	replace (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"replace"
		end

	putbool (b: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"putbool"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"sequential_search"
		end

	frozen ec_illegal_36_ec_illegal_36_put_double (current_: RAW_FILE; d: DOUBLE) is
		external
			"IL static signature (RAW_FILE, System.Double): System.Void use Implementation.RAW_FILE"
		alias
			"$$put_double"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"after"
		end

	frozen ec_illegal_36_ec_illegal_36_read_real (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$read_real"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"GetHashCode"
		end

	set_write_mode is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"set_write_mode"
		end

	extendible_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"extendible"
		end

	frozen ec_illegal_36_ec_illegal_36_writer (current_: RAW_FILE): BINARY_WRITER is
		external
			"IL static signature (RAW_FILE): System.IO.BinaryWriter use Implementation.RAW_FILE"
		alias
			"$$writer"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"default_create"
		end

	open_read_append is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"open_read_append"
		end

	change_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"change_date"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.RAW_FILE"
		alias
			"io"
		end

	end_of_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"end_of_file"
		end

	is_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_owner"
		end

	enable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"enable_time_accounting"
		end

	stamp (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"stamp"
		end

	a_set_mode (mode2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"_set_mode"
		end

	read_real is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_real"
		end

	total_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"total_memory"
		end

	putint (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"putint"
		end

	c_basic_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.RAW_FILE"
		alias
			"c_basic_store"
		end

	gc_monitoring (flag: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"gc_monitoring"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_CHAR is
		external
			"IL signature (): LINEAR_CHAR use Implementation.RAW_FILE"
		alias
			"linear_representation"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"compare_objects"
		end

	set_max_mem (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_max_mem"
		end

	fd_open_read (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"fd_open_read"
		end

	lastint: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"lastint"
		end

	writer_binary_writer: BINARY_WRITER is
		external
			"IL signature (): System.IO.BinaryWriter use Implementation.RAW_FILE"
		alias
			"writer"
		end

	is_block: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_block"
		end

	reader_binary_reader: BINARY_READER is
		external
			"IL signature (): System.IO.BinaryReader use Implementation.RAW_FILE"
		alias
			"reader"
		end

	exhausted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"exhausted"
		end

	readdouble is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readdouble"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"compare_references"
		end

	support_storable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"support_storable"
		end

	general_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"general_store"
		end

	a_set_last_real (last_real2: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.RAW_FILE"
		alias
			"_set_last_real"
		end

	mode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"mode"
		end

	true_string: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"true_string"
		end

	new_line is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"new_line"
		end

	generation_object_limit: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"generation_object_limit"
		end

	a_set_internal_swrite (internal_swrite2: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_swrite"
		end

	file_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"file_writable"
		end

	memory_threshold: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"memory_threshold"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.RAW_FILE"
		alias
			"operating_environment"
		end

	internal_separators: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"internal_separators"
		end

	there_exists (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.RAW_FILE"
		alias
			"there_exists"
		end

	closed_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"closed_file"
		end

	internal_swrite: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.RAW_FILE"
		alias
			"internal_swrite"
		end

	allocate_fast is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"allocate_fast"
		end

	writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"writable"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_inserted"
		end

	change_mode (mask: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"change_mode"
		end

	last_real: REAL is
		external
			"IL signature (): System.Single use Implementation.RAW_FILE"
		alias
			"last_real"
		end

	readreal is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readreal"
		end

	allocate_compact is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"allocate_compact"
		end

	file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.RAW_FILE"
		alias
			"file_info"
		end

	readable_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"readable"
		end

	c_readwrite: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_readwrite"
		end

	do_all (action: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.RAW_FILE"
		alias
			"do_all"
		end

	is_character: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_character"
		end

	lastdouble: DOUBLE is
		external
			"IL signature (): System.Double use Implementation.RAW_FILE"
		alias
			"lastdouble"
		end

	frozen ec_illegal_36_ec_illegal_36_put_integer (current_: RAW_FILE; i: INTEGER) is
		external
			"IL static signature (RAW_FILE, System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"$$put_integer"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.RAW_FILE"
		alias
			"default_pointer"
		end

	mem_free (addr: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.RAW_FILE"
		alias
			"mem_free"
		end

	set_read_mode is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"set_read_mode"
		end

	a_set_descriptor_available (descriptor_available2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"_set_descriptor_available"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"default_rescue"
		end

	owner_name: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"owner_name"
		end

	reopen_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reopen_read_write"
		end

	retrieved: ANY is
		external
			"IL signature (): ANY use Implementation.RAW_FILE"
		alias
			"retrieved"
		end

	is_open_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_open_write"
		end

	internal_breader: BINARY_READER is
		external
			"IL signature (): System.IO.BinaryReader use Implementation.RAW_FILE"
		alias
			"internal_breader"
		end

	is_in_final_collect: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_in_final_collect"
		end

	file_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"file_readable"
		end

	internal_stream: FILE_STREAM is
		external
			"IL signature (): System.IO.FileStream use Implementation.RAW_FILE"
		alias
			"internal_stream"
		end

	item_char: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.RAW_FILE"
		alias
			"item"
		end

	collect is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"collect"
		end

	independent_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"independent_store"
		end

	reopen_read_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reopen_read_append"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"tagged_out"
		end

	make_open_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_open_append"
		end

	referers (an_object: ANY): ARRAY_ANY is
		external
			"IL signature (ANY): ARRAY_ANY use Implementation.RAW_FILE"
		alias
			"referers"
		end

	change_owner (new_owner_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"change_owner"
		end

	fd_open_write (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"fd_open_write"
		end

	last_character: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.RAW_FILE"
		alias
			"last_character"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"start"
		end

	scavenge_zone_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"scavenge_zone_size"
		end

	collection_off is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"collection_off"
		end

	date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"date"
		end

	frozen ec_illegal_36_ec_illegal_36_putbool (current_: RAW_FILE; b: BOOLEAN) is
		external
			"IL static signature (RAW_FILE, System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"$$putbool"
		end

	file_prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"file_prunable"
		end

	user_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"user_id"
		end

	make (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make"
		end

	put_double (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.RAW_FILE"
		alias
			"put_double"
		end

	free (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"free"
		end

	make_open_read (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_open_read"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"name"
		end

	change_name (new_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"change_name"
		end

	memory_statistics (memory_type: INTEGER): MEM_INFO is
		external
			"IL signature (System.Int32): MEM_INFO use Implementation.RAW_FILE"
		alias
			"memory_statistics"
		end

	internal_bwriter: BINARY_WRITER is
		external
			"IL signature (): System.IO.BinaryWriter use Implementation.RAW_FILE"
		alias
			"internal_bwriter"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL signature (CONTAINER_CHAR): System.Void use Implementation.RAW_FILE"
		alias
			"fill"
		end

	c_independent_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.RAW_FILE"
		alias
			"c_independent_store"
		end

	is_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_writable"
		end

	set_coalesce_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_coalesce_period"
		end

	link (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"link"
		end

	make_open_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_open_read_write"
		end

	access_exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"access_exists"
		end

	separator: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.RAW_FILE"
		alias
			"separator"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"deep_copy"
		end

	reset (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reset"
		end

	frozen ec_illegal_36_ec_illegal_36_read_integer (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$read_integer"
		end

	put_string (s: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"put_string"
		end

	wipe_out is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"wipe_out"
		end

	open_read_write is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"open_read_write"
		end

	file_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.RAW_FILE"
		alias
			"file_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_read_double (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$read_double"
		end

	frozen ec_illegal_36_ec_illegal_36_readdouble (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$readdouble"
		end

	go (abs_position: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"go"
		end

	is_access_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_access_executable"
		end

	change_group (new_group_id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"change_group"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.RAW_FILE"
		alias
			"internal_clone"
		end

	is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_closed"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_readreal (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$readreal"
		end

	protection: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"protection"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"forth"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"prune_all"
		end

	largest_coalesced_block: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"largest_coalesced_block"
		end

	c_read: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"c_read"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RAW_FILE"
		alias
			"clone"
		end

	do_if (action: PROCEDURE_ANY_ANY; test: FUNCTION_ANY_ANY_BOOLEAN) is
		external
			"IL signature (PROCEDURE_ANY_ANY, FUNCTION_ANY_ANY_BOOLEAN): System.Void use Implementation.RAW_FILE"
		alias
			"do_if"
		end

	a_set_internal_file (internal_file2: FILE_INFO) is
		external
			"IL signature (System.IO.FileInfo): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_file"
		end

	readchar is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readchar"
		end

	a_set_separator (separator2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"_set_separator"
		end

	frozen ec_illegal_36_ec_illegal_36_support_storable (current_: RAW_FILE): BOOLEAN is
		external
			"IL static signature (RAW_FILE): System.Boolean use Implementation.RAW_FILE"
		alias
			"$$support_storable"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"equal"
		end

	dispose is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"dispose"
		end

	chunk_size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"chunk_size"
		end

	read_line is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_line"
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"find_referers"
		end

	full_collect is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"full_collect"
		end

	remove_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.RAW_FILE"
		alias
			"remove_permission"
		end

	read_character is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_character"
		end

	has (v: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use Implementation.RAW_FILE"
		alias
			"has"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RAW_FILE"
		alias
			"ToString"
		end

	write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"write_file"
		end

	a_set_last_character (last_character2: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"_set_last_character"
		end

	disable_time_accounting is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"disable_time_accounting"
		end

	set_buffer is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"set_buffer"
		end

	make_open_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_open_write"
		end

	add_permission (who: STRING; what: STRING) is
		external
			"IL signature (STRING, STRING): System.Void use Implementation.RAW_FILE"
		alias
			"add_permission"
		end

	is_open_append: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_open_append"
		end

	text_writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use Implementation.RAW_FILE"
		alias
			"text_writer"
		end

	links: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"links"
		end

	put_real (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.RAW_FILE"
		alias
			"put_real"
		end

	read_integer is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_integer"
		end

	is_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_executable"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"out"
		end

	readint is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readint"
		end

	collecting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"collecting"
		end

	force (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"force"
		end

	delete is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"delete"
		end

	is_sticky: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_sticky"
		end

	is_creatable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_creatable"
		end

	open_append is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"open_append"
		end

	c_general_store (file_handle: INTEGER; object: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr): System.Void use Implementation.RAW_FILE"
		alias
			"c_general_store"
		end

	internal_file: FILE_INFO is
		external
			"IL signature (): System.IO.FileInfo use Implementation.RAW_FILE"
		alias
			"internal_file"
		end

	a_set_internal_bwriter (internal_bwriter2: BINARY_WRITER) is
		external
			"IL signature (System.IO.BinaryWriter): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_bwriter"
		end

	occurrences_char (v: CHARACTER): INTEGER is
		external
			"IL signature (System.Char): System.Int32 use Implementation.RAW_FILE"
		alias
			"occurrences"
		end

	laststring: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"laststring"
		end

	text_reader: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.RAW_FILE"
		alias
			"text_reader"
		end

	basic_store (object: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"basic_store"
		end

	put_data (p: POINTER; size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"put_data"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"deep_equal"
		end

	lastchar: CHARACTER is
		external
			"IL signature (): System.Char use Implementation.RAW_FILE"
		alias
			"lastchar"
		end

	is_setgid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_setgid"
		end

	set_access (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_access"
		end

	readstream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"readstream"
		end

	search (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"search"
		end

	put_new_line is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"put_new_line"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"standard_copy"
		end

	access_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"access_date"
		end

	for_all (test: FUNCTION_ANY_ANY_BOOLEAN): BOOLEAN is
		external
			"IL signature (FUNCTION_ANY_ANY_BOOLEAN): System.Boolean use Implementation.RAW_FILE"
		alias
			"for_all"
		end

	buffered_file_info: UNIX_FILE_INFO is
		external
			"IL signature (): UNIX_FILE_INFO use Implementation.RAW_FILE"
		alias
			"buffered_file_info"
		end

	frozen ec_illegal_36_ec_illegal_36_put_real (current_: RAW_FILE; r: REAL) is
		external
			"IL static signature (RAW_FILE, System.Single): System.Void use Implementation.RAW_FILE"
		alias
			"$$put_real"
		end

	append_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"append_file"
		end

	is_symlink: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_symlink"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"off"
		end

	frozen ec_illegal_36_ec_illegal_36_put_boolean (current_: RAW_FILE; b: BOOLEAN) is
		external
			"IL static signature (RAW_FILE, System.Boolean): System.Void use Implementation.RAW_FILE"
		alias
			"$$put_boolean"
		end

	internal_sread: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use Implementation.RAW_FILE"
		alias
			"internal_sread"
		end

	reopen_append (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reopen_append"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RAW_FILE"
		alias
			"deep_clone"
		end

	read_stream (nb_char: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"read_stream"
		end

	fd_open_read_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"fd_open_read_append"
		end

	next_line is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"next_line"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RAW_FILE"
		alias
			"standard_equal"
		end

	putchar (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"putchar"
		end

	is_plain_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_plain_text"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL signature (System.Char, System.Int32): System.Int32 use Implementation.RAW_FILE"
		alias
			"index_of"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"position"
		end

	coalesce_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"coalesce_period"
		end

	is_access_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_access_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_close (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$close"
		end

	putdouble (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.RAW_FILE"
		alias
			"putdouble"
		end

	put (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"put"
		end

	is_setuid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_setuid"
		end

	exists: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"exists"
		end

	fd_open_append (fd: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"fd_open_append"
		end

	is_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_readable"
		end

	full_collector: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"full_collector"
		end

	putreal (r: REAL) is
		external
			"IL signature (System.Single): System.Void use Implementation.RAW_FILE"
		alias
			"putreal"
		end

	make_create_read_write (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_create_read_write"
		end

	before: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"before"
		end

	extend (v: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"extend"
		end

	group_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"group_id"
		end

	read_double is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_double"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.RAW_FILE"
		alias
			"default"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"generating_type"
		end

	lastreal: REAL is
		external
			"IL signature (): System.Single use Implementation.RAW_FILE"
		alias
			"lastreal"
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
		external
			"IL signature (System.Int32): GC_INFO use Implementation.RAW_FILE"
		alias
			"gc_statistics"
		end

	finish is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"finish"
		end

	remove is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"remove"
		end

	set_memory_threshold (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_memory_threshold"
		end

	inode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"inode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.RAW_FILE"
		alias
			"Equals"
		end

	append_read_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"append_read_file"
		end

	read_word is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"read_word"
		end

	collection_period: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"collection_period"
		end

	recreate_read_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"recreate_read_write"
		end

	flush is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"flush"
		end

	a_set_last_string (last_string2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"_set_last_string"
		end

	is_socket: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_socket"
		end

	a_set_internal_stream (internal_stream2: FILE_STREAM) is
		external
			"IL signature (System.IO.FileStream): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_stream"
		end

	max_mem: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"max_mem"
		end

	is_directory: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_directory"
		end

	put_character (c: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use Implementation.RAW_FILE"
		alias
			"put_character"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"full"
		end

	count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"count"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RAW_FILE"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"print"
		end

	a_set_last_integer (last_integer2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"_set_last_integer"
		end

	frozen ec_illegal_36_ec_illegal_36_c_open_modifier (current_: RAW_FILE): INTEGER is
		external
			"IL static signature (RAW_FILE): System.Int32 use Implementation.RAW_FILE"
		alias
			"$$c_open_modifier"
		end

	allocate_tiny is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"allocate_tiny"
		end

	false_string: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"false_string"
		end

	readword is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"readword"
		end

	set_collection_period (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_collection_period"
		end

	c_retrieved (file_handle: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.RAW_FILE"
		alias
			"c_retrieved"
		end

	reopen_write (fname: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"reopen_write"
		end

	a_set_internal_sread (internal_sread2: TEXT_READER) is
		external
			"IL signature (System.IO.TextReader): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_sread"
		end

	frozen ec_illegal_36_ec_illegal_36_putint (current_: RAW_FILE; i: INTEGER) is
		external
			"IL static signature (RAW_FILE, System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"$$putint"
		end

	frozen ec_illegal_36_ec_illegal_36_readint (current_: RAW_FILE) is
		external
			"IL static signature (RAW_FILE): System.Void use Implementation.RAW_FILE"
		alias
			"$$readint"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"copy"
		end

	a_set_internal_breader (internal_breader2: BINARY_READER) is
		external
			"IL signature (System.IO.BinaryReader): System.Void use Implementation.RAW_FILE"
		alias
			"_set_internal_breader"
		end

	open_read is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"open_read"
		end

	set_date (time: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.RAW_FILE"
		alias
			"set_date"
		end

	make_open_read_append (fn: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.RAW_FILE"
		alias
			"make_open_read_append"
		end

	is_plain: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_plain"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RAW_FILE"
		alias
			"internal_copy"
		end

	create_read_write is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"create_read_write"
		end

	back is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"back"
		end

	eiffel_memory: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"eiffel_memory"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"is_empty"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL signature (SEQUENCE_CHAR): System.Void use Implementation.RAW_FILE"
		alias
			"append"
		end

	get_fd (hdl: INTEGER; omode: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.Int32): System.Int32 use Implementation.RAW_FILE"
		alias
			"get_fd"
		end

	tenure: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"tenure"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.RAW_FILE"
		alias
			"generator"
		end

	read_write_file: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"read_write_file"
		end

	descriptor: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RAW_FILE"
		alias
			"descriptor"
		end

	descriptor_available: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RAW_FILE"
		alias
			"descriptor_available"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.RAW_FILE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_RAW_FILE
