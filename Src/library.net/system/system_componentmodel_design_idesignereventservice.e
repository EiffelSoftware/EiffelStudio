indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDesignerEventService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNEREVENTSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_designers: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerCollection use System.ComponentModel.Design.IDesignerEventService"
		alias
			"get_Designers"
		end

	get_active_designer: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL deferred signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.IDesignerEventService"
		alias
			"get_ActiveDesigner"
		end

feature -- Element Change

	remove_designer_created (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_DesignerCreated"
		end

	remove_active_designer_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ActiveDesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_ActiveDesignerChanged"
		end

	add_active_designer_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ActiveDesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_ActiveDesignerChanged"
		end

	remove_designer_disposed (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_DesignerDisposed"
		end

	add_designer_created (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_DesignerCreated"
		end

	add_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_SelectionChanged"
		end

	add_designer_disposed (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNEREVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_DesignerDisposed"
		end

	remove_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_SelectionChanged"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNEREVENTSERVICE
