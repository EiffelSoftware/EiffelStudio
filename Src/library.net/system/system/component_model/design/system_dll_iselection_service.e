indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ISelectionService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ISELECTION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_selection_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.ComponentModel.Design.ISelectionService"
		alias
			"get_SelectionCount"
		end

	get_primary_selection: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.ComponentModel.Design.ISelectionService"
		alias
			"get_PrimarySelection"
		end

feature -- Element Change

	remove_selection_changing (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"remove_SelectionChanging"
		end

	add_selection_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"add_SelectionChanged"
		end

	add_selection_changing (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"add_SelectionChanging"
		end

	remove_selection_changed (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"remove_SelectionChanged"
		end

feature -- Basic Operations

	set_selected_components_icollection_selection_types (components: ICOLLECTION; selection_type: SYSTEM_DLL_SELECTION_TYPES) is
		external
			"IL deferred signature (System.Collections.ICollection, System.ComponentModel.Design.SelectionTypes): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"SetSelectedComponents"
		end

	get_component_selected (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.Design.ISelectionService"
		alias
			"GetComponentSelected"
		end

	set_selected_components (components: ICOLLECTION) is
		external
			"IL deferred signature (System.Collections.ICollection): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"SetSelectedComponents"
		end

	get_selected_components: ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.ComponentModel.Design.ISelectionService"
		alias
			"GetSelectedComponents"
		end

end -- class SYSTEM_DLL_ISELECTION_SERVICE
