indexing
	description: "Implemented `IAxWinAmbientDispatch' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IAX_WIN_AMBIENT_DISPATCH_IMPL

inherit
	IAX_WIN_AMBIENT_DISPATCH_INTERFACE

	OLE_CONTROL_PROXY
	
feature -- Access

	allow_windowless_activation: BOOLEAN is
			-- Enable or disable windowless activation
		do
			-- Put Implementation here.
		end

	back_color: INTEGER is
			-- Set the background color
		do
			-- Put Implementation here.
		end

	fore_color: INTEGER is
			-- Set the ambient foreground color
		do
			-- Put Implementation here.
		end

	locale_id: INTEGER is
			-- Set the ambient locale
		do
			-- Put Implementation here.
		end

	user_mode: BOOLEAN is
			-- Set the ambient user mode
		do
			-- Put Implementation here.
		end

	display_as_default: BOOLEAN is
			-- Enable or disable the control as default
		do
			-- Put Implementation here.
		end

	font: FONT_INTERFACE is
			-- Set the ambient font
		do
			-- Put Implementation here.
		end

	message_reflect: BOOLEAN is
			-- Enable or disable message reflection
		do
			-- Put Implementation here.
		end

	doc_host_flags: INTEGER is
			-- Set the DOCHOSTUIFLAG flags
		do
			-- Put Implementation here.
		end

	doc_host_double_click_flags: INTEGER is
			-- Set the DOCHOSTUIDBLCLK flags
		do
			-- Put Implementation here.
		end

	allow_context_menu: BOOLEAN is
			-- Enable or disable context menus
		do
			-- Put Implementation here.
		end

	allow_show_ui: BOOLEAN is
			-- Enable or disable UI
		do
			-- Put Implementation here.
		end

	option_key_path: STRING is
			-- Set the option key path
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	set_allow_windowless_activation (pb_can_windowless_activate: BOOLEAN) is
			-- Enable or disable windowless activation
			-- `pb_can_windowless_activate' [in].  
		do
			-- Put Implementation here.
		end

	set_back_color (pclr_background: INTEGER) is
			-- Set the background color
			-- `pclr_background' [in].  
		do
			-- Put Implementation here.
		end

	set_fore_color (pclr_foreground: INTEGER) is
			-- Set the ambient foreground color
			-- `pclr_foreground' [in].  
		do
			-- Put Implementation here.
		end

	set_locale_id (plcid_locale_id: INTEGER) is
			-- Set the ambient locale
			-- `plcid_locale_id' [in].  
		do
			-- Put Implementation here.
		end

	set_user_mode (pb_user_mode: BOOLEAN) is
			-- Set the ambient user mode
			-- `pb_user_mode' [in].  
		do
			-- Put Implementation here.
		end

	set_display_as_default (pb_display_as_default: BOOLEAN) is
			-- Enable or disable the control as default
			-- `pb_display_as_default' [in].  
		do
			-- Put Implementation here.
		end

	set_font (p_font: FONT_INTERFACE) is
			-- Set the ambient font
			-- `p_font' [in].  
		do
			-- Put Implementation here.
		end

	set_message_reflect (pb_msg_reflect: BOOLEAN) is
			-- Enable or disable message reflection
			-- `pb_msg_reflect' [in].  
		do
			-- Put Implementation here.
		end

	show_grab_handles (pb_show_grab_handles: BOOLEAN_REF) is
			-- Show or hide grab handles
			-- `pb_show_grab_handles' [out].  
		do
			-- Put Implementation here.
		end

	show_hatching (pb_show_hatching: BOOLEAN_REF) is
			-- Are grab handles enabled
			-- `pb_show_hatching' [out].  
		do
			-- Put Implementation here.
		end

	set_doc_host_flags (pdw_doc_host_flags: INTEGER) is
			-- Set the DOCHOSTUIFLAG flags
			-- `pdw_doc_host_flags' [in].  
		do
			-- Put Implementation here.
		end

	set_doc_host_double_click_flags (pdw_doc_host_double_click_flags: INTEGER) is
			-- Set the DOCHOSTUIDBLCLK flags
			-- `pdw_doc_host_double_click_flags' [in].  
		do
			-- Put Implementation here.
		end

	set_allow_context_menu (pb_allow_context_menu: BOOLEAN) is
			-- Enable or disable context menus
			-- `pb_allow_context_menu' [in].  
		do
			-- Put Implementation here.
		end

	set_allow_show_ui (pb_allow_show_ui: BOOLEAN) is
			-- Enable or disable UI
			-- `pb_allow_show_ui' [in].  
		do
			-- Put Implementation here.
		end

	set_option_key_path (pbstr_option_key_path: STRING) is
			-- Set the option key path
			-- `pbstr_option_key_path' [in].  
		do
			-- Put Implementation here.
		end

feature {NONE} -- Implementaion

	m_allow_windowless_activation: BOOLEAN 
			-- Enable or disable windowless activation

	m_back_color: INTEGER 
			-- Set the background color

	m_fore_color: INTEGER 
			-- Set the ambient foreground color

	m_locale_id: INTEGER 
			-- Set the ambient locale

	m_user_mode: BOOLEAN 
			-- Set the ambient user mode

	m_display_as_default: BOOLEAN 
			-- Enable or disable the control as default

	m_font: FONT_INTERFACE 
			-- Set the ambient font

	m_message_reflect: BOOLEAN 
			-- Enable or disable message reflection

	m_doc_host_flags: INTEGER 
			-- Set the DOCHOSTUIFLAG flags

	m_doc_host_double_click_flags: INTEGER 
			-- Set the DOCHOSTUIDBLCLK flags

	m_allow_context_menu: BOOLEAN 
			-- Enable or disable context menus

	m_allow_show_ui: BOOLEAN 
			-- Enable or disable UI

	m_option_key_path: STRING 
			-- Set the option key path
		
	fire_ambient_property_change (disp_changed: INTEGER) is
			-- Notify control that ambient property has changed.
		require
			non_void_control_unknown: m_unknown /= Void
		do
			if ole_control /= Void then
				ole_control.on_ambient_property_change (disp_changed)
			end
		end

end -- IAX_WIN_AMBIENT_DISPATCH_IMPL

