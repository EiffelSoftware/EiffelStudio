indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.HASH_TABLE_ANY_ANY"

external class
	IMPLEMENTATION_HASH_TABLE_ANY_ANY

inherit
	CONTAINER_ANY
		rename
			has as has_item
		end
	HASH_TABLE_ANY_ANY
		rename
			count as count_int32,
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	TABLE_ANY_ANY
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
	COLLECTION_ANY
		rename
			has as has_item,
			wipe_out as clear_all,
			extend as collection_extend,
			put as bag_put
		end
	BAG_ANY
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
			"IL creator use Implementation.HASH_TABLE_ANY_ANY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_found_item: ANY is
		external
			"IL field signature :ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$found_item"
		end

	frozen ec_illegal_36_ec_illegal_36_keys: ARRAY_ANY is
		external
			"IL field signature :ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$keys"
		end

	frozen ec_illegal_36_ec_illegal_36_has_default: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$has_default"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted_marks: ARRAY_BOOLEAN is
		external
			"IL field signature :ARRAY_BOOLEAN use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_control: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$control"
		end

	frozen ec_illegal_36_ec_illegal_36_capacity: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_content: ARRAY_ANY is
		external
			"IL field signature :ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$content"
		end

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$object_comparison"
		end

	frozen ec_illegal_36_ec_illegal_36_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$count"
		end

	frozen ec_illegal_36_ec_illegal_36_iteration_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$iteration_position"
		end

	frozen ec_illegal_36_ec_illegal_36_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$position"
		end

	frozen ec_illegal_36_ec_illegal_36_used_slot_count: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$used_slot_count"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted_position: INTEGER is
		external
			"IL field signature :System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$deleted_position"
		end

