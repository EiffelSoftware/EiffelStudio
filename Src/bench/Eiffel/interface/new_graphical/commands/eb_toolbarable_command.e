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

	EB_TOOLBARABLE
		redefine
			new_toolbar_item
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		deferred
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		deferred
		ensure
			valid_result: Result /= Void
		end

	tooltext: STRING is
			-- Text displayed on the toolbar button.
		do
			Result := ""
		ensure
			valid_result: Result /= Void
		end

	has_text: BOOLEAN is
			-- Does `Current' show text when displayed
		do
			Result := tooltext /= Void and then not tooltext.is_equal ("")
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
			toolbar_items: like managed_toolbar_items
		do
			if not is_sensitive then
				is_sensitive := True
				toolbar_items := managed_toolbar_items
				if toolbar_items /= Void then
					from
						toolbar_items.start
					until
						toolbar_items.after
					loop
						toolbar_items.item.enable_sensitive
						toolbar_items.forth
					end
				end
			end
		end

	disable_sensitive is
			-- Set `is_sensitive' to True.
		local
			toolbar_items: like managed_toolbar_items
		do
			if is_sensitive then
				toolbar_items := managed_toolbar_items
				if toolbar_items /= Void then
					from
						toolbar_items.start
					until
						toolbar_items.after
					loop
						toolbar_items.item.disable_sensitive
						toolbar_items.forth
					end
				end
				is_sensitive := False
			end
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			initialize_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		require
			mini_pixmap_not_void: mini_pixmap /= Void
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	initialize_toolbar_item (a_item: EB_COMMAND_TOOL_BAR_BUTTON; display_text: BOOLEAN) is
			-- Initialize `a_item'
		local
			tt: STRING
		do
			if display_text and then has_text then
				a_item.set_text (tooltext)
			end
			a_item.set_pixmap (pixmap)
			if is_sensitive then
				a_item.enable_sensitive
			else
				a_item.disable_sensitive
			end
			tt := tooltip.twin
			if accelerator /= Void then
				tt.append (opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (closing_parenthesis)
			end
			a_item.set_tooltip (tt)
		end

feature {EB_COMMAND_TOOL_BAR_BUTTON} -- Implementation

	internal_managed_toolbar_items: ARRAYED_LIST [like new_toolbar_item]

	managed_toolbar_items: ARRAYED_LIST [like new_toolbar_item] is
			-- Toolbar items associated with this command.
		do
			if internal_managed_toolbar_items = Void then
				create internal_managed_toolbar_items.make (1)
			end
			Result := internal_managed_toolbar_items
		end

	Opening_parenthesis: STRING is " ("
	Closing_parenthesis: STRING is ")";
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

end -- class EB_TOOLBARABLE_COMMAND
