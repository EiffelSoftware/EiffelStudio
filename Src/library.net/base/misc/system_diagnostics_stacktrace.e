indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.StackTrace"

external class
	SYSTEM_DIAGNOSTICS_STACKTRACE

inherit
	ANY
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

	frozen make_7 (e: SYSTEM_EXCEPTION; skip_frames: INTEGER; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Exception, System.Int32, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_6 (e: SYSTEM_EXCEPTION; skip_frames: INTEGER) is
		external
			"IL creator signature (System.Exception, System.Int32) use System.Diagnostics.StackTrace"
		end

	frozen make_5 (e: SYSTEM_EXCEPTION; f_need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Exception, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_4 (e: SYSTEM_EXCEPTION) is
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

	frozen make_9 (target_thread: SYSTEM_THREADING_THREAD; need_file_info: BOOLEAN) is
		external
			"IL creator signature (System.Threading.Thread, System.Boolean) use System.Diagnostics.StackTrace"
		end

	frozen make_8 (frame: SYSTEM_DIAGNOSTICS_STACKFRAME) is
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

	frozen methods_to_skip: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Diagnostics.StackTrace"
		alias
			"METHODS_TO_SKIP"
		end

feature -- Basic Operations

	get_frame (index: INTEGER): SYSTEM_DIAGNOSTICS_STACKFRAME is
		external
			"IL signature (System.Int32): System.Diagnostics.StackFrame use System.Diagnostics.StackTrace"
		alias
			"GetFrame"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.StackTrace"
		alias
			"ToString"
		end

end -- class SYSTEM_DIAGNOSTICS_STACKTRACE
