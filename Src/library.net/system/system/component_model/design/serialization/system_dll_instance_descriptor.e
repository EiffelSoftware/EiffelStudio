indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.InstanceDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_INSTANCE_DESCRIPTOR

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (member: MEMBER_INFO; arguments: ICOLLECTION) is
		external
			"IL creator signature (System.Reflection.MemberInfo, System.Collections.ICollection) use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		end

	frozen make_1 (member: MEMBER_INFO; arguments: ICOLLECTION; is_complete: BOOLEAN) is
		external
			"IL creator signature (System.Reflection.MemberInfo, System.Collections.ICollection, System.Boolean) use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		end

feature -- Access

	frozen get_member_info: MEMBER_INFO is
		external
			"IL signature (): System.Reflection.MemberInfo use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"get_MemberInfo"
		end

	frozen get_arguments: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"get_Arguments"
		end

	frozen get_is_complete: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"get_IsComplete"
		end

feature -- Basic Operations

	frozen invoke: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"Invoke"
		end

end -- class SYSTEM_DLL_INSTANCE_DESCRIPTOR
