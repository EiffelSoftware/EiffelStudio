indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IEditableObject"

deferred external class
	SYSTEM_COMPONENTMODEL_IEDITABLEOBJECT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

end -- class SYSTEM_COMPONENTMODEL_IEDITABLEOBJECT
