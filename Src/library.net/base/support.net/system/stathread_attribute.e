indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.STAThreadAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STATHREAD_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_stathread_attribute

feature {NONE} -- Initialization

	frozen make_stathread_attribute is
		external
			"IL creator use System.STAThreadAttribute"
		end

end -- class STATHREAD_ATTRIBUTE
