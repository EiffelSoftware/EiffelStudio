indexing
	description	: "Command that can be added in a menu."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_MENUABLE_COMMAND 

inherit
	EB_GRAPHICAL_COMMAND
	
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

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
			-- 
		do
			create Result.make (Current)
			initialize_menu_item (Result)
			Result.select_actions.extend (agent execute)
		end

	initialize_menu_item (a_menu_item: EB_COMMAND_MENU_ITEM) is
			-- Initialize `a_menu_item'
		local
			mname: STRING
		do
			mname := menu_name.twin
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			a_menu_item.set_text (mname)
			if is_sensitive then
				a_menu_item.enable_sensitive
			else
				a_menu_item.disable_sensitive
			end
		end

feature {EB_COMMAND_MENU_ITEM} -- Implementation

	managed_menu_items: ARRAYED_LIST [like new_menu_item] is
			-- Menu items associated with this command.
		do
			if internal_managed_menu_items = Void then
				create internal_managed_menu_items.make (1)
			end
			Result := internal_managed_menu_items
		end
	
	internal_managed_menu_items: ARRAYED_LIST [like new_menu_item]
		-- Menu items associated with this command.
	
	Tabulation: STRING is "%T"

end -- class EB_MENUABLE_COMMAND
