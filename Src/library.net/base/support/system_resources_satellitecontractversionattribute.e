indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.SatelliteContractVersionAttribute"

frozen external class
	SYSTEM_RESOURCES_SATELLITECONTRACTVERSIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_satellitecontractversionattribute

feature {NONE} -- Initialization

	frozen make_satellitecontractversionattribute (version: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.SatelliteContractVersionAttribute"
		end

feature -- Access

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Resources.SatelliteContractVersionAttribute"
		alias
			"get_Version"
		end

end -- class SYSTEM_RESOURCES_SATELLITECONTRACTVERSIONATTRIBUTE
