indexing
	description: "Implemented `IAxWinHostWindow' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HOST_WINDOW_IMPL

inherit
	ECOM_INTERFACE
	
	OLE_CONTROL_PROXY

	EXTERNAL_CONTROLERS
	
	ECOM_FLAGS
		export
			{NONE} all
		end
	
	OLEMISC_CONSTANTS
		export
			{NONE} all
		end

	CONTROL_WINDOW
		undefine
			on_size,
			on_kill_focus,
			on_destroy,
			on_set_focus,
			process_message,
			dispose
		end
	
	WEL_RDW_CONSTANTS
		export
			{NONE} all
		end
	
feature -- Basic Operations

	create_control (lp_trics_data: STRING; p_stream: ECOM_STREAM) is
			-- No description available.
			-- `lp_trics_data' [in].  
			-- `p_stream' [in].  
		local
			ppunk: CELL [ECOM_INTERFACE]
		do
			create ppunk.put (Void)
			create_control_ex (lp_trics_data, p_stream, ppunk, Void, Void)
		end

	create_control_ex (lp_trics_data: STRING; 
					p_stream: ECOM_STREAM; 
					ppunk: CELL [ECOM_INTERFACE]; 
					riid_advise: ECOM_GUID; 
					punk_advise: ECOM_INTERFACE) is
			-- No description available.
			-- `lp_trics_data' [in].  
			-- `p_stream' [in].  
			-- `ppunk' [out].  
			-- `riid_advise' [in].  
			-- `punk_advise' [in].  
		do
			-- Put Implementation here.
		end

	attach_control (p_unk_control: ECOM_INTERFACE) is
			-- No description available.
			-- `p_unk_control' [in].  
		local
			retried: BOOLEAN
		do
			release_all
			cwin_redraw_window (wel_item, Default_pointer, Default_pointer, 
									Rdw_invalidate + 
									Rdw_updatenow + 
									Rdw_erase + 
									Rdw_internalpaint + 
									Rdw_frame)
			if not retried then
				activate_ax (p_unk_control, False, Void)
			end
		rescue
			retried := True
			retry
		end

	activate_ax (p_unk_control: ECOM_INTERFACE; initialized: BOOLEAN; p_stream: ECOM_STREAM) is
			-- Activates COM control.
		local
			pdw_status: INTEGER_REF
			client_site: IOLE_CLIENT_SITE_IMPL_PROXY
			advise_sink: IADVISE_SINK_IMPL_PROXY
			advise_sink_cookie: INTEGER_REF
			a_size_in_pixel: WEL_SIZE
			a_size_in_himetric: WEL_SIZE
			psizel: TAG_SIZEL_RECORD
			a_client_rect: WEL_RECT
		do
			if p_unk_control /= Void then
				unknown_control := p_unk_control
				if ole_object /= Void then
					create pdw_status
					ole_object.get_misc_status (Dvaspect_content, pdw_status)
					if 
						binary_and (pdw_status.item, Olemisc_setclientsitefirst).to_boolean 
					then
						create client_site.make_from_other (Current)
						ole_object.set_client_site (client_site)
					end
					if 
						persist_stream_init /= Void and 
						not initialized 
					then
						if p_stream /= Void then
							persist_stream_init.load (p_stream)
						else
							persist_stream_init.init_new
						end
					end
					if 
						not binary_and (pdw_status.item, Olemisc_setclientsitefirst).to_boolean 
					then
						create client_site.make_from_other (Current)
						ole_object.set_client_site (client_site)
					end
					create advise_sink.make_from_other (Current)
					create advise_sink_cookie
					ole_object.advise (advise_sink, advise_sink_cookie)
					m_dw_ole_object := advise_sink_cookie.item
					if view_object /= Void then
						view_object.set_advise (Dvaspect_content, 0, advise_sink)
					end
					ole_object.set_host_names (wel_class_name, Void)
					
					a_client_rect := client_rect
					create a_size_in_pixel
					a_size_in_pixel.set_width (a_client_rect.width)
					a_size_in_pixel.set_height (a_client_rect.height)
					a_size_in_himetric := pixel_to_himetric (a_size_in_pixel)

					create psizel.make_from_pointer (a_size_in_himetric.item)
					if
						ole_object /= Void
					then
						ole_object.set_extent (Dvaspect_content, psizel)
						ole_object.get_extent (Dvaspect_content, psizel)
					end
					a_size_in_pixel := himetric_to_pixel (a_size_in_himetric)
					create m_position.make_from_wel_rect (a_client_rect)
					m_position.set_right (m_position.left + a_size_in_pixel.width)
					m_position.set_bottom (m_position.top + a_size_in_pixel.height)
					check
						non_void_client_site: client_site /= Void
					end
					ole_object.do_verb (Oleiverb_inplaceactivate, 
										Void, 
										client_site, 
										0, 
										wel_item, 
										m_position)
					
					cwin_redraw_window (wel_item, Default_pointer, Default_pointer, 
									Rdw_invalidate + 
									Rdw_updatenow + 
									Rdw_erase + 
									Rdw_internalpaint + 
									Rdw_frame)
				end
				if object_with_site /= Void then
					object_with_site.set_site (Current)
				end
			end
		end

	set_external_dispatch (p_disp: ECOM_INTERFACE) is
			-- No description available.
			-- `p_disp' [in].  
		do
			external_dispatch := p_disp
		end

	set_external_uihandler (p_disp: IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE) is
			-- No description available.
			-- `p_disp' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				create external_ui_handler.make_from_other (p_disp)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	m_dw_ole_object: INTEGER
	
end -- IAX_WIN_HOST_WINDOW_IMPL

