note
	description: "[
			EiffelRibbon root ribbon object, it contains ribbon group
			Some global ribbon features are available in this class
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON

inherit
	EV_ANY_HANDLER

	EV_SHARED_RESOURCES
		export
			{NONE} all
		end

	DISPOSABLE

feature {NONE} -- Initialization

	init_with_window (a_window: EV_WINDOW)
			-- Creation method
		do
			init_with_window_and_dll (a_window, Void)
		end

	init_with_window_and_dll (a_window: EV_WINDOW; a_ribbon_dll_name: detachable STRING_32)
			-- Creation method
		do
			if attached {EV_WINDOW_IMP} a_window.implementation as l_imp then
				com_initialize
					-- Make sure the dispatcher is created
				dispatcher.do_nothing
				create_ribbon_com_framework_from_dll (l_imp.wel_item, a_ribbon_dll_name)
				associated_window := l_imp

					-- All command observers have been added, now harvest them from EV_COMMAND_HANDLER into current object
				fetch_ui_objects
			end
		end

	create_ribbon_com_framework_from_dll (a_hwnd: POINTER; a_ribbon_dll_name: detachable STRING_32)
			-- Create ribbon framework from a DLL which named `a_ribbon_dll_name'
		require
			valid: a_hwnd /= default_pointer
		local
			l_loader: DYNAMIC_API_LOADER
			l_res_dll: POINTER
		do
			create l_loader
			if a_ribbon_dll_name /= Void and then not a_ribbon_dll_name.is_empty then
				 -- Load Ribbon resouce from eiffel.ribbon.dll
				l_res_dll := l_loader.load_library (a_ribbon_dll_name, void)
				item := create_ribbon_com_framework (a_hwnd, l_res_dll)
			else
				item := create_ribbon_com_framework (a_hwnd, default_pointer)
			end

		end

feature -- Command

	set_modes (a_modes: ITERABLE [NATURAL_32])
			-- Set application mode for current ribbon framework
		require
			exists: exists
		local
			l_new_cursor: ITERATION_CURSOR [NATURAL_32]
			l_modes: NATURAL_32
		do
			from
				l_new_cursor := a_modes.new_cursor
			until
				l_new_cursor.after
			loop
				l_modes := l_modes | c_ui_make_app_mode(l_new_cursor.item)
				l_new_cursor.forth
			end

			c_set_modes (l_modes, item)
		end

	set_background_color (a_color: EV_RIBBON_HSB_COLOR)
			-- Set global background color with `a_color'
		require
			exists: exists
			not_void: a_color /= Void
		local
			l_key: EV_PROPERTY_KEY
		do
			create l_key.make_global_background_color
			c_set_ribbon_color (item, l_key.item, a_color.value)
		end

	set_highlight_color (a_color: EV_RIBBON_HSB_COLOR)
			-- Set global highlight color with `a_color'
		require
			not_void: a_color /= Void
		local
			l_key: EV_PROPERTY_KEY
		do
			create l_key.make_global_highlight_color
			c_set_ribbon_color (item, l_key.item, a_color.value)
		end

	set_text_color (a_color: EV_RIBBON_HSB_COLOR)
			-- Set global text color with `a_color'
		require
			not_void: a_color /= Void
		local
			l_key: EV_PROPERTY_KEY
		do
			create l_key.make_global_text_color
			c_set_ribbon_color (item, l_key.item, a_color.value)
		end

	show_contextual_ui (a_point: EV_COORDINATE; a_command_id: NATURAL_32)
			-- Show context menu or minitoolbar at
		local
			l_result: NATURAL_32
		do
			l_result := c_show_contextual_ui (a_point.x, a_point.y, item, a_command_id)
			check success: l_result = {WEL_COM_HRESULT}.s_ok end
		end

	destroy
			-- Clean up all ribbon related COM objects and resources
		require
			exists: exists
		do
			destroy_ribbon_com_framwork (item)
			item := default_pointer
			com_uninitialize
			associated_window := Void
		end

	save_settings_to_file (a_file_name: READABLE_STRING_GENERAL)
			-- Writes ribbon settings to a binary stream
		local
			l_f_stream: WEL_COM_ISTREAM
			l_result: NATURAL_32
		do
			create l_f_stream.create_istream_from_file (a_file_name)

			l_result := c_save_settings_to_stream (item, l_f_stream.item)

			check l_result = {WEL_COM_HRESULT}.s_ok end
		end

	load_settings_from_file (a_file_name: READABLE_STRING_GENERAL)
			-- Load ribbon settings from a binary stream
		local
			l_f_stream: WEL_COM_ISTREAM
			l_result: NATURAL_32
		do
			create l_f_stream.create_istream_from_file (a_file_name)

			l_result := c_load_settings_from_stream (item, l_f_stream.item)

			check l_result = {WEL_COM_HRESULT}.s_ok end
		end

feature {EV_RIBBON_ITEM, EV_RIBBON_TEXTABLE, EV_RIBBON_TOOLTIPABLE, EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS, EV_RIBBON_QUICK_ACCESS_TOOLBAR,
		EV_RIBBON_IMAGEABLE, EV_RIBBON_APPLICATION_MENU_GROUP} -- Commands

	get_command_property (a_command_id: NATURAL_32; a_key: EV_PROPERTY_KEY; a_variant: EV_PROPERTY_VARIANT)
			-- Retrieves a command property, value, or state.
		require
			exists: exists
			a_key_not_void: a_key /= Void
			a_key_exists: a_key.exists
			a_variant_not_void: a_variant /= Void
		local
			l_result: NATURAL_32
		do
			l_result := c_get_ui_command_property (item, a_command_id, a_key.item, a_variant.item)
			check l_result = {WEL_COM_HRESULT}.s_ok end
		end

	set_command_property (a_command_id: NATURAL_32; a_key: EV_PROPERTY_KEY; a_variant: EV_PROPERTY_VARIANT): BOOLEAN
			-- Sets a command property, value, or state.
			-- Result true means setting success, otherwise failed
		require
			exists: exists
			a_key_not_void: a_key /= Void
			a_key_exists: a_key.exists
			a_variant_not_void: a_variant /= Void
		local
			l_result: NATURAL_32
		do
			l_result := c_set_ui_command_property (item, a_command_id, a_key.item, a_variant.item)
			Result := l_result = {WEL_COM_HRESULT}.s_ok
		end

	invalidate (a_command_id: NATURAL_32; a_flags: INTEGER_32; a_key: EV_PROPERTY_KEY)
			-- Invalidates a Windows Ribbon framework Command property, value, or state.
		require
			exists: exists
			a_key_not_void: a_key /= Void
			a_key_exists: a_key.exists
			valid: (create {EV_UI_INVALIDATIONS_ENUM}).is_valid (a_flags)
		do
			c_invalidate_ui_command (item, a_command_id, a_flags, a_key.item)
		end

feature -- Status Report

	tabs: ARRAYED_LIST [EV_RIBBON_TAB]
			-- All tabs in current tool bar

	height: INTEGER
			-- Current ribbon height
		require
			exists: exists
		do
			Result := c_height (item)
		end

	exists: BOOLEAN
			-- Does current still exist?
		do
			Result := item /= default_pointer
		end

	dispose
			-- <Precursor>
		do
			if exists then
				destroy
			end
		end

feature {EV_COMMAND_HANDLER, EV_RIBBON} -- Status Report

	item: POINTER
			-- Ribbon framework object

	ui_application: POINTER
			-- IUIApplication object

	command_handler: POINTER
			-- Command handler C object

	observers: detachable ARRAYED_LIST [EV_COMMAND_HANDLER_OBSERVER]
			-- Command handler observers

feature {NONE} -- Access

	associated_window: detachable EV_WINDOW_IMP
			-- Window associated with Current ribbon.

feature {NONE} -- Implementation

	fetch_ui_objects
			-- Fetch ui objects from EV_COMMAND_HANDLER
		do
			observers := command_handler_singleton.observers
			command_handler_singleton.recreate_observers
		end

