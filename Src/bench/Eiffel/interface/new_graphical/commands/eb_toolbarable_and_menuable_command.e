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
			enable_sensitive
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
			-- Set `is_sensitive' to True.
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

end -- class EB_TOOLBARABLE_AND_MENUABLE_COMMAND
