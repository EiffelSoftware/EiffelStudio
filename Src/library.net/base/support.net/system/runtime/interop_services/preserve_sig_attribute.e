indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.PreserveSigAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PRESERVE_SIG_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_preserve_sig_attribute

feature {NONE} -- Initialization

	frozen make_preserve_sig_attribute is
		external
			"IL creator use System.Runtime.InteropServices.PreserveSigAttribute"
		end

end -- class PRESERVE_SIG_ATTRIBUTE
