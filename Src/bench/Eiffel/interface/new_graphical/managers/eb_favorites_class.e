indexing
	description	: "Item for EB_FAVORITES, This item describes a class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_CLASS

inherit
	EB_FAVORITES_ITEM
		redefine
			make
		end

	EB_CONSTANTS
		undefine
			is_equal
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make, make_from_class_stone

feature -- Access

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name'.
		do
			Precursor {EB_FAVORITES_ITEM} (a_name, a_parent)
			get_class_i
		end

	make_from_class_stone (a_stone: CLASSI_STONE; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Generate from the data associated to a class stone and attach to `a_parent'
		require
			parent_non_void: a_parent /= Void
			valid_stone: a_stone /= Void
		do
			make (a_stone.class_name, a_parent)
		end

	is_folder: BOOLEAN is False
			-- Is the current item a folder?

feature -- Graphical interface

	mouse_cursor: EV_CURSOR is
		once
			Result := Cursors.cur_Class
		end

	Xmouse_cursor: EV_CURSOR is
		once
			Result := Cursors.cur_X_Class
		end

feature -- Convert

	associated_class_i: CLASS_I
			-- CLASS_I associated with Current, Void if none.

	associated_class_c: CLASS_C is
			-- CLASS_C associated with this favorite class, Void if none
		local
			class_i: CLASS_I
		do
			class_i := associated_class_i
			if class_i /= Void then
				Result := class_i.compiled_class
			end
		end

	associated_file_name: FILE_NAME is
			-- Full file name of this favorite class.
		local
			class_i: CLASS_I
		do
			class_i := associated_class_i
			if class_i /= Void then
				Result := class_i.file_name
			end
		end
	
	associated_class_stone: CLASSI_STONE is
			-- CLASSI_STONE associated with favorite class, Void if none.
		local
			class_i: CLASS_I
			class_c: CLASS_C
		do
			class_i := associated_class_i
			if class_i /= Void then
				class_c := class_i.compiled_class
				if class_c /= Void then
					create {EB_FAVORITES_CLASSC_STONE} Result.make_from_favorite (Current)
				else
					create {EB_FAVORITES_CLASS_STONE} Result.make_from_favorite (Current)
				end
			end
		end

feature {NONE} -- Implementation

	get_class_i is
			-- Find the corresponding class_i, depending on the name.
		local
			loc_list: LIST [CLASS_I]
		do
			loc_list := Eiffel_universe.classes_with_name (name)
		
				-- Return the first element of the list.
			if loc_list /= Void and then not loc_list.is_empty then
				associated_class_i := loc_list.first
			end
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		do
			Result := name
		end

end -- class EB_FAVORITES_CLASS
