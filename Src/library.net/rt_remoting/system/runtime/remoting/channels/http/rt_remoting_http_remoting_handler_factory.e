indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_HTTP_REMOTING_HANDLER_FACTORY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_IHTTP_HANDLER_FACTORY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"ToString"
		end

	frozen release_handler (handler: WEB_IHTTP_HANDLER) is
		external
			"IL signature (System.Web.IHttpHandler): System.Void use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"ReleaseHandler"
		end

	frozen get_handler (context: WEB_HTTP_CONTEXT; verb: SYSTEM_STRING; url: SYSTEM_STRING; file_path: SYSTEM_STRING): WEB_IHTTP_HANDLER is
		external
			"IL signature (System.Web.HttpContext, System.String, System.String, System.String): System.Web.IHttpHandler use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"GetHandler"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_HTTP_REMOTING_HANDLER_FACTORY
