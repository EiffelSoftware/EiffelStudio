indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.UnmanagedMarshal"

frozen external class
	SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL

create {NONE}

feature -- Access

	frozen get_element_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_ElementCount"
		end

	frozen get_base_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE is
		external
			"IL signature (): System.Runtime.InteropServices.UnmanagedType use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_BaseType"
		end

	frozen get_get_unmanaged_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE is
		external
			"IL signature (): System.Runtime.InteropServices.UnmanagedType use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_GetUnmanagedType"
		end

	frozen get_iidguid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_IIDGuid"
		end

feature -- Basic Operations

	frozen define_safe_array (elem_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineSafeArray"
		end

	frozen define_lparray (elem_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineLPArray"
		end

	frozen define_by_val_tstr (elem_count: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Int32): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineByValTStr"
		end

	frozen define_by_val_array (elem_count: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Int32): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineByValArray"
		end

	frozen define_unmanaged_marshal (unmanaged_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineUnmanagedMarshal"
		end

end -- class SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL
