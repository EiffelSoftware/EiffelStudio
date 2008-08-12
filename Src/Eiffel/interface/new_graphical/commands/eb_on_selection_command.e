indexing
	description: "Command on selected text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ON_SELECTION_COMMAND

inherit
	EB_STANDARD_CMD
		rename
			make as make_standard
		redefine
			executable,
			internal_recycle
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		undefine
			internal_detach_entities
		redefine
			executable, make, internal_recycle, target
		end

	TEXT_OBSERVER
		redefine
			on_selection_begun, on_selection_finished
		end

create
	make

feature {NONE} -- initialization

	make (a_target: like target) is
			-- creation function
		do
			make_standard
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND} (a_target)
		end

feature -- Execution

	executable: BOOLEAN is
		do
			Result := is_sensitive
		end

feature -- Status setting

	set_needs_editable (ed: BOOLEAN) is
			-- Tell the command it requires the editor to be editable.
		do
			needs_editable := ed
		end

	set_is_for_main_editors (a_b: BOOLEAN) is
			-- Set `is_for_main_editor' with `a_b'.
		do
			is_for_main_editor := a_b
		end

	update_status is
			-- Enable or disable `Current'.
		do
			if has_selection then
				if needs_editable then
					if is_editable then
						enable_sensitive
					else
						disable_sensitive
					end
				else
					enable_sensitive
				end
			else
				disable_sensitive
			end
		end

feature -- Status report

	needs_editable: BOOLEAN
			-- Does the command require the editor to be editable?

	is_for_main_editor: BOOLEAN
			-- Is the command only for the main editors?

feature -- Observer pattern

	on_selection_begun is
			-- make the command sensitive
		do
			has_selection := True
			update_status
		end

	on_selection_finished is
			-- make the command insensitive
		do
			has_selection := False
			update_status
		end

	on_editable is
			-- Editor has become editable.
		do
			is_editable := True
			update_status
		end

	on_not_editable is
			-- Editor is no longer editable.
		do
			is_editable := False
			update_status
		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
			Precursor {EB_STANDARD_CMD}
		end

feature {NONE} -- Implementation

	target: EB_DEVELOPMENT_WINDOW
		-- Target of `Current'.

	has_selection: BOOLEAN
			-- Is a text loaded?

	is_editable: BOOLEAN;
			-- Is the current text editable?

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

end -- class EB_COMMENT_COMMAND
