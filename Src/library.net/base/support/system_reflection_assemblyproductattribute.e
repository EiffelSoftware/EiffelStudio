indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyProductAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYPRODUCTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblyproductattribute

feature {NONE} -- Initialization

	frozen make_assemblyproductattribute (product: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyProductAttribute"
		end

feature -- Access

	frozen get_product: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyProductAttribute"
		alias
			"get_Product"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYPRODUCTATTRIBUTE
