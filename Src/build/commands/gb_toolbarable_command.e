indexing
	description	: "Command that can be added in a toolbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	GB_TOOLBARABLE_COMMAND 

inherit
	GB_GRAPHICAL_COMMAND

	GB_TOOLBARABLE
		redefine
			new_toolbar_item
		end

feature -- Access

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version at least).
			-- Items at position 3 and 4 contain text.
		deferred
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		deferred
		ensure
			valid_result: Result /= Void
		end
		
	drop_agent: PROCEDURE [ANY, TUPLE [ANY]]
	
	veto_drop_agent: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
	
	pebble_function: FUNCTION [ANY, TUPLE, ANY]

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

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): GB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		local
			tt: STRING
		do
				-- Add it to the managed toolbar items
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
			create Result.make (Current)
			if display_text and pixmap.count >= 2 then
				Result.set_pixmap (pixmap @ 2)
			else
				Result.set_pixmap (pixmap @ 1)
			end
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			tt := tooltip.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.select_actions.extend (agent execute)
			if drop_agent /= Void then
				Result.drop_actions.extend (drop_agent)
			end
			if veto_drop_agent /= Void then
				Result.drop_actions.set_veto_pebble_function (veto_drop_agent)
			end
			if pebble_function /= Void then
				Result.set_pebble_function (pebble_function)
			end
		end

	new_mini_toolbar_item: GB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		require
			mini_pixmap_not_void: mini_pixmap /= Void
		do
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap @ 1)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent execute)
		end

feature {GB_COMMAND_TOOL_BAR_BUTTON} -- Implementation

	managed_toolbar_items: ARRAYED_LIST [like new_toolbar_item]
			-- Toolbar items associated with this command.
	
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
