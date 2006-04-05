indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		export
			{EB_PRINTER_IMP} item
			{NONE} all
		end

	EB_CONSTANTS
		undefine
			copy, is_equal
		end

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
			l_loader: WEL_RICH_EDIT_BUFFER_LOADER
		do
			create wnd.make_top (Interface_names.t_Dummy)
			create rich.make (wnd, Interface_names.t_Dummy, 10, 10, 300, 500, -1)
			create pdc.make_by_pointer (interface.context.printer_context)
			txt := interface.text
				-- Rich edits don't like lonely '%N' characters.
			txt.prune_all ('%R')
			txt.replace_substring_all ("%N", "%R%N")
			create l_loader.make (txt)
			rich.rtf_stream_in (l_loader)
			if interface.job_name /= Void then
				rich.print_all (pdc, interface.job_name)
			else
				rich.print_all (pdc, Interface_names.t_Default_print_job_name)
			end
			wnd.destroy
		end

feature {EB_PRINTER} -- Implementation

	interface: EB_PRINTER
			-- The object that is visible from outside.

feature {NONE} -- Implementation

invariant
	valid_interface: interface /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_PRINTER_IMP
