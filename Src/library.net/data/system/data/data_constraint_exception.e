indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ConstraintException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_CONSTRAINT_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_constraint_exception_1,
	make_data_constraint_exception

feature {NONE} -- Initialization

	frozen make_data_constraint_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.ConstraintException"
		end

	frozen make_data_constraint_exception is
		external
			"IL creator use System.Data.ConstraintException"
		end

end -- class DATA_CONSTRAINT_EXCEPTION
