indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.HASH_TABLE_ANY_INT32"

external class
	IMPLEMENTATION_HASH_TABLE_ANY_INT32

inherit
	CONTAINER_ANY
		rename
			has as has_item
		end
	BAG_ANY
		rename
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	FINITE_ANY
		rename
			count as count_int32,
			has as has_item
		end
	HASH_TABLE_ANY_INT32
		rename
			count as count_int32,
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	BOX_ANY
		rename
			has as has_item
		end
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	TABLE_ANY_INT32
		rename
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	COLLECTION_ANY
		rename
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	UNBOUNDED_ANY
		rename
			count as count_int32,
			has as has_item
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.HASH_TABLE_ANY_INT32"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_found_item: ANY is
		external
			"IL field signature :ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$found_item"
		end

	frozen ec_illegal_36_ec_illegal_36_keys: ARRAY_INT32 is
		external
			"IL field signature :ARRAY_INT32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$keys"
		end

	frozen ec_illegal_36_ec_illegal_36_has_default: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$has_default"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted_marks: ARRAY_BOOLEAN is
		external
			"IL field signature :ARRAY_BOOLEAN use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_control: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$control"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_content: ARRAY_ANY is
		external
			"IL field signature :ARRAY_ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$content"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_iteration_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$iteration_position"
		end

	frozen ec_illegal_36_ec_illegal_36_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$position"
		end

	frozen ec_illegal_36_ec_illegal_36_used_slot_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$used_slot_count"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$deleted_position"
		end

