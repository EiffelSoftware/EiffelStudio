indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignerSerializationVisibility"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen content: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY is
		external
			"IL enum signature :System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.DesignerSerializationVisibility"
		alias
			"2"
		end

	frozen hidden: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY is
		external
			"IL enum signature :System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.DesignerSerializationVisibility"
		alias
			"0"
		end

	frozen visible: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY is
		external
			"IL enum signature :System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.DesignerSerializationVisibility"
		alias
			"1"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY
