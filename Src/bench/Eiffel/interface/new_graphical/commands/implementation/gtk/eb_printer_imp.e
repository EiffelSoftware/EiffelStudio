indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER_IMP

inherit

	EB_CONSTANTS

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
		do
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRINTER} -- Implementation

	interface: EB_PRINTER
			-- The object that is visible from outside.

invariant
	valid_interface: interface /= Void

end -- class EB_PRINTER_IMP
