indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IEditableObject"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IEDITABLE_OBJECT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	begin_edit is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.IEditableObject"
		alias
			"BeginEdit"
		end

	cancel_edit is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.IEditableObject"
		alias
			"CancelEdit"
		end

	end_edit is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.IEditableObject"
		alias
			"EndEdit"
		end

end -- class SYSTEM_DLL_IEDITABLE_OBJECT
