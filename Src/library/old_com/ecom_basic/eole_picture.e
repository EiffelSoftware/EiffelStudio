indexing

	description: "OLE IPicture interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PICTURE

inherit
	EOLE_UNKNOWN
		redefine
			interface_identifier,
			interface_identifier_list
		end

	EOLE_PICTYPE

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_picture
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (Iid_picture)
		end

feature -- Message Transmission

	get_handle: INTEGER is
			-- Windows GDI handle of picture.
			-- Not meant to be redefined; redefine `on_get_handle' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_handle (ole_interface_ptr)
		end

	get_hpal: INTEGER is
			-- Windows handle of palette used by picture 
			-- Not meant to be redefined; redefine `on_get_hpal' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_hpal (ole_interface_ptr)
		end

	get_type: INTEGER is
			-- Type of picture
			-- (See EOLE_PICTYPE for `Result'  value.)
			-- Not meant to be redefined; redefine `on_get_type' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_type (ole_interface_ptr)
		ensure
			valid_pictype: is_valid_pictype (Result)
		end

	get_width: INTEGER is
			-- Current width of picture in picture object
			-- Not meant to be redefined; redefine `on_get_width' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_width (ole_interface_ptr)
		end

	get_height: INTEGER is
			-- Current height of picture in picture object
			-- Not meant to be redefined; redefine `on_get_height' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_height (ole_interface_ptr)
		end
	
	get_cur_dc: INTEGER is
			-- Current device context into which picture is selected
			-- Not meant to be redefined; redefine `on_get_cur_dc' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_cur_dc (ole_interface_ptr)
		end

	get_keep_original_format: BOOLEAN is
			-- Current value of picture object’s KeepOriginalFormat property
			-- Not meant to be redefined; redefine `on_get_keep_original_format' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_picture_get_keep_original_format (ole_interface_ptr)
		end		
		
	get_attributes: INTEGER is
			-- Current set of picture’s bit attributes
			-- Not meant to be redefined; redefine `on_get_attributes' instead.
		require
			valid_interface: is_valid_interface
			do
				Result := ole2_picture_get_attributes (ole_interface_ptr)
			end
	
	render (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER;
			x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER;
			bounds: EOLE_RECT) is
			-- Draw specified portion of picture defined by offsets `xSrc'
			-- and `ySrc' of source picture and dimensions to copy `cxSrc',
			-- `xySrc'. Picture is rendered onto specified device context `hdc', 
			-- positioned at point `x', `y', and scaled to dimensions `cx', `cy'.
			-- Specify position of rendering if destination device context is a
			-- metafile with `bound'. 
			-- Not meant to be redefined; redefine `on_render' instead.
		require
			valid_interface: is_valid_interface
			valid_bounds: bounds /= Void and then bounds.ole_ptr /= default_pointer
		do
			ole2_picture_render (ole_interface_ptr, hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src, bounds.ole_ptr)
		end

	set_hpal (hpal: INTEGER) is
			-- Set current palette of picture with `hpal'. 
			-- Not meant to be redefined; redefine `on_set_hpal' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_picture_set_hpal (ole_interface_ptr, hpal)
		end

	select_picture (hdc_in: INTEGER): EOLE_SELECT_PICTURE is
			-- Select bitmap picture into device context `hdc_in'.
			-- Return device context in which picture was previously
			-- selected and picture’s GDI handle.
			-- (See EOLE_SELECT_PICTURE for more details.)
			-- Not meant to be redefined; redefine `on_select_picture' instead.
		require
			valid_interface: is_valid_interface
		do
			!! Result
			Result.attach (ole2_picture_select_picture (ole_interface_ptr, hdc_in))
		end

	put_keep_original_format (keep: BOOLEAN) is
			-- Set picture object’s KeepOriginalFormat property with `keep'.
			-- Not meant to be redefined; redefine `on_put_keep_original_format' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_picture_put_keep_original_format (ole_interface_ptr, keep)
		end

	picture_changed is
			-- Notify picture object that its picture resource changed.
			-- Not meant to be redefined; redefine `on_picture_change' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_picture_picture_changed (ole_interface_ptr)
		end

	save_as_file (stream: EOLE_STREAM; fsave_mem_copy: BOOLEAN): INTEGER is
			-- Save picture’s data into `stream' in same
			-- format that it would save itself into a file.
			-- Save in memory when `fsave_mem_copy' is `True'.
			-- Not meant to be redefined; redefine `on_save_as_file' instead.
		require
			valid_interface: is_valid_interface
			valid_stream: stream /= Void and then stream.is_valid_interface
		do
			Result := ole2_picture_save_as_file (ole_interface_ptr, stream.ole_interface_ptr, fsave_mem_copy)
		end

feature {EOLE_CALL_DISPATCHER} -- Callback
		
	on_get_handle: INTEGER is
			-- Windows GDI handle of picture.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_hpal: INTEGER is
			-- Windows handle of palette used by picture 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_type: INTEGER is
			-- Type of picture
			-- (See EOLE_PICTYPE for `Result' value.)
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		ensure
			valid_pictype: is_valid_pictype (Result)
		end

	on_get_width: INTEGER is
			-- Current width of picture in picture object
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_height: INTEGER is
			-- Current height of picture in picture object
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end
	
	on_get_cur_dc: INTEGER is
			-- Current device context into which picture is selected
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_keep_original_format: BOOLEAN is
			-- Current value of picture object’s KeepOriginalFormat property
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end		
		
	on_get_attributes: INTEGER is
			-- Current set of picture’s bit attributes
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end
	
	on_render (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER;
			x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER;
			bounds: EOLE_RECT) is
			-- Draw specified portion of picture defined by offsets `xSrc'
			-- and `ySrc' of source picture and dimensions to copy `cxSrc',
			-- `xySrc'. Picture is rendered onto specified device context `hdc', 
			-- positioned at point `x', `y', and scaled to dimensions `cx', `cy'.
			-- Specify position of rendering if destination device context is a
			-- metafile with `bound'. 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		require
			valid_bounds: bounds.is_attached
		do
			set_last_hresult (E_notimpl)
		end

	on_set_hpal (hpal: INTEGER) is
			-- Set current palette of picture with `hpal'. 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_select_picture (hdc_in: INTEGER): EOLE_SELECT_PICTURE is
			-- Select bitmap picture into device context `hdc_in'.
			-- Return device context in which picture was previously
			-- selected and picture’s GDI handle.
			-- (See EOLE_SELECT_PICTURE for more details.)
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		ensure
			valid_result: Result /= Void
		end

	on_put_keep_original_format (keep: BOOLEAN) is
			-- Set picture object’s KeepOriginalFormat property with `keep'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_picture_changed is
			-- Notify picture object that its picture resource changed.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_save_as_file (pstream: EOLE_STREAM; fsave_mem_copy: BOOLEAN): INTEGER is
			-- Save picture’s data into `pstream' in same
			-- format that it would save itself into a file.
			-- Save in memory when `fsave_mem_copy' is `True'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end
		
feature {NONE} -- Externals

	ole2_picture_get_handle (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_handle"
		end

	ole2_picture_get_hpal (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_hpal"
		end

	ole2_picture_get_type (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_type"
		end

	ole2_picture_get_width (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_width"
		end

	ole2_picture_get_height (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_height"
		end

	ole2_picture_render (p: POINTER; hdc: INTEGER; x: INTEGER; y: INTEGER; 
						cx: INTEGER; cy: INTEGER; x_src: INTEGER; y_src: INTEGER;
						cx_src: INTEGER; cy_src: INTEGER; bounds: POINTER) is
		external
			"C"
		alias
			"eole2_picture_render"
		end

	ole2_picture_set_hpal (p: POINTER; hpal: INTEGER) is
		external
			"C"
		alias
			"eole2_picture_set_hpal"
		end

	ole2_picture_get_cur_dc (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_cur_dc"
		end

	ole2_picture_select_picture (p: POINTER; hdc_in: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_picture_select_picture"
		end

	ole2_picture_get_keep_original_format (p: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_picture_get_keep_original_format"
		end

	ole2_picture_put_keep_original_format (p: POINTER; keep: BOOLEAN) is
		external
			"C"
		alias
			"eole2_picture_put_keep_original_format"
		end

	ole2_picture_picture_changed (p: POINTER) is
		external
			"C"
		alias
			"eole2_picture_picture_changed"
		end

	ole2_picture_save_as_file (p, stream: POINTER; fsave_mem_copy: BOOLEAN): INTEGER is
		external
			"C"
		alias
			"eole2_picture_save_as_file"
		end

	ole2_picture_get_attributes (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_picture_get_attributes"
		end
	
end -- class EOLE_PICTURE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

