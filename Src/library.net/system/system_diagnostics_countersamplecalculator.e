indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.CounterSampleCalculator"

frozen external class
	SYSTEM_DIAGNOSTICS_COUNTERSAMPLECALCULATOR

create {NONE}

feature -- Basic Operations

	frozen compute_counter_value (new_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSampleCalculator"
		alias
			"ComputeCounterValue"
		end

	frozen compute_counter_value_counter_sample_counter_sample (old_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE; new_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample, System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSampleCalculator"
		alias
			"ComputeCounterValue"
		end

end -- class SYSTEM_DIAGNOSTICS_COUNTERSAMPLECALCULATOR
