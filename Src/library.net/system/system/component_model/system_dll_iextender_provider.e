indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IExtenderProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IEXTENDER_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	can_extend (extendee: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.IExtenderProvider"
		alias
			"CanExtend"
		end

end -- class SYSTEM_DLL_IEXTENDER_PROVIDER
