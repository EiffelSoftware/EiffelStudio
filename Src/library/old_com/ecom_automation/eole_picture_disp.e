indexing

	description: "COM IPicture interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PICTURE_DISP

inherit
	EOLE_DISPATCH
		redefine
			on_query_interface,
			on_invoke
		end
		
	EOLE_PICTURE
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
	
feature -- Callback

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
			-- Expose picture object’s properties through Automation.
			-- (Implementation of IFontDisp interface)
		local
			hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src: INTEGER
			bounds: EOLE_RECT
		do
			if flags = Dispatch_propertyget then
				if dispid = Dispid_pict_handle then
					res.set_integer2 (get_handle)
				elseif dispid = Dispid_pict_hpal then
					res.set_integer2 (get_hpal)
				elseif dispid = Dispid_pict_type then
					res.set_integer2 (get_type)
				elseif dispid = Dispid_pict_width then
					res.set_integer2 (get_width)
				elseif dispid = Dispid_pict_height then
					res.set_integer2 (get_height)
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_method then
				if dispid = Dispid_pict_render then
					if params.argument (0).vartype = Vt_i4 then
						hdc := params.argument(0).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (1).vartype = Vt_i4 then
						x := params.argument(1).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (2).vartype = Vt_i4 then
						y := params.argument(2).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (3).vartype = Vt_i4 then
						cx := params.argument(3).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (4).vartype = Vt_i4 then
						cy := params.argument(4).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (5).vartype = Vt_i4 then
						x_src := params.argument(5).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (6).vartype = Vt_i4 then
						y_src := params.argument(6).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (7).vartype = Vt_i4 then
						cx_src := params.argument(7).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (8).vartype = Vt_i4 then
						cy_src := params.argument(8).integer4
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					if params.argument (9).is_reference then
						!! bounds.make
						bounds.attach (params.argument(9).by_reference.ptr)
					else
						exception.set_error_code (Disp_e_typemismatch)
					end
					render (hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src, bounds)
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyput then
				exception.set_error_code (Disp_e_membernotfound)
			elseif flags = Dispatch_propertyputref then
				exception.set_error_code (Disp_e_membernotfound)
			else
				exception.set_error_code (E_notimpl)
			end
		end

end -- class EOLE_PICTURE_DISP

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

