indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.MonitoringDescriptionAttribute"

external class
	SYSTEM_DIAGNOSTICS_MONITORINGDESCRIPTIONATTRIBUTE

inherit
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
		redefine
			get_description
		end

create
	make_monitoringdescriptionattribute

feature {NONE} -- Initialization

	frozen make_monitoringdescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.MonitoringDescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.MonitoringDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_DIAGNOSTICS_MONITORINGDESCRIPTIONATTRIBUTE
