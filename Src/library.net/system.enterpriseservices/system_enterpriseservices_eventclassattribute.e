indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.EventClassAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_EVENTCLASSATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_eventclassattribute

feature {NONE} -- Initialization

	frozen make_eventclassattribute is
		external
			"IL creator use System.EnterpriseServices.EventClassAttribute"
		end

feature -- Access

	frozen get_publisher_filter: STRING is
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

	frozen set_publisher_filter (value: STRING) is
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

end -- class SYSTEM_ENTERPRISESERVICES_EVENTCLASSATTRIBUTE
