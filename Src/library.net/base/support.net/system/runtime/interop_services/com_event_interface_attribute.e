indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComEventInterfaceAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COM_EVENT_INTERFACE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_com_event_interface_attribute

feature {NONE} -- Initialization

	frozen make_com_event_interface_attribute (source_interface: TYPE; event_provider: TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.Runtime.InteropServices.ComEventInterfaceAttribute"
		end

feature -- Access

	frozen get_event_provider: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.InteropServices.ComEventInterfaceAttribute"
		alias
			"get_EventProvider"
		end

	frozen get_source_interface: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.InteropServices.ComEventInterfaceAttribute"
		alias
			"get_SourceInterface"
		end

end -- class COM_EVENT_INTERFACE_ATTRIBUTE