feature -- Basic Operations

	frozen ec_illegal_36_ec_illegal_36_replace_key (current_: HASH_TABLE_ANY_ANY; new_key: HASHABLE; old_key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$replace_key"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"conforms_to"
		end

	go_to (c: CURSOR) is
		external
			"IL signature (CURSOR): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_conflict_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$conflict_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_at_position (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$remove_at_position"
		end

	conflict: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"conflict"
		end

	a_set_keys (keys2: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_keys"
		end

	content: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"content"
		end

	forth is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"forth"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"object_comparison"
		end

	control: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"control"
		end

	set_default is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_default"
		end

	truly_occupied (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"truly_occupied"
		end

	has_item (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"has_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_deleted (current_: HASH_TABLE_ANY_ANY; i: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_occupied (current_: HASH_TABLE_ANY_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$occupied"
		end

	not_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"not_found"
		end

	prune (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"prune"
		end

	position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"position"
		end

	frozen ec_illegal_36_ec_illegal_36_set_inserted (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_inserted"
		end

	set_not_found is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: HASH_TABLE_ANY_ANY; n: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$make"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_set_replaced (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_replaced"
		end

	a_set_has_default (has_default2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_has_default"
		end

	conflict_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"conflict_constant"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"changeable_comparison_criterion"
		end

	frozen ec_illegal_36_ec_illegal_36_after (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$after"
		end

	a_set_deleted_position (deleted_position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_deleted_position"
		end

	valid_key (k: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"valid_key"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"same_type"
		end

	deleted_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deleted_position"
		end

	replace (new: ANY; key: HASHABLE) is
		external
			"IL signature (ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"replace"
		end

	frozen ec_illegal_36_ec_illegal_36_removed (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$removed"
		end

	frozen ec_illegal_36_ec_illegal_36_extend (current_: HASH_TABLE_ANY_ANY; new: ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$extend"
		end

	set_found is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_found"
		end

	frozen ec_illegal_36_ec_illegal_36_removed_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$removed_constant"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_replaced (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$replaced"
		end

	frozen ec_illegal_36_ec_illegal_36_forth (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$forth"
		end

	frozen ec_illegal_36_ec_illegal_36_inserted_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$inserted_constant"
		end

	found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"found"
		end

	frozen ec_illegal_36_ec_illegal_36_set_not_deleted (current_: HASH_TABLE_ANY_ANY; i: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_not_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_set_removed (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_removed"
		end

	frozen ec_illegal_36_ec_illegal_36_add_space (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$add_space"
		end

	cursor: CURSOR is
		external
			"IL signature (): CURSOR use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"cursor"
		end

	replace_key (new_key: HASHABLE; old_key: HASHABLE) is
		external
			"IL signature (HASHABLE, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"replace_key"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"standard_is_equal"
		end

	linear_representation: LINEAR_ANY is
		external
			"IL signature (): LINEAR_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"linear_representation"
		end

	clear_all is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"clear_all"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"compare_objects"
		end

	frozen ec_illegal_36_ec_illegal_36_computed_default_value (current_: HASH_TABLE_ANY_ANY): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$computed_default_value"
		end

	a_set_control (control2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_control"
		end

	replaced: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"replaced"
		end

	frozen ec_illegal_36_ec_illegal_36_found_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$found_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_to_next_candidate (current_: HASH_TABLE_ANY_ANY; increment: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$to_next_candidate"
		end

	frozen ec_illegal_36_ec_illegal_36_put_at_position (current_: HASH_TABLE_ANY_ANY; new: ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$put_at_position"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"operating_environment"
		end

	put_any_any (v: ANY; k: ANY) is
		external
			"IL signature (ANY, ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"put"
		end

	internal_search (key: HASHABLE) is
		external
			"IL signature (HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"internal_search"
		end

	inserted_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"inserted_constant"
		end

	capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"capacity"
		end

	set_no_status is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_no_status"
		end

	collection_extend (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"collection_extend"
		end

	accommodate (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"accommodate"
		end

	frozen ec_illegal_36_ec_illegal_36_go_to (current_: HASH_TABLE_ANY_ANY; c: CURSOR) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, CURSOR): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$go_to"
		end

	frozen ec_illegal_36_ec_illegal_36_prunable (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$prunable"
		end

	initial_position (hash_value: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"initial_position"
		end

	position_increment (hash_value: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"position_increment"
		end

	frozen ec_illegal_36_ec_illegal_36_found (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$found"
		end

	to_next_candidate (increment: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"to_next_candidate"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"default_pointer"
		end

	bag_put (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"bag_put"
		end

	frozen ec_illegal_36_ec_illegal_36_is_off_position (current_: HASH_TABLE_ANY_ANY; pos: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$is_off_position"
		end

	has_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"has_default"
		end

	set_replaced is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_replaced"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"default_rescue"
		end

	search_item: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"search_item"
		end

	remove_at_position is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"remove_at_position"
		end

	a_set_deleted_marks (deleted_marks2: ARRAY_BOOLEAN) is
		external
			"IL signature (ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_deleted_marks"
		end

	set_not_deleted (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_not_deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_force (current_: HASH_TABLE_ANY_ANY; new: ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$force"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"tagged_out"
		end

	inserted: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_minimum_capacity (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$minimum_capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_conflict (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_default_key_value (current_: HASH_TABLE_ANY_ANY): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$default_key_value"
		end

	initial_occupation: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"initial_occupation"
		end

	a_set_iteration_position (iteration_position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_iteration_position"
		end

	a_set_capacity (capacity2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_capacity"
		end

	set_no_default is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_no_default"
		end

	frozen ec_illegal_36_ec_illegal_36_internal_search (current_: HASH_TABLE_ANY_ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$internal_search"
		end

	add_space is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"add_space"
		end

	put_at_position (new: ANY; key: HASHABLE) is
		external
			"IL signature (ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"put_at_position"
		end

	make (n: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"make"
		end

	iteration_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"iteration_position"
		end

	frozen ec_illegal_36_ec_illegal_36_remove (current_: HASH_TABLE_ANY_ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$remove"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_initial_occupation (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$initial_occupation"
		end

	extend_any_hashable (new: ANY; key: HASHABLE) is
		external
			"IL signature (ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"extend"
		end

	frozen ec_illegal_36_ec_illegal_36_truly_occupied (current_: HASH_TABLE_ANY_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$truly_occupied"
		end

	frozen ec_illegal_36_ec_illegal_36_prune (current_: HASH_TABLE_ANY_ANY; v: ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$prune"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_count"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_object_comparison"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_computed_default_key (current_: HASH_TABLE_ANY_ANY): HASHABLE is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$computed_default_key"
		end

	soon_full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"soon_full"
		end

	search_for_insertion (key: HASHABLE) is
		external
			"IL signature (HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"search_for_insertion"
		end

	frozen ec_illegal_36_ec_illegal_36_replace (current_: HASH_TABLE_ANY_ANY; new: ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$replace"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"____class_name"
		end

	count_int32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"count"
		end

	default_key_value: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"default_key_value"
		end

	frozen ec_illegal_36_ec_illegal_36_extra_space (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$extra_space"
		end

	minimum_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"minimum_capacity"
		end

	frozen ec_illegal_36_ec_illegal_36_off (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$off"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"internal_clone"
		end

	has_hashable (key: HASHABLE): BOOLEAN is
		external
			"IL signature (HASHABLE): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"has"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"do_nothing"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_key_at (current_: HASH_TABLE_ANY_ANY; n: INTEGER): HASHABLE is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$key_at"
		end

	is_off_position (pos: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"is_off_position"
		end

	prunable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"prunable"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"prune_all"
		end

	set_content (c: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_content"
		end

	deleted (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deleted"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"is_inserted"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"clone"
		end

	deleted_marks: ARRAY_BOOLEAN is
		external
			"IL signature (): ARRAY_BOOLEAN use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_initial_position (current_: HASH_TABLE_ANY_ANY; hash_value: INTEGER): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$initial_position"
		end

	a_set_used_slot_count (used_slot_count2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_used_slot_count"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_impossible_position (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$impossible_position"
		end

	frozen ec_illegal_36_ec_illegal_36_soon_full (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$soon_full"
		end

	frozen ec_illegal_36_ec_illegal_36_max_occupation (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$max_occupation"
		end

	current_keys: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"current_keys"
		end

	frozen ec_illegal_36_ec_illegal_36_key_for_iteration (current_: HASH_TABLE_ANY_ANY): HASHABLE is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$key_for_iteration"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_has_item (current_: HASH_TABLE_ANY_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$has_item"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"compare_references"
		end

	frozen ec_illegal_36_ec_illegal_36_extendible (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$extendible"
		end

	not_found_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"not_found_constant"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"Equals"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_not_found_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$not_found_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_search (current_: HASH_TABLE_ANY_ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$search"
		end

	replaced_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"replaced_constant"
		end

	infix "@" (k: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"infix "@""
		end

	force (new: ANY; key: HASHABLE) is
		external
			"IL signature (ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"force"
		end

	set_conflict is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_search_item (current_: HASH_TABLE_ANY_ANY): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$search_item"
		end

	frozen ec_illegal_36_ec_illegal_36_set_deleted_marks (current_: HASH_TABLE_ANY_ANY; d: ARRAY_BOOLEAN) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_deleted_marks"
		end

	key_for_iteration: HASHABLE is
		external
			"IL signature (): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"key_for_iteration"
		end

	occupied (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"occupied"
		end

	frozen ec_illegal_36_ec_illegal_36_has (current_: HASH_TABLE_ANY_ANY; key: HASHABLE): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$has"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deep_equal"
		end

	computed_default_key: HASHABLE is
		external
			"IL signature (): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"computed_default_key"
		end

	frozen ec_illegal_36_ec_illegal_36_set_no_status (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_no_status"
		end

	found_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"found_constant"
		end

	special_status: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"special_status"
		end

	search (key: HASHABLE) is
		external
			"IL signature (HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"search"
		end

	frozen ec_illegal_36_ec_illegal_36_start (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$start"
		end

	frozen ec_illegal_36_ec_illegal_36_accommodate (current_: HASH_TABLE_ANY_ANY; n: INTEGER) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$accommodate"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_current_keys (current_: HASH_TABLE_ANY_ANY): ARRAY_ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$current_keys"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_inserted (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_cursor (current_: HASH_TABLE_ANY_ANY): CURSOR is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): CURSOR use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$cursor"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_cursor (current_: HASH_TABLE_ANY_ANY; c: CURSOR): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, CURSOR): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$valid_cursor"
		end

	set_deleted (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_deleted"
		end

	item_for_iteration: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"item_for_iteration"
		end

	frozen ec_illegal_36_ec_illegal_36_linear_representation (current_: HASH_TABLE_ANY_ANY): ARRAYED_LIST_ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ARRAYED_LIST_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$linear_representation"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"deep_clone"
		end

	item (k: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"item"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"GetHashCode"
		end

	impossible_position: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"impossible_position"
		end

	frozen ec_illegal_36_ec_illegal_36_put (current_: HASH_TABLE_ANY_ANY; new: ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$put"
		end

	frozen ec_illegal_36_ec_illegal_36_set_no_default (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_no_default"
		end

	frozen ec_illegal_36_ec_illegal_36_item_for_iteration (current_: HASH_TABLE_ANY_ANY): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$item_for_iteration"
		end

	frozen ec_illegal_36_ec_illegal_36_set_keys (current_: HASH_TABLE_ANY_ANY; c: ARRAY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_keys"
		end

	set_deleted_marks (d: ARRAY_BOOLEAN) is
		external
			"IL signature (ARRAY_BOOLEAN): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_deleted_marks"
		end

	frozen ec_illegal_36_ec_illegal_36_set_conflict (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_conflict"
		end

	frozen ec_illegal_36_ec_illegal_36_set_not_found (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_set_default (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_default"
		end

	key_at (n: INTEGER): HASHABLE is
		external
			"IL signature (System.Int32): HASHABLE use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"key_at"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_key (current_: HASH_TABLE_ANY_ANY; k: HASHABLE): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$valid_key"
		end

	start is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"start"
		end

	after: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"after"
		end

	frozen ec_illegal_36_ec_illegal_36_item (current_: HASH_TABLE_ANY_ANY; key: HASHABLE): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$item"
		end

	used_slot_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"used_slot_count"
		end

	extra_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"extra_space"
		end

	set_keys (c: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_keys"
		end

	frozen ec_illegal_36_ec_illegal_36_set_found (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_found"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"default"
		end

	max_occupation: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"max_occupation"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: HASH_TABLE_ANY_ANY; other: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$copy"
		end

	frozen ec_illegal_36_ec_illegal_36_deleted (current_: HASH_TABLE_ANY_ANY; i: INTEGER): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$deleted"
		end

	frozen ec_illegal_36_ec_illegal_36_special_status (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$special_status"
		end

	removed: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"removed"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"empty"
		end

	frozen ec_illegal_36_ec_illegal_36_set_content (current_: HASH_TABLE_ANY_ANY; c: ARRAY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$set_content"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: HASH_TABLE_ANY_ANY; other: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$is_equal"
		end

	occurrences (v: ANY): INTEGER is
		external
			"IL signature (ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"occurrences"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_insertion (current_: HASH_TABLE_ANY_ANY; key: HASHABLE) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$search_for_insertion"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_not_found (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$not_found"
		end

	frozen ec_illegal_36_ec_illegal_36_clear_all (current_: HASH_TABLE_ANY_ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$clear_all"
		end

	frozen ec_illegal_36_ec_illegal_36_collection_extend (current_: HASH_TABLE_ANY_ANY; v: ANY) is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$collection_extend"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"standard_clone"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"print"
		end

	set_removed is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_removed"
		end

	remove (key: HASHABLE) is
		external
			"IL signature (HASHABLE): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"remove"
		end

	frozen ec_illegal_36_ec_illegal_36_occurrences (current_: HASH_TABLE_ANY_ANY; v: ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$occurrences"
		end

	computed_default_value: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"computed_default_value"
		end

	off: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"off"
		end

	keys: ARRAY_ANY is
		external
			"IL signature (): ARRAY_ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"keys"
		end

	frozen ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ec_illegal_64_ec_illegal_34_ (current_: HASH_TABLE_ANY_ANY; key: HASHABLE): ANY is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, HASHABLE): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$infix "@""
		end

	a_set_position (position2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_position"
		end

	set_inserted is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"set_inserted"
		end

	removed_constant: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"removed_constant"
		end

	frozen ec_illegal_36_ec_illegal_36_full (current_: HASH_TABLE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$full"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"internal_copy"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"is_empty"
		end

	a_set_content (content2: ARRAY_ANY) is
		external
			"IL signature (ARRAY_ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_content"
		end

	frozen ec_illegal_36_ec_illegal_36_position_increment (current_: HASH_TABLE_ANY_ANY; hash_value: INTEGER): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY, System.Int32): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$position_increment"
		end

	found_item: ANY is
		external
			"IL signature (): ANY use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"found_item"
		end

	a_set_found_item (found_item2: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"_set_found_item"
		end

	extendible: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"extendible"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_replaced_constant (current_: HASH_TABLE_ANY_ANY): INTEGER is
		external
			"IL static signature (HASH_TABLE_ANY_ANY): System.Int32 use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"$$replaced_constant"
		end

	valid_cursor (c: CURSOR): BOOLEAN is
		external
			"IL signature (CURSOR): System.Boolean use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"valid_cursor"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.HASH_TABLE_ANY_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_HASH_TABLE_ANY_ANY
