indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDbCommand"

deferred external class
	SYSTEM_DATA_IDBCOMMAND

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_command_type: SYSTEM_DATA_COMMANDTYPE is
		external
			"IL deferred signature (): System.Data.CommandType use System.Data.IDbCommand"
		alias
			"get_CommandType"
		end

	get_updated_row_source: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL deferred signature (): System.Data.UpdateRowSource use System.Data.IDbCommand"
		alias
			"get_UpdatedRowSource"
		end

	get_parameters: SYSTEM_DATA_IDATAPARAMETERCOLLECTION is
		external
			"IL deferred signature (): System.Data.IDataParameterCollection use System.Data.IDbCommand"
		alias
			"get_Parameters"
		end

	get_command_text: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbCommand"
		alias
			"get_CommandText"
		end

	get_command_timeout: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbCommand"
		alias
			"get_CommandTimeout"
		end

	get_connection: SYSTEM_DATA_IDBCONNECTION is
		external
			"IL deferred signature (): System.Data.IDbConnection use System.Data.IDbCommand"
		alias
			"get_Connection"
		end

	get_transaction: SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL deferred signature (): System.Data.IDbTransaction use System.Data.IDbCommand"
		alias
			"get_Transaction"
		end

feature -- Element Change

	set_connection (value: SYSTEM_DATA_IDBCONNECTION) is
		external
			"IL deferred signature (System.Data.IDbConnection): System.Void use System.Data.IDbCommand"
		alias
			"set_Connection"
		end

	set_command_type (value: SYSTEM_DATA_COMMANDTYPE) is
		external
			"IL deferred signature (System.Data.CommandType): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandType"
		end

	set_command_timeout (value: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandTimeout"
		end

	set_command_text (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandText"
		end

	set_transaction (value: SYSTEM_DATA_IDBTRANSACTION) is
		external
			"IL deferred signature (System.Data.IDbTransaction): System.Void use System.Data.IDbCommand"
		alias
			"set_Transaction"
		end

	set_updated_row_source (value: SYSTEM_DATA_UPDATEROWSOURCE) is
		external
			"IL deferred signature (System.Data.UpdateRowSource): System.Void use System.Data.IDbCommand"
		alias
			"set_UpdatedRowSource"
		end

feature -- Basic Operations

	cancel is
		external
			"IL deferred signature (): System.Void use System.Data.IDbCommand"
		alias
			"Cancel"
		end

	execute_non_query: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbCommand"
		alias
			"ExecuteNonQuery"
		end

	create_parameter: SYSTEM_DATA_IDATAPARAMETER is
		external
			"IL deferred signature (): System.Data.IDataParameter use System.Data.IDbCommand"
		alias
			"CreateParameter"
		end

	execute_reader_command_behavior (behavior: SYSTEM_DATA_COMMANDBEHAVIOR): SYSTEM_DATA_IDATAREADER is
		external
			"IL deferred signature (System.Data.CommandBehavior): System.Data.IDataReader use System.Data.IDbCommand"
		alias
			"ExecuteReader"
		end

	execute_reader: SYSTEM_DATA_IDATAREADER is
		external
			"IL deferred signature (): System.Data.IDataReader use System.Data.IDbCommand"
		alias
			"ExecuteReader"
		end

	execute_scalar: ANY is
		external
			"IL deferred signature (): System.Object use System.Data.IDbCommand"
		alias
			"ExecuteScalar"
		end

	prepare is
		external
			"IL deferred signature (): System.Void use System.Data.IDbCommand"
		alias
			"Prepare"
		end

end -- class SYSTEM_DATA_IDBCOMMAND
