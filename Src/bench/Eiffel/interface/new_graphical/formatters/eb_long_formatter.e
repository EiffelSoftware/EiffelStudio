indexing
	description:
		"This kind of format is long to process. Ask %
			%for a confirmation before executing it."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LONG_FORMATTER

inherit
	EB_FILTERABLE
		rename
			process as process_format 
		redefine
			launch
		end

feature -- Commands

	launch (argument: STONE) is
			-- Ask for a confirmation before executing the format.
		local
--			mp: MOUSE_PTR
			md: EV_MESSAGE_DIALOG
		do
			if argument = Void then
				s2 := tool.stone
			else
				s2 ?= argument
			end
			if (s2 /= Void and then s2.clickable) then
--				not data.control_key_pressed then
--					-- click requires a confirmation, control-click doesn't.

				create md.make_with_text (
					"This format requires exploring the entire%N%
					%system and may take a long time...")
				md.set_title (Interface_names.t_Confirm)
				md.set_buttons (<<" Continue ", Interface_names.b_Cancel>>)
				md.button (" Continue ").select_actions.extend (agent process)
				md.show_modal
			else
				process
			end
		end

feature {EB_CONFIRM_FORMATTING_DIALOG} -- callbacks

	process is
		local
			ed: EB_EDIT_TOOL
			csd: EB_CONFIRM_SAVE_DIALOG
		do
				-- The user wants to execute this format,
				-- even though it's a long format.
			ed ?= tool
			if ed /= Void then
				if ed.text_area.changed then
					create csd.make_and_launch (ed, Current)
				else
					process_format
				end
			else
				process_format
			end
		end

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

end -- class EB_LONG_FORMATTER
