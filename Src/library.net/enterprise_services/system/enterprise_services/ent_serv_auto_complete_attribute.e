indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.AutoCompleteAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_AUTO_COMPLETE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_auto_complete_attribute,
	make_ent_serv_auto_complete_attribute_1

feature {NONE} -- Initialization

	frozen make_ent_serv_auto_complete_attribute is
		external
			"IL creator use System.EnterpriseServices.AutoCompleteAttribute"
		end

	frozen make_ent_serv_auto_complete_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.AutoCompleteAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.AutoCompleteAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_AUTO_COMPLETE_ATTRIBUTE
