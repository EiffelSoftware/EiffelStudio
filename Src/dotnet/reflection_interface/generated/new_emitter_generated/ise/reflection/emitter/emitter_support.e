indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EmitterSupport"

external class
	EMITTER_SUPPORT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use EmitterSupport"
		end

feature -- Basic Operations

	frozen to_reflection_string (str: SYSTEM_STRING): STRING is
		external
			"IL static signature (System.String): STRING use EmitterSupport"
		alias
			"ToReflectionString"
		end

	frozen from_reflection_string (str: STRING): SYSTEM_STRING is
		external
			"IL static signature (STRING): System.String use EmitterSupport"
		alias
			"FromReflectionString"
		end

end -- class EMITTER_SUPPORT
