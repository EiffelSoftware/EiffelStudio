indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.CLSCompliantAttribute"

frozen external class
	SYSTEM_CLSCOMPLIANTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_cls_compliant_attribute

feature {NONE} -- Initialization

	frozen make_cls_compliant_attribute (isCompliant2: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.CLSCompliantAttribute"
		end

feature -- Access

	frozen get_is_compliant: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CLSCompliantAttribute"
		alias
			"get_IsCompliant"
		end

end -- class SYSTEM_CLSCOMPLIANTATTRIBUTE
