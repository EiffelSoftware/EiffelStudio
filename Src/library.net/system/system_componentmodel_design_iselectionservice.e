indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ISelectionService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_ISELECTIONSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_selection_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.ComponentModel.Design.ISelectionService"
		alias
			"get_SelectionCount"
		end

	get_primary_selection: ANY is
		external
			"IL deferred signature (): System.Object use System.ComponentModel.Design.ISelectionService"
		alias
			"get_PrimarySelection"
		end

feature -- Element Change

	remove_selection_changing (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"remove_SelectionChanging"
		end

	add_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"add_SelectionChanged"
		end

	add_selection_changing (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"add_SelectionChanging"
		end

	remove_selection_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"remove_SelectionChanged"
		end

feature -- Basic Operations

	set_selected_components_icollection_selection_types (components: SYSTEM_COLLECTIONS_ICOLLECTION; selection_type: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES) is
		external
			"IL deferred signature (System.Collections.ICollection, System.ComponentModel.Design.SelectionTypes): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"SetSelectedComponents"
		end

	get_component_selected (component: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.Design.ISelectionService"
		alias
			"GetComponentSelected"
		end

	set_selected_components (components: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL deferred signature (System.Collections.ICollection): System.Void use System.ComponentModel.Design.ISelectionService"
		alias
			"SetSelectedComponents"
		end

	get_selected_components: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.ComponentModel.Design.ISelectionService"
		alias
			"GetSelectedComponents"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ISELECTIONSERVICE
