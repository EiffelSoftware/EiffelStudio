indexing
	description: "Objects that represent a command with two states%
		%e.g. hide/show."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_TWO_STATE_COMMAND
		-- Note that there is no support for changing pixmaps for the different
		-- states. This can easily be added if necessary.
	
inherit

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item
		end
		
	GB_SHARED_COMMAND_HANDLER

feature {NONE} -- Initialization

	make is
			-- Create `Current' and initialize.
		deferred
		end

feature -- Access

	tooltip: STRING is
			-- Tooltip for Current
		do
			Result := description
		end

	description: STRING is
			-- Description for current command.
		do
			Result := menu_name
		end

	menu_name: STRING is
			-- Name as it appears in menus.
		deferred
		end

	name: STRING is
		do
			Result := clone (menu_name)
			Result.prune_all ('&')
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		deferred
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		deferred
		end

	enable_selected is
			-- Set `is_selected' to True.
		do
			set_selected (True)
		end

	disable_selected is
			-- Set `is_selected' to False.
		do
			set_selected (False)
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		local
			tt: STRING
		do
				-- Add it to the managed toolbar items
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
				-- Create the button
			create Result.make (Current)
			if display_text and pixmap.count >= 2 then
				Result.set_pixmap (pixmap @ 2)
			else
				Result.set_pixmap (pixmap @ 1)
			end
			if is_selected then
				Result.enable_select
			end
			Result.select_actions.extend (~execute)
			Result.enable_sensitive
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
		end

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
			Result.select_actions.extend (~execute)
			Result.enable_sensitive
			if is_selected then
				Result.enable_select
			else
				Result.disable_select
			end
		end

feature {NONE} -- Implementation

	set_selected (a_selected: BOOLEAN)is
			-- Set `is_selected' to `a_selected'.
		local
			toolbar_items: like managed_toolbar_items
			menu_items: like managed_menu_items
		do
			if not safety_flag then
				safety_flag := True
				is_selected := a_selected
				toolbar_items := managed_toolbar_items
				if toolbar_items /= Void then
					from
						toolbar_items.start
					until
						toolbar_items.after
					loop
						if a_selected then
							toolbar_items.item.enable_select
						else
							toolbar_items.item.disable_select
						end
						toolbar_items.item.set_tooltip (tooltip)
						toolbar_items.forth
					end
				end

				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						if a_selected then
							menu_items.item.enable_select
						else
							menu_items.item.disable_select
						end
						menu_items.item.set_text (menu_name)
						menu_items.forth
					end
				end
				execute
				safety_flag := False
			end
		end

feature {NONE} -- Implementation

	safety_flag: BOOLEAN
			-- Are we changing the `is_selected' attribute? (To prevent stack overflows)
			
	is_selected: BOOLEAN
		-- Is current selected?


end -- class GB_TWO_STATE_COMMAND
