indexing
	description: "Command to separate the stone management between the development%
				%window and the context tool"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_UNIFY_STONE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Initialization

	make (dev: EB_DEVELOPMENT_WINDOW) is
			-- Initialize `Current' and associate it with `dev'.
		do
			window := dev
			enable_sensitive
		end

feature -- Status report

	description: STRING is
		do
			Result := Interface_names.e_Toggle_stone_management
		end

	name: STRING is "Toggle_stone"

	pixmap: ARRAY [EV_PIXMAP] is
		do
			Result := Pixmaps.Icon_unify_stone
		end

	tooltip: STRING is
		do
			if window.unified_stone then
				Result := Interface_names.e_Separate_stone
			else
				Result := Interface_names.e_Unify_stone
			end
		end

	menu_name: STRING is
		do
			if window.unified_stone then
				Result := Interface_names.m_Separate_stone
			else
				Result := Interface_names.m_Unify_stone
			end
		end

feature -- Basic operations

	execute is
			-- Toggle between a unified mode and a separate mode.
		do
			if not flag then
				flag := True
				window.toggle_unified_stone
				if managed_menu_items /= Void then
					from
						managed_menu_items.start
					until
						managed_menu_items.after
					loop
						managed_menu_items.item.remove_text
						managed_menu_items.item.set_text (menu_name)
						managed_menu_items.forth
					end
				end
				if managed_toolbar_items /= Void then
					from
						managed_toolbar_items.start
					until
						managed_toolbar_items.after
					loop
						managed_toolbar_items.item.select_actions.block
						managed_toolbar_items.item.toggle
						managed_toolbar_items.item.select_actions.resume
						managed_toolbar_items.forth
					end
				end
				update_tooltip
				flag := False
			end
		end

	update_tooltip is
			-- Display the good tooltip on buttons.
		do
			if managed_toolbar_items /= Void then
				from
					managed_toolbar_items.start
				until
					managed_toolbar_items.after
				loop
--					managed_toolbar_items.item.remove_tooltip
					managed_toolbar_items.item.set_tooltip (tooltip)
					managed_toolbar_items.forth
				end
			end
		end

	toggle_buttons is
			-- Display the good tooltip on buttons.
		do
			if managed_toolbar_items /= Void then
				from
					managed_toolbar_items.start
				until
					managed_toolbar_items.after
				loop
					managed_toolbar_items.item.select_actions.block
					managed_toolbar_items.item.toggle
					managed_toolbar_items.item.select_actions.resume
					managed_toolbar_items.forth
				end
			end
		end

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
			if window.unified_stone then
				Result.toggle
			end
			Result.select_actions.extend (~execute)
			Result.select_actions.extend (~toggle_buttons)
			Result.enable_sensitive
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
		end

feature {NONE} -- Implementation

	flag: BOOLEAN
			-- Is `Current' being executed?

	window: EB_DEVELOPMENT_WINDOW
			-- Window `Current' is associated with.

end -- class EB_UNIFY_STONE_CMD
