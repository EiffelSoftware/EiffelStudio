note
	description: "When first initlialize smart editor, we create this fake one to make opening fast."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAKE_SMART_EDITOR

inherit
	EB_SMART_EDITOR
		rename
			make as make_real
		redefine
			set_stone,
			on_focus,
			changed,
			update_click_list,
			has_focus,
			set_focus,
			is_offset_valid,
			internal_recycle
		end

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT)
			-- Creation method
		do
			content := a_content
		end

feature -- Query

	content: SD_CONTENT;
			-- Content related.

	is_offset_valid: BOOLEAN = True
			-- Redefine for not break invariant.

feature -- Stone

	set_stone (a_stone: STONE)
			-- Redefine
		local
			l_cell: EB_FAKE_SMART_EDITOR_CELL
		do
			Precursor {EB_SMART_EDITOR}(a_stone)
			l_cell ?= docking_content.user_widget
			check not_void: l_cell /= Void end
			l_cell.set_stone (a_stone)
		end

feature -- Fake implemetation

	on_focus
			-- Redefine
		do
		end

	changed: BOOLEAN
			-- Redefine
		do
		end

	update_click_list (after_save: BOOLEAN)
			-- Redefine
		do
		end

	has_focus: BOOLEAN
			-- Redefine
		do
		end

	set_focus
			-- Redefine
		do
		end

feature {NONE} -- Implementation

	internal_recycle
			-- Do nothing, since we nothing was initialized.
		do
		end

note
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

end -- class EB_FAKE_SMART_EDITOR
