indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.ComponentEditorPage"

deferred external class
	SYSTEM_WINDOWS_FORMS_DESIGN_COMPONENTEDITORPAGE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_PANEL
		redefine
			get_create_params
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

feature -- Access

	frozen get_commit_on_deactivate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_CommitOnDeactivate"
		end

	get_title: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_Title"
		end

	frozen get_icon: SYSTEM_DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_Icon"
		end

feature -- Element Change

	frozen set_commit_on_deactivate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_CommitOnDeactivate"
		end

	frozen set_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_Icon"
		end

feature -- Basic Operations

	set_site_icomponent_editor_page_site (site: SYSTEM_WINDOWS_FORMS_ICOMPONENTEDITORPAGESITE) is
		external
			"IL signature (System.Windows.Forms.IComponentEditorPageSite): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"SetSite"
		end

	is_page_message (msg: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"IsPageMessage"
		end

	get_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"GetControl"
		end

	activate is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"Activate"
		end

	set_component_icomponent (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"SetComponent"
		end

	show_help is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"ShowHelp"
		end

	apply_changes is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"ApplyChanges"
		end

	supports_help: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"SupportsHelp"
		end

	on_apply_complete is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"OnApplyComplete"
		end

	deactivate is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"Deactivate"
		end

feature {NONE} -- Implementation

	frozen set_loading (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_Loading"
		end

	frozen get_loading: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_Loading"
		end

	frozen set_load_required (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_LoadRequired"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_CreateParams"
		end

	frozen get_page_site: SYSTEM_WINDOWS_FORMS_ICOMPONENTEDITORPAGESITE is
		external
			"IL signature (): System.Windows.Forms.IComponentEditorPageSite use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_PageSite"
		end

	frozen get_first_activate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_FirstActivate"
		end

	frozen set_component (value: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_Component"
		end

	frozen exit_loading_mode is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"ExitLoadingMode"
		end

	load_component is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"LoadComponent"
		end

	frozen set_page_site (value: SYSTEM_WINDOWS_FORMS_ICOMPONENTEDITORPAGESITE) is
		external
			"IL signature (System.Windows.Forms.IComponentEditorPageSite): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_PageSite"
		end

	reload_component is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"ReloadComponent"
		end

	frozen get_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL signature (): System.ComponentModel.IComponent use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_Component"
		end

	frozen get_selected_component: SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL signature (): System.ComponentModel.IComponent use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"GetSelectedComponent"
		end

	frozen get_load_required: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"get_LoadRequired"
		end

	frozen is_first_activate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"IsFirstActivate"
		end

	set_dirty is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"SetDirty"
		end

	frozen enter_loading_mode is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"EnterLoadingMode"
		end

	frozen is_loading: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"IsLoading"
		end

	frozen set_first_activate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"set_FirstActivate"
		end

	save_component is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.Design.ComponentEditorPage"
		alias
			"SaveComponent"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_COMPONENTEDITORPAGE
