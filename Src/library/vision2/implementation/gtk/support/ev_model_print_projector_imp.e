indexing
	description:
		"Projection to a Printer."
	status: "See notice at end of class"
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PRINT_PROJECTOR_IMP

inherit

	EV_ANY_IMP
		redefine
			interface
		end

	EV_MODEL_PRINT_PROJECTOR_I
		redefine
			interface
		end

	EV_MODEL_POSTSCRIPT_PROJECTOR
		redefine
			project--,
--			add_ps,
--			add_footer
		end

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			--| Hack to prevent invariant violation
			set_c_object ({EV_GTK_EXTERNALS}.gtk_label_new (NULL))

			if interface.context.output_to_file then
				create filename.make_from_string (interface.context.file_name)
			else -- Printing via lpr
				-- Printing directly using lpr spooler
				create filename.make_from_string (tmp_print_job_name)
			end
			make_with_filename (an_interface.world, filename)
				-- World needs resetting on project
				
					-- Set up our page size based on context size resolution.
--			point_width := interface.context.horizontal_resolution
--			point_height := interface.context.vertical_resolution
		end

	initialize is
		do
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Access

	project is
		local
			i: INTEGER
			a_cs: C_STRING
		do
			if not interface.context.output_to_file then
				-- Create the named pipe
				create a_cs.make (filename)
				i := mkfifo (a_cs.item, S_IRWXU)
				system ("lpr < " + filename + " &")
			end

--			create file.make_open_write (filename)
--			output_to_postscript
--			file.close
		end

--	add_ps (ps_code: STRING) is
--			-- Append `ps_code' postscript to output.
--		do
--			file.put_string (ps_code + "%N")
--		end

feature {NONE} -- Implementation

--	add_footer is
--			-- Add showpage if printing to printer.
--		do
--			if not interface.context.output_to_file then
--				add_ps ("showpage")
--			end
--			Precursor {EV_POSTSCRIPT_PROJECTOR}
--		end

	tmp_print_job_name: STRING is
			-- A unique print job file name.
		do
			create Result.make (0)
			Result.from_c (tmpnam (Default_pointer))
			Result := Result.twin
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

	interface: EV_MODEL_PRINT_PROJECTOR

end -- class EV_MODEL_PRINT_PROJECTOR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

