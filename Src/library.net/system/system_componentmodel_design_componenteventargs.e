indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_componenteventargs

feature {NONE} -- Initialization

	frozen make_componenteventargs (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL creator signature (System.ComponentModel.IComponent) use System.ComponentModel.Design.ComponentEventArgs"
		end

feature -- Access

	get_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.ComponentEventArgs"
		alias
			"get_Component"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTARGS
