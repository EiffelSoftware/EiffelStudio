indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.InstanceData"

external class
	SYSTEM_DIAGNOSTICS_INSTANCEDATA

create
	make

feature {NONE} -- Initialization

	frozen make (instance_name: STRING; sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE) is
		external
			"IL creator signature (System.String, System.Diagnostics.CounterSample) use System.Diagnostics.InstanceData"
		end

feature -- Access

	frozen get_raw_value: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.InstanceData"
		alias
			"get_RawValue"
		end

	frozen get_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE is
		external
			"IL signature (): System.Diagnostics.CounterSample use System.Diagnostics.InstanceData"
		alias
			"get_Sample"
		end

	frozen get_instance_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.InstanceData"
		alias
			"get_InstanceName"
		end

end -- class SYSTEM_DIAGNOSTICS_INSTANCEDATA
