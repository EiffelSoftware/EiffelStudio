indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDataParameterCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDATA_PARAMETER_COLLECTION

inherit
	ILIST
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_item_string (parameter_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.Data.IDataParameterCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item_string (parameter_name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Data.IDataParameterCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at_string (parameter_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameterCollection"
		alias
			"RemoveAt"
		end

	index_of_string (parameter_name: SYSTEM_STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.IDataParameterCollection"
		alias
			"IndexOf"
		end

	contains_string (parameter_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Data.IDataParameterCollection"
		alias
			"Contains"
		end

end -- class DATA_IDATA_PARAMETER_COLLECTION
