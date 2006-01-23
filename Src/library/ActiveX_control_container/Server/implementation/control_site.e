indexing
	description: "Control Site."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROL_SITE

inherit
	WEL_COLOR_CONTROL
		rename
			exists as wel_exists
		end
	
	HOST_WINDOW_IMPL
		redefine
			make
		end

	IOLE_CLIENT_SITE_IMPL

	IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL
		redefine
			make
		end

	IOLE_CONTROL_SITE_IMPL
		undefine
			dispose
		end

	IOLE_CONTAINER_IMPL
		undefine
			dispose
		end

	IOBJECT_WITH_SITE_IMPL

	IPROPERTY_NOTIFY_SINK_IMPL

	IAX_WIN_AMBIENT_DISPATCH_IMPL

	IDOC_HOST_UIHANDLER_IMPL
		rename
			translate_accelerator as idoc_host_uihandler_translate_accelerator1,
			translate_accelerator_user_precondition as idoc_host_uihandler_translate_accelerator1_user_precondition
		undefine
			dispose
		end

	IADVISE_SINK_IMPL
	
	ISERVICE_PROVIDER_IMPL
		undefine
			dispose
		end

	ECOM_STUB

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING) is
			-- Make the window as a child of `a_parent' and
			-- `a_name' as a title.
		do
			Precursor {HOST_WINDOW_IMPL} (a_parent, a_name)
			m_allow_context_menu := True
			m_doc_host_flags := Dochostuiflag_no3dborder
			m_doc_host_double_click_flags := Dochostuidblclk_default
		end

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end
		
feature {NONE} -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::control_site %"ecom_control_library_control_site_s.h%"](EIF_OBJECT)"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- CONTROL_SITE

