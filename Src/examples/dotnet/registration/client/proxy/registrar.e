indexing
	Generator: "Eiffel Emitter v2809.1"

external class
	REGISTRAR
alias
	"Registrar"

inherit
	SYSTEM_WEB_SERVICES_PROTOCOLS_SOAPCLIENTPROTOCOL

create
	make_registrar

feature {NONE} -- Initialization

	make_registrar is
		external
			"IL creator use Registrar"
		end

feature -- Basic Operations

	frozen EndStart (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndStart"
		end

	frozen BeginLast_operation_successful (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginLast_operation_successful"
		end

	frozen BeginSet_last_operation_successful (success: BOOLEAN; callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginSet_last_operation_successful"
		end

	frozen EndAdd_registration (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndAdd_registration"
		end

	frozen BeginAdd_registrant (address_form: STRING; first_name: STRING; last_name: STRING; company_name: STRING; address: STRING; city: STRING; state: STRING; zip: STRING; country: STRING; callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginAdd_registrant"
		end

	frozen BeginLast_registrant_identifier (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginLast_registrant_identifier"
		end

	frozen Add_registrant (address_form: STRING; first_name: STRING; last_name: STRING; company_name: STRING; address: STRING; city: STRING; state: STRING; zip: STRING; country: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String): System.Void use Registrar"
		alias
			"Add_registrant"
		end

	frozen EndRegistrations_database (asyncResult: SYSTEM_IASYNCRESULT): DATABASE_SYSTEM_OBJECT_SYSTEM_INT32 is
		external
			"IL signature (System.IAsyncResult): DataBase_System_Object_System_Int32 use Registrar"
		alias
			"EndRegistrations_database"
		end

	frozen Last_error_message: STRING is
		external
			"IL signature (): System.String use Registrar"
		alias
			"Last_error_message"
		end

	frozen Last_registrant_identifier: INTEGER is
		external
			"IL signature (): System.Int32 use Registrar"
		alias
			"Last_registrant_identifier"
		end

	frozen BeginLast_error_message (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginLast_error_message"
		end

	frozen BeginRegistrations_database (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginRegistrations_database"
		end

	frozen Set_last_error_message (message: STRING) is
		external
			"IL signature (System.String): System.Void use Registrar"
		alias
			"Set_last_error_message"
		end

	frozen BeginSet_last_registrant_identifier (id: INTEGER; callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginSet_last_registrant_identifier"
		end

	frozen Begin_invariant (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"Begin_invariant"
		end

	frozen EndLast_error_message (asyncResult: SYSTEM_IASYNCRESULT): STRING is
		external
			"IL signature (System.IAsyncResult): System.String use Registrar"
		alias
			"EndLast_error_message"
		end

	frozen EndLast_registrant_identifier (asyncResult: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use Registrar"
		alias
			"EndLast_registrant_identifier"
		end

	frozen a_invariant is
		external
			"IL signature (): System.Void use Registrar"
		alias
			"_invariant"
		end

	frozen Set_last_operation_successful (success: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Registrar"
		alias
			"Set_last_operation_successful"
		end

	frozen Set_last_registrant_identifier (id: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use Registrar"
		alias
			"Set_last_registrant_identifier"
		end

	frozen Registrants_database: DATABASE_SYSTEM_OBJECT_SYSTEM_INT32 is
		external
			"IL signature (): DataBase_System_Object_System_Int32 use Registrar"
		alias
			"Registrants_database"
		end

	frozen End_invariant (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"End_invariant"
		end

	frozen Registrations_database: DATABASE_SYSTEM_OBJECT_SYSTEM_INT32 is
		external
			"IL signature (): DataBase_System_Object_System_Int32 use Registrar"
		alias
			"Registrations_database"
		end

	frozen BeginStart (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginStart"
		end

	frozen BeginSet_last_error_message (message: STRING; callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginSet_last_error_message"
		end

	frozen EndSet_last_operation_successful (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndSet_last_operation_successful"
		end

	frozen EndRegistrants_database (asyncResult: SYSTEM_IASYNCRESULT): DATABASE_SYSTEM_OBJECT_SYSTEM_INT32 is
		external
			"IL signature (System.IAsyncResult): DataBase_System_Object_System_Int32 use Registrar"
		alias
			"EndRegistrants_database"
		end

	frozen EndAdd_registrant (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndAdd_registrant"
		end

	frozen EndSet_last_error_message (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndSet_last_error_message"
		end

	frozen Add_registration (registrant_id: INTEGER; quantity: STRING; discount_plan: STRING; preconf: BOOLEAN; wet: BOOLEAN; conference: BOOLEAN; esummit: BOOLEAN; postconf: BOOLEAN) is
		external
			"IL signature (System.Int32, System.String, System.String, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.Boolean): System.Void use Registrar"
		alias
			"Add_registration"
		end

	frozen Last_operation_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use Registrar"
		alias
			"Last_operation_successful"
		end

	frozen EndSet_last_registrant_identifier (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Registrar"
		alias
			"EndSet_last_registrant_identifier"
		end

	frozen BeginRegistrants_database (callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginRegistrants_database"
		end

	frozen EndLast_operation_successful (asyncResult: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use Registrar"
		alias
			"EndLast_operation_successful"
		end

	frozen BeginAdd_registration (registrant_id: INTEGER; quantity: STRING; discount_plan: STRING; preconf: BOOLEAN; wet: BOOLEAN; conference: BOOLEAN; esummit: BOOLEAN; postconf: BOOLEAN; callback: SYSTEM_ASYNCCALLBACK; asyncState: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Int32, System.String, System.String, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use Registrar"
		alias
			"BeginAdd_registration"
		end

	frozen Start is
		external
			"IL signature (): System.Void use Registrar"
		alias
			"Start"
		end

end -- class REGISTRAR