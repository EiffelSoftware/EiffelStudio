indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.Expando.IExpando"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IEXPANDO

inherit
	IREFLECT

feature -- Basic Operations

	add_field (name: SYSTEM_STRING): FIELD_INFO is
		external
			"IL deferred signature (System.String): System.Reflection.FieldInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddField"
		end

	add_method (name: SYSTEM_STRING; method: DELEGATE): METHOD_INFO is
		external
			"IL deferred signature (System.String, System.Delegate): System.Reflection.MethodInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddMethod"
		end

	add_property (name: SYSTEM_STRING): PROPERTY_INFO is
		external
			"IL deferred signature (System.String): System.Reflection.PropertyInfo use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"AddProperty"
		end

	remove_member (m: MEMBER_INFO) is
		external
			"IL deferred signature (System.Reflection.MemberInfo): System.Void use System.Runtime.InteropServices.Expando.IExpando"
		alias
			"RemoveMember"
		end

end -- class IEXPANDO
