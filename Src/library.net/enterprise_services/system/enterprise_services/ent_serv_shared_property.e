indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SharedProperty"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SHARED_PROPERTY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.EnterpriseServices.SharedProperty"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.EnterpriseServices.SharedProperty"
		alias
			"set_Value"
		end

end -- class ENT_SERV_SHARED_PROPERTY
