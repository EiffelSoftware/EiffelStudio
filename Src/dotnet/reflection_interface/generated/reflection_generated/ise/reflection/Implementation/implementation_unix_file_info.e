indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.UNIX_FILE_INFO"

external class
	IMPLEMENTATION_UNIX_FILE_INFO

inherit
	TO_SPECIAL_CHAR
		rename
			make_area as make_buffered_file_info,
			a_set_area as a_set_buffered_file_info,
			area as buffered_file_info
		end
	UNIX_FILE_INFO
		rename
			make_area as make_buffered_file_info,
			a_set_area as a_set_buffered_file_info,
			area as buffered_file_info
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.UNIX_FILE_INFO"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_is_owner: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_is_writable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_writable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_readable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_readable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_owner: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_access_owner"
		end

	frozen ec_illegal_36_ec_illegal_36_is_plain: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_plain"
		end

	frozen ec_illegal_36_ec_illegal_36_date: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$date"
		end

	frozen ec_illegal_36_ec_illegal_36_file_name: STRING is
		external
			"IL field signature :STRING use Implementation.UNIX_FILE_INFO"
		alias
			"$$file_name"
		end

	frozen ec_illegal_36_ec_illegal_36_protection: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$protection"
		end

	frozen ec_illegal_36_ec_illegal_36_is_device: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_device"
		end

	frozen ec_illegal_36_ec_illegal_36_is_fifo: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_fifo"
		end

	frozen ec_illegal_36_ec_illegal_36_user_id: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$user_id"
		end

	frozen ec_illegal_36_ec_illegal_36_is_block: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_block"
		end

	frozen ec_illegal_36_ec_illegal_36_is_socket: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_socket"
		end

	frozen ec_illegal_36_ec_illegal_36_size: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$size"
		end

	frozen ec_illegal_36_ec_illegal_36_is_setgid: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_setgid"
		end

	frozen ec_illegal_36_ec_illegal_36_is_directory: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_directory"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_readable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_access_readable"
		end

	frozen ec_illegal_36_ec_illegal_36_group_id: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$group_id"
		end

	frozen ec_illegal_36_ec_illegal_36_is_executable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_executable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_writable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_access_writable"
		end

	frozen ec_illegal_36_ec_illegal_36_is_character: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_character"
		end

	frozen ec_illegal_36_ec_illegal_36_inode: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$inode"
		end

	frozen ec_illegal_36_ec_illegal_36_is_sticky: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_sticky"
		end

	frozen ec_illegal_36_ec_illegal_36_links: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$links"
		end

	frozen ec_illegal_36_ec_illegal_36_change_date: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$change_date"
		end

	frozen ec_illegal_36_ec_illegal_36_is_setuid: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_setuid"
		end

	frozen ec_illegal_36_ec_illegal_36_device_type: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$device_type"
		end

	frozen ec_illegal_36_ec_illegal_36_access_date: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$access_date"
		end

	frozen ec_illegal_36_ec_illegal_36_device: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$device"
		end

	frozen ec_illegal_36_ec_illegal_36_owner_name: STRING is
		external
			"IL field signature :STRING use Implementation.UNIX_FILE_INFO"
		alias
			"$$owner_name"
		end

	frozen ec_illegal_36_ec_illegal_36_is_symlink: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_symlink"
		end

	frozen ec_illegal_36_ec_illegal_36_is_access_executable: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"$$is_access_executable"
		end

	frozen ec_illegal_36_ec_illegal_36_buffered_file_info: SPECIAL_CHAR is
		external
			"IL field signature :SPECIAL_CHAR use Implementation.UNIX_FILE_INFO"
		alias
			"$$buffered_file_info"
		end

	frozen ec_illegal_36_ec_illegal_36_group_name: STRING is
		external
			"IL field signature :STRING use Implementation.UNIX_FILE_INFO"
		alias
			"$$group_name"
		end

	frozen ec_illegal_36_ec_illegal_36_type: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"$$type"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.UNIX_FILE_INFO"
		alias
			"operating_environment"
		end

	is_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_owner"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNIX_FILE_INFO"
		alias
			"____class_name"
		end

	update (f_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"update"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"default_create"
		end

	is_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_writable"
		end

	a_set_device (device2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_device"
		end

	is_symlink: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_symlink"
		end

	a_set_is_symlink (is_symlink2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_symlink"
		end

	a_set_is_plain (is_plain2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_plain"
		end

	date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"date"
		end

	is_device: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_device"
		end

	a_set_is_executable (is_executable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_executable"
		end

	make_buffered_file_info (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"make_buffered_file_info"
		end

	a_set_size (size2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_size"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"copy"
		end

	device: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"device"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"generating_type"
		end

	protection: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"protection"
		end

	put (v: CHARACTER; i: INTEGER) is
		external
			"IL signature (System.Char, System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"put"
		end

	a_set_owner_name (owner_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_owner_name"
		end

	item (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.UNIX_FILE_INFO"
		alias
			"item"
		end

	is_socket: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_socket"
		end

	is_access_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_access_executable"
		end

	file_name: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"file_name"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"out"
		end

	device_type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"device_type"
		end

	inode: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"inode"
		end

	type: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"type"
		end

	frozen ec_illegal_36_ec_illegal_36_update (current_: UNIX_FILE_INFO; f_name: STRING) is
		external
			"IL static signature (UNIX_FILE_INFO, STRING): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"$$update"
		end

	a_set_links (links2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_links"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"make"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: UNIX_FILE_INFO) is
		external
			"IL static signature (UNIX_FILE_INFO): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"$$make"
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"valid_index"
		end

	a_set_is_access_owner (is_access_owner2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_access_owner"
		end

	a_set_is_writable (is_writable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_writable"
		end

	a_set_is_sticky (is_sticky2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_sticky"
		end

	links: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"links"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.UNIX_FILE_INFO"
		alias
			"io"
		end

	a_set_is_setuid (is_setuid2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_setuid"
		end

	is_sticky: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_sticky"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"tagged_out"
		end

	a_set_is_access_executable (is_access_executable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_access_executable"
		end

	is_block: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_block"
		end

	is_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_readable"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"do_nothing"
		end

	a_set_device_type (device_type2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_device_type"
		end

	a_set_is_socket (is_socket2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_socket"
		end

	is_access_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_access_readable"
		end

	owner_name: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"owner_name"
		end

	a_set_is_setgid (is_setgid2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_setgid"
		end

	group_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"group_id"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"deep_equal"
		end

	is_character: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_character"
		end

	a_set_is_block (is_block2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_block"
		end

	a_set_is_device (is_device2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_device"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"standard_is_equal"
		end

	a_set_inode (inode2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_inode"
		end

	change_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"change_date"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"Equals"
		end

	a_set_file_name (file_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_file_name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"equal"
		end

	a_set_buffered_file_info (buffered_file_info2: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_buffered_file_info"
		end

	a_set_date (date2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_date"
		end

	a_set_access_date (access_date2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_access_date"
		end

	infix "@" (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use Implementation.UNIX_FILE_INFO"
		alias
			"infix "@""
		end

	user_id: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"user_id"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.UNIX_FILE_INFO"
		alias
			"default_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.UNIX_FILE_INFO"
		alias
			"default"
		end

	a_set_is_directory (is_directory2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_directory"
		end

	is_directory: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_directory"
		end

	a_set_is_access_writable (is_access_writable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_access_writable"
		end

	a_set_group_name (group_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_group_name"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_equal"
		end

	is_access_owner: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_access_owner"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"print"
		end

	is_plain: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_plain"
		end

	a_set_is_access_readable (is_access_readable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_access_readable"
		end

	is_setuid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_setuid"
		end

	a_set_is_readable (is_readable2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_readable"
		end

	a_set_type (type2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_type"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNIX_FILE_INFO"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"standard_equal"
		end

	is_fifo: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_fifo"
		end

	a_set_change_date (change_date2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_change_date"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"standard_copy"
		end

	is_setgid: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_setgid"
		end

	size: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"size"
		end

	a_set_protection (protection2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_protection"
		end

	a_set_is_character (is_character2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_character"
		end

	is_access_writable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_access_writable"
		end

	is_executable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNIX_FILE_INFO"
		alias
			"is_executable"
		end

	buffered_file_info: SPECIAL_CHAR is
		external
			"IL signature (): SPECIAL_CHAR use Implementation.UNIX_FILE_INFO"
		alias
			"buffered_file_info"
		end

	access_date: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"access_date"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNIX_FILE_INFO"
		alias
			"GetHashCode"
		end

	a_set_is_fifo (is_fifo2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_fifo"
		end

	set_area (other: SPECIAL_CHAR) is
		external
			"IL signature (SPECIAL_CHAR): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"set_area"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNIX_FILE_INFO"
		alias
			"standard_clone"
		end

	a_set_user_id (user_id2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_user_id"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.UNIX_FILE_INFO"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNIX_FILE_INFO"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"internal_copy"
		end

	a_set_group_id (group_id2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_group_id"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNIX_FILE_INFO"
		alias
			"ToString"
		end

	group_name: STRING is
		external
			"IL signature (): STRING use Implementation.UNIX_FILE_INFO"
		alias
			"group_name"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"deep_copy"
		end

	a_set_is_owner (is_owner2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"_set_is_owner"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.UNIX_FILE_INFO"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_UNIX_FILE_INFO
