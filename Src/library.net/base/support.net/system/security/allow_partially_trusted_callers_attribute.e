indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.AllowPartiallyTrustedCallersAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ALLOW_PARTIALLY_TRUSTED_CALLERS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_allow_partially_trusted_callers_attribute

feature {NONE} -- Initialization

	frozen make_allow_partially_trusted_callers_attribute is
		external
			"IL creator use System.Security.AllowPartiallyTrustedCallersAttribute"
		end

end -- class ALLOW_PARTIALLY_TRUSTED_CALLERS_ATTRIBUTE
