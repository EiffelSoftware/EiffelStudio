indexing
	description	: "Command that can be added in a toolbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE_COMMAND

inherit
	EB_GRAPHICAL_COMMAND
		redefine
			update
		end

	EB_TOOLBARABLE
		redefine
			new_sd_toolbar_item
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		deferred
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer which representing the command.
		deferred
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command for mini toolbars.
		do
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		deferred
		ensure
			valid_result: Result /= Void
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on the toolbar button.
		do
			Result := ""
		ensure
			valid_result: Result /= Void
		end

	has_text: BOOLEAN is
			-- Does `Current' show text when displayed
		do
			Result := tooltext /= Void and then not tooltext.is_empty
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := False
		end

feature -- Status Report

	is_displayed: BOOLEAN
			-- Is the toolbar button currently displayed?

feature -- Status setting

	enable_displayed is
			-- Set `is_displayed' to True.
		do
			is_displayed := True
		end

	disable_displayed is
			-- Set `is_displayed' to False.
		do
			is_displayed := False
		end

	enable_sensitive is
			-- Set `is_sensitive' to True.
		local
			sd_toolbar_items: like internal_managed_sd_toolbar_items
			tbi: SD_TOOL_BAR_BUTTON
		do
			if not is_sensitive then
				is_sensitive := True

				sd_toolbar_items := internal_managed_sd_toolbar_items
				if sd_toolbar_items /= Void then
					from
						sd_toolbar_items.start
					until
						sd_toolbar_items.after
					loop
						tbi := sd_toolbar_items.item
						if tbi /= Void then
							tbi.enable_sensitive
						end
						sd_toolbar_items.forth
					end
				end
			end
		end

	disable_sensitive is
			-- Set `is_sensitive' to True.
		local
			sd_toolbar_items: like internal_managed_sd_toolbar_items
			tbi: SD_TOOL_BAR_BUTTON
		do
			if is_sensitive then
				sd_toolbar_items := internal_managed_sd_toolbar_items
				if sd_toolbar_items /= Void then
					from
						sd_toolbar_items.start
					until
						sd_toolbar_items.after
					loop
						tbi := sd_toolbar_items.item
						if tbi /= Void then
							tbi.disable_sensitive
						end
						sd_toolbar_items.forth
					end
				end
				is_sensitive := False
			end
		end

	update (a_window: EV_WINDOW) is
			-- Update `accelerator' and interfaces according to `referred_shortcut'.
		do
			Precursor {EB_GRAPHICAL_COMMAND} (a_window)
			update_tooltips
		end

feature -- Basic operations

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new docking tool bar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		require
			mini_pixmap_not_void: mini_pixmap /= Void
		local
			l_tt: like tooltip
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap)
			Result.set_pixel_buffer (mini_pixel_buffer)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			l_tt := tooltip.twin
			if shortcut_available then
				l_tt.append (opening_parenthesis)
				l_tt.append (shortcut_string)
				l_tt.append (closing_parenthesis)
			end
			Result.set_tooltip (l_tt)
			Result.select_actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	add_sd_toolbar_item (a_toolbar_item: like new_sd_toolbar_item) is
			-- Add `a_sd_toolbar_item' to `managed_sd_toolbar_items'.
		do
			managed_sd_toolbar_items.extend (a_toolbar_item)
		ensure
			managed_sd_toolbar_items_has_item: managed_sd_toolbar_items.has (a_toolbar_item)
		end

	initialize_sd_toolbar_item (a_item: EB_SD_COMMAND_TOOL_BAR_BUTTON; display_text: BOOLEAN) is
			-- Initialize `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_tt: STRING_GENERAL
		do
			if display_text and then has_text then
				a_item.set_text (tooltext)
			end
			a_item.set_pixmap (pixmap)
			if pixel_buffer /= Void then
				a_item.set_pixel_buffer (pixel_buffer)
			end
			a_item.set_description (description)
			if is_sensitive then
				a_item.enable_sensitive
			else
				a_item.disable_sensitive
			end
			if shortcut_available then
				l_tt := tooltip.twin
				l_tt.append (opening_parenthesis)
				l_tt.append (shortcut_string)
				l_tt.append (closing_parenthesis)
				a_item.set_tooltip (l_tt)
			else
				a_item.set_tooltip (tooltip)
			end
		end

	remove_sd_toolbar_item (a_toolbar_item: like new_sd_toolbar_item) is
			-- Remove `a_sd_toolbar_item' from `managed_sd_toolbar_items'.
		require
			managed_sd_toolbar_items_not_empty: not managed_sd_toolbar_items.is_empty
			managed_sd_toolbar_items_has_item: managed_sd_toolbar_items.has (a_toolbar_item)
		do
			managed_sd_toolbar_items.prune_all (a_toolbar_item)
		ensure
			managed_sd_toolbar_items_not_has_item: not managed_sd_toolbar_items.has (a_toolbar_item)
		end

feature {EB_SD_COMMAND_TOOL_BAR_BUTTON, EB_DEBUGGER_MANAGER} -- Implementaiton

	managed_sd_toolbar_items: ARRAYED_LIST [like new_sd_toolbar_item] is
			-- Managed Smart Docking lib tool bar items.
		do
			if internal_managed_sd_toolbar_items = Void then
				create internal_managed_sd_toolbar_items.make (1)
			end
			Result := internal_managed_sd_toolbar_items
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	update_tooltips is
			-- Update tooltips when shortcut is changed.
		local
			l_sd_items: like managed_sd_toolbar_items
			l_tt: STRING_GENERAL
			tbi: SD_TOOL_BAR_BUTTON
		do
			if tooltip /= Void then
				l_tt := tooltip.twin
				if shortcut_available then
					l_tt.append (opening_parenthesis)
					l_tt.append (shortcut_string)
					l_tt.append (closing_parenthesis)
				end
				from
					l_sd_items := managed_sd_toolbar_items
					l_sd_items.start
				until
					l_sd_items.after
				loop
					tbi := l_sd_items.item
					if tbi /= Void then
						tbi.set_description (description)
						tbi.set_tooltip (l_tt)
					end
					l_sd_items.forth
				end
			end
		end

	internal_managed_sd_toolbar_items: ARRAYED_LIST [like new_sd_toolbar_item]

	Opening_parenthesis: STRING is " ("
	Closing_parenthesis: STRING is ")";

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

end -- class EB_TOOLBARABLE_COMMAND
