indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ActiveDesignerEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_activedesignereventargs

feature {NONE} -- Initialization

	frozen make_activedesignereventargs (old_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST; new_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost, System.ComponentModel.Design.IDesignerHost) use System.ComponentModel.Design.ActiveDesignerEventArgs"
		end

feature -- Access

	frozen get_new_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.ActiveDesignerEventArgs"
		alias
			"get_NewDesigner"
		end

	frozen get_old_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.ActiveDesignerEventArgs"
		alias
			"get_OldDesigner"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTARGS
