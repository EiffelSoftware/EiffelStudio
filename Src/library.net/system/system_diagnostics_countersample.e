indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.CounterSample"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_COUNTERSAMPLE

inherit
	VALUE_TYPE



feature -- Initialization

	frozen make_countersample (raw_value: INTEGER_64; base_value: INTEGER_64; counter_frequency: INTEGER_64; system_frequency: INTEGER_64; time_stamp: INTEGER_64; time_stamp100n_sec: INTEGER_64; counter_type: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE) is
		external
			"IL creator signature (System.Int64, System.Int64, System.Int64, System.Int64, System.Int64, System.Int64, System.Diagnostics.PerformanceCounterType) use System.Diagnostics.CounterSample"
		end

	frozen make_countersample_1 (raw_value: INTEGER_64; base_value: INTEGER_64; counter_frequency: INTEGER_64; system_frequency: INTEGER_64; time_stamp: INTEGER_64; time_stamp100n_sec: INTEGER_64; counter_type: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE; counter_time_stamp: INTEGER_64) is
		external
			"IL creator signature (System.Int64, System.Int64, System.Int64, System.Int64, System.Int64, System.Int64, System.Diagnostics.PerformanceCounterType, System.Int64) use System.Diagnostics.CounterSample"
		end

feature -- Access

	frozen get_counter_time_stamp: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_CounterTimeStamp"
		end

	frozen get_raw_value: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_RawValue"
		end

	frozen get_time_stamp100n_sec: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_TimeStamp100nSec"
		end

	frozen get_system_frequency: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_SystemFrequency"
		end

	frozen get_base_value: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_BaseValue"
		end

	frozen get_counter_type: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERTYPE is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterType use System.Diagnostics.CounterSample"
		alias
			"get_CounterType"
		end

	frozen get_counter_frequency: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_CounterFrequency"
		end

	frozen empty: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE is
		external
			"IL static_field signature :System.Diagnostics.CounterSample use System.Diagnostics.CounterSample"
		alias
			"Empty"
		end

	frozen get_time_stamp: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Diagnostics.CounterSample"
		alias
			"get_TimeStamp"
		end

feature -- Basic Operations

	frozen calculate (counter_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSample"
		alias
			"Calculate"
		end

	frozen calculate_counter_sample_counter_sample (counter_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE; next_counter_sample: SYSTEM_DIAGNOSTICS_COUNTERSAMPLE): REAL is
		external
			"IL static signature (System.Diagnostics.CounterSample, System.Diagnostics.CounterSample): System.Single use System.Diagnostics.CounterSample"
		alias
			"Calculate"
		end

end -- class SYSTEM_DIAGNOSTICS_COUNTERSAMPLE
