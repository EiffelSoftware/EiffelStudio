indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER_IMP

inherit
		--| FIXME XR:
		--| We have to inherit from this (or EV_PRINT_PROJECTOR_I)
		--| in order to have access to the printer device context...
		--| There are probably a zillion invariants violated from Vision2,
		--| but there is no good way around this.
		--| Another solution would be to have a class inherit from EV_PRINT_CONTEXT
		--| that would export `printer_context' and copy the context that is given to
		--| us by the EV_PRINT_DIALOG. To spare a class to the system (and since the
		--| second solution is not much better since a precondition would be violated
		--| in `copy'), this is the chosen solution...
	EV_PRINT_DIALOG_IMP
		rename
			interface as dialog_interface,
			make as dialog_make
		export {NONE}
			all
		end

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
		local
			wnd: WEL_FRAME_WINDOW -- Needed to create the rich edit component.
			rich: WEL_RICH_EDIT
			pdc: WEL_PRINTER_DC
			form: WEL_CHARACTER_FORMAT
			txt: STRING
			fnt: EV_FONT
			imp: EV_FONT_IMP
		do
			create wnd.make_top (Interface_names.t_Dummy)
			create rich.make (wnd, Interface_names.t_Dummy, 10, 10, 300, 500, -1)
			create pdc.make_by_pointer (interface.context.printer_context)
			fnt := interface.font
			if fnt /= Void then
				form := rich.default_character_format
				form.set_face_name (fnt.preferred_families.first)
				imp ?= fnt.implementation
				check
					imp /= Void
				end
				form.set_height (imp.wel_font.point)
				rich.set_character_format_all (form)
			end
			txt := interface.text.image
				-- Rich edits don't like lonely '%N' characters.
			txt.prune_all ('%R')
			txt.replace_substring_all ("%N", "%R%N")
			rich.set_text (txt)
			if interface.job_name /= Void then
				rich.print_all (pdc, interface.job_name)
			else
				rich.print_all (pdc, Interface_names.t_Default_print_job_name)
			end
			wnd.destroy
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRINTER} -- Implementation

	interface: EB_PRINTER
			-- The object that is visible from outside.

feature {NONE} -- Implementation

invariant
	valid_interface: interface /= Void

end -- class EB_PRINTER_IMP
