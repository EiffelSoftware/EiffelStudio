indexing
	description: "Implemented `IDocHostUIHandler' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IDOC_HOST_UIHANDLER_IMPL

inherit
	IDOC_HOST_UIHANDLER_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; ppt: TAG_POINT_RECORD; pcmdt_reserved: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE) is
			-- No description available.
			-- `dw_id' [in].  
			-- `ppt' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		do
			-- Put Implementation here.
		end

	get_host_info (p_info: X_DOCHOSTUIINFO_RECORD) is
			-- No description available.
			-- `p_info' [in, out].  
		do
			-- Put Implementation here.
		end

	show_ui (dw_id: INTEGER; p_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE; p_command_target: IOLE_COMMAND_TARGET_INTERFACE; p_frame: IOLE_IN_PLACE_FRAME_INTERFACE; p_doc: IOLE_IN_PLACE_UIWINDOW_INTERFACE) is
			-- No description available.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		do
			-- Put Implementation here.
		end

	hide_ui is
			-- No description available.
		do
			-- Put Implementation here.
		end

	update_ui is
			-- No description available.
		do
			-- Put Implementation here.
		end

	enable_modeless (f_enable: INTEGER) is
			-- No description available.
			-- `f_enable' [in].  
		do
			-- Put Implementation here.
		end

	on_doc_window_activate (f_activate: INTEGER) is
			-- No description available.
			-- `f_activate' [in].  
		do
			-- Put Implementation here.
		end

	on_frame_window_activate (f_activate: INTEGER) is
			-- No description available.
			-- `f_activate' [in].  
		do
			-- Put Implementation here.
		end

	resize_border (prc_border: TAG_RECT_RECORD; p_uiwindow: IOLE_IN_PLACE_UIWINDOW_INTERFACE; f_rame_window: INTEGER) is
			-- No description available.
			-- `prc_border' [in].  
			-- `p_uiwindow' [in].  
			-- `f_rame_window' [in].  
		do
			-- Put Implementation here.
		end

	translate_accelerator (lpmsg: TAG_MSG_RECORD; pguid_cmd_group: ECOM_GUID; n_cmd_id: INTEGER) is
			-- No description available.
			-- `lpmsg' [in].  
			-- `pguid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		do
			-- Put Implementation here.
		end

	get_option_key_path (pch_key: CELL [STRING]; dw: INTEGER) is
			-- No description available.
			-- `pch_key' [out].  
			-- `dw' [in].  
		do
			-- Put Implementation here.
		end

	get_drop_target (p_drop_target: IDROP_TARGET_INTERFACE; pp_drop_target: CELL [IDROP_TARGET_INTERFACE]) is
			-- No description available.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		do
			-- Put Implementation here.
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_dispatch' [out].  
		do
			-- Put Implementation here.
		end

	translate_url (dw_translate: INTEGER; pch_urlin: INTEGER_REF; ppch_urlout: CELL [INTEGER_REF]) is
			-- No description available.
			-- `dw_translate' [in].  
			-- `pch_urlin' [in].  
			-- `ppch_urlout' [out].  
		do
			-- Put Implementation here.
		end

	filter_data_object (p_do: IDATA_OBJECT_INTERFACE; pp_doret: CELL [IDATA_OBJECT_INTERFACE]) is
			-- No description available.
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		do
			-- Put Implementation here.
		end


end -- IDOC_HOST_UIHANDLER_IMPL

