indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IListSource"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ILIST_SOURCE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_contains_list_collection: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IListSource"
		alias
			"get_ContainsListCollection"
		end

feature -- Basic Operations

	get_list: ILIST is
		external
			"IL deferred signature (): System.Collections.IList use System.ComponentModel.IListSource"
		alias
			"GetList"
		end

end -- class SYSTEM_DLL_ILIST_SOURCE
