indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentChangedEventArgs"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_componentchangedeventargs

feature {NONE} -- Initialization

	frozen make_componentchangedeventargs (component: ANY; member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR; old_value: ANY; new_value: ANY) is
		external
			"IL creator signature (System.Object, System.ComponentModel.MemberDescriptor, System.Object, System.Object) use System.ComponentModel.Design.ComponentChangedEventArgs"
		end

feature -- Access

	frozen get_component: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_Component"
		end

	frozen get_new_value: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_NewValue"
		end

	frozen get_member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.MemberDescriptor use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_Member"
		end

	frozen get_old_value: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_OldValue"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTARGS
