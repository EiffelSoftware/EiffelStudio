indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ActivationOption"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION

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

	frozen server: SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.ActivationOption use System.EnterpriseServices.ActivationOption"
		alias
			"1"
		end

	frozen library: SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.ActivationOption use System.EnterpriseServices.ActivationOption"
		alias
			"0"
		end

end -- class SYSTEM_ENTERPRISESERVICES_ACTIVATIONOPTION
