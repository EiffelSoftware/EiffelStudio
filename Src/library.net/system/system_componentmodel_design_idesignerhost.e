indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDesignerHost"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST

inherit
	SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER
	SYSTEM_ISERVICEPROVIDER

feature -- Access

	get_transaction_description: STRING is
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

	get_container: SYSTEM_COMPONENTMODEL_ICONTAINER is
		external
			"IL deferred signature (): System.ComponentModel.IContainer use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_Container"
		end

	get_root_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL deferred signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_RootComponent"
		end

	get_root_component_class_name: STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.Design.IDesignerHost"
		alias
			"get_RootComponentClassName"
		end

feature -- Element Change

	add_transaction_closing (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionClosing"
		end

	remove_activated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_Activated"
		end

	remove_transaction_closing (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionClosing"
		end

	add_transaction_closed (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionClosed"
		end

	remove_transaction_closed (value: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerTransactionCloseEventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionClosed"
		end

	remove_load_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_LoadComplete"
		end

	add_transaction_opening (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionOpening"
		end

	add_transaction_opened (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_TransactionOpened"
		end

	add_activated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_Activated"
		end

	remove_transaction_opened (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionOpened"
		end

	remove_transaction_opening (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_TransactionOpening"
		end

	add_deactivated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_Deactivated"
		end

	remove_deactivated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"remove_Deactivated"
		end

	add_load_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"add_LoadComplete"
		end

feature -- Basic Operations

	create_transaction: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerTransaction use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateTransaction"
		end

	create_component_type_string (component_class: SYSTEM_TYPE; name: STRING): SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL deferred signature (System.Type, System.String): System.ComponentModel.IComponent use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateComponent"
		end

	get_type_string (type_name: STRING): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.IDesignerHost"
		alias
			"GetType"
		end

	destroy_component (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Design.IDesignerHost"
		alias
			"DestroyComponent"
		end

	get_designer (component: SYSTEM_COMPONENTMODEL_ICOMPONENT): SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNER is
		external
			"IL deferred signature (System.ComponentModel.IComponent): System.ComponentModel.Design.IDesigner use System.ComponentModel.Design.IDesignerHost"
		alias
			"GetDesigner"
		end

	create_component (component_class: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_ICOMPONENT is
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

	create_transaction_string (description: STRING): SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTION is
		external
			"IL deferred signature (System.String): System.ComponentModel.Design.DesignerTransaction use System.ComponentModel.Design.IDesignerHost"
		alias
			"CreateTransaction"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST
