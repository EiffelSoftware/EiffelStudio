indexing
	description	: "Command that can be added in a menu."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_MENUABLE_COMMAND 

inherit
	EB_GRAPHICAL_COMMAND

feature -- Access

	menu_name: STRING is
			-- Name as it appears in the menu (with '&' symbol).
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

	enable_sensitive is
			-- Set `is_sensitive' to True.
		local
			menu_items: like managed_menu_items
		do
			if not is_sensitive then
				is_sensitive := True
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
			end
		end

	disable_sensitive is
			-- Set `is_sensitive' to False.
		local
			menu_items: like managed_menu_items
		do
			if is_sensitive then
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
				is_sensitive := False
			end
		end

feature -- Basic operations

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
			mname := clone (menu_name)
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			Result.set_text (mname)
			Result.select_actions.extend (~execute)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
		end

feature {EB_COMMAND_MENU_ITEM} -- Implementation

	managed_menu_items: ARRAYED_LIST [like new_menu_item]
			-- Menu items associated with this command.
	
	Tabulation: STRING is "%T"

end -- class EB_MENUABLE_COMMAND
