indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignerAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGNERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals_object
		end

create
	make_designerattribute,
	make_designerattribute_3,
	make_designerattribute_2,
	make_designerattribute_4,
	make_designerattribute_1

feature {NONE} -- Initialization

	frozen make_designerattribute (designer_type_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_designerattribute_3 (designer_type_name: STRING; designer_base_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_designerattribute_2 (designer_type_name: STRING; designer_base_type_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_designerattribute_4 (designer_type: SYSTEM_TYPE; designer_base_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_designerattribute_1 (designer_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.DesignerAttribute"
		end

feature -- Access

	frozen get_designer_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerAttribute"
		alias
			"get_DesignerTypeName"
		end

	frozen get_designer_base_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerAttribute"
		alias
			"get_DesignerBaseTypeName"
		end

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.DesignerAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignerAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNERATTRIBUTE
