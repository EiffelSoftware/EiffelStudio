note
	description: "Objects that provide common features for object editors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_COMMON_EDITOR

inherit
	DEFAULT_OBJECT_STATE_CHECKER

feature -- Access

	attribute_editor: GB_OBJECT_EDITOR_ITEM
			-- A control which allows modification of items within
			-- `objects' of type `type'.
		deferred
		end

	type: STRING
			-- String representation of object_type modifyable by `Current'.
		deferred
		end

	ev_type: EV_ANY
		-- Vision2 type represented by `Current'.
		-- Only used with `like' in descendents.
		-- Always `Void'.
		deferred
		end

	first: like ev_type
			-- First entry in `objects'. This corresponds to
			-- the display component.
		require
			objects_not_empty: not objects.is_empty
		do
			Result := objects.first
		ensure
			Result_not_void: Result /= Void
		end

	parent_window (widget: EV_WIDGET): EV_WINDOW
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		do
			Result := {EV_WINDOW} / widget.parent
			if not attached Result and then attached widget.parent as p then
				Result := parent_window (p)
			end
		end

	parent_dialog (widget: EV_WIDGET): EV_DIALOG
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		do
			Result := {EV_DIALOG} / widget.parent
			if not attached Result and then attached widget.parent as p then
				Result := parent_dialog (p)
			end
		end

	parent_editor: EV_VERTICAL_BOX
			-- Object editor containing `Current'.

	set_parent_editor (parent: EV_VERTICAL_BOX)
			-- Assign `parent' to `parent_editor'.
		require
			parent_not_void: parent /= Void
			parent_not_destroyed: not parent.is_destroyed
		do
			parent_editor := parent
		ensure
			parent_set: parent_editor = parent
		end


	objects: ARRAYED_LIST [like ev_type]
		-- All objects to which `Current' represents.
		-- Modifications must be made to all items
		-- identically.

	set_main_object (an_object: like ev_type)
			-- Add `object' to `objects'.
		require
			object_not_void: an_object /= Void
		do
			if objects = Void then
				create objects.make (2)
			end
			objects.extend (an_object)
		end

	set_object (an_object: GB_OBJECT)
			--
		deferred
		end


feature -- Status setting

	align_labels_left (b: EV_BOX)
			-- For every item in `b' of type EV_LABEL, align the test left.
		require
			box_not_void: b /= Void
		do
			from
				b.start
			until
				b.off
			loop
				if attached {EV_LABEL} b.item as label then
					label.align_text_left
				end
				b.forth
			end
		end

	disable_all_items (b: EV_BOX)
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

	named_list_item_from_object (container: EV_CONTAINER): EV_LIST_ITEM
			-- `Result' is list item with text matching class name of `container'.
		require
			container_not_void: container /= Void
		do
			create Result.make_with_text (class_name (container.item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Basic operations

	for_all_objects (p: PROCEDURE)
			-- Call `p' on every item in `objects'.
		do
			from
				objects.start
			until
				objects.off
			loop
				p.flexible_call (objects.item)
				objects.forth
			end
		end

	for_first_object (p: PROCEDURE)
			-- Call `p' on the first_item in `objects'.
		do
			if not objects.is_empty then
				p.flexible_call (objects.first)
			end
		end

feature {NONE} -- Implementation

		-- All the features in this section do not require any implementation, but
		-- are available as the object editor classes from Build, will call them, as they
		-- are required by Build. For this widget test, they do not need to perform anything.

	update_editors
			-- Short version for calling everywhere.
		do
		end

	initialize_attribute_editor (editor: GB_OBJECT_EDITOR_ITEM)
			-- Initialize `editor'.
		do
		end


	enable_project_modified
			-- Call enable_project_modified on `system_status' and
			-- update commands to reflect this.
		do
		end

	new_object_editor (an_object: GB_OBJECT)
			-- Generate a new object editor containing `object'.
		do
		end

	set_default_icon_pixmap (dialog: EV_DIALOG)
			-- Set the default icon pixmap to `dialog'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
