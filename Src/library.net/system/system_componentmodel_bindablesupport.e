indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.BindableSupport"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_BINDABLESUPPORT

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

	frozen default: SYSTEM_COMPONENTMODEL_BINDABLESUPPORT is
		external
			"IL enum signature :System.ComponentModel.BindableSupport use System.ComponentModel.BindableSupport"
		alias
			"2"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_BINDABLESUPPORT is
		external
			"IL enum signature :System.ComponentModel.BindableSupport use System.ComponentModel.BindableSupport"
		alias
			"1"
		end

	frozen no: SYSTEM_COMPONENTMODEL_BINDABLESUPPORT is
		external
			"IL enum signature :System.ComponentModel.BindableSupport use System.ComponentModel.BindableSupport"
		alias
			"0"
		end

end -- class SYSTEM_COMPONENTMODEL_BINDABLESUPPORT
