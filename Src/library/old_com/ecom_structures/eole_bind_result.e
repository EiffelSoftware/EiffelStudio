indexing

	description: "Result structure of EOLE_TYPE_COMP.bind"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_BIND_RESULT
	
inherit
	EOLE_DESC_KIND
	
feature -- Access

	type_info: EOLE_TYPE_INFO is
			-- if `desc_kind' is Var_desc or Func_desce,
			-- pointer to type description that contains 
			-- item to which it is bound
		require
			valid_desc_kind: desc_kind = Desckind_vardesc or
								desc_kind = Desckind_funcdesc
		do
			!! Result.make
			Result.attach_ole_interface_ptr (tinfo)
		end
		
	desc_kind: INTEGER
			-- Descriptor kind.
			-- See class EOLE_DESC_KIND for possible values.
		
	var_desc: EOLE_VAR_DESC is
			-- Bound VARDESC structure
		require
			valid_desc_kind: desc_kind = Desckind_vardesc
		do
			!! Result
			Result.attach (bind_ptr)
		end
		
	func_desc: EOLE_FUNC_DESC is
			-- Bound FUNCDESC structure
		require
			valid_desc_kind: desc_kind = Desckind_funcdesc
		do
			!! Result
			Result.attach (bind_ptr)
		end
		
	type_comp: EOLE_TYPE_COMP is
			-- Bound ITypeComp
		require
			valid_desc_kind: desc_kind = Desckind_typecomp
		do
			!! Result.make
			Result.attach_ole_interface_ptr (bind_ptr)
		end
			
feature -- Element Change

	set_type_info (tinf: POINTER) is
			-- Set `tinfo' with `tinf'.
			-- Should not be called (used by C-side).
		do
			tinfo := tinf
		end
		
	set_desc_kind (kind: INTEGER) is
			-- Set `desc_kind' with `kind'.
			-- Should not be called (used by C-side).
		require
			valid_kind: is_valid_desc_kind (kind)
		do
			desc_kind := kind
		end

	set_bind_ptr (ptr: POINTER) is
			-- Set `bind_ptr' with `ptr'.
			-- Should not be called (used by C-side).
		do
			bind_ptr := ptr
		end
		
feature {NONE} -- Implementation

	tinfo: POINTER
			-- OLE ITypeInfo pointer
			
	bind_ptr: POINTER
			-- OLE pointer to bound structure
		
end -- class EOLE_BIND_RESULT

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

