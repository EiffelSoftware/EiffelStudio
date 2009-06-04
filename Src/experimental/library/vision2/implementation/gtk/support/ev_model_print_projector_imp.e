note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			project
		end

	EXECUTION_ENVIRONMENT

create
	make_with_context

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
		do
			assign_interface (an_interface)
		end

	make_with_context (a_world: EV_MODEL_WORLD; a_context: EV_PRINT_CONTEXT)
		do
			if a_context.output_to_file then
				create filename.make_from_string (a_context.file_name.as_string_8)
			else -- Printing via lpr
				-- Printing directly using lpr spooler
				create filename.make_from_string (tmp_print_job_name)
			end
			make_with_filename (a_world, filename)
			make
		end

	make
		do
			--| Hack to prevent invariant violation
			set_c_object ({EV_GTK_EXTERNALS}.gtk_label_new (NULL))

				-- World needs resetting on project
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Access

	project
			-- Make a standard projection of the world on the device.
		local
			i: INTEGER
			a_cs: C_STRING
		do
			if not attached_interface.context.output_to_file then
				-- Create the named pipe
				create a_cs.make (filename)
				i := mkfifo (a_cs.item, S_IRWXU)
				system ("lpr < " + filename + " &")
			end
				-- Print the file using the postscript projector.
			Precursor {EV_MODEL_POSTSCRIPT_PROJECTOR}
		end

feature {NONE} -- Implementation

	tmp_print_job_name: STRING
			-- A unique print job file name.
		do
			create Result.make (0)
			Result.from_c (tmpnam (Default_pointer))
			Result := Result.twin
			Result.append ("_vision2_print_job")
		end

	mkfifo (a_pathname: POINTER; mode: INTEGER): INTEGER
			-- See man mkfifo.
		external
			"C [macro <fcntl.h>]"
		end

	tmpnam (s: POINTER): POINTER
			-- See man tmpnam.
		external
			"C | <stdio.h>"
		end

	S_IRWXU: INTEGER
		external
			"C [macro <fcntl.h>]"
		alias
			"S_IRWXU"
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_MODEL_PRINT_PROJECTOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_PRINT_PROJECTOR_IMP





