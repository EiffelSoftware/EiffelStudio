indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.StackFrame"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STACK_FRAME

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (file_name: SYSTEM_STRING; line_number: INTEGER; col_number: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32) use System.Diagnostics.StackFrame"
		end

	frozen make_4 (file_name: SYSTEM_STRING; line_number: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Diagnostics.StackFrame"
		end

	frozen make_3 (skip_frames: INTEGER; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Diagnostics.StackFrame"
		end

	frozen make_2 (skip_frames: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Diagnostics.StackFrame"
		end

	frozen make is
		external
			"IL creator use System.Diagnostics.StackFrame"
		end

	frozen make_1 (f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Diagnostics.StackFrame"
		end

feature -- Access

	frozen offset_unknown: INTEGER is 0xffffffff

feature -- Basic Operations

	get_file_column_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.StackFrame"
		alias
			"GetFileColumnNumber"
		end

	get_method: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Diagnostics.StackFrame"
		alias
			"GetMethod"
		end

	get_native_offset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.StackFrame"
		alias
			"GetNativeOffset"
		end

	get_file_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.StackFrame"
		alias
			"GetFileLineNumber"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.StackFrame"
		alias
			"ToString"
		end

	get_iloffset: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.StackFrame"
		alias
			"GetILOffset"
		end

	get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.StackFrame"
		alias
			"GetFileName"
		end

end -- class STACK_FRAME
