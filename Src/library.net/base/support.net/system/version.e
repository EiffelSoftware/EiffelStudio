indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Version"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	VERSION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ICOMPARABLE

create
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_4 is
		external
			"IL creator use System.Version"
		end

	frozen make_3 (version: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Version"
		end

	frozen make_2 (major: INTEGER; minor: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Version"
		end

	frozen make (major: INTEGER; minor: INTEGER; build: INTEGER; revision: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Version"
		end

	frozen make_1 (major: INTEGER; minor: INTEGER; build: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.Version"
		end

feature -- Access

	frozen get_revision: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"get_Revision"
		end

	frozen get_minor: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"get_Minor"
		end

	frozen get_build: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"get_Build"
		end

	frozen get_major: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"get_Major"
		end

feature -- Basic Operations

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Version"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"GetHashCode"
		end

	frozen to_string_int32 (field_count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Version"
		alias
			"ToString"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Version"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Version"
		alias
			"Clone"
		end

	frozen compare_to (version: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Version"
		alias
			"CompareTo"
		end

feature -- Binary Operators

	frozen infix ">=" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_Equality"
		end

	frozen infix "|=" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_Inequality"
		end

	frozen infix "<" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (v2: VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_GreaterThan"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Version"
		alias
			"Finalize"
		end

end -- class VERSION
