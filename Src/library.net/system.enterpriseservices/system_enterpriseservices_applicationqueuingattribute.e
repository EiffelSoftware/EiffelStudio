indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ApplicationQueuingAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_APPLICATIONQUEUINGATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_applicationqueuingattribute

feature {NONE} -- Initialization

	frozen make_applicationqueuingattribute is
		external
			"IL creator use System.EnterpriseServices.ApplicationQueuingAttribute"
		end

feature -- Access

	frozen get_max_listener_threads: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"get_MaxListenerThreads"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"get_Enabled"
		end

	frozen get_queue_listener_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"get_QueueListenerEnabled"
		end

feature -- Element Change

	frozen set_queue_listener_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"set_QueueListenerEnabled"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"set_Enabled"
		end

	frozen set_max_listener_threads (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.EnterpriseServices.ApplicationQueuingAttribute"
		alias
			"set_MaxListenerThreads"
		end

end -- class SYSTEM_ENTERPRISESERVICES_APPLICATIONQUEUINGATTRIBUTE
