indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.EventHandlerList"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EVENT_HANDLER_LIST

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.EventHandlerList"
		end

feature -- Access

	frozen get_item (key: SYSTEM_OBJECT): DELEGATE is
		external
			"IL signature (System.Object): System.Delegate use System.ComponentModel.EventHandlerList"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (key: SYSTEM_OBJECT; value: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_handler (key: SYSTEM_OBJECT; value: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"RemoveHandler"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.EventHandlerList"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.EventHandlerList"
		alias
			"ToString"
		end

	frozen add_handler (key: SYSTEM_OBJECT; value: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"AddHandler"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.EventHandlerList"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_EVENT_HANDLER_LIST
