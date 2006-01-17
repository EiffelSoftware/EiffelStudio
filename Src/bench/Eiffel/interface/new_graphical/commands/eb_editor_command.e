indexing
	description	: "Abstract notion of a command for the editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EDITOR_COMMAND

inherit

	EB_STANDARD_CMD

	TEXT_OBSERVER
		redefine
			on_text_fully_loaded,
			on_text_reset
		end

create
	make

feature -- Status setting

	set_needs_editable (ed: BOOLEAN) is
			-- Tell the command it requires the editor to be editable.
		do
			needs_editable := True
		end

	update_status is
			-- Enable or disable `Current'.
		do
			if is_loaded then
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

feature -- observer pattern

	on_text_fully_loaded is
			-- make the command sensitive
		do
			is_loaded := True
			update_status
		end

	on_text_reset is
			-- make the command sensitive
		do
			is_loaded := False
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

feature {NONE} -- Implementation

	is_loaded: BOOLEAN
			-- Is a text loaded?
			
	is_editable: BOOLEAN;
			-- Is the current text editable?

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

end -- class EB_EDITOR_COMMAND
