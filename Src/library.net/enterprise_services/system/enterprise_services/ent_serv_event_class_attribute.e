indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.EventClassAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_EVENT_CLASS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_event_class_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_event_class_attribute is
		external
			"IL creator use System.EnterpriseServices.EventClassAttribute"
		end

feature -- Access

	frozen get_publisher_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.EventClassAttribute"
		alias
			"get_PublisherFilter"
		end

	frozen get_allow_inproc_subscribers: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.EventClassAttribute"
		alias
			"get_AllowInprocSubscribers"
		end

	frozen get_fire_in_parallel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.EventClassAttribute"
		alias
			"get_FireInParallel"
		end

feature -- Element Change

	frozen set_allow_inproc_subscribers (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.EventClassAttribute"
		alias
			"set_AllowInprocSubscribers"
		end

	frozen set_publisher_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.EventClassAttribute"
		alias
			"set_PublisherFilter"
		end

	frozen set_fire_in_parallel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.EventClassAttribute"
		alias
			"set_FireInParallel"
		end

end -- class ENT_SERV_EVENT_CLASS_ATTRIBUTE
