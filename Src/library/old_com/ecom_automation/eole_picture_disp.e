indexing

	description: "COM IPicture interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PICTURE_DISP

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
			Result := Iid_picture_disp
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_picture_disp)
		end

	picture: EOLE_PICTURE is
			-- Picture with exposed properties
		once
			!! Result.make
		end

feature -- Element Change

	create_ole_interface_ptr is
			-- Initialize associated OLE pointers.
		do
			dispatch_create_ole_interface_ptr
			picture.create_ole_interface_ptr
		end

feature {EOLE_CALL_DISPATCHER} -- Callback
		
	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Expose picture object’s properties through Automation.
			-- (Implementation of IFontDisp interface)
		local
			hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src: INTEGER
			bounds: EOLE_RECT
		do
			if flags = Dispatch_propertyget then
				if dispid = Dispid_pict_handle then
					res.set_integer2 (picture.get_handle)
				elseif dispid = Dispid_pict_hpal then
					res.set_integer2 (picture.get_hpal)
				elseif dispid = Dispid_pict_type then
					res.set_integer2 (picture.get_type)
				elseif dispid = Dispid_pict_width then
					res.set_integer4 (picture.get_width)
				elseif dispid = Dispid_pict_height then
					res.set_integer4 (picture.get_height)
				else
					exception.set_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyput then
				if dispid = Dispid_pict_hpal then
					if params.argument (0).var_type = Vt_i2 then
						picture.set_hpal (params.argument (0).integer2)
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

end -- class EOLE_PICTURE_DISP

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

