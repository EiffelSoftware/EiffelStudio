indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RefreshProperties"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES

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

	frozen All_: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES is
		external
			"IL enum signature :System.ComponentModel.RefreshProperties use System.ComponentModel.RefreshProperties"
		alias
			"1"
		end

	frozen repaint: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES is
		external
			"IL enum signature :System.ComponentModel.RefreshProperties use System.ComponentModel.RefreshProperties"
		alias
			"2"
		end

	frozen none: SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES is
		external
			"IL enum signature :System.ComponentModel.RefreshProperties use System.ComponentModel.RefreshProperties"
		alias
			"0"
		end

end -- class SYSTEM_COMPONENTMODEL_REFRESHPROPERTIES
