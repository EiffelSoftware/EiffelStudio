indexing
	description	: "Command that can be added in a menu and in a toolbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	GB_TOOLBARABLE_AND_MENUABLE_COMMAND 

inherit
	GB_TOOLBARABLE_COMMAND
		redefine
			disable_sensitive,
			enable_sensitive
		end

	GB_MENUABLE_COMMAND
		redefine
			disable_sensitive,
			enable_sensitive,
			new_menu_item
		end

feature -- Status setting

	enable_sensitive is
			-- Set `is_sensitive' to True.
		local
			menu_items: like managed_menu_items
			toolbar_items: like managed_toolbar_items
		do
			if not is_sensitive then
					-- Enable menu items
				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						menu_items.item.enable_sensitive
						menu_items.forth
					end
				end

					-- Enable toolbar item
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

				is_sensitive := True
			end
		end

	disable_sensitive is
			-- Set `is_sensitive' to False.
		local
			menu_items: like managed_menu_items
			toolbar_items: like managed_toolbar_items
		do
			if is_sensitive then
					-- Disable menu items
				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						menu_items.item.disable_sensitive
						menu_items.forth
					end
				end

					-- Disable toolbar item
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
		
	new_menu_item: GB_COMMAND_MENU_ITEM is
			-- Create a new menu entry for this command.
		local
			mname: STRING
		do
				-- Add it to the managed menu items
			if managed_menu_items = Void then
				create managed_menu_items.make (1)
			end
				-- Create the menu item
			create Result.make (Current)
			mname := menu_name.twin
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			if pixmap /= Void then
				if pixmap.count >= 2 then
					Result.set_pixmap (pixmap @ 2)
				else
					Result.set_pixmap (pixmap @ 1)
				end
			end
			Result.set_text (mname)
			Result.select_actions.extend (agent execute)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
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


end -- class EB_TOOLBARABLE_AND_MENUABLE_COMMAND
