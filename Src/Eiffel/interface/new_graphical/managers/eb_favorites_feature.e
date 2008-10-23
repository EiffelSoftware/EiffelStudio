indexing
	description	: "Item for EB_FAVORITES, This item describes a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			associated_e_feature := a_stone.e_feature
			associated_class_c := a_stone.e_class
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

feature -- Element change

	refresh is
			-- Refresh information.
		local
			l_stone: like associated_stone
		do
			l_stone ?= associated_stone.synchronized_stone
			if l_stone /= Void then
				make_from_feature_stone (l_stone, parent)
			end
		end

feature -- Graphical interface

	mouse_cursor: EV_POINTER_STYLE is
		once
			Result := Cursors.cur_feature
		end

	Xmouse_cursor: EV_POINTER_STYLE is
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

	associated_stone: FEATURE_STONE is
			-- FEATURE_STONE associated with favorite class, Void if none.
		do
			if associated_e_feature /= Void then
				create {EB_FAVORITES_FEATURE_STONE} Result.make_from_favorite (Current)
			end
		end

feature -- Feature nature

	is_deferred: BOOLEAN is
		do
			Result := associated_e_feature.is_deferred
		end

	is_constant: BOOLEAN is
		do
			Result := associated_e_feature.is_constant
		end

	is_once: BOOLEAN is
		do
			Result := associated_e_feature.is_once
		end

	is_attribute: BOOLEAN is
		do
			Result := associated_e_feature.is_attribute
		end

	is_external: BOOLEAN is
		do
			Result := associated_e_feature.is_external
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
			if associated_class_c /= Void and associated_e_feature = Void then
				associated_e_feature := associated_class_c.feature_with_name (feature_name)
			end
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		do
			Result := name
		end

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

end -- class EB_FAVORITES_FEATURE
