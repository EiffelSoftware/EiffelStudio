indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TO_SPECIAL_ANY"

deferred external class
	TO_SPECIAL_ANY

feature -- Basic Operations

	set_area (other: SPECIAL_ANY) is
		external
			"IL deferred signature (SPECIAL_ANY): System.Void use TO_SPECIAL_ANY"
		alias
			"set_area"
		end

	a_set_area (area2: SPECIAL_ANY) is
		external
			"IL deferred signature (SPECIAL_ANY): System.Void use TO_SPECIAL_ANY"
		alias
			"_set_area"
		end

	infix "@" (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use TO_SPECIAL_ANY"
		alias
			"infix %"@%""
		end

	valid_index (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TO_SPECIAL_ANY"
		alias
			"valid_index"
		end

	put (v: ANY; i: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use TO_SPECIAL_ANY"
		alias
			"put"
		end

	area: SPECIAL_ANY is
		external
			"IL deferred signature (): SPECIAL_ANY use TO_SPECIAL_ANY"
		alias
			"area"
		end

	item (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use TO_SPECIAL_ANY"
		alias
			"item"
		end

	make_area (n: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use TO_SPECIAL_ANY"
		alias
			"make_area"
		end

end -- class TO_SPECIAL_ANY
