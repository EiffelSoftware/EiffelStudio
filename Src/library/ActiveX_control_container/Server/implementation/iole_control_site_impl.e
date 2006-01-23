indexing
	description: "Implemented `IOleControlSite' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_CONTROL_SITE_IMPL

inherit
	IOLE_CONTROL_SITE_INTERFACE

	OLE_CONTROL_PROXY

	ECOM_EXCEPTION

feature -- Basic Operations

	on_control_info_changed is
			-- No description available.
		do
			-- No Implementation.
		end

	lock_in_place_active (f_lock: INTEGER) is
			-- No description available.
			-- `f_lock' [in].  
		do
			-- No Implementation.
		end

	get_extended_control (pp_disp: CELL [ECOM_INTERFACE]) is
			-- Requests an IDispatch pointer to the extended control.
			-- `pp_disp' [out].  
		do
			pp_disp.put (dispatch)
		end

	transform_coords (p_ptl_himetric: X_POINTL_RECORD; p_ptf_container: TAG_POINTF_RECORD; dw_flags: INTEGER) is
			-- No description available.
			-- `p_ptl_himetric' [in, out].  
			-- `p_ptf_container' [in, out].  
			-- `dw_flags' [in].  
		do
			-- No Implementation.
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD; grf_modifiers: INTEGER) is
			-- No description available.
			-- `p_msg' [in].  
			-- `grf_modifiers' [in].  
		do
			trigger (S_false)
		end

	on_focus (f_got_focus: INTEGER) is
			-- No description available.
			-- `f_got_focus' [in].  
		do
			-- No Implementation.
		end

	show_property_frame is
			-- No description available.
		do
			trigger (E_notimpl)
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




end -- IOLE_CONTROL_SITE_IMPL

