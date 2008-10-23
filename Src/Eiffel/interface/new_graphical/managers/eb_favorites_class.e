indexing
	description	: "Item for EB_FAVORITES, This item describes a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_CLASS

inherit

	EB_FAVORITES_FOLDER
		redefine
			is_class,
			make,
			string_representation,
			mouse_cursor, Xmouse_cursor,
			refresh,
			associated_stone
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

create {EB_FAVORITES_ITEM_LIST}
	make_from_string

create
	make, make_from_class_stone

create {EB_FAVORITES_CLASS}
	make_filled

feature {NONE} -- Access

	make_from_string (a_analyzed_string: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `a_analyzed_string' set to `a_name'.
		local
			l_split: LIST [STRING]
		do
			l_split := a_analyzed_string.split (':')
			l_split.start
			make (l_split.item, a_parent)
			if not l_split.after then
				from
					l_split.forth
				until
					l_split.after
				loop
					add_feature (l_split.item)
					l_split.forth
				end
			end
		end

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name'.
		do
			Precursor {EB_FAVORITES_FOLDER} (a_name, a_parent)
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

feature -- Status

	is_class: BOOLEAN is True
			-- Is the current item a class ?			

feature -- Element change

	refresh is
			-- Refresh this item.
		local
			l_stone: like associated_stone
		do
			l_stone := associated_stone
			if l_stone /= Void then
				l_stone := l_stone.synchronized_stone
				if l_stone /= Void then
					make_from_class_stone (l_stone, parent)
				end
			end
		end

feature -- Graphical interface

	mouse_cursor: EV_POINTER_STYLE is
		once
			Result := Cursors.cur_Class
		end

	Xmouse_cursor: EV_POINTER_STYLE is
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

	associated_stone: CLASSI_STONE is
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
			if eiffel_universe.target /= Void then
				loc_list := Eiffel_universe.classes_with_name (name)
			end

				-- Return the first element of the list.
			if loc_list /= Void and then not loc_list.is_empty then
				associated_class_i := loc_list.first
			end
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		do
			if count = 0 then
				Result := name
			else
				Result := name
				from
					start
				until
					after
				loop
					Result := Result + ":" + item.string_representation
					forth
				end
			end
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

end -- class EB_FAVORITES_CLASS
