indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.IPropertyValueUIService"

deferred external class
	SYSTEM_DRAWING_DESIGN_IPROPERTYVALUEUISERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Element Change

	add_property_uivalue_items_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"add_PropertyUIValueItemsChanged"
		end

	remove_property_uivalue_items_changed (value: SYSTEM_EVENTHANDLER) is
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

	get_property_uivalue_items (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; prop_desc: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): ARRAY [SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEM] is
		external
			"IL deferred signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor): System.Drawing.Design.PropertyValueUIItem[] use System.Drawing.Design.IPropertyValueUIService"
		alias
			"GetPropertyUIValueItems"
		end

	remove_property_value_uihandler (new_handler: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIHANDLER) is
		external
			"IL deferred signature (System.Drawing.Design.PropertyValueUIHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"RemovePropertyValueUIHandler"
		end

	add_property_value_uihandler (new_handler: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIHANDLER) is
		external
			"IL deferred signature (System.Drawing.Design.PropertyValueUIHandler): System.Void use System.Drawing.Design.IPropertyValueUIService"
		alias
			"AddPropertyValueUIHandler"
		end

end -- class SYSTEM_DRAWING_DESIGN_IPROPERTYVALUEUISERVICE
