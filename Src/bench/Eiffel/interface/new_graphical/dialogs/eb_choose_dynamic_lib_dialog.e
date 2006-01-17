indexing
	description: "Dialog to choose or build a dynamic library file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOOSE_DYNAMIC_LIB_DIALOG

inherit
	EV_DIALOG

	EV_COMMAND
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make_default

feature {NONE} -- Initialization

	make_default (a_caller: like caller; t: STRING; msg: STRING) is
		local
			i: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create vb
			create hb
			hb.set_padding (4)
			hb.enable_homogeneous
			caller := a_caller
			default_create
			set_title (t)
			create label.make_with_text (msg)
			vb.extend (label)
			create i.make_with_text (Interface_names.b_Browse)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (agent execute (Browse_it))
			create i.make_with_text (Interface_names.b_Default)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (agent execute (Build_it))
			create i.make_with_text (Interface_names.b_Cancel)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (agent execute (Void))
			vb.extend (hb)
			extend (vb)
			disable_user_resize
			show_modal
		end

feature {NONE} -- Execution

	execute (arg: ANY) is
		do
			destroy
			if arg = Browse_it then
				caller.load_chosen
			elseif arg = Build_it then
				caller.load_default
			end
		end

feature {NONE} -- Implementation

	Browse_it: ANY is
		once
			create Result
		end

	Build_it: ANY is
		once
			create Result
		end

	label: EV_LABEL

	caller: EB_SHOW_DYNAMIC_LIB_WINDOW_COMMAND;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CHOOSE_DYNAMIC_LIB_DIALOG
