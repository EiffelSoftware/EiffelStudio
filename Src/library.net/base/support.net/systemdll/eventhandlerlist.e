indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.EventHandlerList"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

frozen external class
	EVENTHANDLERLIST

inherit
	ANY
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

	frozen get_item (key: ANY): DELEGATE is
		external
			"IL signature (System.Object): System.Delegate use System.ComponentModel.EventHandlerList"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (key: ANY; value: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_handler (key: ANY; value: DELEGATE) is
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

	frozen add_handler (key: ANY; value: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventHandlerList"
		alias
			"AddHandler"
		end

	equals (obj: ANY): BOOLEAN is
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

end -- class EVENTHANDLERLIST
