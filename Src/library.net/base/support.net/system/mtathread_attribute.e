indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MTAThreadAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MTATHREAD_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_mtathread_attribute

feature {NONE} -- Initialization

	frozen make_mtathread_attribute is
		external
			"IL creator use System.MTAThreadAttribute"
		end

end -- class MTATHREAD_ATTRIBUTE
