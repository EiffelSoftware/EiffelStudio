indexing
	description	: "Item for EB_FAVORITES, This item describes a folder %
				  %and contains a set of folders and classes."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_FOLDER

inherit
	EB_FAVORITES_ITEM_LIST
		rename
			make as item_list_make
		undefine
			is_equal,
			copy
		end

	EB_FAVORITES_ITEM
		undefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name' and
			-- with parent `a_parent'.
		do
			item_list_make (5)
			name := a_name
			parent := a_parent
		end

feature -- Access

	is_folder: BOOLEAN is True
			-- Is the current item a folder?

feature -- Element change

	set_name (a_new_name: STRING) is
			-- Rename the current folder to `a_new_name'.
		require
			valid_new_name: a_new_name /= Void and then not a_new_name.is_empty
		do
			name := a_new_name
		ensure
			name_set: name.is_equal (a_new_name)
		end

feature -- Basic operations

	has_recursive_child (other: EB_FAVORITES_ITEM): BOOLEAN is
			-- Is `other' a recursive child of `Current'?
		local
			conv_folder: EB_FAVORITES_FOLDER
		do
			Result := other = Current
			from
				start
			until
				after or else Result
			loop
				conv_folder ?= item
				if conv_folder /= Void then
					Result := (item = other) or else (conv_folder.has_recursive_child (other))
				else
					Result := item = other
				end
				forth
			end
		end

feature -- Graphical interface

	mouse_cursor: EV_CURSOR is
			-- mouse pointer representing a class.
		once
			Result := Cursors.cur_Favorites_folder
		end

	Xmouse_cursor: EV_CURSOR is
			-- mouse pointer representing a class.
		once
			Result := Cursors.cur_X_Favorites_folder
		end

end -- class EB_FAVORITES_FOLDER
