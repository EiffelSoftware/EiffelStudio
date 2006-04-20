indexing
	description	: "Item for an EB_EXPLORER_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "split, area, box, header, item"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXPLORER_BAR_ITEM

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_with_mini_toolbar,
	make_with_info

feature {NONE} -- Initialization

	make (a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET; a_title: STRING; closeable: BOOLEAN) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
		do
			is_closeable := closeable
			is_maximizable := True
			is_minimizable := True
			generic_make (a_parent, a_widget, a_title)
		end

	make_with_mini_toolbar (
		a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET;
		a_title: STRING; closeable: BOOLEAN;
		a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			mini_toolbar_not_void: a_mini_toolbar /= Void
		do
			mini_toolbar := a_mini_toolbar
			make (a_parent, a_widget, a_title, closeable)
		end

	make_with_info (
			a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET;
			a_title: STRING; closeable: BOOLEAN;
			info: EV_HORIZONTAL_BOX; a_mini_toolbar: EV_TOOL_BAR)
		is
				-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			info_not_void: info /= Void
		do
			mini_toolbar := a_mini_toolbar
			header_addon := info
			make (a_parent, a_widget, a_title, closeable)
		end

	generic_make (a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET; a_title: STRING) is
			-- Generic Initialization
		require
			a_parent_not_void: a_parent /= Void
			a_widget_not_void: a_widget /= Void
			a_title_not_void: a_title /= Void
		do
				-- Set the attributes
			parent := a_parent
			widget := a_widget
			is_visible := False
			menu_name := "Explorer bar item"
			title := a_title
			create show_actions
			create {EV_CELL} mini_toolbar_holder
			if mini_toolbar /= Void then
				mini_toolbar_holder.extend (mini_toolbar)
			end

				-- Connect actions required to update `Current' which its state
				-- has been changed in `parent'.
			parent.minimize_actions.extend (agent internal_set_minimized_wrapper)
			parent.maximize_actions.extend (agent internal_set_maximized_wrapper)
			parent.restore_actions.extend (agent internal_set_restored_wrapper)
			parent.close_actions.extend (agent close_wrapper)
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget.


	associated_command: EB_TOOLBARABLE_AND_MENUABLE_COMMAND
				-- Command associated with Current.

	pixmap: EV_PIXMAP
			-- Pixmap representing the item (for buttons)

	menu_name: STRING
			-- Name as it appears in menus.

	title: STRING
			-- Name as displayed in tools.

	parent: EB_EXPLORER_BAR
		-- Associated outlook bar.

	explorer_bar_manager: EB_EXPLORER_BAR_MANAGER is
			-- Associated Explorer Bar manager
		do
			Result := parent.explorer_bar_manager
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when the item becomes visible.

feature -- Status Report

	is_visible: BOOLEAN
			-- Is item visible?

	is_minimized: BOOLEAN
			-- Is the item minimized? (only the header is visible)

	is_maximized: BOOLEAN
			-- Is the item maximized? (obscures other items)

	is_restored: BOOLEAN is
			-- Is the item neither minimized nor maximized?
		do
			Result := not is_minimized and not is_maximized
		end

	is_closeable: BOOLEAN
			-- Is the current item closeable?

	is_maximizable: BOOLEAN
			-- Is the current item maximizable?

	is_minimizable: BOOLEAN
			-- Is the current item minimizable?

	is_text_on_button: BOOLEAN
			-- Is there a text displayed on some buttons?

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		require
			valid_pixmap: a_pixmap /= Void
		do
			pixmap := a_pixmap
		end

	set_menu_name (a_name: STRING) is
			-- Set `a_name' to `menu_name'.
		do
			menu_name := a_name
		end

	set_associated_command (a_command: like associated_command) is
			-- Set `a_command' to `associated_command'.
		do
			associated_command := a_command
		end

feature -- Status Setting

	close is
			-- Hide/Close current
		local
			selectable_command: EB_SELECTABLE
		do
			if is_visible then
				parent.remove (widget)
			end
			is_visible := False
			is_maximized := False
			is_minimized := False
			selectable_command ?= associated_command
			if selectable_command /= Void then
				selectable_command.disable_selected
			end
			if mini_toolbar_holder /= Void and then mini_toolbar_holder.parent /= Void then
				mini_toolbar_holder.parent.prune_all (mini_toolbar_holder)
			end
			parent.on_item_hidden (Current)
		end

	show_external (an_x, a_y, a_width, a_height: INTEGER) is
			--
		local
			selectable_command: EB_SELECTABLE
		do
			is_visible := True
			is_maximized := False
			is_minimized := False
			parent.add_external (widget, parent.explorer_bar_manager.window, title, 1, an_x, a_y, a_width, a_height)
			parent.docked_external (widget)

			if is_closeable then
				parent.enable_close_button (widget)
			else
				parent.enable_close_button_as_grayed (widget)
			end
				-- As the tools are added and removed from the toolbar frequently,
				-- `minimi_toolbar' may be parented, so must be unparented.
			if mini_toolbar_holder.parent /= Void then
				mini_toolbar_holder.parent.prune_all (mini_toolbar_holder)
			end
			parent.customizeable_area_of_widget (widget).extend (mini_toolbar_holder)
			parent.customizeable_area_of_widget (widget).disable_item_expand (mini_toolbar_holder)

			if header_addon /= Void then
				if header_addon.parent /= Void then
					header_addon.parent.prune_all (header_addon)
				end
				parent.customizeable_area_of_widget (widget).extend (header_addon)
			end

			selectable_command ?= associated_command
			if selectable_command /= Void then
				selectable_command.enable_selected
			end
		end


	show is
			-- Show current
		local
			selectable_command: EB_SELECTABLE
			position_within_tools: INTEGER
			insert_pos: INTEGER
			current_item: EB_EXPLORER_BAR_ITEM
			item_list: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]
			must_add_as_external: BOOLEAN
			external_window: EV_WINDOW
			a_widget: EV_WIDGET
		do
			parent.explorer_bar_manager.lock_update
			is_maximized := False
			is_minimized := False
			if not is_visible then
				is_visible := True
				show_actions.call (Void)

					-- Now calculate the insert position for `widget'.
					-- This is non trivial, as it must match the order within `item_list' of
					-- `parent', and some items in this list may not be displayed.
					-- We iterate `item_list' to determine the last item displayed in `parent'
					-- that should be displayed before `widget' and insert based on this.
				position_within_tools := parent.item_list.index_of (Current, 1)
				item_list := parent.item_list
				insert_pos := 1
				from
					item_list.start
				until
					item_list.off
				loop
					current_item ?= item_list.item
					check
						current_item_not_void: current_item /= Void
					end
					if current_item.is_visible and item_list.index < position_within_tools then
						insert_pos := insert_pos + 1
					end
					item_list.forth
				end
				if parent.explorer_style then
					from
						parent.item_list.start
					until
						parent.item_list.off
					loop
						if
							parent.external_representation.has (parent.item_list.item.widget) and
							parent.item_list.item.is_closeable and is_closeable
						then
							must_add_as_external := True
							from
								a_widget := parent.item_list.item.widget
							until
								external_window /= Void
							loop
								external_window ?= a_widget.parent
								a_widget := a_widget.parent
							end
						end
						if parent.linear_representation.has (parent.item_list.item.widget) and parent.item_list.item.is_closeable then
								-- Determine the position of the previous item contained in the bar which `Current'
								-- must replace. We use this index to insert `Current' at the correct index when in explorer style mode.
							insert_pos := parent.linear_representation.index_of (parent.item_list.item.widget, 1)
						end
						parent.item_list.forth
					end
				end

				if must_add_as_external then
					parent.add_external (widget, parent.explorer_bar_manager.window, title, insert_pos.min (parent.count + 1), external_window.x_position, external_window.y_position, external_window.width, external_window.height)
				else
					parent.insert_widget (widget, title, insert_pos.min (parent.count + 1), widget.minimum_height.max (150))
				end
				if is_closeable then
					parent.enable_close_button (widget)
				else
					parent.enable_close_button_as_grayed (widget)
				end
						-- As the tools are added and removed from the toolbar frequently,
						-- `mini_toolbar' may be parented, so must be unparented.
				if mini_toolbar_holder.parent /= Void then
					mini_toolbar_holder.parent.prune_all (mini_toolbar_holder)
				end
				parent.customizeable_area_of_widget (widget).extend (mini_toolbar_holder)
				parent.customizeable_area_of_widget (widget).disable_item_expand (mini_toolbar_holder)
				if header_addon /= Void then
					if header_addon.parent /= Void then
						header_addon.parent.prune_all (header_addon)
					end
					parent.customizeable_area_of_widget (widget).extend (header_addon)
				end
			end

			selectable_command ?= associated_command
			if selectable_command /= Void then
				selectable_command.enable_selected
			end
			parent.on_item_shown (Current)
			parent.explorer_bar_manager.unlock_update
		end

	minimize is
			-- Set the item to be minimized.
		require
			not_minimized: not is_minimized
		do
			is_minimized := True
			is_maximized := False

				-- Notify the parent
			parent.on_item_minimized (Current)
		end

	maximize is
			-- Set the item to be maximized.
		require
			not_maximized: not is_maximized
		do
			is_maximized := True
			is_minimized := False

				-- Notify the parent
			parent.on_item_maximized (Current)
		ensure
			maximized: is_maximized
		end

	restore is
			-- Set the item not to be minimized.
		require
			not_restored: not is_restored
		do
				-- Notify the parent
			parent.on_item_restored (Current)
			is_minimized := False
			is_maximized := False
		ensure
			restored: is_restored
		end

	recycle is
			-- Recycle current when not needed any longer.
		local
			selectable_command: EB_SELECTABLE
		do
			if parent /= Void then
					-- `parent' = `Void' if we are already recycled.
				is_visible := False
				is_maximized := False
				is_minimized := False
				selectable_command ?= associated_command
				if selectable_command /= Void then
					selectable_command.disable_selected
				end

					-- In EiffelStudio, the `parent' of `Current'
					-- does not have to contain `Current', as it may
					-- not be shown, hence we only remove the widget
					-- if actually inserted.
				if parent.linear_representation.has (widget) or parent.external_representation.has (widget) then
					parent.remove (widget)
				end
				parent.prune_item (Current)
				parent := Void
			end
		end

	disable_minimizable is
			-- Set `is_minimizable' to False
		do
			is_minimizable := False
		end

	enable_minimizable is
			-- Set `is_minimizable' to True
		do
			is_minimizable := True
		end

	disable_maximizable is
			-- Set `is_maximizable' to False
		do
			is_maximizable := False
		end

	enable_maximizable is
			-- Set `is_maximizable' to True
		do
			is_maximizable := True
		end

feature {EB_EXPLORER_BAR_ATTACHABLE} -- Status setting

	set_parent (new_parent: EB_EXPLORER_BAR) is
			-- Define a new explorer bar as the parent.
		require
			unparented: parent = Void
		do
			parent := new_parent
			new_parent.add (Current)
		end

	update_mini_toolbar (mtb: like mini_toolbar) is
			-- Update the mini_toolbar content with `mtb'
		require
			unparented: mtb.parent = Void
		do
			mini_toolbar := mtb
			mini_toolbar_holder.wipe_out
			mini_toolbar_holder.extend (mtb)
		ensure
			parented: mtb.parent = mini_toolbar_holder
		end

feature {EB_EXPLORER_BAR} -- Controls

	mini_toolbar_holder: EV_CONTAINER

	mini_toolbar: EV_TOOL_BAR

	header_addon: EV_HORIZONTAL_BOX
			-- Horizontal bar displayed in the header.

feature {EB_EXPLORER_BAR} -- Implementation

	reset is
			-- Reset `Current' to default state, non minimized, maximized or visible.
		do
			is_minimized := False
			is_maximized := False
			is_visible := False
			is_maximizable := True
			is_minimizable := True
		end

feature {EB_EXPLORER_BAR, EB_EXPLORER_BAR_ITEM} -- Implementation

	internal_set_restored is
			-- Flag current an non minimized or maximized.
		do
			is_minimized := False
			is_maximized := False
		end

feature {NONE} -- Implementation

	close_wrapper (closed_widget: EV_WIDGET) is
			-- A wrapper between the actions of `parent', and `Current',
			-- fired when the widget is closed. This message is
			-- sent to all items, and we must only respond if the widget
			-- is that of `Current'.
		do
			if closed_widget = widget then
				close
			end
		end

	internal_set_minimized_wrapper (a_widget: EV_WIDGET) is
			-- A wrapper between the actions of `parent', and `Current',
			-- fired when the widget is minimized. This message is
			-- sent to all items, and we must only respond if the widget
			-- is that of `Current'.
		do
			if a_widget = widget then
				internal_set_minimized
			end
		end

	internal_set_maximized_wrapper (a_widget: EV_WIDGET) is
			-- A wrapper between the actions of `parent', and `Current',
			-- fired when the widget is maximized. This message is
			-- sent to all items, and we must only respond if the widget
			-- is that of `Current'.
		do
			if a_widget = widget then
				internal_set_maximized
			end
		end

	internal_set_restored_wrapper (a_widget: EV_WIDGET) is
			-- A wrapper between the actions of `parent', and `Current',
			-- fired when the widget is restored. This message is
			-- sent to all items, and we must only respond if the widget
			-- is that of `Current'.
		do
			if a_widget = widget then
				internal_set_restored
			end
		end

	internal_set_minimized is
			-- Set internal state to minimized.
		do
			is_minimized := True
			is_maximized := False
		end

	internal_set_maximized is
			-- Set internal state to maximized.
		do
			is_maximized := True
			is_minimized := False
		end

invariant
	closed_implies_not_maximized: not is_visible implies not is_maximized
	not_minimized_and_maximized: not (is_minimized and is_maximized)

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

end -- class EB_EXPLORER_BAR_ITEM

