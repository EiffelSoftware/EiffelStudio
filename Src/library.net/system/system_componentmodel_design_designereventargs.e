indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_designereventargs

feature {NONE} -- Initialization

	frozen make_designereventargs (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost) use System.ComponentModel.Design.DesignerEventArgs"
		end

feature -- Access

	frozen get_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.DesignerEventArgs"
		alias
			"get_Designer"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTARGS
