indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RefreshPropertiesAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_REFRESHPROPERTIESATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_refreshpropertiesattribute

feature {NONE} -- Initialization

	frozen make_refreshpropertiesattribute (refresh: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES) is
		external
			"IL creator signature (System.ComponentModel.RefreshProperties) use System.ComponentModel.RefreshPropertiesAttribute"
		end

feature -- Access

	frozen All_: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIESATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"All"
		end

	frozen default: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIESATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Default"
		end

	frozen repaint: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIESATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Repaint"
		end

	frozen get_refresh_properties: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES is
		external
			"IL signature (): System.ComponentModel.RefreshProperties use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"get_RefreshProperties"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"GetHashCode"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_REFRESHPROPERTIESATTRIBUTE
