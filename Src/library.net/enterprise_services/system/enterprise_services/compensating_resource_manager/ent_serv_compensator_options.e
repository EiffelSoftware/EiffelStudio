indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_COMPENSATOR_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen abort_phase: ENT_SERV_COMPENSATOR_OPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"4"
		end

	frozen commit_phase: ENT_SERV_COMPENSATOR_OPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"2"
		end

	frozen all_phases: ENT_SERV_COMPENSATOR_OPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"7"
		end

	frozen prepare_phase: ENT_SERV_COMPENSATOR_OPTIONS is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions use System.EnterpriseServices.CompensatingResourceManager.CompensatorOptions"
		alias
			"1"
		end

	frozen fail_if_in_doubts_remain: ENT_SERV_COMPENSATOR_OPTIONS is
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

end -- class ENT_SERV_COMPENSATOR_OPTIONS
