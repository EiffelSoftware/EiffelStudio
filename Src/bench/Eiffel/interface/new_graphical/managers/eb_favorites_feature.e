indexing
	description	: "Item for EB_FAVORITES, This item describes a feature."
	author		: "$author$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_FEATURE

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

create {EB_FAVORITES_FEATURE}
	make
	
create {EB_FAVORITES_ITEM_LIST}
	make_with_class_c
	
create
	make_from_feature_stone

feature {NONE} -- Access

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name'.
		do
			Precursor {EB_FAVORITES_ITEM} (a_name, a_parent)
			get_e_feature
		end

	make_from_feature_stone (a_stone: FEATURE_STONE; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Generate from the data associated to a feature stone and attach to `a_parent'
		require
			parent_non_void: a_parent /= Void
			valid_stone: a_stone /= Void
		do
			class_name := a_stone.class_name
			feature_name := a_stone.feature_name
			make (feature_name, a_parent)
		end
		
	make_with_class_c (a_name: STRING; a_class_c: CLASS_C; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Generate from the data associated to a feature stone and attach to `a_parent'
		require
			parent_non_void: a_parent /= Void
			valid_name: a_name /= Void
			valid_class_c: a_class_c /= Void
		do
			class_name := a_class_c.name_in_upper
			feature_name := a_name.as_lower
			associated_class_c := a_class_c
			make (feature_name, a_parent)
		end		
		
feature -- Status

	is_folder: BOOLEAN is False
			-- Is the current item a folder ?

	is_class: BOOLEAN is False
			-- Is the current item a class ?			

	is_feature: BOOLEAN is True
			-- Is the current item a feature ?

feature -- Graphical interface

	mouse_cursor: EV_CURSOR is
		once
			Result := Cursors.cur_feature
		end

	Xmouse_cursor: EV_CURSOR is
		once
			Result := Cursors.cur_X_Feature
		end

feature -- Convert

	class_name: STRING
	
	feature_name: STRING

	associated_e_feature: E_FEATURE
			-- E_FEATURE associated with Current, Void if none.

	associated_class_c: CLASS_C
			-- CLASS_C associated with Current, Void if none.

	associated_feature_stone: FEATURE_STONE is
			-- FEATURE_STONE associated with favorite class, Void if none.
		do
			create {EB_FAVORITES_FEATURE_STONE} Result.make_from_favorite (Current)
		end

feature {NONE} -- Implementation

	get_e_feature is
		-- Find the corresponding feature_i, depending on the name.
		local
			conv_class: EB_FAVORITES_CLASS
			l_fav_list: EB_FAVORITES_ITEM_LIST
		do
			l_fav_list := parent
			if associated_class_c = Void then
				conv_class ?= parent
				if conv_class /= Void then
					associated_class_c := conv_class.associated_class_c
				end				
			end
			if associated_class_c /= Void then
				associated_e_feature := associated_class_c.feature_with_name (feature_name)
			end
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		do
			Result := name
		end

end -- class EB_FAVORITES_FEATURE
