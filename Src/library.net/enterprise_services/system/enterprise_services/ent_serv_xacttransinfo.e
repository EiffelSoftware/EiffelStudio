indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.XACTTRANSINFO"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	ENT_SERV_XACTTRANSINFO

inherit
	VALUE_TYPE

feature -- Access

	frozen iso_level: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"isoLevel"
		end

	frozen uow: ENT_SERV_BOID is
		external
			"IL field signature :System.EnterpriseServices.BOID use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"uow"
		end

	frozen grf_tcsupported: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"grfTCSupported"
		end

	frozen grf_tcsupported_retaining: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"grfTCSupportedRetaining"
		end

	frozen iso_flags: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"isoFlags"
		end

	frozen grf_rmsupported_retaining: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"grfRMSupportedRetaining"
		end

	frozen grf_rmsupported: INTEGER is
		external
			"IL field signature :System.Int32 use System.EnterpriseServices.XACTTRANSINFO"
		alias
			"grfRMSupported"
		end

end -- class ENT_SERV_XACTTRANSINFO
