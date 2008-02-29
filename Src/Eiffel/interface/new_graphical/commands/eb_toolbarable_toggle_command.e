indexing
	description	: "Command using toggle button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE_TOGGLE_COMMAND

inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			initialize_sd_toolbar_item,
			new_sd_toolbar_item,
			new_mini_sd_toolbar_item
		end

feature -- Change

	set_select (b: BOOLEAN) is
		local
			sdlst: like internal_managed_sd_toolbar_items
			sdbut: like new_sd_toolbar_item
		do
			sdlst := internal_managed_sd_toolbar_items
			if sdlst /= Void and then not sdlst.is_empty then
				from
					sdlst.start
				until
					sdlst.after
				loop
					sdbut ?= sdlst.item
					if sdbut /= Void then
						sdbut.select_actions.block
						if b then
							sdbut.enable_select
						else
							sdbut.disable_select
						end
						sdbut.select_actions.resume
					end
					sdlst.forth
				end
			end
		end

feature -- Basic operations

	is_selected: BOOLEAN is
		deferred
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON is
			-- Create a new docking tool bar toggle button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap)
			Result.set_pixel_buffer (mini_pixel_buffer)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			if is_selected then
				Result.enable_select
			end
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent update_sd_tooltip (Result))
		end

feature {NONE} -- Implementation

	update_sd_tooltip (toggle: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON) is
			-- Update tooltip of `toggle'.
		do
			toggle.set_tooltip (tooltip)
		end

	initialize_sd_toolbar_item (a_item: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON; display_text: BOOLEAN) is
			-- Initialize `a_item'
		do
			Precursor (a_item, display_text)
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

end
