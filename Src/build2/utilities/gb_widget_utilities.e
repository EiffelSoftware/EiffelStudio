indexing	
	description: "Objects that provide useful facilities for widgets."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_WIDGET_UTILITIES

feature -- Basic operations

	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		local
			window: EV_WINDOW
		do
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := parent_window (widget.parent)
				end	
			else
				Result := window
			end	
		end
		
	parent_dialog (widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		local
			dialog: EV_DIALOG
		do
			dialog ?= widget.parent
			if dialog = Void then
				if widget.parent /= Void then
					Result := parent_dialog (widget.parent)
				end	
			else
				Result := dialog
			end	
		end
		
	x_position_relative_to_window (widget: EV_WIDGET): INTEGER is
			-- `Result' is the x position of `widget' relative to
			-- the EV_WINDOW containing `widget'.
			-- If `widget' is not contained in an EV_WINDOW, then
			-- there will be problems.
		local
			window: EV_WINDOW
		do
			Result := Result + widget.x_position
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := Result + x_position_relative_to_window (widget.parent)
				else
					check
						Widget_was_not_parented_in_a_window: False
					end
				end
			end
		end
		
	y_position_relative_to_window (widget: EV_WIDGET): INTEGER is
			-- `Result' is the y position of `widget' relative to
			-- the EV_WINDOW containing `widget'.
			-- If `widget' is not contained in an EV_WINDOW, then
			-- there will be problems.
		local
			window: EV_WINDOW
		do
			Result := Result + widget.y_position
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := Result + y_position_relative_to_window (widget.parent)
				else
					check
						Widget_was_not_parented_in_a_window: False
					end
				end
			end
		end
		

	extend_no_expand (a_box: EV_BOX; a_widget: EV_WIDGET) is
			-- Extend `a_widget' into `a_box' and disable expandability.
		require
			box_not_void: a_box /= Void
			a_widget_not_void: a_widget /= Void
		do
			a_box.extend (a_widget)
			a_box.disable_item_expand (a_widget)
		ensure
			box_contains_widget: a_box.has (a_widget)
			widget_not_expanded: not a_box.is_item_expanded (a_widget)
		end
		
	disable_all_items (b: EV_BOX) is
			-- Call `disable_item_expand' on all items in `b'.
		require
			box_not_void: b /= Void
		do
			from
				b.start
			until
				b.off
			loop
				b.disable_item_expand (b.item)
				b.forth
			end
		end
		
	align_labels_left (b: EV_BOX) is
			-- For every item in `b' of type EV_LABEL, align the test left.
		require
			box_not_void: b /= Void
		local
			label: EV_LABEL
		do
			from
				b.start
			until
				b.off
			loop
				label ?= b.item
				if label /= Void then
					label.align_text_left
				end
				b.forth
			end
		end
		
		
	unparent_ev_object (ev_object: EV_ANY) is
			-- Remove `ev_object' from its parent.
		local
			dynamic_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]
			container: EV_CONTAINER
			widget: EV_WIDGET
			containable: EV_CONTAINABLE
			menu_bar: EV_MENU_BAR
			titled_window: EV_TITLED_WINDOW
		do
			containable ?= ev_object
			check
				containable_not_void: containable /= Void
				containable_has_parent: containable.parent /= Void
			end
			dynamic_list ?= containable.parent
			if dynamic_list /= Void then
				check
					containable_contained_in_parent: dynamic_list.has (containable)
				end
				dynamic_list.prune (containable)
			else
				menu_bar ?= containable
				if menu_bar /= Void then
					titled_window ?= containable.parent
					check
						titled_window_not_void: titled_window /= Void
					end
					titled_window.remove_menu_bar
				else
					container ?= containable.parent
					widget ?= containable
					check
						container_not_void: container /= Void
						widget_not_void: widget /= Void
					end
					container.prune (widget)
				end
			end
			check
				containable_unparented: containable.parent = Void
			end
		end
		
	fake_cancel_button (a_dialog: EV_DIALOG; action: PROCEDURE [ANY, TUPLE]) is
			-- Place a cancel button in `a_dialog',
			-- and then remove it, so that we have
			-- a cross on the window.
		local
			button: EV_BUTTON
		do
			create button
			a_dialog.extend (button)
			button.select_actions.extend (action)
			a_dialog.set_default_cancel_button (button)
			a_dialog.prune_all (button)
		end
		
	restore_titled_window (window: EV_TITLED_WINDOW; title: STRING) is
			-- Restore `window' to a default state except title will
			-- be set to `title'.
		require
			window_not_void: window /= Void
			title_not_void: title /= Void
		local
			temp_window: EV_TITLED_WINDOW
		do
			create temp_window
			window.set_maximum_size (temp_window.maximum_width, temp_window.maximum_height)
			window.remove_background_pixmap
			window.set_title (title)
			window.set_background_color (temp_window.background_color)
			window.set_foreground_color (temp_window.foreground_color)
			window.enable_user_resize
			window.set_minimum_width (temp_window.minimum_width)
			window.set_minimum_height (temp_window.minimum_height)
			temp_window.destroy
		end

end -- class GB_UTILITIES
