indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS

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

	frozen abort_phase: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"4"
		end

	frozen commit_phase: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"2"
		end

	frozen all_phases: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"7"
		end

	frozen prepare_phase: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"1"
		end

	frozen fail_if_in_doubts_remain: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_COMPENSATOROPTIONS
