indexing
	description:
		"Projection to a Printer."
	status: "See notice at end of class"
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR_IMP

inherit

	EV_ANY_IMP
		redefine
			interface
		end

	EV_PRINT_PROJECTOR_I
		redefine
			interface
		end

	EV_POSTSCRIPT_PROJECTOR
		redefine
			project,
			add_ps,
			add_footer
		end

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			--| Hack to prevent invariant violation
			set_c_object (C.gtk_label_new (NULL))

			if interface.context.output_to_file then
				create filename.make_from_string (interface.context.file_name)
			else -- Printing via lpr
				-- Printing directly using lpr spooler
				create filename.make_from_string (tmp_print_job_name)
			end
			make_with_filename (an_interface.world, filename)
			-- World needs resetting on project
		end

	initialize is
		do
			is_initialized := True
		end

feature {EV_ANY_I} -- Access

	project is
		local
			i: INTEGER
		do
			if not interface.context.output_to_file then
				-- Create the named pipe
				i := mkfifo (eiffel_to_c (filename), S_IRWXU)
				system ("lpr < " + filename + " &")
			end

			create file.make_open_write (filename)
			output_to_postscript
			file.close
		end

	add_ps (ps_code: STRING) is
			-- Append `ps_code' postscript to output.
		do
			file.put_string (ps_code + "%N")
		end

feature {NONE} -- Implementation

	add_footer is
			-- Add showpage if printing to printer.
		do
			if not interface.context.output_to_file then
				add_ps ("showpage")
			end
			Precursor {EV_POSTSCRIPT_PROJECTOR}
		end

	tmp_print_job_name: STRING is
			-- A unique print job file name.
		do
			create Result.make (0)
			Result.from_c (tmpnam (Default_pointer))
			Result := clone (Result)
			Result.append ("_vision2_print_job")
		end

	mkfifo (a_pathname: POINTER; mode: INTEGER): INTEGER is
			-- See man mkfifo.
		external
			"C [macro <fcntl.h>]"
		end

	tmpnam (s: POINTER): POINTER is
			-- See man tmpnam.
		external
			"C | <stdio.h>"
		end

	S_IRWXU: INTEGER is
		external
			"C [macro <fcntl.h>]"
		alias
			"S_IRWXU"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRINT_PROJECTOR

end -- class EV_PRINT_PROJECTOR_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.7  2001/04/26 19:00:49  king
--| Made releasable
--|
--| Revision 1.1.2.6  2000/11/15 01:04:11  king
--| Added feature comments
--|
--| Revision 1.1.2.4  2000/11/14 22:26:13  king
--| Implemented pipe output functionality
--|
--| Revision 1.1.2.3  2000/11/08 22:44:31  andrew
--| Corrected inheritance
--|
--| Revision 1.1.2.2  2000/11/08 17:59:10  andrew
--| Not for release
--|
--| Revision 1.1.2.1  2000/11/08 17:46:47  andrew
--| Initial
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

