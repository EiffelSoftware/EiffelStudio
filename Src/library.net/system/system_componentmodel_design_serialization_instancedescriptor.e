indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.InstanceDescriptor"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_INSTANCEDESCRIPTOR

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (member: SYSTEM_REFLECTION_MEMBERINFO; arguments: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Reflection.MemberInfo, System.Collections.ICollection) use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		end

	frozen make_1 (member: SYSTEM_REFLECTION_MEMBERINFO; arguments: SYSTEM_COLLECTIONS_ICOLLECTION; is_complete: BOOLEAN) is
		external
			"IL creator signature (System.Reflection.MemberInfo, System.Collections.ICollection, System.Boolean) use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		end

feature -- Access

	frozen get_member_info: SYSTEM_REFLECTION_MEMBERINFO is
		external
			"IL signature (): System.Reflection.MemberInfo use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"get_MemberInfo"
		end

	frozen get_arguments: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	frozen invoke: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.InstanceDescriptor"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_INSTANCEDESCRIPTOR
