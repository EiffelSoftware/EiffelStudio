indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "Registrar"
	assembly: "Registrar", "0.0.0.0", "neutral", ""

external class
	REGISTRAR

inherit
	SYSTEM_WEB_SERVICES_PROTOCOLS_SOAPHTTPCLIENTPROTOCOL
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE

create
	make_registrar

feature {NONE} -- Initialization

	frozen make_registrar is
		external
			"IL creator use Registrar"
		end

feature -- Basic Operations

	frozen start is
		external
			"IL signature (): System.Void use Registrar"
		alias
			"start"
		end

	frozen beginregistrations_database (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginregistrations_database"
		end

	frozen endlast_registrant_identifier (async_result: SYSTEM_IASYNCRESULT): STRING is
		external
			"IL signature (System.IAsyncResult): System.String use Registrar"
		alias
			"Endlast_registrant_identifier"
		end

	frozen beginadd_registrant (address_form: STRING; first_name: STRING; last_name: STRING; company_name: STRING; address: STRING; city: STRING; state: STRING; zip: STRING; country: STRING; callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginadd_registrant"
		end

	frozen endregistrants_database (async_result: SYSTEM_IASYNCRESULT): DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): DataBase_System_Object_System_Object use Registrar"
		alias
			"Endregistrants_database"
		end

	frozen endset_last_registrant_identifier (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endset_last_registrant_identifier"
		end

	frozen last_operation_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use Registrar"
		alias
			"last_operation_successful"
		end

	frozen endlast_operation_successful (async_result: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use Registrar"
		alias
			"Endlast_operation_successful"
		end

	frozen set_last_error_message (message: STRING) is
		external
			"IL signature (System.String): System.Void use Registrar"
		alias
			"set_last_error_message"
		end

	frozen add_registrant (address_form: STRING; first_name: STRING; last_name: STRING; company_name: STRING; address: STRING; city: STRING; state: STRING; zip: STRING; country: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String): System.Void use Registrar"
		alias
			"add_registrant"
		end

	frozen beginstart (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginstart"
		end

	frozen endadd_registrant (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endadd_registrant"
		end

	frozen beginlast_error_message (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginlast_error_message"
		end

	frozen endregistrations_database (async_result: SYSTEM_IASYNCRESULT): DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): DataBase_System_Object_System_Object use Registrar"
		alias
			"Endregistrations_database"
		end

	frozen beginlast_operation_successful (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginlast_operation_successful"
		end

	frozen beginlast_registrant_identifier (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginlast_registrant_identifier"
		end

	frozen endset_last_error_message (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endset_last_error_message"
		end

	frozen endlast_error_message (async_result: SYSTEM_IASYNCRESULT): STRING is
		external
			"IL signature (System.IAsyncResult): System.String use Registrar"
		alias
			"Endlast_error_message"
		end

	frozen endset_last_operation_successful (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endset_last_operation_successful"
		end

	frozen endstart (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endstart"
		end

	frozen set_last_operation_successful (success: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Registrar"
		alias
			"set_last_operation_successful"
		end

	frozen beginset_last_operation_successful (success: BOOLEAN; callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginset_last_operation_successful"
		end

	frozen beginset_last_error_message (message: STRING; callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginset_last_error_message"
		end

	frozen registrations_database: DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT is
		external
			"IL signature (): DataBase_System_Object_System_Object use Registrar"
		alias
			"registrations_database"
		end

	frozen beginset_last_registrant_identifier (id: STRING; callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginset_last_registrant_identifier"
		end

	frozen beginadd_registration (registrant_id: STRING; quantity: STRING; discount_plan: STRING; preconf: BOOLEAN; wet: BOOLEAN; conference: BOOLEAN; esummit: BOOLEAN; postconf: BOOLEAN; callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.String, System.String, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginadd_registration"
		end

	frozen last_registrant_identifier: STRING is
		external
			"IL signature (): System.String use Registrar"
		alias
			"last_registrant_identifier"
		end

	frozen endadd_registration (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"Endadd_registration"
		end

	frozen add_registration (registrant_id: STRING; quantity: STRING; discount_plan: STRING; preconf: BOOLEAN; wet: BOOLEAN; conference: BOOLEAN; esummit: BOOLEAN; postconf: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.String, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.Boolean): System.Void use Registrar"
		alias
			"add_registration"
		end

	frozen beginregistrants_database (callback: SYSTEM_ASYNCCALLBACK; async_state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Beginregistrants_database"
		end

	frozen registrants_database: DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT is
		external
			"IL signature (): DataBase_System_Object_System_Object use Registrar"
		alias
			"registrants_database"
		end

	frozen set_last_registrant_identifier (id: STRING) is
		external
			"IL signature (System.String): System.Void use Registrar"
		alias
			"set_last_registrant_identifier"
		end

	frozen last_error_message: STRING is
		external
			"IL signature (): System.String use Registrar"
		alias
			"last_error_message"
		end

end -- class REGISTRAR
