indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPREMOTINGHANDLER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_IHTTPHANDLER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		end

	frozen make_1 (type: SYSTEM_TYPE; srv_id: ANY) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpRemotingHandler"
		alias
			"Equals"
		end

	frozen process_request (context: SYSTEM_WEB_HTTPCONTEXT) is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPREMOTINGHANDLER
