indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesigntimeLicenseContextSerializer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNTIME_LICENSE_CONTEXT_SERIALIZER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen serialize (o: SYSTEM_STREAM; crypto_key: SYSTEM_STRING; context: SYSTEM_DLL_DESIGNTIME_LICENSE_CONTEXT) is
		external
			"IL static signature (System.IO.Stream, System.String, System.ComponentModel.Design.DesigntimeLicenseContext): System.Void use System.ComponentModel.Design.DesigntimeLicenseContextSerializer"
		alias
			"Serialize"
		end

end -- class SYSTEM_DLL_DESIGNTIME_LICENSE_CONTEXT_SERIALIZER
