indexing
	description: "Implemented `IDocHostUIHandler' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IDOC_HOST_UIHANDLER_IMPL

inherit
	IDOC_HOST_UIHANDLER_INTERFACE

	OLE_CONTROL_PROXY

	EXTERNAL_CONTROLERS
	
	DOC_HOST_UI_FLAG_ENUM
		export
			{NONE} all
		end
	
	DOC_HOST_UI_DBL_CLK_ENUM
		export
			{NONE} all
		end
	
	ECOM_EXCEPTION
	
	AMBIENT_PROPERTIES
	
feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; ppt: TAG_POINT_RECORD; command_target: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE) is
			-- MSHTML requests to display its context menu.
			-- `dw_id' [in].  
			-- `ppt' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		local
			hr: ECOM_HRESULT
		do
			if external_ui_handler /= Void then
				hr := external_ui_handler.show_context_menu (dw_id, 
											ppt.x, 
											ppt.y, 
											command_target, 
											pdisp_reserved)								
				if hr.item /= S_ok then
					trigger (hr.item)
				end
			end
		end

	get_host_info (p_info: X_DOCHOSTUIINFO_RECORD) is
			-- Called at initialisation to find UI styles from container.
			-- `p_info' [in, out].  
		local
			pdw_flags, pdw_double_click: INTEGER_REF
		do
			if external_ui_handler /= Void then
				create pdw_flags
				pdw_flags.set_item (p_info.dw_flags)
				create pdw_double_click
				pdw_double_click.set_item (p_info.dw_double_click)
				external_ui_handler.get_host_info (pdw_flags, pdw_double_click)
			else
				p_info.set_dw_flags (m_doc_host_flags)
				p_info.set_dw_double_click (m_doc_host_double_click_flags)
			end
		end

	show_ui (dw_id: INTEGER; p_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE; p_command_target: IOLE_COMMAND_TARGET_INTERFACE; p_frame: IOLE_IN_PLACE_FRAME_INTERFACE; p_doc: IOLE_IN_PLACE_UIWINDOW_INTERFACE) is
			-- Allows the host to replace the IE4/MSHTML menus and toolbars.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		local
			hr: ECOM_HRESULT
		do
			if external_ui_handler /= Void then
				hr := external_ui_handler.show_ui (dw_id, p_active_object, p_command_target, p_frame, p_doc)
				if hr.item /= S_ok then
					trigger (hr.item)
				end
			end
		end

	hide_ui is
			-- Called when IE4/MSHTML removes its menus and toolbars.
		do
			if external_ui_handler /= Void then
				external_ui_handler.hide_ui
			end
		end

	update_ui is
			-- Notifies the host that the command state has changed.
		do
			if external_ui_handler /= Void then
				external_ui_handler.update_ui
			end
		end

	enable_modeless (f_enable: INTEGER) is
			-- Called from the IE4/MSHTML implementation of
			-- IOleInPlaceActiveObject::EnableModeless.
			-- `f_enable' [in].  
		local
			boolean: BOOLEAN
		do
			if external_ui_handler /= Void then
				if f_enable = 0 then
					boolean := False
				else
					boolean := True
				end
				external_ui_handler.enable_modeless (boolean)
			end
		end

	on_doc_window_activate (f_activate: INTEGER) is
			-- Called from the IE4/MSHTML implementation of
			-- IOleInPlaceActiveObject::OnDocWindowActivate.
			-- `f_activate' [in].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.on_doc_window_activate (f_activate.to_boolean)
			end
		end

	on_frame_window_activate (f_activate: INTEGER) is
			-- Called from the IE4/MSHTML implementation of
			-- IOleInPlaceActiveObject::OnFrameWindowActivate.
			-- `f_activate' [in].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.on_frame_window_activate (f_activate.to_boolean)
			end
		end

	resize_border (prc_border: TAG_RECT_RECORD; 
		p_uiwindow: IOLE_IN_PLACE_UIWINDOW_INTERFACE; 
		f_rame_window: INTEGER) is
			-- Called from the IE4/MSHTML implementation of
			-- IOleInPlaceActiveObject::ResizeBorder.
			-- `prc_border' [in].  
			-- `p_uiwindow' [in].  
			-- `f_rame_window' [in].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.resize_border (	prc_border.left, 
											prc_border.top,
											prc_border.right,
											prc_border.bottom,
											p_uiwindow,
											f_rame_window.to_boolean)
			end
		end

	translate_accelerator (lpmsg: TAG_MSG_RECORD; pguid_cmd_group: ECOM_GUID; n_cmd_id: INTEGER) is
			-- Called by IE4/MSHTML when
			-- IOleInPlaceActiveObject::TranslateAccelerator or
			-- IOleControlSite::TranslateAccelerator is called. 
			-- `lpmsg' [in].  
			-- `pguid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		local
			hr: ECOM_HRESULT
		do
			create hr.make_from_integer (S_false)
			if external_ui_handler /= Void then
				hr := external_ui_handler.translate_accelerator (lpmsg.h_wnd_integer,
														lpmsg.message,
														lpmsg.w_param,
														lpmsg.l_param,
														pguid_cmd_group.to_string,
														n_cmd_id)
				
			end
			if hr.item /= S_ok then
				trigger (hr.item)
			end
		end

	get_option_key_path (pch_key: CELL [STRING]; dw: INTEGER) is
			-- Returns the registry key under which IE4/MSHTML 
			-- stores user preferences. 
			-- Returns S_OK if successful, or S_FALSE otherwise. 
			-- If S_FALSE, IE4/MSHTML will default to its own user options.
			-- `pch_key' [out].  
			-- `dw' [in].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.get_option_key_path (pch_key, dw)
			else
				pch_key.put (clone (m_option_key_path))
			end
		end

	get_drop_target (p_drop_target: IDROP_TARGET_INTERFACE; pp_drop_target: CELL [IDROP_TARGET_INTERFACE]) is
			-- Called by IE4/MSHTML when it is being used as 
			-- a drop target to allow the host to supply an 
			-- alternative IDropTarget.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		local
			unknown_cell: CELL [ECOM_INTERFACE]
			drop_target: IDROP_TARGET_IMPL_PROXY
			retried: BOOLEAN
		do
			if not retried then
				if external_ui_handler /= Void then
					create unknown_cell.put (Void)
					external_ui_handler.get_drop_target (p_drop_target, unknown_cell)
					if unknown_cell.item /= Void then
						create drop_target.make_from_other (unknown_cell.item)
						pp_drop_target.put (drop_target)
					end
				end
			else
				trigger (S_false)
			end
		rescue
			retried := True
			retry
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- Called by IE4/MSHTML to obtain the host's IDispatch interface.
			-- `pp_dispatch' [out].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.get_external (pp_dispatch)
			else
				pp_dispatch.put (external_dispatch)
			end
		end

	translate_url (dw_translate: INTEGER; pch_urlin: STRING; ppch_urlout: CELL [STRING]) is
			-- Called by IE4/MSHTML to allow the host an 
			-- opportunity to modify the URL to be loaded.
			-- `dw_translate' [in].  
			-- `pch_urlin' [in].  
			-- `ppch_urlout' [out].  
		do
			if external_ui_handler /= Void then
				external_ui_handler.translate_url (dw_translate, pch_urlin, ppch_urlout)
			end
		end

	filter_data_object (p_do: IDATA_OBJECT_INTERFACE; pp_doret: CELL [IDATA_OBJECT_INTERFACE]) is
			-- Called on the host by IE4/MSHTML to allow 
			-- the host to replace IE4/MSHTML's data object.
			-- This allows the host to block certain clipboard 
			-- formats or support additional clipboard formats. 
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		local
			unknown_cell: CELL [ECOM_INTERFACE]
			l_data_object: IDATA_OBJECT_IMPL_PROXY
			retried: BOOLEAN
		do
			if not retried then
				if external_ui_handler /= Void then
					create unknown_cell.put (Void)
					external_ui_handler.filter_data_object (p_do, unknown_cell)
					if unknown_cell.item /= Void then
						create l_data_object.make_from_other (unknown_cell.item)
						pp_doret.put (l_data_object)
					end
				end
			else
				trigger (S_false)
			end
		rescue
			retried := True
			retry
		end
	
end -- IDOC_HOST_UIHANDLER_IMPL

