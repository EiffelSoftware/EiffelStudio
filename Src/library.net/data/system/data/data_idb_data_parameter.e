indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDbDataParameter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDB_DATA_PARAMETER

inherit
	DATA_IDATA_PARAMETER

feature -- Access

	get_precision: INTEGER_8 is
		external
			"IL deferred signature (): System.Byte use System.Data.IDbDataParameter"
		alias
			"get_Precision"
		end

	get_scale: INTEGER_8 is
		external
			"IL deferred signature (): System.Byte use System.Data.IDbDataParameter"
		alias
			"get_Scale"
		end

	get_size: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbDataParameter"
		alias
			"get_Size"
		end

feature -- Element Change

	set_precision (value: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use System.Data.IDbDataParameter"
		alias
			"set_Precision"
		end

	set_size (value: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Data.IDbDataParameter"
		alias
			"set_Size"
		end

	set_scale (value: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use System.Data.IDbDataParameter"
		alias
			"set_Scale"
		end

end -- class DATA_IDB_DATA_PARAMETER
