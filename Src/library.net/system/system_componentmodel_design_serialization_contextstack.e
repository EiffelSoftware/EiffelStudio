indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.ContextStack"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_CONTEXTSTACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Design.Serialization.ContextStack"
		end

feature -- Access

	frozen get_item (type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Item"
		end

	frozen get_item_int32 (level: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Item"
		end

	frozen get_current: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"get_Current"
		end

feature -- Basic Operations

	frozen pop: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"Pop"
		end

	frozen push (context: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.ContextStack"
		alias
			"Push"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_CONTEXTSTACK
