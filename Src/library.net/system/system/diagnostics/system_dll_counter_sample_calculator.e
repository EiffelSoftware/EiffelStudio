indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.CounterSampleCalculator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_COUNTER_SAMPLE_CALCULATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen compute_counter_value (new_sample: SYSTEM_DLL_COUNTER_SAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSampleCalculator"
		alias
			"ComputeCounterValue"
		end

	frozen compute_counter_value_counter_sample_counter_sample (old_sample: SYSTEM_DLL_COUNTER_SAMPLE; new_sample: SYSTEM_DLL_COUNTER_SAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample, System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSampleCalculator"
		alias
			"ComputeCounterValue"
		end

end -- class SYSTEM_DLL_COUNTER_SAMPLE_CALCULATOR
