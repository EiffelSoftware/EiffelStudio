indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.EventBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_EVENTBUILDER

create {NONE}

feature -- Basic Operations

	frozen set_add_on_method (mdBuilder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetAddOnMethod"
		end

	frozen set_raise_method (mdBuilder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetRaiseMethod"
		end

	frozen get_event_token: SYSTEM_REFLECTION_EMIT_EVENTTOKEN is
		external
			"IL signature (): System.Reflection.Emit.EventToken use System.Reflection.Emit.EventBuilder"
		alias
			"GetEventToken"
		end

	frozen set_remove_on_method (mdBuilder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetRemoveOnMethod"
		end

	frozen set_custom_attributes (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen set_custom_attributes_with_blob (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryAttribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen add_other_method (mdBuilder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.EventBuilder"
		alias
			"AddOtherMethod"
		end

end -- class SYSTEM_REFLECTION_EMIT_EVENTBUILDER
