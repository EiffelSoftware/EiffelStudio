indexing

	description: "COM IFontDisp interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FONT_DISP

inherit
	EOLE_DISPATCH
		rename
			create_ole_interface_ptr as dispatch_create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			on_invoke
		end
		
	EOLE_DISPID
		export
			{NONE} all
		end

	EOLE_METHOD_FLAGS
		export
			{NONE} all
		end
	
	EOLE_VAR_TYPE
		export
			{NONE} all
		end

feature -- Access

	interface_identifier: STRING is
			-- Interface identifier
		once
			Result := Iid_font_disp
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (Iid_font_disp)
		end

	font: EOLE_FONT is
			-- Font with exposed properties
		once
			!! Result.make
		end

feature -- Element Change

	create_ole_interface_ptr is
			-- Initialize associated OLE pointers.
		do
			dispatch_create_ole_interface_ptr
			font.create_ole_interface_ptr
		end

feature {EOLE_CALL_DISPATCHER} -- Callback
		
	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Expose font object’s properties through Automation.
			-- (Implementation of IFontDisp interface)
		local	
			currency: EOLE_CURRENCY
		do
			if flags = Dispatch_propertyget then
				if dispid = Dispid_font_name then
					res.set_bstr (font.get_name)
				elseif dispid =  Dispid_font_size then
					res.set_currency (font.get_size.lo, font.get_size.hi)
				elseif dispid = Dispid_font_bold then
					res.set_boolean (font.get_bold)
				elseif dispid = Dispid_font_italic then
					res.set_boolean (font.get_italic)
				elseif dispid = Dispid_font_under then
					res.set_boolean (font.get_underline)
				elseif dispid = Dispid_font_strike then
					res.set_boolean (font.get_strikethrough)
				elseif dispid = Dispid_font_weight then
					res.set_integer2 (font.get_weight)
				elseif dispid = Dispid_font_charset then
					res.set_integer2 (font.get_charset)
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyput then
				if dispid = Dispid_font_name then
					if params.argument (0).var_type = Vt_bstr then
						font.put_name (params.argument (0).bstr)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_size then
					if params.argument (0).var_type = Vt_cy then
						!! currency
						currency.set_lo (params.argument (0).currency_lo)
						currency.set_hi (params.argument (0).currency_hi)
						font.put_size (currency)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_bold then
					if params.argument (0).var_type = Vt_bool then
						font.put_bold(params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_italic then
					if params.argument (0).var_type = Vt_bool then
						font.put_italic (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_under then
					if params.argument (0).var_type = Vt_bool then
						font.put_underline (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_strike then
					if params.argument (0).var_type = Vt_bool then
						font.put_strikethrough (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_weight then
					if params.argument (0).var_type = Vt_i2 then
						font.put_weight (params.argument (0).integer2)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_charset then
					if params.argument (0).var_type = Vt_i2 then
						font.put_charset (params.argument (0).integer2)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			else
				exception.set_error_code (E_notimpl)
			end
		end
		
end -- class EOLE_FONT_DISP

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

