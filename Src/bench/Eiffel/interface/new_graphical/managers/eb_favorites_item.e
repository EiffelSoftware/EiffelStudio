indexing
	description	: "Abstract Item for EB_FAVORITES"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_FAVORITES_ITEM

inherit
	EB_CONSTANTS
		undefine
			is_equal
		end

	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name'.
		do
			name := clone (a_name)
			name.to_upper
			parent := a_parent
		end

feature -- Access

	name: STRING
			-- Name of the "favorites" item (class name or folder name)

	parent: EB_FAVORITES_ITEM_LIST
			-- Parent for the item.

	is_folder: BOOLEAN is
			-- Is the current item a folder?
		deferred
		end

	is_equal (other: like Current): BOOLEAN is
			-- Compare the names
		do
			Result := (other /= Void) and then
				(name.is_equal (other.name))
		end

feature -- Element change

	set_parent (a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		end

feature -- Interactivity

	add_item_to_parent (new_item: EB_FAVORITES_ITEM) is
			-- Insert `new_item' in the parent list just after `Current'
		do
			parent.start
			parent.search (Current)
			parent.put_right (new_item)
		end

	mouse_cursor: EV_CURSOR is
		deferred
		end

	Xmouse_cursor: EV_CURSOR is
		deferred
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		deferred
		end

end -- class EB_FAVORITES_ITEM
