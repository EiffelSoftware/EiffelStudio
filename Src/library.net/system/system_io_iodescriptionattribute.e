indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IODescriptionAttribute"

external class
	SYSTEM_IO_IODESCRIPTIONATTRIBUTE

inherit
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
		redefine
			get_description
		end

create
	make_iodescriptionattribute

feature {NONE} -- Initialization

	frozen make_iodescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.IO.IODescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.IO.IODescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_IO_IODESCRIPTIONATTRIBUTE
