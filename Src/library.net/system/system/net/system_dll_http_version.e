indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.HttpVersion"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_HTTP_VERSION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.HttpVersion"
		end

feature -- Access

	frozen version10: VERSION is
		external
			"IL static_field signature :System.Version use System.Net.HttpVersion"
		alias
			"Version10"
		end

	frozen version11: VERSION is
		external
			"IL static_field signature :System.Version use System.Net.HttpVersion"
		alias
			"Version11"
		end

end -- class SYSTEM_DLL_HTTP_VERSION
