indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+ClsidAttribute"

frozen external class
	CLSIDATTRIBUTE_IN_SYSTEM_WINDOWS_FORMS_AXHOST

inherit
	SYSTEM_ATTRIBUTE

create
	make_clsidattribute

feature {NONE} -- Initialization

	frozen make_clsidattribute (clsid: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.AxHost+ClsidAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost+ClsidAttribute"
		alias
			"get_Value"
		end

end -- class CLSIDATTRIBUTE_IN_SYSTEM_WINDOWS_FORMS_AXHOST
