indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.EventBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	EVENT_BUILDER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen set_raise_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetRaiseMethod"
		end

	frozen set_add_on_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetAddOnMethod"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen add_other_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"AddOtherMethod"
		end

	frozen get_event_token: EVENT_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.EventToken use System.Reflection.Emit.EventBuilder"
		alias
			"GetEventToken"
		end

	frozen set_remove_on_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetRemoveOnMethod"
		end

end -- class EVENT_BUILDER
