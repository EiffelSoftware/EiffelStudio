indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.SuppressUnmanagedCodeSecurityAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SUPPRESS_UNMANAGED_CODE_SECURITY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_suppress_unmanaged_code_security_attribute

feature {NONE} -- Initialization

	frozen make_suppress_unmanaged_code_security_attribute is
		external
			"IL creator use System.Security.SuppressUnmanagedCodeSecurityAttribute"
		end

end -- class SUPPRESS_UNMANAGED_CODE_SECURITY_ATTRIBUTE
