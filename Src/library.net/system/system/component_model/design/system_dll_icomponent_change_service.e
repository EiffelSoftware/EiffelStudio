indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IComponentChangeService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICOMPONENT_CHANGE_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Element Change

	remove_component_adding (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentAdding"
		end

	add_component_changed (value: SYSTEM_DLL_COMPONENT_CHANGED_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangedEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentChanged"
		end

	remove_component_changing (value: SYSTEM_DLL_COMPONENT_CHANGING_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangingEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentChanging"
		end

	remove_component_rename (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRename"
		end

	remove_component_added (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentAdded"
		end

	remove_component_removing (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRemoving"
		end

	remove_component_changed (value: SYSTEM_DLL_COMPONENT_CHANGED_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangedEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentChanged"
		end

	remove_component_removed (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"remove_ComponentRemoved"
		end

	add_component_adding (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentAdding"
		end

	add_component_rename (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRename"
		end

	add_component_removing (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRemoving"
		end

	add_component_removed (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentRemoved"
		end

	add_component_changing (value: SYSTEM_DLL_COMPONENT_CHANGING_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentChangingEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentChanging"
		end

	add_component_added (value: SYSTEM_DLL_COMPONENT_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentEventHandler): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"add_ComponentAdded"
		end

feature -- Basic Operations

	on_component_changing (component: SYSTEM_OBJECT; member: SYSTEM_DLL_MEMBER_DESCRIPTOR) is
		external
			"IL deferred signature (System.Object, System.ComponentModel.MemberDescriptor): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"OnComponentChanging"
		end

	on_component_changed (component: SYSTEM_OBJECT; member: SYSTEM_DLL_MEMBER_DESCRIPTOR; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.ComponentModel.MemberDescriptor, System.Object, System.Object): System.Void use System.ComponentModel.Design.IComponentChangeService"
		alias
			"OnComponentChanged"
		end

end -- class SYSTEM_DLL_ICOMPONENT_CHANGE_SERVICE
