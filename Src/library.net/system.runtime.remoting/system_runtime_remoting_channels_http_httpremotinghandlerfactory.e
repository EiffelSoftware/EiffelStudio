indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPREMOTINGHANDLERFACTORY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_IHTTPHANDLERFACTORY

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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"ToString"
		end

	frozen release_handler (handler: SYSTEM_WEB_IHTTPHANDLER) is
		external
			"IL signature (System.Web.IHttpHandler): System.Void use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"ReleaseHandler"
		end

	frozen get_handler (context: SYSTEM_WEB_HTTPCONTEXT; verb: STRING; url: STRING; file_path: STRING): SYSTEM_WEB_IHTTPHANDLER is
		external
			"IL signature (System.Web.HttpContext, System.String, System.String, System.String): System.Web.IHttpHandler use System.Runtime.Remoting.Channels.Http.HttpRemotingHandlerFactory"
		alias
			"GetHandler"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPREMOTINGHANDLERFACTORY
