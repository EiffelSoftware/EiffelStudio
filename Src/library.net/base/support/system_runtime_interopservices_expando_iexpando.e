indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.Expando.IExpando"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_EXPANDO_IEXPANDO

inherit
	SYSTEM_REFLECTION_IREFLECT

feature -- Basic Operations

	add_field (name: STRING): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL deferred signature (System.String): System.Reflection.FieldInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddField"
		end

	add_method (name: STRING; method: SYSTEM_DELEGATE): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.String, System.Delegate): System.Reflection.MethodInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddMethod"
		end

	add_property (name: STRING): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL deferred signature (System.String): System.Reflection.PropertyInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddProperty"
		end

	remove_member (m: SYSTEM_REFLECTION_MEMBERINFO) is
		external
			"IL deferred signature (System.Reflection.MemberInfo): System.Void use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"RemoveMember"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_EXPANDO_IEXPANDO
