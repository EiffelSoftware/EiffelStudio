indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.Thread"

frozen external class
	SYSTEM_THREADING_THREAD

inherit
	ANY
		redefine
			finalize
		end

create
	make

feature {NONE} -- Initialization

	frozen make (start2: SYSTEM_THREADING_THREADSTART) is
		external
			"IL creator signature (System.Threading.ThreadStart) use System.Threading.Thread"
		end

feature -- Access

	frozen get_thread_state: SYSTEM_THREADING_THREADSTATE is
		external
			"IL signature (): System.Threading.ThreadState use System.Threading.Thread"
		alias
			"get_ThreadState"
		end

	frozen get_priority: SYSTEM_THREADING_THREADPRIORITY is
		external
			"IL signature (): System.Threading.ThreadPriority use System.Threading.Thread"
		alias
			"get_Priority"
		end

	frozen get_current_uiculture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Threading.Thread"
		alias
			"get_CurrentUICulture"
		end

	frozen get_is_alive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.Thread"
		alias
			"get_IsAlive"
		end

	frozen get_current_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Threading.Thread"
		alias
			"get_CurrentCulture"
		end

	frozen get_apartment_state: SYSTEM_THREADING_APARTMENTSTATE is
		external
			"IL signature (): System.Threading.ApartmentState use System.Threading.Thread"
		alias
			"get_ApartmentState"
		end

	frozen get_current_principal: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL static signature (): System.Security.Principal.IPrincipal use System.Threading.Thread"
		alias
			"get_CurrentPrincipal"
		end

	frozen get_current_context: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT is
		external
			"IL static signature (): System.Runtime.Remoting.Contexts.Context use System.Threading.Thread"
		alias
			"get_CurrentContext"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Threading.Thread"
		alias
			"get_Name"
		end

	frozen get_current_thread: SYSTEM_THREADING_THREAD is
		external
			"IL static signature (): System.Threading.Thread use System.Threading.Thread"
		alias
			"get_CurrentThread"
		end

	frozen get_is_background: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.Thread"
		alias
			"get_IsBackground"
		end

feature -- Element Change

	frozen set_priority (value: SYSTEM_THREADING_THREADPRIORITY) is
		external
			"IL signature (System.Threading.ThreadPriority): System.Void use System.Threading.Thread"
		alias
			"set_Priority"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Threading.Thread"
		alias
			"set_Name"
		end

	frozen set_current_culture (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Threading.Thread"
		alias
			"set_CurrentCulture"
		end

	frozen set_is_background (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Threading.Thread"
		alias
			"set_IsBackground"
		end

	frozen set_current_uiculture (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Threading.Thread"
		alias
			"set_CurrentUICulture"
		end

	frozen set_apartment_state (value: SYSTEM_THREADING_APARTMENTSTATE) is
		external
			"IL signature (System.Threading.ApartmentState): System.Void use System.Threading.Thread"
		alias
			"set_ApartmentState"
		end

	frozen set_current_principal (value: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL static signature (System.Security.Principal.IPrincipal): System.Void use System.Threading.Thread"
		alias
			"set_CurrentPrincipal"
		end

feature -- Basic Operations

	frozen start is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Start"
		end

	frozen get_named_data_slot (name: STRING): SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Threading.Thread"
		alias
			"GetNamedDataSlot"
		end

	frozen get_data (slot: SYSTEM_LOCALDATASTORESLOT): ANY is
		external
			"IL static signature (System.LocalDataStoreSlot): System.Object use System.Threading.Thread"
		alias
			"GetData"
		end

	frozen reset_abort is
		external
			"IL static signature (): System.Void use System.Threading.Thread"
		alias
			"ResetAbort"
		end

	frozen join_time_span (timeout: SYSTEM_TIMESPAN): BOOLEAN is
		external
			"IL signature (System.TimeSpan): System.Boolean use System.Threading.Thread"
		alias
			"Join"
		end

	frozen interrupt is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Interrupt"
		end

	frozen join_int32 (milliseconds_timeout: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Threading.Thread"
		alias
			"Join"
		end

	frozen sleep_int32 (milliseconds_timeout: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Threading.Thread"
		alias
			"Sleep"
		end

	frozen get_domain: SYSTEM_APPDOMAIN is
		external
			"IL static signature (): System.AppDomain use System.Threading.Thread"
		alias
			"GetDomain"
		end

	frozen abort_object (state_info: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Threading.Thread"
		alias
			"Abort"
		end

	frozen allocate_data_slot: SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (): System.LocalDataStoreSlot use System.Threading.Thread"
		alias
			"AllocateDataSlot"
		end

	frozen resume is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Resume"
		end

	frozen set_data (slot: SYSTEM_LOCALDATASTORESLOT; data: ANY) is
		external
			"IL static signature (System.LocalDataStoreSlot, System.Object): System.Void use System.Threading.Thread"
		alias
			"SetData"
		end

	frozen join is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Join"
		end

	frozen suspend is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Suspend"
		end

	frozen allocate_named_data_slot (name: STRING): SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Threading.Thread"
		alias
			"AllocateNamedDataSlot"
		end

	frozen get_domain_id: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Threading.Thread"
		alias
			"GetDomainID"
		end

	frozen abort is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Abort"
		end

	frozen sleep (timeout: SYSTEM_TIMESPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Threading.Thread"
		alias
			"Sleep"
		end

	frozen free_named_data_slot (name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Threading.Thread"
		alias
			"FreeNamedDataSlot"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Finalize"
		end

end -- class SYSTEM_THREADING_THREAD
