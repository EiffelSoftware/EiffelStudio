indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IDataErrorInfo"

deferred external class
	SYSTEM_COMPONENTMODEL_IDATAERRORINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_error: STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.IDataErrorInfo"
		alias
			"get_Error"
		end

	get_item (column_name: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.ComponentModel.IDataErrorInfo"
		alias
			"get_Item"
		end

end -- class SYSTEM_COMPONENTMODEL_IDATAERRORINFO
