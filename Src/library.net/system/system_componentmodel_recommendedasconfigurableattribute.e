indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RecommendedAsConfigurableAttribute"

external class
	SYSTEM_COMPONENTMODEL_RECOMMENDEDASCONFIGURABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_recommendedasconfigurableattribute

feature {NONE} -- Initialization

	frozen make_recommendedasconfigurableattribute (recommended_as_configurable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.RecommendedAsConfigurableAttribute"
		end

feature -- Access

	frozen get_recommended_as_configurable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"get_RecommendedAsConfigurable"
		end

	frozen default: SYSTEM_COMPONENTMODEL_RECOMMENDEDASCONFIGURABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_RECOMMENDEDASCONFIGURABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_RECOMMENDEDASCONFIGURABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_RECOMMENDEDASCONFIGURABLEATTRIBUTE
