indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REMOTING_SURROGATE_SELECTOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISURROGATE_SELECTOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		end

feature -- Access

	frozen get_filter: MESSAGE_SURROGATE_FILTER is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.MessageSurrogateFilter use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"get_Filter"
		end

feature -- Element Change

	frozen set_filter (value: MESSAGE_SURROGATE_FILTER) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.MessageSurrogateFilter): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"set_Filter"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"ToString"
		end

	get_surrogate (type: TYPE; context: STREAMING_CONTEXT; ssout: ISURROGATE_SELECTOR): ISERIALIZATION_SURROGATE is
		external
			"IL signature (System.Type, System.Runtime.Serialization.StreamingContext, System.Runtime.Serialization.ISurrogateSelector&): System.Runtime.Serialization.ISerializationSurrogate use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetSurrogate"
		end

	get_next_selector: ISURROGATE_SELECTOR is
		external
			"IL signature (): System.Runtime.Serialization.ISurrogateSelector use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetNextSelector"
		end

	chain_selector (selector: ISURROGATE_SELECTOR) is
		external
			"IL signature (System.Runtime.Serialization.ISurrogateSelector): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"ChainSelector"
		end

	use_soap_format is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"UseSoapFormat"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"Equals"
		end

	frozen get_root_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"GetRootObject"
		end

	frozen set_root_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Messaging.RemotingSurrogateSelector"
		alias
			"SetRootObject"
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

end -- class REMOTING_SURROGATE_SELECTOR
