indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_HTTP_REMOTING_HANDLER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_IHTTP_HANDLER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		end

	frozen make_1 (type: TYPE; srv_id: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Type, System.Object) use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		end

feature -- Access

	frozen get_is_reusable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"get_IsReusable"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"Equals"
		end

	frozen process_request (context: WEB_HTTP_CONTEXT) is
		external
			"IL signature (System.Web.HttpContext): System.Void use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"ProcessRequest"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_HTTP_REMOTING_HANDLER
