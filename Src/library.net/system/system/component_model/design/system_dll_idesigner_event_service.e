indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDesignerEventService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_EVENT_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_designers: SYSTEM_DLL_DESIGNER_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerCollection use System.ComponentModel.Design.IDesignerEventService"
		alias
			"get_Designers"
		end

	get_active_designer: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL deferred signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.IDesignerEventService"
		alias
			"get_ActiveDesigner"
		end

feature -- Element Change

	remove_designer_created (value: SYSTEM_DLL_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_DesignerCreated"
		end

	remove_active_designer_changed (value: SYSTEM_DLL_ACTIVE_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ActiveDesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_ActiveDesignerChanged"
		end

	add_active_designer_changed (value: SYSTEM_DLL_ACTIVE_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ActiveDesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_ActiveDesignerChanged"
		end

	remove_designer_disposed (value: SYSTEM_DLL_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_DesignerDisposed"
		end

	add_designer_created (value: SYSTEM_DLL_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_DesignerCreated"
		end

	add_selection_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_SelectionChanged"
		end

	add_designer_disposed (value: SYSTEM_DLL_DESIGNER_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerEventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"add_DesignerDisposed"
		end

	remove_selection_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerEventService"
		alias
			"remove_SelectionChanged"
		end

end -- class SYSTEM_DLL_IDESIGNER_EVENT_SERVICE
