indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ApplicationQueuingAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_APPLICATION_QUEUING_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_application_queuing_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_application_queuing_attribute is
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

end -- class ENT_SERV_APPLICATION_QUEUING_ATTRIBUTE
