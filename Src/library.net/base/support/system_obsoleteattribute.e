indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ObsoleteAttribute"

frozen external class
	SYSTEM_OBSOLETEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_obsoleteattribute,
	make_obsoleteattribute_1,
	make_obsoleteattribute_2

feature {NONE} -- Initialization

	frozen make_obsoleteattribute is
		external
			"IL creator use System.ObsoleteAttribute"
		end

	frozen make_obsoleteattribute_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ObsoleteAttribute"
		end

	frozen make_obsoleteattribute_2 (message: STRING; error: BOOLEAN) is
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

	frozen get_message: STRING is
		external
			"IL signature (): System.String use System.ObsoleteAttribute"
		alias
			"get_Message"
		end

end -- class SYSTEM_OBSOLETEATTRIBUTE
