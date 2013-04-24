note
	description: "Ambient properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AMBIENT_PROPERTIES
	
feature -- Access

	m_allow_windowless_activation: BOOLEAN 
			-- Enable or disable windowless activation

	background_color: WEL_COLOR_REF 
			-- Set the background color

	foreground_color: WEL_COLOR_REF 
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

	m_option_key_path: STRING; 
			-- Set the option key path
			
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- AMBIENT_PROPERTIES
