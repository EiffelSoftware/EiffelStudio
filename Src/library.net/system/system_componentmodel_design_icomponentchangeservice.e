indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IComponentChangeService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_ICOMPONENTCHANGESERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Element Change

	remove_component_adding (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentAdding"
		end

	add_component_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangedEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentChanged"
		end

	remove_component_changing (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGINGEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangingEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentChanging"
		end

	remove_component_rename (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRename"
		end

	remove_component_added (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentAdded"
		end

	remove_component_removing (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRemoving"
		end

	remove_component_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangedEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentChanged"
		end

	remove_component_removed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRemoved"
		end

	add_component_adding (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentAdding"
		end

	add_component_rename (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRename"
		end

	add_component_removing (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRemoving"
		end

	add_component_removed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRemoved"
		end

	add_component_changing (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGINGEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangingEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentChanging"
		end

	add_component_added (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentAdded"
		end

feature -- Basic Operations

	on_component_changing (component: ANY; member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR) is
		external
			"IL deferred signature (System.Object, System.ComponentModel.MemberDescriptor): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"OnComponentChanging"
		end

	on_component_changed (component: ANY; member: SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR; old_value: ANY; new_value: ANY) is
		external
			"IL deferred signature (System.Object, System.ComponentModel.MemberDescriptor, System.Object, System.Object): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"OnComponentChanged"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ICOMPONENTCHANGESERVICE
