indexing

	description: "COM IFont interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FONT

inherit
	EOLE_UNKNOWN
		redefine
			interface_identifier,
			interface_identifier_list
		end

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_font
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_font)
		end
	
feature -- Message Transmission

	get_name: EOLE_BSTR is
			-- Font name
			-- Not meant to be redefined; redefine `on_get_name' instead.
		require
			valid_interface: is_valid_interface
		local
			name: POINTER
		do
			name := ole2_font_get_name (ole_interface_ptr)
			if name /= default_pointer then
				!! Result.make
				Result.make_from_ptr (name)
			end
		end

	get_size: EOLE_CURRENCY is
			-- Font size
			-- Not meant to be redefined; redefine `on_get_size' instead.
		require
			valid_interface: is_valid_interface
		do
			!! Result
			Result.init
			ole2_font_get_size (ole_interface_ptr, Result.ole_ptr)
		end

	get_bold: BOOLEAN is
			-- Is font bold?
			-- Not meant to be redefined; redefine `on_get_bold' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_bold (ole_interface_ptr)
		end

	get_italic: BOOLEAN is
			-- Is font italics?
			-- Not meant to be redefined; redefine `on_get_italic' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_italic (ole_interface_ptr)
		end

	get_underline: BOOLEAN is
			-- Is font underline?
			-- Not meant to be redefined; redefine `on_get_underline' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_underline (ole_interface_ptr)
		end

	get_strikethrough: BOOLEAN is
			-- Is font strikethrough?
			-- Not meant to be redefined; redefine `on_get_strikethrough' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_strikethrough (ole_interface_ptr)
		end

	get_weight: INTEGER is
			-- Font weight
			-- Not meant to be redefined; redefine `on_get_weight' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_weight (ole_interface_ptr)
		end

	get_charset: INTEGER is
			-- Font character set
			-- Not meant to be redefined; redefine `on_get_charset' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_charset (ole_interface_ptr)
		end

	get_h_font: INTEGER is
			-- Windows font handle.
			-- Not meant to be redefined; redefine `on_get_h_font' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_get_h_font (ole_interface_ptr)
		end

	font_clone: EOLE_FONT is
			-- Clone of Current. 
			-- Not meant to be redefined; redefine `on_font_clone' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_font_clone (ole_interface_ptr)
		end

	query_text_metrics: EOLE_TEXTMETRIC is
			-- Describe the font.
			-- Not meant to be redefined; redefine `on_query_text_metrics' instead.
		require
			valid_interface: is_valid_interface
		do
			!! Result
			Result.init
			ole2_font_query_text_metrics (ole_interface_ptr, Result.ole_ptr)
		end
		
	put_name (name: EOLE_BSTR) is
			-- Set font name with `name'.
			-- Not meant to be redefined; redefine `on_put_name' instead.
		require
			valid_interface: is_valid_interface
			valid_name: name /= Void and then name.ole_ptr /= default_pointer
		do
			ole2_font_put_name (ole_interface_ptr, name.ole_ptr)
		end

	put_size (size: EOLE_CURRENCY) is
			-- Set font size with `size'.
			-- Not meant to be redefined; redefine `on_put_size' instead.
		require
			valid_interface: is_valid_interface
			valid_size: size /= Void and then size.ole_ptr /= default_pointer
		do
			ole2_font_put_size (ole_interface_ptr, size.ole_ptr)
		end

	put_bold (bold: BOOLEAN) is
			-- Set bold format with `bold'.
			-- Not meant to be redefined; redefine `on_put_bold' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_bold (ole_interface_ptr, bold)
		end

	put_italic (italic: BOOLEAN) is
			-- Set italics format with `italic'.
			-- Not meant to be redefined; redefine `on_put_italic' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_italic (ole_interface_ptr, italic)
		end

	put_underline (underline: BOOLEAN) is
			-- Set underline format with `underline'.
			-- Not meant to be redefined; redefine `on_put_underline' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_underline (ole_interface_ptr, underline)
		end

	put_strikethrough (strikethrough: BOOLEAN) is
			-- Set strikethrough format with `strikethrough'
			-- Not meant to be redefined; redefine `on_put_strikethrough' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_strikethrough (ole_interface_ptr, strikethrough)
		end

	put_weight (weight: INTEGER) is
			-- Set weight with `weight'
			-- Not meant to be redefined; redefine `on_put_weight' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_weight (ole_interface_ptr, weight)
		end

	put_charset (charset: INTEGER) is
			-- Set character set with `charset'
			-- Not meant to be redefined; redefine `on_put_charset' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_put_charset (ole_interface_ptr, charset)
		end

	set_ratio (cy_logical: INTEGER; cy_himetric: INTEGER) is
			-- Convert the scaling factor between logical units and
			-- HIMETRIC units with `cy_logical' and `cy_himetric'.
			-- Not meant to be redefined; redefine `on_set_ratio' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_set_ratio (ole_interface_ptr, cy_logical, cy_himetric)
		end

	add_ref_hfont (hfont: INTEGER) is
			-- Notify `Current' that previously realized font identified with `hFont'
			-- should remain valid until `release_hfont' is called or `Current'
			-- itself is released. 
			-- Not meant to be redefined; redefine `on_add_ref_hfont' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_add_ref_hfont (ole_interface_ptr, hfont)
		end

	release_hfont (hfont: INTEGER) is
			-- Notify `Current' that caller that previously locked this font in the 
			-- cache with `add_ref_hfont' no longer requires the lock.
			-- Not meant to be redefined; redefine `on_release_hfont' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_release_hfont (ole_interface_ptr, hfont)
		end
		
	set_hdc (hdc: INTEGER) is
			-- Provide device context handle to font that describes logical mapping mode. 
			-- Not meant to be redefined; redefine `on_set_hdc' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_font_set_hdc (ole_interface_ptr, hdc)
		end
		
	is_equal_font (other: EOLE_FONT) is
			-- Is Current same as `other'?
			-- Set status code for result.
			-- Not meant to be redefined; redefine `on_is_equal_font' instead.
		require
			valid_interface: is_valid_interface
			valid_other_font: other /= Void and then other.is_valid_interface
		do
			ole2_font_is_equal (ole_interface_ptr, other.ole_interface_ptr)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback
		
	on_get_name: EOLE_BSTR is
			-- Font name
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_size: EOLE_CURRENCY is
			-- Font size
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_bold: BOOLEAN is
			-- Is font bold?
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_italic: BOOLEAN is
			-- Is font italics?
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_underline: BOOLEAN is
			-- Is font underline?
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_strikethrough: BOOLEAN is
			-- Is font strikethrough?
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_weight: INTEGER is
			-- Font weight
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_charset: INTEGER is
			-- Font character set
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_h_font: INTEGER is
			-- Windows font handle.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_font_clone: EOLE_FONT is
			-- Clone of Current. 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_query_text_metrics: EOLE_TEXTMETRIC is
			-- Describe font.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end
		
	on_put_name (name: EOLE_BSTR) is
			-- Set font name with `name'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_size (size: EOLE_CURRENCY) is
			-- Set font size with `size'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_bold (bold: BOOLEAN) is
			-- Set bold format with `bold'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_italic (italic: BOOLEAN) is
			-- Set italics format with `italic'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_underline (underline: BOOLEAN) is
			-- Set underline format with `underline'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_strikethrough (strikethrough: BOOLEAN) is
			-- Set strikethrough format with `strikethrough'
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_weight (weight: INTEGER) is
			-- Set weight with `weight'
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_put_charset (charset: INTEGER) is
			-- Set character set with `charset'
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_set_ratio (cy_logical: INTEGER; cy_himetric: INTEGER) is
			-- Convert the scaling factor between logical units and
			-- HIMETRIC units with `cy_logical' and `cy_himetric'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_add_ref_hfont (hfont: INTEGER) is
			-- Notify `Current' that previously realized font identified with `hFont'
			-- should remain valid until `release_hfont' is called or `Current'
			-- itself is released. 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_release_hfont (hfont: INTEGER) is
			-- Notify `Current' that caller that previously locked this font in the 
			-- cache with `add_ref_hfont' no longer requires the lock.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end
		
	on_set_hdc (hdc: INTEGER) is
			-- Provide device context handle to font that describes logical mapping mode. 
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end
		
	on_is_equal_font (other: EOLE_FONT) is
			-- Is Current same as `other'?
			-- Set status code for result.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descedant if needed.
		do
			set_last_hresult (E_notimpl)
		end

feature {NONE} -- Externals

	ole2_font_get_name (p: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_font_get_name"
		end

	ole2_font_put_name (p: POINTER; name: POINTER) is
		external
			"C"
		alias
			"eole2_font_put_name"
		end

	ole2_font_get_size (p: POINTER; size: POINTER) is
		external
			"C"
		alias
			"eole2_font_get_size"
		end

	ole2_font_put_size (p: POINTER; size: POINTER) is
		external
			"C"
		alias
			"eole2_font_put_size"
		end

	ole2_font_get_bold (p: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_font_get_bold"
		end

	ole2_font_put_bold (p: POINTER; bold: BOOLEAN) is
		external
			"C"
		alias
			"eole2_font_put_bold"
		end

	ole2_font_get_italic (p: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_font_get_italic"
		end

	ole2_font_put_italic (p: POINTER; italic: BOOLEAN) is
		external
			"C"
		alias
			"eole2_font_put_italic"
		end

	ole2_font_get_underline (p: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_font_get_underline"
		end

	ole2_font_put_underline (p: POINTER; underline: BOOLEAN) is
		external
			"C"
		alias
			"eole2_font_put_underline"
		end

	ole2_font_get_strikethrough (p: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_font_get_strikethrough"
		end

	ole2_font_put_strikethrough (p: POINTER; strikethrough: BOOLEAN) is
		external
			"C"
		alias
			"eole2_font_put_strikethrough"
		end

	ole2_font_get_weight (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_font_get_weight"
		end

	ole2_font_put_weight (p: POINTER; weight: INTEGER) is
		external
			"C"
		alias
			"eole2_font_put_weight"
		end

	ole2_font_get_charset (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_font_get_charset"
		end

	ole2_font_put_charset (p: POINTER; charset: INTEGER) is
		external
			"C"
		alias
			"eole2_font_put_charset"
		end

	ole2_font_get_h_font (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_font_get_h_font"
		end

	ole2_font_clone (p: POINTER): EOLE_FONT is
		external
			"C"
		alias
			"eole2_font_clone"
		end

	ole2_font_is_equal (p: POINTER; font_other: POINTER) is
		external
			"C"
		alias
			"eole2_font_is_equal"
		end

	ole2_font_set_ratio (p: POINTER; cy_logical: INTEGER; cy_himetric: INTEGER) is
		external
			"C"
		alias
			"eole2_font_set_ratio"
		end

	ole2_font_query_text_metrics (p: POINTER; ip_tm: POINTER) is
		external
			"C"
		alias
			"eole2_font_query_text_metrics"
		end

	ole2_font_add_ref_hfont (p: POINTER; hfont: INTEGER) is
		external
			"C"
		alias
			"eole2_font_add_ref_hfont"
		end

	ole2_font_release_hfont (p: POINTER; hfont: INTEGER) is
		external
			"C"
		alias
			"eole2_font_release_hfont"
		end

	ole2_font_set_hdc (p: POINTER; hdc: INTEGER) is
		external
			"C"
		alias
			"eole2_font_set_hdc"
		end
	
end -- class EOLE_FONT

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

