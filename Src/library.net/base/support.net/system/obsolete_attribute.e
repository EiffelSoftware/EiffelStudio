indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ObsoleteAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	OBSOLETE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_obsolete_attribute_1,
	make_obsolete_attribute,
	make_obsolete_attribute_2

feature {NONE} -- Initialization

	frozen make_obsolete_attribute_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ObsoleteAttribute"
		end

	frozen make_obsolete_attribute is
		external
			"IL creator use System.ObsoleteAttribute"
		end

	frozen make_obsolete_attribute_2 (message: SYSTEM_STRING; error: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.ObsoleteAttribute"
		end

feature -- Access

	frozen get_is_error: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ObsoleteAttribute"
		alias
			"get_IsError"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ObsoleteAttribute"
		alias
			"get_Message"
		end

end -- class OBSOLETE_ATTRIBUTE
