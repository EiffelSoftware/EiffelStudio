indexing

	description: "Dispatcher: Transmit messages from OLE to%
					%the corresponding Eiffel object"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CALL_DISPATCHER

creation 
	make

feature -- Initialization

	make is
			-- Initialize dispatcher.
		do
			ole2_setup_ocx_dispatcher ($Current)
		end

feature -- Element change

	on_unknown_status_code (unk: EOLE_UNKNOWN): INTEGER is
			-- Last error code
		do
			Result := unk.status.last_hresult
		end

	on_unknown_set_last_hresult (unk: EOLE_UNKNOWN; status: INTEGER) is
			-- Set last error code
		do
			unk.set_last_hresult (status)
		end

	on_unknown_query_interface (unk: EOLE_UNKNOWN; iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if the interface is not supported.
		do
			if unk.delegate = Void then
				Result := unk.on_query_interface (iid)
			else
				Result := unk.delegate.on_query_interface (iid)
			end
		end

	on_unknown_add_ref (unk: EOLE_UNKNOWN): INTEGER is
			-- Standard AddRef method.
		do
			if unk.delegate = Void then
				Result := unk.on_add_ref
			else
				Result := unk.delegate.on_add_ref
			end
		end

	on_unknown_release (unk: EOLE_UNKNOWN): INTEGER is
			-- Standard Release method.
		do
			if unk.delegate = Void then
				Result := unk.on_release
			else
				Result := unk.delegate.on_release
			end
		end

	on_unknown_reference_counter (unk: EOLE_UNKNOWN): INTEGER is
			-- Reference count
		do
			if unk.delegate = Void then
				Result := unk.reference_counter
			else
				Result := unk.delegate.reference_counter
			end
		end
		
	on_clsfact_create_instance (clsfact: EOLE_CLASS_FACTORY; ip_controller: POINTER; class_id: STRING): POINTER is
			-- Create an instance of an object with `interface_identifier'
			-- interface, which may optionally be controlled by `ip_controller'.
		do
			Result := clsfact.on_create_instance (ip_controller, class_id)
		end

	on_clsfact_lock_server (clsfact: EOLE_CLASS_FACTORY; lock: BOOLEAN) is
			-- Keep server in memory even if not servicing when
			-- `lock' is true.
		do
			clsfact.on_lock_server (lock)
		end

	on_dispatch_get_type_info_count (dispatch: EOLE_DISPATCH): INTEGER is
			-- Number of type interfaces supported by `oledispatch'
			-- May be only 0 or 1 - nothing else.
		do
			Result := dispatch.on_get_type_info_count
		end

	on_dispatch_get_type_info (dispatch: EOLE_DISPATCH): POINTER is
			-- Type information for `oledispatch'
		local
			type_info: EOLE_TYPE_INFO
		do
			type_info := dispatch.on_get_type_info
			if type_info /= Void then
				Result := type_info.ole_interface_ptr
			end
		end

	on_dispatch_get_ids_of_names (dispatch: EOLE_DISPATCH; names: ARRAY [STRING]): ARRAY [INTEGER] is
			-- Maps `names' to their 'dispids'. First element 
			-- in arrays correspond to member name, others 
			-- to parameter names.
		do
			Result := dispatch.on_get_ids_of_names (names)
		end

	on_dispatch_invoke (dispatch: EOLE_DISPATCH; dispid, flags: INTEGER; params, res, exception: POINTER) is
			-- Invoke corresponding method or access property with
			-- dispatch identifier `dispid' according to `flags'.
			-- `params' are the arguments, `res' will receive the
			-- result and `exception' the description of the
			-- exception that occured (if any).
			-- See EOLE_INVOKE_FLAGS for `flags' value.
		local
			dispparams: EOLE_DISPPARAMS
			varresult: EOLE_VARIANT
			excepinfo: EOLE_EXCEPINFO
		do
			!! dispparams
			dispparams.attach (params)
			!! excepinfo
			excepinfo.attach (exception)
			if res /= default_pointer then
				!! varresult
				varresult.attach (res)
				dispatch.on_invoke (dispid, flags, dispparams, varresult, excepinfo)
			else
				dispatch.on_invoke (dispid, flags, dispparams, Void, excepinfo)
			end			
		end
	
	on_font_get_name (font: EOLE_FONT): POINTER is
			-- Font name
		do
			Result := font.on_get_name.ole_ptr
		end
		
	on_font_put_name (font: EOLE_FONT; name: POINTER) is
			-- Set font name with `name'
		local
			bstr: EOLE_BSTR
		do
			!! bstr.make_from_ptr (name)
			font.on_put_name (bstr)
		end
		
	on_font_get_size (font: EOLE_FONT): POINTER is
			-- Font size
		do
			Result := font.on_get_size.ole_ptr
		end
		
	on_font_put_size (font: EOLE_FONT; size: POINTER) is
			-- Set font size with `size'
		local
			cur: EOLE_CURRENCY
		do
			!! cur
			cur.attach (size)
			font.on_put_size (cur)
		end
	
	on_font_get_bold (font: EOLE_FONT): BOOLEAN is
			-- Is font bold?
		do
			Result := font.on_get_bold
		end
		
	on_font_put_bold (font: EOLE_FONT; bold: BOOLEAN) is
			-- Set bold format with `bold'
		do
			font.on_put_bold (bold)
		end
		
	on_font_get_italic (font: EOLE_FONT): BOOLEAN is
			-- Is font italic?
		do
			Result := font.on_get_italic
		end
	
	on_font_put_italic (font: EOLE_FONT; italic: BOOLEAN) is
			-- Set italic format with `italic'
		do
			font.on_put_italic (italic)
		end
		
	on_font_get_underline (font: EOLE_FONT): BOOLEAN is
			-- Is font underline?
		do
			Result := font.on_get_underline
		end
			
	on_font_put_underline (font: EOLE_FONT; underline: BOOLEAN) is
			-- Set underline format with `underline'
		do
			font.on_put_underline (underline)
		end
			
	on_font_get_strikethrough (font: EOLE_FONT): BOOLEAN is
			-- Is font strikethrough?
		do
			Result := font.on_get_strikethrough
		end

	on_font_put_strikethrough (font: EOLE_FONT; strikethrough: BOOLEAN) is
			-- Set strikethrough format with `strikethrough'
		do
			font.on_put_strikethrough (strikethrough)
		end
		
	on_font_get_weight (font: EOLE_FONT): INTEGER is
			-- Font weight
		do
			Result := font.on_get_weight
		end
		
	on_font_put_weight (font: EOLE_FONT; weight: INTEGER) is
			-- Set font weight with `weight'
		do
			font.on_put_weight (weight)
		end
		
	on_font_get_charset(font: EOLE_FONT): INTEGER is
			-- Font character set
		do
			Result := font.on_get_charset
		end
		
	on_font_put_charset (font: EOLE_FONT; charset: INTEGER) is
			-- Set font character set with `charset'
		do
			font.on_put_charset (charset)
		end
		
	on_font_get_hfont (font: EOLE_FONT): INTEGER is
			-- Windows font handle.
		do
			Result := font.on_get_h_font
		end
				
	on_font_clone (font: EOLE_FONT): POINTER is
			-- Clone of `font'
		local
			font_clone: EOLE_FONT
		do
			font_clone := font.on_font_clone
			if font_clone /= Void then
				Result := font_clone.ole_interface_ptr
			end
		end
		
	on_font_is_equal (font: EOLE_FONT; other: POINTER) is
			-- Is `font' same as `other'?
		local
			other_font: EOLE_FONT
		do
			!! other_font.make
			other_font.attach_ole_interface_ptr (other)
			font.on_is_equal_font (other_font)
		end
		
	on_font_set_ratio (font: EOLE_FONT; cy_logical: INTEGER; cy_himetric: INTEGER) is
			-- Convert the scaling factor between logical units and
			-- HIMETRIC units with `cy_logical' and `cy_himetric'.
		do
			font.on_set_ratio (cy_logical, cy_himetric)
		end
			
	on_font_query_text_metrics (font: EOLE_FONT): POINTER is
			-- Describe `font'.T
		do
			Result := font.on_query_text_metrics.ole_ptr
		end

	on_font_add_ref_hfont (font: EOLE_FONT; hfont: INTEGER) is
			-- Notify `font' that previously realized font identified with `hFont'
			-- should remain valid until `release_hfont' is called or `font'
			-- itself is released. 
		do
			font.on_add_ref_hfont (hfont)
		end
		
	on_font_release_hfont (font: EOLE_FONT; hfont: INTEGER) is
			-- Notify `font' that caller that previously locked it in
			-- cache with `add_ref_hfont' no longer requires lock.
		do
			font.on_release_hfont (hfont)
		end

	on_font_set_hdc (font: EOLE_FONT; hdc: INTEGER) is
			-- Provide device context handle `hdc' to `font' that 
			-- describes logical mapping mode. 
		do
			font.on_set_hdc (hdc)
		end
	
	on_font_disp_invoke (font_disp: EOLE_FONT_DISP; dispid, flags: INTEGER; 
							params: POINTER; res: POINTER; 
							exception: POINTER) is
			-- Expose `font' properties through Automation.
		local
			par: EOLE_DISPPARAMS
			resul: EOLE_VARIANT
			exc: EOLE_EXCEPINFO
		do
			!! par
			!! resul
			!! exc
			par.attach (params)
			resul.attach (res)
			exc.attach (exception)
			font_disp.on_invoke (dispid, flags, par, resul, exc)
		end
		
	on_picture_get_handle (picture: EOLE_PICTURE): INTEGER is
			-- Windows GDI handle of `picture'.
		do
			Result := picture.on_get_handle
		end

	on_picture_get_hpal (picture: EOLE_PICTURE): INTEGER is
			-- Windows handle of palette used by `picture'
		do
			Result := picture.on_get_hpal
		end

	on_picture_get_type (picture: EOLE_PICTURE): INTEGER is
			-- Type of picture
			-- (See EOLE_PICTYPE for `Result' value.)
		do
			Result := picture.on_get_type
		end

	on_picture_get_width (picture: EOLE_PICTURE): INTEGER is
			-- Current width of picture in picture object
		do
			Result := picture.on_get_width
		end

	on_picture_get_height (picture: EOLE_PICTURE): INTEGER is
			-- Current height of picture in picture object
		do
			Result := picture.on_get_height
		end
	
	on_picture_get_cur_dc (picture: EOLE_PICTURE): INTEGER is
			-- Current device context into which picture is selected
		do
			Result := picture.on_get_cur_dc
		end

	on_picture_get_keep_original_format (picture: EOLE_PICTURE): BOOLEAN is
			-- Current value of picture object’s KeepOriginalFormat property
		do
			Result := picture.on_get_keep_original_format
		end
	
	on_picture_get_attributes (picture: EOLE_PICTURE): INTEGER is
			-- Current set of picture’s bit attributes
		do
			Result := picture.on_get_attributes
		end

	on_picture_render (picture: EOLE_PICTURE; hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER;
			x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER;
			bounds: POINTER) is
			-- Draw specified portion of picture defined by offsets `xSrc'
			-- and `ySrc' of source picture and dimensions to copy `cxSrc',
			-- `xySrc'. Picture is rendered onto specified device context `hdc', 
			-- positioned at point `x', `y', and scaled to dimensions `cx', `cy'.
			-- Specify position of rendering if destination device context is a
			-- metafile with `bound'. 
		local
			bnds: EOLE_RECT
		do
			!! bnds.make
			bnds.attach (bounds)
			picture.on_render (hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src, bnds)
		end

	on_picture_set_hpal (picture: EOLE_PICTURE; hpal: INTEGER) is
			-- Set current palette of picture with `hpal'. .
		do
			picture.on_set_hpal (hpal)
		end

	on_picture_select_picture (picture: EOLE_PICTURE; hdc_in: INTEGER): POINTER is
			-- Select bitmap picture into device context `hdc_in'.
			-- Return device context in which picture was previously
			-- selected and picture’s GDI handle.
			-- (See EOLE_SELECT_PICTURE for more details.)
		do
			Result := picture.on_select_picture (hdc_in).ole_ptr
		end

	on_picture_put_keep_original_format (picture: EOLE_PICTURE; keep: BOOLEAN) is
			-- Set picture object’s KeepOriginalFormat property with `keep'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			picture.on_put_keep_original_format (keep)
		end

	on_picture_picture_changed (picture: EOLE_PICTURE) is
			-- Notify picture object that its picture resource changed.
		do
			picture.on_picture_changed
		end

	on_picture_save_as_file (picture: EOLE_PICTURE; pstream: POINTER; fsave_mem_copy: BOOLEAN): INTEGER is
			-- Save picture’s data into `pstream' in same
			-- format that it would save itself into a file.
			-- Save in memory when `fsave_mem_copy' is `True'.
		local
			stream: EOLE_STREAM
		do
			!! stream.make
			stream.attach_ole_interface_ptr (pstream)
			Result := picture.on_save_as_file (stream, fsave_mem_copy)
		end
	
	on_picture_disp_invoke (picture_disp: EOLE_PICTURE_DISP; dispid, flags: INTEGER; 
							params, res, exception: POINTER) is
			-- Expose picture object’s properties through Automation.
		local
			par: EOLE_DISPPARAMS
			resul: EOLE_VARIANT
			exc: EOLE_EXCEPINFO
		do
			!! par
			!! resul
			!! exc
			par.attach (params)
			resul.attach (res)
			exc.attach (exception)
			picture_disp.on_invoke (dispid, flags, par, resul, exc)
		end

	on_provide_class_info_get_class_info (prclinf: EOLE_PROVIDE_CLASS_INFO): POINTER is
			-- EOLE_TYPE_INFO interface for object's type information 
		local
			type_info: EOLE_TYPE_INFO
		do
			type_info := prclinf.on_get_class_info
			if type_info /= Void then
				Result := type_info.ole_interface_ptr
			end
		end

	on_connection_point_container_enum_connection_points (conptc: EOLE_CONNPT_CONTAINER): POINTER is
			-- Enumerate all connection points
			-- supported in this connectable object.
		local
			connpt: EOLE_ENUM_CONNECTION_POINTS
		do
			connpt := conptc.on_enum_connection_points
			if connpt /= Void then
				Result := connpt.ole_interface_ptr
			end
		end

	on_connection_point_container_find_connection_point (conptc: EOLE_CONNPT_CONTAINER; refiid: STRING): POINTER is
			-- Request connection point outgoing interface `refiid'.
		local
			connpt: EOLE_CONNECTION_POINT
		do
			connpt := conptc.on_find_connection_point (refiid)
			if connpt /= Void then
				Result := connpt.ole_interface_ptr
			end
		end

	on_connection_point_advise (conpt: EOLE_CONNECTION_POINT; client_sink: POINTER): INTEGER is
			-- Create connection between connection point 
			-- and `client_sink', where `client_sink' implements the
			-- outgoing interface supported by this connection point.
			-- Result is corresponding connection token.
		local
			clsink: EOLE_UNKNOWN
		do
			!! clsink.make
			clsink.attach_ole_interface_ptr (client_sink)
			Result := conpt.on_advise (clsink)
		end

	on_connection_point_unadvise (conpt: EOLE_CONNECTION_POINT; token: INTEGER) is
			-- Terminate notification with `token'
			-- previously given by `advise'.
		do
			conpt.on_unadvise (token)
		end

	on_connection_point_get_connection_interface (conpt: EOLE_CONNECTION_POINT): POINTER is
			-- IID of outgoing interface
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (conpt.on_get_connection_interface)
			Result := wel_string.item
		end

	on_connection_point_get_connection_point_container (conpt: EOLE_CONNECTION_POINT): POINTER is
			-- Parent (connectable) object’s 
			-- IConnectionPointContainer interface pointer
		local
			connptcont: EOLE_CONNPT_CONTAINER
		do
			connptcont := conpt.on_get_connection_point_container
			if connptcont /= Void then
				Result := connptcont.ole_interface_ptr
			end
		end

	on_connection_point_enum_connections (conpt: EOLE_CONNECTION_POINT): POINTER is
			-- Enumerate current advisory connection
		local
			enum_conn: EOLE_ENUM_CONNECTIONS
		do
			enum_conn := conpt.on_enum_connections
			if enum_conn /= Void then
				Result := enum_conn.ole_interface_ptr
			end
		end

	on_enum_unknown_next (enum_unknown: EOLE_ENUM_UNKNOWN; count: INTEGER): ARRAY [EOLE_UNKNOWN] is
		do
			Result := enum_unknown.on_next (count)
		end
	
	on_enum_unknown_skip (enum_unknown: EOLE_ENUM_UNKNOWN; count: INTEGER) is
		do
			enum_unknown.on_skip (count)
		end
		
	on_enum_unknown_reset (enum_unknown: EOLE_ENUM_UNKNOWN) is
		do
			enum_unknown.on_reset
		end
	
	on_enum_unknown_clone (enum_unknown: EOLE_ENUM_UNKNOWN): POINTER is
		do
			Result := enum_unknown.on_clone
		end
		
	on_enum_connections_next (enum_connections: EOLE_ENUM_CONNECTIONS; count: INTEGER): ARRAY [EOLE_CONNECTDATA] is
		do
			Result := enum_connections.on_next (count)
		end

	on_enum_connections_skip (enum_connections: EOLE_ENUM_CONNECTIONS; count: INTEGER) is
		do
			enum_connections.on_skip (count)
		end
		
	on_enum_connections_reset (enum_connections: EOLE_ENUM_CONNECTIONS) is
		do
			enum_connections.on_reset
		end

	on_enum_connections_clone (enum_connections: EOLE_ENUM_CONNECTIONS): POINTER is
		do
			Result := enum_connections.on_clone
		end
		
	on_enum_connection_points_next (enum_connections_pts: EOLE_ENUM_CONNECTION_POINTS; celt: INTEGER): ARRAY [EOLE_UNKNOWN] is
		do
			Result := enum_connections_pts.on_next (celt)
		end

	on_enum_connection_points_skip (enum_connections_pts: EOLE_ENUM_CONNECTION_POINTS; count: INTEGER) is
		do
			enum_connections_pts.on_skip (count)
		end
		
	on_enum_connection_points_reset (enum_connections_pts: EOLE_ENUM_CONNECTION_POINTS) is
		do
			enum_connections_pts.on_reset
		end

	on_enum_connection_points_clone (enum_connection_pts: EOLE_ENUM_CONNECTION_POINTS): POINTER is
		do
			Result := enum_connection_pts.on_clone
		end

	on_persist_get_class_id (persist: EOLE_PERSIST): STRING is
		do
			Result := persist.on_get_class_id
		end
		
feature {NONE} -- External

	ole2_setup_ocx_dispatcher (disp: POINTER) is
			-- Initialize dispatcher.
		external
			"C"
		alias
			"eole2_setup_ocx_dispatcher"
		end
	
end -- class EOLE_CALL_DISPATCHER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

