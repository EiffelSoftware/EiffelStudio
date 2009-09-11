note
	description	: "Wizard state: Target file(s) exist(s)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WARNING_FILE_PRESENCE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			cancel
		end

	BENCH_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_names

feature {NONE} -- Creation

	make_with_names (names: TRAVERSABLE [STRING_GENERAL]; i: like wizard_information)
		require
			names_attached: names /= Void
			names_not_empty: not names.is_empty
		do
			files := names
			make (i)
		ensure
			files_set: files = names
		end

feature {NONE} -- Access

	files: TRAVERSABLE [STRING_GENERAL]
			-- List of files that exist in the target directory

feature -- basic Operations

	display_state_text
			-- Display message text relative to current state.
		local
			l: STRING_GENERAL
		do
			title.set_text (Bench_interface_names.t_Files_already_exist)
			create {STRING_32} l.make_empty
			files.do_all (agent (n: STRING_GENERAL; s: STRING_GENERAL)
				do
					s.append_code (('%N').to_character_32.natural_32_code)
					s.append_code (('%T').to_character_32.natural_32_code)
					s.append (n)
				end (?, l))
			message.set_text (Bench_interface_names.m_Files_already_exist (l))
		end

	proceed_with_current_info
		do
			Precursor
				-- Go to code generation step.
			proceed_with_new_state(create {WIZARD_FINAL_STATE}.make (wizard_information))
		end

	final_message: STRING
		do
		end

	cancel
		do
		end

feature {WIZARD_STATE_WINDOW}

	pixmap_icon_location: FILE_NAME
			-- Icon for the Eiffel Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

note
	copyright:	"Copyright (c) 2009, Eiffel Software"
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
end
