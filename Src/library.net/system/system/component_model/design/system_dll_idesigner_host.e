indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDesignerHost"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_HOST

inherit
	SYSTEM_DLL_ISERVICE_CONTAINER
	ISERVICE_PROVIDER

feature -- Access

	get_transaction_description: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_TransactionDescription"
		end

	get_loading: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_Loading"
		end

	get_in_transaction: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_InTransaction"
		end

	get_container: SYSTEM_DLL_ICONTAINER is
		external
			"IL deferred signature (): System.ComponentModel.IContainer use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_Container"
		end

	get_root_component: SYSTEM_DLL_ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_RootComponent"
		end

	get_root_component_class_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_RootComponentClassName"
		end

feature -- Element Change

	add_transaction_closing (value: SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionClosing"
		end

	remove_activated (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_Activated"
		end

	remove_transaction_closing (value: SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionClosing"
		end

	add_transaction_closed (value: SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionClosed"
		end

	remove_transaction_closed (value: SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionClosed"
		end

	remove_load_complete (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_LoadComplete"
		end

	add_transaction_opening (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionOpening"
		end

	add_transaction_opened (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionOpened"
		end

	add_activated (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_Activated"
		end

	remove_transaction_opened (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionOpened"
		end

	remove_transaction_opening (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionOpening"
		end

	add_deactivated (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_Deactivated"
		end

	remove_deactivated (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_Deactivated"
		end

	add_load_complete (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_LoadComplete"
		end

feature -- Basic Operations

	create_transaction: SYSTEM_DLL_DESIGNER_TRANSACTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerTransaction use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateTransaction"
		end

	create_component_type_string (component_class: TYPE; name: SYSTEM_STRING): SYSTEM_DLL_ICOMPONENT is
		external
			"IL deferred signature (System.Type, System.String): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateComponent"
		end

	get_type_string (type_name: SYSTEM_STRING): TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.IDesignerHost"
		alias
			"GetType"
		end

	destroy_component (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"DestroyComponent"
		end

	get_designer (component: SYSTEM_DLL_ICOMPONENT): SYSTEM_DLL_IDESIGNER is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.ComponentModel.Design.IDesigner use System.ComponentModel.Design.IDesignerHost"
		alias
			"GetDesigner"
		end

	create_component (component_class: TYPE): SYSTEM_DLL_ICOMPONENT is
		external
			"IL deferred signature (System.Type): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateComponent"
		end

	activate is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"Activate"
		end

	create_transaction_string (description: SYSTEM_STRING): SYSTEM_DLL_DESIGNER_TRANSACTION is
		external
			"IL deferred signature (System.String): System.ComponentModel.Design.DesignerTransaction use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateTransaction"
		end

end -- class SYSTEM_DLL_IDESIGNER_HOST
