indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.StackTrace"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STACK_TRACE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make,
	make_7,
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make_1,
	make_9,
	make_8

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.StackTrace"
		end

	frozen make_7 (e: EXCEPTION; skip_frames: INTEGER; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Exception, System.Int32, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_6 (e: EXCEPTION; skip_frames: INTEGER) is
		external
			"IL creator signature (System.Exception, System.Int32) use System.Diagnostics.StackTrace"
		end

	frozen make_5 (e: EXCEPTION; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Exception, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_4 (e: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Diagnostics.StackTrace"
		end

	frozen make_3 (skip_frames: INTEGER; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_2 (skip_frames: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Diagnostics.StackTrace"
		end

	frozen make_1 (f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_9 (target_thread: THREAD; need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Threading.Thread, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_8 (frame: STACK_FRAME) is
		external
			"IL creator signature (System.Diagnostics.StackFrame) use System.Diagnostics.StackTrace"
		end

feature -- Access

	get_frame_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.StackTrace"
		alias
			"get_FrameCount"
		end

	frozen methods_to_skip: INTEGER is 0x0

feature -- Basic Operations

	get_frame (index: INTEGER): STACK_FRAME is
		external
			"IL signature (System.Int32): System.Diagnostics.StackFrame use System.Diagnostics.StackTrace"
		alias
			"GetFrame"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.StackTrace"
		alias
			"ToString"
		end

end -- class STACK_TRACE
