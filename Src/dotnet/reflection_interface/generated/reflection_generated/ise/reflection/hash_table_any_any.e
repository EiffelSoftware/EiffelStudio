indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "HASH_TABLE_ANY_ANY"

deferred external class
	HASH_TABLE_ANY_ANY

inherit
	COLLECTION_ANY
	BOX_ANY
	BAG_ANY
	CONTAINER_ANY
	TABLE_ANY_ANY
	UNBOUNDED_ANY
	FINITE_ANY

feature -- Basic Operations

	content: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use HASH_TABLE_ANY_ANY"
		alias
			"content"
		end

	a_set_capacity (capacity2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_capacity"
		end

	conflict_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"conflict_constant"
		end

	start is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"start"
		end

	key_at (n: INTEGER): HASHABLE is
		external
			"IL deferred signature (System.Int32): HASHABLE use HASH_TABLE_ANY_ANY"
		alias
			"key_at"
		end

	found_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"found_constant"
		end

	control: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"control"
		end

	a_set_found_item (found_item2: ANY) is
		external
			"IL deferred signature (ANY): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_found_item"
		end

	set_inserted is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_inserted"
		end

	set_found is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_found"
		end

	extra_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"extra_space"
		end

	conflict: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"conflict"
		end

	a_set_deleted_position (deleted_position2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_deleted_position"
		end

	set_not_found is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_not_found"
		end

	go_to (c: CURSOR) is
		external
			"IL deferred signature (CURSOR): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"go_to"
		end

	keys: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use HASH_TABLE_ANY_ANY"
		alias
			"keys"
		end

	a_set_control (control2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_control"
		end

	deleted (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"deleted"
		end

	set_conflict is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_conflict"
		end

	found: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"found"
		end

	initial_position (hash_value: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"initial_position"
		end

	make (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"make"
		end

	to_next_candidate (increment: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"to_next_candidate"
		end

	removed_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"removed_constant"
		end

	found_item: ANY is
		external
			"IL deferred signature (): ANY use HASH_TABLE_ANY_ANY"
		alias
			"found_item"
		end

	replaced_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"replaced_constant"
		end

	set_removed is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_removed"
		end

	occupied (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"occupied"
		end

	set_content (c: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_content"
		end

	forth is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"forth"
		end

	inserted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"inserted"
		end

	set_default is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_default"
		end

	iteration_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"iteration_position"
		end

	set_no_status is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_no_status"
		end

	a_set_iteration_position (iteration_position2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_iteration_position"
		end

	search_for_insertion (key: HASHABLE) is
		external
			"IL deferred signature (HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"search_for_insertion"
		end

	add_space is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"add_space"
		end

	internal_search (key: HASHABLE) is
		external
			"IL deferred signature (HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"internal_search"
		end

	remove (key: HASHABLE) is
		external
			"IL deferred signature (HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"remove"
		end

	force (new: ANY; key: HASHABLE) is
		external
			"IL deferred signature (ANY, HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"force"
		end

	item_for_iteration: ANY is
		external
			"IL deferred signature (): ANY use HASH_TABLE_ANY_ANY"
		alias
			"item_for_iteration"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"after"
		end

	extend_any_hashable (new: ANY; key: HASHABLE) is
		external
			"IL deferred signature (ANY, HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"extend"
		end

	replaced: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"replaced"
		end

	replace_key (new_key: HASHABLE; old_key: HASHABLE) is
		external
			"IL deferred signature (HASHABLE, HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"replace_key"
		end

	max_occupation: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"max_occupation"
		end

	soon_full: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"soon_full"
		end

	accommodate (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"accommodate"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"capacity"
		end

	initial_occupation: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"initial_occupation"
		end

	cursor: CURSOR is
		external
			"IL deferred signature (): CURSOR use HASH_TABLE_ANY_ANY"
		alias
			"cursor"
		end

	set_keys (c: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_keys"
		end

	deleted_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"deleted_position"
		end

	count_int32: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"count"
		end

	valid_cursor (c: CURSOR): BOOLEAN is
		external
			"IL deferred signature (CURSOR): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"valid_cursor"
		end

	a_set_keys (keys2: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_keys"
		end

	impossible_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"impossible_position"
		end

	key_for_iteration: HASHABLE is
		external
			"IL deferred signature (): HASHABLE use HASH_TABLE_ANY_ANY"
		alias
			"key_for_iteration"
		end

	a_set_content (content2: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_content"
		end

	position_increment (hash_value: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"position_increment"
		end

	not_found_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"not_found_constant"
		end

	not_found: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"not_found"
		end

	truly_occupied (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"truly_occupied"
		end

	set_not_deleted (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_not_deleted"
		end

	used_slot_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"used_slot_count"
		end

	position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"position"
		end

	special_status: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"special_status"
		end

	replace (new: ANY; key: HASHABLE) is
		external
			"IL deferred signature (ANY, HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"replace"
		end

	computed_default_value: ANY is
		external
			"IL deferred signature (): ANY use HASH_TABLE_ANY_ANY"
		alias
			"computed_default_value"
		end

	has_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"has_default"
		end

	set_deleted (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_deleted"
		end

	a_set_deleted_marks (deleted_marks2: ARRAY_BOOLEAN) is
		external
			"IL deferred signature (ARRAY_BOOLEAN): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_deleted_marks"
		end

	minimum_capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"minimum_capacity"
		end

	a_set_count (count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_count"
		end

	deleted_marks: ARRAY_BOOLEAN is
		external
			"IL deferred signature (): ARRAY_BOOLEAN use HASH_TABLE_ANY_ANY"
		alias
			"deleted_marks"
		end

	removed: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"removed"
		end

	has_hashable (key: HASHABLE): BOOLEAN is
		external
			"IL deferred signature (HASHABLE): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"has"
		end

	computed_default_key: HASHABLE is
		external
			"IL deferred signature (): HASHABLE use HASH_TABLE_ANY_ANY"
		alias
			"computed_default_key"
		end

	put_at_position (new: ANY; key: HASHABLE) is
		external
			"IL deferred signature (ANY, HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"put_at_position"
		end

	a_set_has_default (has_default2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_has_default"
		end

	current_keys: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use HASH_TABLE_ANY_ANY"
		alias
			"current_keys"
		end

	remove_at_position is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"remove_at_position"
		end

	set_deleted_marks (d: ARRAY_BOOLEAN) is
		external
			"IL deferred signature (ARRAY_BOOLEAN): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_deleted_marks"
		end

	a_set_used_slot_count (used_slot_count2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_used_slot_count"
		end

	off: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"off"
		end

	inserted_constant: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HASH_TABLE_ANY_ANY"
		alias
			"inserted_constant"
		end

	a_set_position (position2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"_set_position"
		end

	default_key_value: ANY is
		external
			"IL deferred signature (): ANY use HASH_TABLE_ANY_ANY"
		alias
			"default_key_value"
		end

	search_item: ANY is
		external
			"IL deferred signature (): ANY use HASH_TABLE_ANY_ANY"
		alias
			"search_item"
		end

	is_off_position (pos: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use HASH_TABLE_ANY_ANY"
		alias
			"is_off_position"
		end

	set_replaced is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_replaced"
		end

	search (key: HASHABLE) is
		external
			"IL deferred signature (HASHABLE): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"search"
		end

	set_no_default is
		external
			"IL deferred signature (): System.Void use HASH_TABLE_ANY_ANY"
		alias
			"set_no_default"
		end

end -- class HASH_TABLE_ANY_ANY
