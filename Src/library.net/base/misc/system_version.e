indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Version"

frozen external class
	SYSTEM_VERSION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_ICOMPARABLE

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (version: STRING) is
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Version"
		alias
			"GetHashCode"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Version"
		alias
			"Clone"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Version"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Version"
		alias
			"ToString"
		end

	frozen to_string_int32 (field_count: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Version"
		alias
			"ToString"
		end

	frozen compare_to (version: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Version"
		alias
			"CompareTo"
		end

feature -- Binary Operators

	frozen infix ">=" (v2: SYSTEM_VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (v2: SYSTEM_VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_Equality"
		end

	frozen infix "|=" (v2: SYSTEM_VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_Inequality"
		end

	frozen infix "<" (v2: SYSTEM_VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (v2: SYSTEM_VERSION): BOOLEAN is
		external
			"IL operator signature (System.Version): System.Boolean use System.Version"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (v2: SYSTEM_VERSION): BOOLEAN is
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

end -- class SYSTEM_VERSION
