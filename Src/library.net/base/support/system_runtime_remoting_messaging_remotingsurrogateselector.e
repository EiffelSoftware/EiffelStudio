indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_REMOTINGSURROGATESELECTOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		end

feature -- Access

	frozen get_filter: SYSTEM_RUNTIME_REMOTING_MESSAGING_MESSAGESURROGATEFILTER is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.MessageSurrogateFilter use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"get_Filter"
		end

feature -- Element Change

	frozen set_filter (value: SYSTEM_RUNTIME_REMOTING_MESSAGING_MESSAGESURROGATEFILTER) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.MessageSurrogateFilter): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"set_Filter"
		end

feature -- Basic Operations

	use_soap_format is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"UseSoapFormat"
		end

	get_surrogate (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT; ssout: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR): SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZATIONSURROGATE is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetSurrogate"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"Equals"
		end

	frozen set_root_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"SetRootObject"
		end

	get_next_selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetNextSelector"
		end

	frozen get_root_object: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetRootObject"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"ToString"
		end

	chain_selector (selector: SYSTEM_RUNTIME_SERIALIZATION_ISURROGATESELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"ChainSelector"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_REMOTINGSURROGATESELECTOR
