indexing
	description: "Error messages for EiffelCOM wizard."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERRORS

feature -- Access

	Cannot_compile_proxy_stub: STRING is "Cannot compile Proxy/Stub"
			-- Cannot produce Proxy/Stub dll

	Generic_error: STRING is "Fatal error"
			-- Generic fatal error

	Could_not_write_file: STRING is "Cannot write file"
			-- Could not save generated file

	Could_not_write_makefile: STRING is "Could not write makefile"
			-- Could not create temporary makefile (@ file)


	Could_not_copy_file: STRING is "File cannot be copied"
			-- File cannot be copied

	Could_not_delete_file: STRING is "File cannot be deleted"
			-- File cannot be deleted

end -- class WIZARD_ERRORS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
