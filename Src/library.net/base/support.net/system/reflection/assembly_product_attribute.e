indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyProductAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_PRODUCT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_product_attribute

feature {NONE} -- Initialization

	frozen make_assembly_product_attribute (product: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AssemblyProductAttribute"
		end

feature -- Access

	frozen get_product: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyProductAttribute"
		alias
			"get_Product"
		end

end -- class ASSEMBLY_PRODUCT_ATTRIBUTE
