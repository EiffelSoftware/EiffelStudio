indexing
	description: "Implemented `IOleControlSite' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_CONTROL_SITE_IMPL

inherit
	IOLE_CONTROL_SITE_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	on_control_info_changed is
			-- No description available.
		do
			-- Put Implementation here.
		end

	lock_in_place_active (f_lock: INTEGER) is
			-- No description available.
			-- `f_lock' [in].  
		do
			-- Put Implementation here.
		end

	get_extended_control (pp_disp: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_disp' [out].  
		do
			-- Put Implementation here.
		end

	transform_coords (p_ptl_himetric: X_POINTL_RECORD; p_ptf_container: TAG_POINTF_RECORD; dw_flags: INTEGER) is
			-- No description available.
			-- `p_ptl_himetric' [in, out].  
			-- `p_ptf_container' [in, out].  
			-- `dw_flags' [in].  
		do
			-- Put Implementation here.
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD; grf_modifiers: INTEGER) is
			-- No description available.
			-- `p_msg' [in].  
			-- `grf_modifiers' [in].  
		do
			-- Put Implementation here.
		end

	on_focus (f_got_focus: INTEGER) is
			-- No description available.
			-- `f_got_focus' [in].  
		do
			-- Put Implementation here.
		end

	show_property_frame is
			-- No description available.
		do
			-- Put Implementation here.
		end



end -- IOLE_CONTROL_SITE_IMPL

