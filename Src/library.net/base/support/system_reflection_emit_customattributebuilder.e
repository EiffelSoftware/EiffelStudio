indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.CustomAttributeBuilder"

external class
	SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructor_args: ARRAY [ANY]; named_properties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; property_values: ARRAY [ANY]; named_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; field_values: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_2 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructor_args: ARRAY [ANY]; named_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; field_values: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructor_args: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_1 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructor_args: ARRAY [ANY]; named_properties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; property_values: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

end -- class SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER
