indexing
	description: "Implemented `IAxWinAmbientDispatch' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IAX_WIN_AMBIENT_DISPATCH_IMPL

inherit
	IAX_WIN_AMBIENT_DISPATCH_INTERFACE

	OLE_CONTROL_PROXY
	
	ECOM_STANDARD_DISPID_ENUM
		export
			{NONE} all
		end
	
	AMBIENT_PROPERTIES

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Access

	allow_windowless_activation: BOOLEAN is
			-- Enable or disable windowless activation
		do
			Result := m_allow_windowless_activation
		end

	back_color: INTEGER is
			-- Set the background color
		do
			if background_color = Void then
				create background_color.make_by_color (Color_background)
			end
			Result := background_color.item
		end

	fore_color: INTEGER is
			-- Set the ambient foreground color
		do
			if foreground_color = Void then
				create foreground_color.make_by_color (Color_window)
			end
			Result := foreground_color.item
		end

	locale_id: INTEGER is
			-- Set the ambient locale
		do
			Result := m_locale_id
		end

	user_mode: BOOLEAN is
			-- Set the ambient user mode
		do
			Result := m_user_mode
		end

	display_as_default: BOOLEAN is
			-- Enable or disable the control as default
		do
			Result := m_display_as_default
		end

	font: FONT_INTERFACE is
			-- Set the ambient font
		do
			Result := m_font
			-- Put Implementation here.
		end

	message_reflect: BOOLEAN is
			-- Enable or disable message reflection
		do
			Result := m_message_reflect
		end

	doc_host_flags: INTEGER is
			-- Set the DOCHOSTUIFLAG flags
		do
			Result := m_doc_host_flags
		end

	doc_host_double_click_flags: INTEGER is
			-- Set the DOCHOSTUIDBLCLK flags
		do
			Result := m_doc_host_double_click_flags
		end

	allow_context_menu: BOOLEAN is
			-- Enable or disable context menus
		do
			Result := m_allow_context_menu
		end

	allow_show_ui: BOOLEAN is
			-- Enable or disable UI
		do
			Result := m_allow_show_ui
		end

	option_key_path: STRING is
			-- Set the option key path
		do
			Result := m_option_key_path
		end

feature -- Basic Operations

	set_allow_windowless_activation (pb_can_windowless_activate: BOOLEAN) is
			-- Enable or disable windowless activation
			-- `pb_can_windowless_activate' [in].  
		do
			m_allow_windowless_activation := pb_can_windowless_activate
		end

	set_back_color (pclr_background: INTEGER) is
			-- Set the background color
			-- `pclr_background' [in].  
		do
			create background_color.make_by_color (pclr_background)
			fire_ambient_property_change (DISPID_AMBIENT_BACKCOLOR)
			invalidate_rect (Void, 0)
		end

	set_fore_color (pclr_foreground: INTEGER) is
			-- Set the ambient foreground color
			-- `pclr_foreground' [in].  
		do
			create foreground_color.make_by_color (pclr_foreground)
			fire_ambient_property_change (DISPID_AMBIENT_FORECOLOR)
		end

	set_locale_id (plcid_locale_id: INTEGER) is
			-- Set the ambient locale
			-- `plcid_locale_id' [in].  
		do
			m_locale_id := plcid_locale_id
			fire_ambient_property_change (DISPID_AMBIENT_LOCALEID)
		end

	set_user_mode (pb_user_mode: BOOLEAN) is
			-- Set the ambient user mode
			-- `pb_user_mode' [in].  
		do
			m_user_mode := pb_user_mode
			fire_ambient_property_change (DISPID_AMBIENT_USERMODE)
		end

	set_display_as_default (pb_display_as_default: BOOLEAN) is
			-- Enable or disable the control as default
			-- `pb_display_as_default' [in].  
		do
			m_display_as_default := pb_display_as_default
			fire_ambient_property_change (DISPID_AMBIENT_DISPLAYASDEFAULT)
		end

	set_font (p_font: FONT_INTERFACE) is
			-- Set the ambient font
			-- `p_font' [in].  
		do
			m_font := p_font
			fire_ambient_property_change (DISPID_AMBIENT_FONT)
		end

	set_message_reflect (pb_msg_reflect: BOOLEAN) is
			-- Enable or disable message reflection
			-- `pb_msg_reflect' [in].  
		do
			m_message_reflect := pb_msg_reflect
			fire_ambient_property_change (DISPID_AMBIENT_MESSAGEREFLECT)
		end

	show_grab_handles (pb_show_grab_handles: BOOLEAN_REF) is
			-- Show or hide grab handles
			-- `pb_show_grab_handles' [out].  
		do
			pb_show_grab_handles.set_item (False)
		end

	show_hatching (pb_show_hatching: BOOLEAN_REF) is
			-- Are grab handles enabled
			-- `pb_show_hatching' [out].  
		do
			pb_show_hatching.set_item (False)
		end

	set_doc_host_flags (pdw_doc_host_flags: INTEGER) is
			-- Set the DOCHOSTUIFLAG flags
			-- `pdw_doc_host_flags' [in].  
		do
			m_doc_host_flags := pdw_doc_host_flags
			fire_ambient_property_change (DISPID_UNKNOWN)
		end

	set_doc_host_double_click_flags (pdw_doc_host_double_click_flags: INTEGER) is
			-- Set the DOCHOSTUIDBLCLK flags
			-- `pdw_doc_host_double_click_flags' [in].  
		do
			m_doc_host_double_click_flags := pdw_doc_host_double_click_flags
		end

	set_allow_context_menu (pb_allow_context_menu: BOOLEAN) is
			-- Enable or disable context menus
			-- `pb_allow_context_menu' [in].  
		do
			m_allow_context_menu := pb_allow_context_menu
		end

	set_allow_show_ui (pb_allow_show_ui: BOOLEAN) is
			-- Enable or disable UI
			-- `pb_allow_show_ui' [in].  
		do
			m_allow_show_ui := pb_allow_show_ui
		end

	set_option_key_path (pbstr_option_key_path: STRING) is
			-- Set the option key path
			-- `pbstr_option_key_path' [in].  
		do
			m_option_key_path := pbstr_option_key_path
		end

feature {NONE} -- Implementaion

	fire_ambient_property_change (disp_changed: INTEGER) is
			-- Notify control that ambient property has changed.
		require
			non_void_control_unknown: unknown_control /= Void
		do
			if m_ole_control = Void then
				m_ole_control := ole_control
			end
			if m_ole_control /= Void then
				m_ole_control.on_ambient_property_change (disp_changed)
			end
		end

	invalidate_rect (p_rect: TAG_RECT_RECORD; f_erase: INTEGER) is
			-- Enables an object to invalidate a specified 
			-- rectangle of its in-place image on the screen.
			-- 
			-- `p_rect' [in]. Rectangle to invalidate, in client
			-- coordinates of the containing window. If this 
			-- parameter is Void, the object's full extent is
			-- invalidated. 
			-- `f_erase' [in]. Specifies whether the background 
			-- within the update region is to be erased when the 
			-- region is updated. If this parameter is TRUE, the
			-- background is erased. If this parameter is FALSE, 
			-- the background remains unchanged. 
			--
			-- Implemented in IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL.
		deferred
			-- Put Implementation here.
		end

end -- IAX_WIN_AMBIENT_DISPATCH_IMPL

