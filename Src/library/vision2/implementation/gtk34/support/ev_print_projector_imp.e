note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR_IMP

obsolete
	"Use EV_MODEL_PRINT_PROJECTOR_IMP instead. [2017-05-31]"

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
			add_ps_line,
			add_footer
		end

	EXECUTION_ENVIRONMENT

create
	make_with_context

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make_with_context (a_world: EV_FIGURE_WORLD; a_context: EV_PRINT_CONTEXT)
		local
			l_filename: like filename
		do
			set_c_object ({GTK}.gtk_label_new (default_pointer))

			if a_context.output_to_file then
				l_filename := a_context.file_path
			else -- Printing via lpr
				-- Printing directly using lpr spooler
				create l_filename.make_from_string (tmp_print_job_name)
			end
			filename := l_filename
			make_with_filepath (a_world, l_filename)
				-- World needs resetting on project

					-- Set up our page size based on context size resolution.
			point_width := a_context.horizontal_resolution
			point_height := a_context.vertical_resolution
		end

	make
			-- <Precursor>
		do
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Access

	project
		local
			i: INTEGER
			a_cs: NATIVE_STRING
			l_file: like file
			l_filename: like filename
		do
			l_filename := filename
			check l_filename /= Void then end
			if not attached_interface.context.output_to_file then
					-- Create the named pipe
				a_cs := l_filename.native_string
				i := mkfifo (a_cs.item, S_IRWXU)
				system ({STRING_32} "lpr < " + l_filename.name + {STRING_32} " &")
			end

			create l_file.make_with_path (l_filename)
			l_file.open_write
			file := l_file
			output_to_postscript
			l_file.close
		end

	add_ps_line (ps_code: READABLE_STRING_GENERAL)
			-- Append `ps_code' postscript to output.
		local
			l_file: like file
		do
			l_file := file
			check l_file /= Void then end
			if l_file /= Void then
				l_file.put_string (ps_code.to_string_8)
				l_file.put_new_line
			end
		end

feature {NONE} -- Implementation

	add_footer
			-- Add showpage if printing to printer.
		do
			if not attached_interface.context.output_to_file then
				add_ps_line ("showpage")
			end
			Precursor {EV_POSTSCRIPT_PROJECTOR}
		end

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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRINT_PROJECTOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PRINT_PROJECTOR_IMP
