indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDataParameterCollection"

deferred external class
	SYSTEM_DATA_IDATAPARAMETERCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

feature -- Access

	get_item_string (parameter_name: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.Data.IDataParameterCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item_string (parameter_name: STRING; value: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Data.IDataParameterCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at_string (parameter_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDataParameterCollection"
		alias
			"RemoveAt"
		end

	index_of_string (parameter_name: STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.IDataParameterCollection"
		alias
			"IndexOf"
		end

	contains_string (parameter_name: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Data.IDataParameterCollection"
		alias
			"Contains"
		end

end -- class SYSTEM_DATA_IDATAPARAMETERCOLLECTION
