indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ExecutionEngineException"

frozen external class
	SYSTEM_EXECUTIONENGINEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_executionengineexception,
	make_executionengineexception_2,
	make_executionengineexception_1

feature {NONE} -- Initialization

	frozen make_executionengineexception is
		external
			"IL creator use System.ExecutionEngineException"
		end

	frozen make_executionengineexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ExecutionEngineException"
		end

	frozen make_executionengineexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ExecutionEngineException"
		end

end -- class SYSTEM_EXECUTIONENGINEEXCEPTION
