indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ResolveEventArgs"

external class
	SYSTEM_RESOLVEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_resolveeventargs

feature {NONE} -- Initialization

	frozen make_resolveeventargs (name: STRING) is
		external
			"IL creator signature (System.String) use System.ResolveEventArgs"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.ResolveEventArgs"
		alias
			"get_Name"
		end

end -- class SYSTEM_RESOLVEEVENTARGS
