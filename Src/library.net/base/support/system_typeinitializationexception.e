indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.TypeInitializationException"

frozen external class
	SYSTEM_TYPEINITIALIZATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_typeinitializationexception

feature {NONE} -- Initialization

	frozen make_typeinitializationexception (full_type_name: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeInitializationException"
		end

feature -- Access

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.TypeInitializationException"
		alias
			"get_TypeName"
		end

end -- class SYSTEM_TYPEINITIALIZATIONEXCEPTION
