indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ThreadStaticAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	THREAD_STATIC_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_thread_static_attribute

feature {NONE} -- Initialization

	frozen make_thread_static_attribute is
		external
			"IL creator use System.ThreadStaticAttribute"
		end

end -- class THREAD_STATIC_ATTRIBUTE
