indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.ContextStack"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_CONTEXT_STACK

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Design.Serialization.ContextStack"
		end

feature -- Access

	frozen get_item (type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Item"
		end

	frozen get_item_int32 (level: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Item"
		end

	frozen get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Current"
		end

feature -- Basic Operations

	frozen pop: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"Pop"
		end

	frozen push (context: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"Push"
		end

end -- class SYSTEM_DLL_CONTEXT_STACK
