indexing
	description	: "Command that can be added in a menu and in a toolbar."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND 

inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			disable_sensitive,
			enable_sensitive
		end

	EB_MENUABLE_COMMAND
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
		
	new_menu_item: EB_COMMAND_MENU_ITEM is
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
			Result.select_actions.extend (~execute)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
		end

end -- class EB_TOOLBARABLE_AND_MENUABLE_COMMAND
