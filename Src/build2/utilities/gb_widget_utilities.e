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
				container ?= containable.parent
				widget ?= containable
				check
					container_not_void: container /= Void
					widget_not_void: widget /= Void
				end
				container.prune (widget)
			end
			check
				containable_unparented: containable.parent = Void
			end
		end

end -- class GB_UTILITIES
