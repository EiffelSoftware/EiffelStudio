indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataSysDescriptionAttribute"

external class
	SYSTEM_DATA_DATASYSDESCRIPTIONATTRIBUTE

inherit
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
		redefine
			get_description
		end

create
	make_datasysdescriptionattribute

feature {NONE} -- Initialization

	frozen make_datasysdescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataSysDescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.Data.DataSysDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_DATA_DATASYSDESCRIPTIONATTRIBUTE
