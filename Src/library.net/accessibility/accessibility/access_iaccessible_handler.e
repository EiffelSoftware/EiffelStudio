indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Accessibility.IAccessibleHandler"
	assembly: "Accessibility", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ACCESS_IACCESSIBLE_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	accessible_object_from_id (hwnd: INTEGER; l_object_id: INTEGER; p_iaccessible: ACCESS_IACCESSIBLE) is
		external
			"IL deferred signature (System.Int32, System.Int32, Accessibility.IAccessible&): System.Void use Accessibility.IAccessibleHandler"
		alias
			"AccessibleObjectFromID"
		end

end -- class ACCESS_IACCESSIBLE_HANDLER
