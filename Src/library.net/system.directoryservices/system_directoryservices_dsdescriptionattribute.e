indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DSDescriptionAttribute"

external class
	SYSTEM_DIRECTORYSERVICES_DSDESCRIPTIONATTRIBUTE

inherit
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
		redefine
			get_description
		end

create
	make_dsdescriptionattribute

feature {NONE} -- Initialization

	frozen make_dsdescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.DirectoryServices.DSDescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DSDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_DIRECTORYSERVICES_DSDESCRIPTIONATTRIBUTE
