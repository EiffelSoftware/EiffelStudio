indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SynchronizationOption"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION

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

	frozen supported: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationOption"
		alias
			"2"
		end

	frozen requires_new: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationOption"
		alias
			"4"
		end

	frozen not_supported: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationOption"
		alias
			"1"
		end

	frozen required: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationOption"
		alias
			"3"
		end

	frozen disabled: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationOption"
		alias
			"0"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION
