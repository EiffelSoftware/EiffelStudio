indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.CustomAttributeBuilder"

external class
	SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructorArgs: ARRAY [ANY]; namedProperties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; propertyValues: ARRAY [ANY]; namedFields: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; fieldValues: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_2 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructorArgs: ARRAY [ANY]; namedFields: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; fieldValues: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.FieldInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructorArgs: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

	frozen make_1 (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; constructorArgs: ARRAY [ANY]; namedProperties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; propertyValues: ARRAY [ANY]) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo, System.Object[], System.Reflection.PropertyInfo[], System.Object[]) use System.Reflection.Emit.CustomAttributeBuilder"
		end

end -- class SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER
