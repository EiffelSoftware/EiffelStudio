indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.ResolveNameEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_resolvenameeventargs

feature {NONE} -- Initialization

	frozen make_resolvenameeventargs (name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		end

feature -- Access

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"get_Value"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"set_Value"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTARGS
