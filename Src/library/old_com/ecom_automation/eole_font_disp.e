indexing

	description: "COM IFontDisp interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FONT_DISP

inherit
	EOLE_DISPATCH
		redefine
			on_query_interface,
			on_invoke
		end
	
	EOLE_FONT
		undefine
			create_ole_interface_ptr
		redefine
			on_query_interface
		end
		
	EOLE_DISPID
		export
			{NONE} all
		end

	EOLE_METHOD_FLAGS
		export
			{NONE} all
		end
	
	EOLE_VARTYPE
		export
			{NONE} all
		end

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
		do
			if iid.is_equal (Iid_font_disp) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end
		
	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Expose font object’s properties through Automation.
			-- (Implementation of IFontDisp interface)
		local	
			currency: EOLE_CURRENCY
		do
			if flags = Dispatch_propertyget then
				if dispid = Dispid_font_name then
					res.set_bstr (get_name)
				elseif dispid =  Dispid_font_size then
					res.set_currency (get_size.lo, get_size.hi)
				elseif dispid = Dispid_font_bold then
					res.set_boolean (get_bold)
				elseif dispid = Dispid_font_italic then
					res.set_boolean (get_italic)
				elseif dispid = Dispid_font_under then
					res.set_boolean (get_underline)
				elseif dispid = Dispid_font_strike then
					res.set_boolean (get_strikethrough)
				elseif dispid = Dispid_font_weight then
					res.set_integer2 (get_weight)
				elseif dispid = Dispid_font_charset then
					res.set_integer2 (get_charset)
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyput then
				if dispid = Dispid_font_name then
					if params.argument (0).vartype = Vt_bstr then
						put_name (params.argument (0).bstr)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_size then
					if params.argument (0).vartype = Vt_cy then
						!! currency
						currency.set_lo (params.argument (0).currency_lo)
						currency.set_hi (params.argument (0).currency_hi)
						put_size (currency)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_bold then
					if params.argument (0).vartype = Vt_bool then
						put_bold(params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_italic then
					if params.argument (0).vartype = Vt_bool then
						put_italic (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_under then
					if params.argument (0).vartype = Vt_bool then
						put_underline (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_strike then
					if params.argument (0).vartype = Vt_bool then
						put_strikethrough (params.argument (0).boolean)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_weight then
					if params.argument (0).vartype = Vt_i2 then
						put_weight (params.argument (0).integer2)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				elseif dispid = Dispid_font_charset then
					if params.argument (0).vartype = Vt_i2 then
						put_charset (params.argument (0).integer2)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_method then
				exception.set_error_code (Disp_e_membernotfound)
			else
				exception.set_error_code (E_notimpl)
			end
		end
		
end -- class EOLE_FONT_DISP

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
------------------------------------------------------------------------------
