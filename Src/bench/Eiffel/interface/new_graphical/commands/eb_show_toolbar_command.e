indexing
	description	: "Command to show/hide a toolbar"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_SHOW_TOOLBAR_COMMAND

inherit
	EB_SHOW_WIDGET_COMMAND
		rename
			make as command_make
		redefine
			enable_visible,
			disable_visible,
			initialize
		end

	EB_MENUABLE_COMMAND
		redefine
			new_menu_item,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target; a_menu_name: STRING) is
			-- Initialize Current with target `a_target' and `menu_name' set to `a_menu_name'.
		do
			command_make (a_target)
			menu_name := a_menu_name
			name := a_menu_name
		end

	initialize is
			-- Initialize default values.
		do
			Precursor {EB_SHOW_WIDGET_COMMAND}
			Precursor {EB_MENUABLE_COMMAND}
		end

feature -- Status setting

	enable_visible is
			-- Set `is_visible' to True.
		local
			menu_items: like managed_menu_items
			citem: EB_COMMAND_CHECK_MENU_ITEM
		do
			if not is_visible then
				is_visible := True
				target.show
				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						citem := menu_items.item
						if not citem.is_selected then
							citem.select_actions.block
							citem.enable_select
							citem.select_actions.resume
						end
						menu_items.forth
					end
				end
			end
		end

	disable_visible is
			-- Set `is_visible' to True.
		local
			menu_items: like managed_menu_items
			citem: EB_COMMAND_CHECK_MENU_ITEM
		do
			if is_visible then
				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						citem := menu_items.item
						if citem.is_selected then
							citem.select_actions.block
							citem.disable_select
							citem.select_actions.resume
						end
						menu_items.forth
					end
				end
				is_visible := False
				target.hide
			end
		end

feature -- Basic operations

	new_menu_item: EB_COMMAND_CHECK_MENU_ITEM is
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
			Result.enable_sensitive
			if is_visible then
				Result.enable_select
			else
				Result.disable_select
			end
			Result.select_actions.extend (~execute)
		end

feature -- Access

	menu_name: STRING
			-- Name as it appears in the menu.

	name: STRING
			-- Name for the command.

end -- class EB_SHOW_TOOLBAR_COMMAND
