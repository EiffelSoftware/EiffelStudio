indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentChangingEventArgs"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGINGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_componentchangingeventargs

feature {NONE} -- Initialization

	frozen make_componentchangingeventargs (component: ANY; member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR) is
		external
			"IL creator signature (System.Object, System.ComponentModel.MemberDescriptor) use System.ComponentModel.Design.ComponentChangingEventArgs"
		end

feature -- Access

	frozen get_component: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangingEventArgs"
		alias
			"get_Component"
		end

	frozen get_member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.MemberDescriptor use System.ComponentModel.Design.ComponentChangingEventArgs"
		alias
			"get_Member"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGINGEVENTARGS
