indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.SatelliteContractVersionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SATELLITE_CONTRACT_VERSION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_satellite_contract_version_attribute

feature {NONE} -- Initialization

	frozen make_satellite_contract_version_attribute (version: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.SatelliteContractVersionAttribute"
		end

feature -- Access

	frozen get_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.SatelliteContractVersionAttribute"
		alias
			"get_Version"
		end

end -- class SATELLITE_CONTRACT_VERSION_ATTRIBUTE
