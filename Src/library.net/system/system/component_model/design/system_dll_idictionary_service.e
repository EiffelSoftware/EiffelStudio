indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDictionaryService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDICTIONARY_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_key (value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.Design.IDictionaryService"
		alias
			"GetKey"
		end

	set_value (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.ComponentModel.Design.IDictionaryService"
		alias
			"SetValue"
		end

	get_value (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.Design.IDictionaryService"
		alias
			"GetValue"
		end

end -- class SYSTEM_DLL_IDICTIONARY_SERVICE
