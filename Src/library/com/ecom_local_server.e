indexing
	description: "Root class for local (.exe) component."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_LOCAL_SERVER

inherit	
	ECOM_ENVIRONMENT
		export
			{NONE} all
		end

	ARGUMENTS
		rename
			command_line as arguments_command_line
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	MEMORY
		redefine
			dispose
		end

creation
	make
	
feature -- Initialization

	make is
			-- Initialize component.
		local
			wel_string: WEL_STRING
		do
			if argument_count > 0 then
				argument (1).to_lower
				if argument (1).is_equal ("-regserver") or 
								argument (1).is_equal ("/regserver") then
					register_server
				elseif argument (1).is_equal ("-unregserver") or
								argument (1).is_equal ("/unregserver") then
					unregister_server
				else
					!! wel_string.make (ecom_class_name)
					initializer := ecom_initialize (wel_string.item, locality, use_type)
				end
			else
				!! wel_string.make (ecom_class_name)
				initializer := ecom_initialize (wel_string.item, locality, use_type)
			end
		end

feature -- Element Change

	register_server is
			-- Register server with ".reg" file.
		local
			reg_file_command: STRING
		do
			reg_file_command := "regedit -s"
			reg_file_command.append (installation_path)
			reg_file_command.append (ecom_class_name)
			reg_file_command.append (".reg")
			system (reg_file_command)
		end

	unregister_server is
			-- Unregister server with ".reg" file.
		local
			reg_file_command: STRING
		do
			reg_file_command := "regedit -s -u "
			reg_file_command.append (installation_path)
			reg_file_command.append (ecom_class_name)
			reg_file_command.append (".reg")
			system (reg_file_command)
		end

feature {NONE} -- Implementation

	dispose is
			-- Delete Initializer before being garbage collected.
		do
			ecom_terminate (initializer)
		end

	initializer: POINTER
			-- Pointer to C++ object
		
feature {NONE} -- Externals

	ecom_initialize (com_class_name: POINTER; clsctx, flags: INTEGER): POINTER is
		external
			"C++ [new CInitializer %"ecom_root.h%"] (EIF_POINTER, EIF_INTEGER, EIF_INTEGER)"
		end

	ecom_terminate (pointer: POINTER) is
		external
			"C++ [delete CInitializer %"ecom_root.h%"] ()"
		end

end -- class ECOM_ROOT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1998-1999 Interactive Software Engineering Inc.
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

