indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.GCHandleType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	GCHANDLE_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen weak_track_resurrection: GCHANDLE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.GCHandleType use System.Runtime.InteropServices.GCHandleType"
		alias
			"1"
		end

	frozen weak: GCHANDLE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.GCHandleType use System.Runtime.InteropServices.GCHandleType"
		alias
			"0"
		end

	frozen normal: GCHANDLE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.GCHandleType use System.Runtime.InteropServices.GCHandleType"
		alias
			"2"
		end

	frozen pinned: GCHANDLE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.GCHandleType use System.Runtime.InteropServices.GCHandleType"
		alias
			"3"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class GCHANDLE_TYPE
