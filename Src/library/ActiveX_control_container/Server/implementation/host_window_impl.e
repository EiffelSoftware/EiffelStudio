indexing
	description: "Implemented `IAxWinHostWindow' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HOST_WINDOW_IMPL

inherit
	OLE_CONTROL_PROXY

feature -- Basic Operations

	create_control (lp_trics_data: STRING; h_wnd: POINTER; p_stream: ISTREAM_INTERFACE) is
			-- No description available.
			-- `lp_trics_data' [in].  
			-- `h_wnd' [in].  
			-- `p_stream' [in].  
		local
			ppunk: CELL [ECOM_INTERFACE]
		do
			create ppunk.put (Void)
			create_control_ex (lp_trics_data, h_wnd, p_stream, ppunk, Void, Void)
		end

	create_control_ex (lp_trics_data: STRING; h_wnd: POINTER; p_stream: ISTREAM_INTERFACE; ppunk: CELL [ECOM_INTERFACE]; riid_advise: ECOM_GUID; punk_advise: ECOM_INTERFACE) is
			-- No description available.
			-- `lp_trics_data' [in].  
			-- `h_wnd' [in].  
			-- `p_stream' [in].  
			-- `ppunk' [out].  
			-- `riid_advise' [in].  
			-- `punk_advise' [in].  
		do
			-- Put Implementation here.
		end

	attach_control (p_unk_control: ECOM_INTERFACE; h_wnd: POINTER) is
			-- No description available.
			-- `p_unk_control' [in].  
			-- `h_wnd' [in].  
		do
			-- Put Implementation here.
		end

	query_control (riid: ECOM_GUID; ppv_object: CELL [POINTER]) is
			-- No description available.
			-- `riid' [in].  
			-- `ppv_object' [out].  
		do
			-- Put Implementation here.
		end

	set_external_dispatch (p_disp: ECOM_INTERFACE) is
			-- No description available.
			-- `p_disp' [in].  
		do
			-- Put Implementation here.
		end

	set_external_uihandler (p_disp: IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE) is
			-- No description available.
			-- `p_disp' [in].  
		do
			-- Put Implementation here.
		end


end -- IAX_WIN_HOST_WINDOW_IMPL

