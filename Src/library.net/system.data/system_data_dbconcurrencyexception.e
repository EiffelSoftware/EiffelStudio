indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DBConcurrencyException"

frozen external class
	SYSTEM_DATA_DBCONCURRENCYEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_dbconcurrencyexception_1,
	make_dbconcurrencyexception

feature {NONE} -- Initialization

	frozen make_dbconcurrencyexception_1 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.DBConcurrencyException"
		end

	frozen make_dbconcurrencyexception (message: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DBConcurrencyException"
		end

feature -- Access

	frozen get_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DBConcurrencyException"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_row (value: SYSTEM_DATA_DATAROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DBConcurrencyException"
		alias
			"set_Row"
		end

end -- class SYSTEM_DATA_DBCONCURRENCYEXCEPTION
