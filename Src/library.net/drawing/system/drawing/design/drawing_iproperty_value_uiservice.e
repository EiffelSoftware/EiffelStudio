indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.IPropertyValueUIService"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_IPROPERTY_VALUE_UISERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Element Change

	add_property_uivalue_items_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"add_PropertyUIValueItemsChanged"
		end

	remove_property_uivalue_items_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"remove_PropertyUIValueItemsChanged"
		end

feature -- Basic Operations

	notify_property_value_uiitems_changed is
		external
			"IL deferred signature (): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"NotifyPropertyValueUIItemsChanged"
		end

	get_property_uivalue_items (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR): NATIVE_ARRAY [DRAWING_PROPERTY_VALUE_UIITEM] is
		external
			"IL deferred signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor): System.Drawing.Design.PropertyValueUIItem[] use System.Drawing.Design.IPropertyValueUIService"
		alias
			"GetPropertyUIValueItems"
		end

	remove_property_value_uihandler (new_handler: DRAWING_PROPERTY_VALUE_UIHANDLER) is
		external
			"IL deferred signature (System.Drawing.Design.PropertyValueUIHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"RemovePropertyValueUIHandler"
		end

	add_property_value_uihandler (new_handler: DRAWING_PROPERTY_VALUE_UIHANDLER) is
		external
			"IL deferred signature (System.Drawing.Design.PropertyValueUIHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"AddPropertyValueUIHandler"
		end

end -- class DRAWING_IPROPERTY_VALUE_UISERVICE
