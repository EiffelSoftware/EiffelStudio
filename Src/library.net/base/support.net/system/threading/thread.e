indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.Thread"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	THREAD

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create
	make

feature {NONE} -- Initialization

	frozen make (start2: THREAD_START) is
		external
			"IL creator signature (System.Threading.ThreadStart) use System.Threading.Thread"
		end

feature -- Access

	frozen get_thread_state: THREAD_STATE is
		external
			"IL signature (): System.Threading.ThreadState use System.Threading.Thread"
		alias
			"get_ThreadState"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Threading.Thread"
		alias
			"get_Name"
		end

	frozen get_priority: THREAD_PRIORITY is
		external
			"IL signature (): System.Threading.ThreadPriority use System.Threading.Thread"
		alias
			"get_Priority"
		end

	frozen get_is_alive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.Thread"
		alias
			"get_IsAlive"
		end

	frozen get_current_culture: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Threading.Thread"
		alias
			"get_CurrentCulture"
		end

	frozen get_is_thread_pool_thread: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.Thread"
		alias
			"get_IsThreadPoolThread"
		end

	frozen get_apartment_state: APARTMENT_STATE is
		external
			"IL signature (): System.Threading.ApartmentState use System.Threading.Thread"
		alias
			"get_ApartmentState"
		end

	frozen get_current_principal: IPRINCIPAL is
		external
			"IL static signature (): System.Security.Principal.IPrincipal use System.Threading.Thread"
		alias
			"get_CurrentPrincipal"
		end

	frozen get_current_context: CONTEXT is
		external
			"IL static signature (): System.Runtime.Remoting.Contexts.Context use System.Threading.Thread"
		alias
			"get_CurrentContext"
		end

	frozen get_current_uiculture: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Threading.Thread"
		alias
			"get_CurrentUICulture"
		end

	frozen get_current_thread: THREAD is
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

	frozen set_priority (value: THREAD_PRIORITY) is
		external
			"IL signature (System.Threading.ThreadPriority): System.Void use System.Threading.Thread"
		alias
			"set_Priority"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Threading.Thread"
		alias
			"set_Name"
		end

	frozen set_current_culture (value: CULTURE_INFO) is
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

	frozen set_current_uiculture (value: CULTURE_INFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Threading.Thread"
		alias
			"set_CurrentUICulture"
		end

	frozen set_apartment_state (value: APARTMENT_STATE) is
		external
			"IL signature (System.Threading.ApartmentState): System.Void use System.Threading.Thread"
		alias
			"set_ApartmentState"
		end

	frozen set_current_principal (value: IPRINCIPAL) is
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

	frozen get_named_data_slot (name: SYSTEM_STRING): LOCAL_DATA_STORE_SLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Threading.Thread"
		alias
			"GetNamedDataSlot"
		end

	frozen get_data (slot: LOCAL_DATA_STORE_SLOT): SYSTEM_OBJECT is
		external
			"IL static signature (System.LocalDataStoreSlot): System.Object use System.Threading.Thread"
		alias
			"GetData"
		end

	frozen get_domain_id: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Threading.Thread"
		alias
			"GetDomainID"
		end

	frozen reset_abort is
		external
			"IL static signature (): System.Void use System.Threading.Thread"
		alias
			"ResetAbort"
		end

	frozen join_time_span (timeout: TIME_SPAN): BOOLEAN is
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

	frozen get_domain: APP_DOMAIN is
		external
			"IL static signature (): System.AppDomain use System.Threading.Thread"
		alias
			"GetDomain"
		end

	frozen abort_object (state_info: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Threading.Thread"
		alias
			"Abort"
		end

	frozen allocate_data_slot: LOCAL_DATA_STORE_SLOT is
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

	frozen set_data (slot: LOCAL_DATA_STORE_SLOT; data: SYSTEM_OBJECT) is
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

	frozen allocate_named_data_slot (name: SYSTEM_STRING): LOCAL_DATA_STORE_SLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Threading.Thread"
		alias
			"AllocateNamedDataSlot"
		end

	frozen spin_wait (iterations: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Threading.Thread"
		alias
			"SpinWait"
		end

	frozen abort is
		external
			"IL signature (): System.Void use System.Threading.Thread"
		alias
			"Abort"
		end

	frozen sleep (timeout: TIME_SPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Threading.Thread"
		alias
			"Sleep"
		end

	frozen free_named_data_slot (name: SYSTEM_STRING) is
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

end -- class THREAD