feature {EV_RIBBON_TITLED_WINDOW_IMP} -- Externals

	com_initialize
			-- Initialize COM
		external
			"C inline use %"Objbase.h%""
		alias
			"CoInitialize (0);"
		end

	com_uninitialize
			-- Clean up COM resources
		external
			"C inline use %"Objbase.h%""
		alias
			"CoUninitialize();"
		end

	create_ribbon_com_framework (a_hwnd: POINTER; a_resource_handle: POINTER): POINTER
			-- Create Ribbon framework, attach ribbon to `a_hwnd'
			-- `a_resource_handle' is a pointer returned by LoadLibrary, the value can be void
			-- If `a_resouce_hanlde' is null, then current executable handle will be used
		external
			"C++ inline use <common.h>"
		alias
			"return InitializeFramework ((HWND) $a_hwnd, (EIF_POINTER)$a_resource_handle);"
		end

	destroy_ribbon_com_framwork (a_framework: POINTER)
			-- Destroy ribbon framwork
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				HRESULT hr = S_OK;
				hr = ((IUIFramework *) $a_framework)->Destroy ();
			}"
		end

	c_height (a_framework: POINTER): INTEGER
			-- Get ribbon height
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				UINT32 val;
				HRESULT hr = S_OK;

				IUIRibbon* pRibbon = NULL;
				if (SUCCEEDED(((IUIFramework *) $a_framework)->GetView(0, IID_IUIRIBBON, (void **) &pRibbon))) {
					hr = pRibbon->GetHeight(&val);
					pRibbon->Release();
				}
				return (EIF_INTEGER) val;
			}"
		end

	c_show_contextual_ui (a_x, a_y: INTEGER_32; a_framework: POINTER; a_command_id: NATURAL_32): NATURAL_32
			-- The IUIContextualUI interface is implemented by the Ribbon framework and provides the core functionality
			-- for the Context Popup View.
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
					HRESULT hr = E_FAIL;

					IUIContextualUI* pContextualUI = NULL;

					if (SUCCEEDED(((IUIFramework *)$a_framework)->GetView(
												(UINT32)$a_command_id,
												IID_PPV_ARGS(&pContextualUI))))
					{
					hr = pContextualUI->ShowAtLocation((INT32)$a_x, (INT32)$a_y);
					pContextualUI->Release();
					}

				return hr;
			}"
		end

	c_set_modes (a_mode: NATURAL_32; a_framework: POINTER)
			-- Set application mode
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				HRESULT hr = S_OK;
				hr = ((IUIFramework *) $a_framework)->SetModes($a_mode);
			}"
		end

feature {NONE} -- Implementation

	c_get_ui_command_property (a_framework: POINTER; a_command_id: NATURAL_32; a_key, a_variant: POINTER): NATURAL_32
			-- Retrieves a command property, value, or state.
		require
			a_framework_not_null: a_framework /= default_pointer
			a_key_not_null: a_key /= default_pointer
			a_variant_not_null: a_variant /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				HRESULT hr = S_OK;
				hr = ((IUIFramework *) $a_framework)->GetUICommandProperty(
					(UINT32) $a_command_id,
					(REFPROPERTYKEY) *(PROPERTYKEY *) $a_key,
					(PROPVARIANT *) $a_variant);
				return hr;
			}"
		end

	c_set_ui_command_property (a_framework: POINTER; a_command_id: NATURAL_32; a_key, a_variant: POINTER): NATURAL_32
			-- Sets a command property, value, or state.
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				HRESULT hr = S_OK;
				hr = ((IUIFramework *) $a_framework)->SetUICommandProperty(
					(UINT32) $a_command_id,
					(REFPROPERTYKEY) *(PROPERTYKEY *)$a_key,
					(REFPROPVARIANT) *(PROPVARIANT *)$a_variant);
				return hr;
			}"
		end

	c_invalidate_ui_command (a_framework: POINTER; a_command_id: NATURAL_32; a_flags: INTEGER; a_key: POINTER)
			-- Invalidates a Windows Ribbon framework Command property, value, or state.
		require
			a_framework_exists: a_framework /= default_pointer
		external
			"C++ inline use <common.h>"
		alias
			"{
				HRESULT hr = S_OK;
				hr = ((IUIFramework *) $a_framework)->InvalidateUICommand(
					(UINT32) $a_command_id,
					(UI_INVALIDATIONS) $a_flags,
					(PROPERTYKEY *) $a_key);
			}"
		end

	c_set_ribbon_color (a_ribbon_framework: POINTER; a_key: POINTER; a_color_value: NATURAL_32)
			-- Set ribbon background color
		external
			"C++ inline use <Propvarutil.h>"
		alias
			"[
			{			
				IPropertyStore *l_spPropertyStore;
				IUIFramework *l_framework = (IUIFramework *) $a_ribbon_framework;

				PROPVARIANT propvarBackground;
				PROPERTYKEY *property_key = (PROPERTYKEY *)$a_key;
				UI_HSBCOLOR BackgroundColor = (UI_HSBCOLOR) $a_color_value;
				InitPropVariantFromUInt32(BackgroundColor, &propvarBackground);

				if (SUCCEEDED(l_framework->QueryInterface(__uuidof(IPropertyStore), (void **)&l_spPropertyStore)))
				{
					 l_spPropertyStore->SetValue(*(property_key), propvarBackground);
 					 l_spPropertyStore->Commit();
 					 l_spPropertyStore->Release();
				}

			}
			]"
		end

	c_ui_make_app_mode (a_mode: NATURAL_32): NATURAL_32
			-- Combine application modes
		external
			"C inline use <common.h>"
		alias
			"return UI_MAKEAPPMODE((INT32) $a_mode);"
		end

feature {EV_RIBBON_DISPACHER} -- Externals callbacks

	on_create_ui_command (a_iui_application: POINTER; a_command_id: NATURAL_32; a_ui_command_type: INTEGER; a_iui_command_handler: POINTER)
			-- Called for each Command specified in the Windows Ribbon framework markup to bind the Command to an IUICommandHandler.
		do
			if ui_application = default_pointer then
				ui_application := a_iui_application
			end
			if ui_application = a_iui_application then
				if command_handler = default_pointer then
					command_handler := c_create_ui_command_handler (a_iui_command_handler)
				end
				c_set_command_handler (command_handler, a_iui_command_handler)
			end
		end

	on_view_changed (a_iui_application: POINTER; a_view_id: NATURAL_32; a_type_id: INTEGER; a_view: POINTER; a_verb, a_reason_code: INTEGER): NATURAL_32
			-- Called when the state of a View changes.
		do
			if ui_application = a_iui_application then
				Result := {WEL_COM_HRESULT}.e_not_impl
				if a_type_id = {EV_VIEW_TYPE}.ribbon then
					inspect a_verb
					when {EV_VIEW_VERB}.create_ then
					when {EV_VIEW_VERB}.size then
							-- We trigger a resizing of the window content associated manually.
						if attached {EV_RIBBON_TITLED_WINDOW_IMP} associated_window as l_window and then l_window.exists then
							l_window.on_size (0, l_window.width, l_window.height)
						end
					when {EV_VIEW_VERB}.destroy then
					else
					end

					Result := {WEL_COM_HRESULT}.s_ok
				end
			end
		end

	c_set_command_handler (a_iui_command_handler: POINTER; a_pointer_pointer: POINTER)
			-- Call COM queryInterface to initialize `a_pointer_pointer'
		external
			"C++ inline use %"eiffel_ribbon.h%""
		alias
			"[
			{
				HRESULT hr;
				IUICommandHandler *pCommandHandler = (IUICommandHandler *)$a_iui_command_handler;	
				IUICommandHandler ** l_command_handler = (IUICommandHandler **)$a_pointer_pointer;
				hr = pCommandHandler->QueryInterface(IID_IUICommandHandler, (void **)l_command_handler);
			}
			]"
		end

	c_create_ui_command_handler (a_iui_command_handler: POINTER): POINTER
			-- Called for each Command specified in the Windows Ribbon framework markup to bind the Command to an IUICommandHandler.
		external
			"C use %"Uiribbon.h%""
		end

	c_load_settings_from_stream (a_framework: POINTER; a_i_stream: POINTER): NATURAL_32
			-- Reads ribbon settings from a binary stream.
		require
			a_framework_exists: a_framework /= default_pointer
			a_i_stream_exists: a_i_stream /= default_pointer
		external
			"C++ inline use %"eiffel_ribbon.h%""
		alias
			"{
				HRESULT hr = S_FALSE;

				IUIRibbon* pRibbon = NULL;
				IStream* l_stream = (IStream *)$a_i_stream;					
				if (SUCCEEDED(((IUIFramework *) $a_framework)->GetView(0, IID_IUIRIBBON, (void **) &pRibbon))) {
					hr = pRibbon->LoadSettingsFromStream(l_stream);
					pRibbon->Release();
				}
				return hr;
			}"
		end

	c_save_settings_to_stream (a_framework: POINTER; a_i_stream: POINTER): NATURAL_32
			-- Writes ribbon settings to a binary stream.
		require
			a_framework_exists: a_framework /= default_pointer
			a_i_stream_exists: a_i_stream /= default_pointer
		external
			"C++ inline use %"eiffel_ribbon.h%""
		alias
			"{
				HRESULT hr = S_FALSE;

				IUIRibbon* pRibbon = NULL;
				IStream* l_stream = (IStream *)$a_i_stream;
				if (SUCCEEDED(((IUIFramework *) $a_framework)->GetView(0, IID_IUIRIBBON, (void **) &pRibbon))) {
					hr = pRibbon->SaveSettingsToStream(l_stream);			
					pRibbon->Release();
				}
				return hr;
			}"
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