feature -- Basic Operations

	frozen ec_illegal_36_ec_illegal_36_replace_key (current_: HASH_TABLE_ANY_INT32; new_key: INTEGER; old_key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$replace_key"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"conforms_to"
		end

	go_to (c: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_conflict_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$conflict_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_at_position (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$remove_at_position"
		end

	conflict: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"conflict"
		end

	a_set_keys (keys2: ARRAY_INT32) is
		external
			"IL signature (ARRAY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_keys"
		end

	content: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"content"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"forth"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"object_comparison"
		end

	control: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"control"
		end

	set_default is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_default"
		end

	truly_occupied (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"truly_occupied"
		end

	has_item (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"has_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_deleted (current_: HASH_TABLE_ANY_INT32; i: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_occupied (current_: HASH_TABLE_ANY_INT32; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$occupied"
		end

	not_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"not_found"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"prune"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"position"
		end

	frozen ec_illegal_36_ec_illegal_36_set_inserted (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_inserted"
		end

	set_not_found is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: HASH_TABLE_ANY_INT32; n: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_set_replaced (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_replaced"
		end

	a_set_has_default (has_default2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_has_default"
		end

	conflict_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"conflict_constant"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"changeable_comparison_criterion"
		end

	frozen ec_illegal_36_ec_illegal_36_after (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$after"
		end

	a_set_deleted_position (deleted_position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_deleted_position"
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"valid_key"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"same_type"
		end

	deleted_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deleted_position"
		end

	replace (new: ANY; key: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"replace"
		end

	frozen ec_illegal_36_ec_illegal_36_removed (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$removed"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: HASH_TABLE_ANY_INT32; new: ANY; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$extend"
		end

	set_found is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_found"
		end

	frozen ec_illegal_36_ec_illegal_36_removed_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$removed_constant"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_replaced (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$replaced"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$forth"
		end

	frozen ec_illegal_36_ec_illegal_36_inserted_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$inserted_constant"
		end

	found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"found"
		end

	frozen ec_illegal_36_ec_illegal_36_set_not_deleted (current_: HASH_TABLE_ANY_INT32; i: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_not_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_set_removed (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_removed"
		end

	frozen ec_illegal_36_ec_illegal_36_add_space (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$add_space"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"cursor"
		end

	replace_key (new_key: INTEGER; old_key: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"replace_key"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_computed_default_value (current_: HASH_TABLE_ANY_INT32): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$computed_default_value"
		end

	a_set_control (control2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_control"
		end

	replaced: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"replaced"
		end

	frozen ec_illegal_36_ec_illegal_36_found_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$found_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_to_next_candidate (current_: HASH_TABLE_ANY_INT32; increment: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$to_next_candidate"
		end

	frozen ec_illegal_36_ec_illegal_36_put_at_position (current_: HASH_TABLE_ANY_INT32; new: ANY; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$put_at_position"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"operating_environment"
		end

	internal_search (key: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"internal_search"
		end

	inserted_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"inserted_constant"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"capacity"
		end

	set_no_status is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_no_status"
		end

	collection_extend (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"collection_extend"
		end

	accommodate (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"accommodate"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: HASH_TABLE_ANY_INT32; c: CURSOR) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, CURSOR): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$go_to"
		end

	has_int32 (key: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"has"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$prunable"
		end

	initial_position (hash_value: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"initial_position"
		end

	position_increment (hash_value: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"position_increment"
		end

	frozen ec_illegal_36_ec_illegal_36_found (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$found"
		end

	to_next_candidate (increment: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"to_next_candidate"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"default_pointer"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_is_off_position (current_: HASH_TABLE_ANY_INT32; pos: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$is_off_position"
		end

	has_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"has_default"
		end

	set_replaced is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_replaced"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"default_rescue"
		end

	search_item: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"search_item"
		end

	remove_at_position is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"remove_at_position"
		end

	a_set_deleted_marks (deleted_marks2: ARRAY_BOOLEAN) is
		external
			"IL signature (ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_deleted_marks"
		end

	set_not_deleted (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_not_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: HASH_TABLE_ANY_INT32; new: ANY; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$force"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"tagged_out"
		end

	inserted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_minimum_capacity (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$minimum_capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_conflict (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_default_key_value (current_: HASH_TABLE_ANY_INT32): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$default_key_value"
		end

	initial_occupation: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"initial_occupation"
		end

	a_set_iteration_position (iteration_position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_iteration_position"
		end

	a_set_capacity (capacity2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_capacity"
		end

	set_no_default is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_no_default"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_search (current_: HASH_TABLE_ANY_INT32; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$internal_search"
		end

	add_space is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"add_space"
		end

	put_at_position (new: ANY; key: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"put_at_position"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"make"
		end

	iteration_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"iteration_position"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: HASH_TABLE_ANY_INT32; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$remove"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_initial_occupation (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$initial_occupation"
		end

	frozen ec_illegal_36_ec_illegal_36_truly_occupied (current_: HASH_TABLE_ANY_INT32; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$truly_occupied"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: HASH_TABLE_ANY_INT32; v: ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$prune"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_computed_default_key (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$computed_default_key"
		end

	soon_full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"soon_full"
		end

	search_for_insertion (key: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"search_for_insertion"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: HASH_TABLE_ANY_INT32; new: ANY; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$replace"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"____class_name"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"count"
		end

	default_key_value: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"default_key_value"
		end

	frozen ec_illegal_36_ec_illegal_36_extra_space (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$extra_space"
		end

	put_any_int32 (v: ANY; k: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"put"
		end

	minimum_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"minimum_capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$off"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"internal_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"do_nothing"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_key_at (current_: HASH_TABLE_ANY_INT32; n: INTEGER): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$key_at"
		end

	is_off_position (pos: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"is_off_position"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"prunable"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"prune_all"
		end

	set_content (c: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_content"
		end

	deleted (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deleted"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"is_inserted"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"clone"
		end

	deleted_marks: ARRAY_BOOLEAN is
		external
			"IL signature (): ARRAY_BOOLEAN use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_initial_position (current_: HASH_TABLE_ANY_INT32; hash_value: INTEGER): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$initial_position"
		end

	a_set_used_slot_count (used_slot_count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_used_slot_count"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_impossible_position (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$impossible_position"
		end

	frozen ec_illegal_36_ec_illegal_36_soon_full (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$soon_full"
		end

	frozen ec_illegal_36_ec_illegal_36_max_occupation (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$max_occupation"
		end

	current_keys: ARRAY_INT32 is
		external
			"IL signature (): ARRAY_INT32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"current_keys"
		end

	frozen ec_illegal_36_ec_illegal_36_key_for_iteration (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$key_for_iteration"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_has_item (current_: HASH_TABLE_ANY_INT32; v: ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$has_item"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"compare_references"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$extendible"
		end

	not_found_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"not_found_constant"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"Equals"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_not_found_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$not_found_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: HASH_TABLE_ANY_INT32; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$search"
		end

	replaced_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"replaced_constant"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"infix "@""
		end

	force (new: ANY; key: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"force"
		end

	set_conflict is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_search_item (current_: HASH_TABLE_ANY_INT32): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$search_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_deleted_marks (current_: HASH_TABLE_ANY_INT32; d: ARRAY_BOOLEAN) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_deleted_marks"
		end

	key_for_iteration: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"key_for_iteration"
		end

	occupied (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"occupied"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: HASH_TABLE_ANY_INT32; key: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$has"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deep_equal"
		end

	computed_default_key: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"computed_default_key"
		end

	frozen ec_illegal_36_ec_illegal_36_set_no_status (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_no_status"
		end

	found_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"found_constant"
		end

	special_status: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"special_status"
		end

	search (key: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_accommodate (current_: HASH_TABLE_ANY_INT32; n: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$accommodate"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_current_keys (current_: HASH_TABLE_ANY_INT32): ARRAY_INT32 is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ARRAY_INT32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$current_keys"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_inserted (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: HASH_TABLE_ANY_INT32): CURSOR is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): CURSOR use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$cursor"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: HASH_TABLE_ANY_INT32; c: CURSOR): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, CURSOR): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$valid_cursor"
		end

	set_deleted (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_deleted"
		end

	item_for_iteration: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"item_for_iteration"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: HASH_TABLE_ANY_INT32): ARRAYED_LIST_ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ARRAYED_LIST_ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$linear_representation"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"deep_clone"
		end

	item (k: INTEGER): ANY is
		external
			"IL signature (System.Int32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"item"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"GetHashCode"
		end

	impossible_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"impossible_position"
		end

	frozen ec_illegal_36_ec_illegal_36_set_no_default (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_no_default"
		end

	frozen ec_illegal_36_ec_illegal_36_item_for_iteration (current_: HASH_TABLE_ANY_INT32): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$item_for_iteration"
		end

	frozen ec_illegal_36_ec_illegal_36_set_keys (current_: HASH_TABLE_ANY_INT32; c: ARRAY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ARRAY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_keys"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: HASH_TABLE_ANY_INT32; new: ANY; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$put"
		end

	set_deleted_marks (d: ARRAY_BOOLEAN) is
		external
			"IL signature (ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_set_conflict (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_set_not_found (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_set_default (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_default"
		end

	key_at (n: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"key_at"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_key (current_: HASH_TABLE_ANY_INT32; k: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$valid_key"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"start"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"after"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: HASH_TABLE_ANY_INT32; key: INTEGER): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$item"
		end

	used_slot_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"used_slot_count"
		end

	extra_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"extra_space"
		end

	set_keys (c: ARRAY_INT32) is
		external
			"IL signature (ARRAY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_keys"
		end

	frozen ec_illegal_36_ec_illegal_36_set_found (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_found"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"default"
		end

	max_occupation: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"max_occupation"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: HASH_TABLE_ANY_INT32; other: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$copy"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted (current_: HASH_TABLE_ANY_INT32; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_special_status (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$special_status"
		end

	removed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"removed"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"empty"
		end

	frozen ec_illegal_36_ec_illegal_36_set_content (current_: HASH_TABLE_ANY_INT32; c: ARRAY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$set_content"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: HASH_TABLE_ANY_INT32; other: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$is_equal"
		end

	occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"occurrences"
		end

	extend_any_int32 (new: ANY; key: INTEGER) is
		external
			"IL signature (ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_insertion (current_: HASH_TABLE_ANY_INT32; key: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$search_for_insertion"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_not_found (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: HASH_TABLE_ANY_INT32) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$clear_all"
		end

	frozen ec_illegal_36_ec_illegal_36_collection_extend (current_: HASH_TABLE_ANY_INT32; v: ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$collection_extend"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"print"
		end

	set_removed is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_removed"
		end

	remove (key: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: HASH_TABLE_ANY_INT32; v: ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, ANY): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$occurrences"
		end

	computed_default_value: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"computed_default_value"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"off"
		end

	keys: ARRAY_INT32 is
		external
			"IL signature (): ARRAY_INT32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"keys"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: HASH_TABLE_ANY_INT32; key: INTEGER): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$infix "@""
		end

	a_set_position (position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_position"
		end

	set_inserted is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"set_inserted"
		end

	removed_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"removed_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: HASH_TABLE_ANY_INT32): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"internal_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"is_empty"
		end

	a_set_content (content2: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_content"
		end

	frozen ec_illegal_36_ec_illegal_36_position_increment (current_: HASH_TABLE_ANY_INT32; hash_value: INTEGER): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32, System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$position_increment"
		end

	found_item: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"found_item"
		end

	a_set_found_item (found_item2: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"_set_found_item"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"extendible"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_replaced_constant (current_: HASH_TABLE_ANY_INT32): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_INT32): System.Int32 use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"$$replaced_constant"
		end

	valid_cursor (c: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_INT32"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_HASH_TABLE_ANY_INT32
