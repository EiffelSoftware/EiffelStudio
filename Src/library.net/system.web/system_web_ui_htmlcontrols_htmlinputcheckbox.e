indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlInputCheckBox"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCHECKBOX

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCONTROL
		redefine
			on_pre_render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_htmlinputcheckbox

feature {NONE} -- Initialization

	frozen make_htmlinputcheckbox is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		end

feature -- Access

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"get_Checked"
		end

feature -- Element Change

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"set_Checked"
		end

	frozen add_server_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"add_ServerChange"
		end

	frozen remove_server_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"remove_ServerChange"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_server_change (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"OnServerChange"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputCheckBox"
		alias
			"OnPreRender"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCHECKBOX
