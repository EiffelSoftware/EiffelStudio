indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.CustomAttributeBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CUSTOM_ATTRIBUTE_BUILDER

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (con: CONSTRUCTOR_INFO; constructor_args: NATIVE_ARRAY [SYSTEM_OBJECT]; named_properties: NATIVE_ARRAY [PROPERTY_INFO]; property_values: NATIVE_ARRAY [SYSTEM_OBJECT]; named_fields: NATIVE_ARRAY [FIELD_INFO]; field_values: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_2 (con: CONSTRUCTOR_INFO; constructor_args: NATIVE_ARRAY [SYSTEM_OBJECT]; named_fields: NATIVE_ARRAY [FIELD_INFO]; field_values: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make (con: CONSTRUCTOR_INFO; constructor_args: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_1 (con: CONSTRUCTOR_INFO; constructor_args: NATIVE_ARRAY [SYSTEM_OBJECT]; named_properties: NATIVE_ARRAY [PROPERTY_INFO]; property_values: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

end -- class CUSTOM_ATTRIBUTE_BUILDER
