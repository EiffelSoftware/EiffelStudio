indexing
	description: "Implementation of a printer under GTK"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER_IMP

inherit

	EB_CONSTANTS

	EB_SHARED_MANAGERS

create {EB_PRINTER}
	make

feature {NONE} -- Initialization

	make (interf: EB_PRINTER) is
			-- Initialize `Current' and associate it with `interf'.
		require
			valid_interface: interf /= Void
		do
			interface := interf
		ensure
			set_interface: interface = interf
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature {EB_PRINTER} -- Basic operations

	send_print_request is
			-- Send a print request based on the parameters in `interface'.
		require
			text_set: interface.text /= Void
			options_set: interface.context /= Void
			do_not_print_to_file: not interface.context.output_to_file
		local
			cmd: STRING
			name: STRING
			i: INTEGER
			fn: FILE_NAME
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			wd: EV_WARNING_DIALOG
			tmp_dir: STRING
			sent_text: STRING
		do
			if not retried then
				cmd := "lp -d "
				name := interface.context.printer_name
				i := name.index_of ('@', 1)
				cmd.append (name)
				
					-- Generate the file we put the text in.
				tmp_dir := (create {EXECUTION_ENVIRONMENT}).get ("TMP")
				if tmp_dir /= Void then
					create fn.make_from_string (tmp_dir)
				else
					create fn.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
				end
				fn.set_file_name ("prn_buffer")
				fn.add_extension ("tmp")
				create file.make (fn)
				if file.exists then
					file.open_write
				else
					file.create_read_write
				end
				sent_text := interface.text.image
				sent_text.prune_all ('%R')
				sent_text.replace_substring_all ("%N", "%R%N")
				file.putstring (sent_text)
				file.close
				
					-- Launch the print session.
				cmd.append_character (' ')
				cmd.append (fn)
				(create {EXECUTION_ENVIRONMENT}).launch (cmd)
			else
				if fn = Void then
					create fn.make_from_string ("")
				end
				create wd.make_with_text (Warning_messages.w_Not_writable (fn))
				wd.show_modal_to_window (window_manager.last_focused_window.window)
			end
		rescue
			retried := True
			retry
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRINTER} -- Implementation

	interface: EB_PRINTER
			-- The object that is visible from outside.

feature {NONE} -- Implementation

	generate_temp_name: STRING is
			-- Generate a temporary file name.
		local
			prefix_name: STRING
			a: ANY
			p: POINTER
		do
			prefix_name := "estudio_"
			a := prefix_name.to_c
			p := tempnam (default_pointer, $a)

			create Result.make (0)
			Result.from_c (p)
		end

	tempnam (d,p: POINTER): POINTER is
		external
			"C | <stdio.h>"
		end

invariant
	valid_interface: interface /= Void

end -- class EB_PRINTER_IMP
