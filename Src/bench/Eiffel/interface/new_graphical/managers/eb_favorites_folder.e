indexing
	description	: "Item for EB_FAVORITES, This item describes a folder %
				  %and contains a set of folders and classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
create {EB_FAVORITES_FOLDER}
	make_filled

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name' and
			-- with parent `a_parent'.
		do
			item_list_make (5)
			name := a_name
			parent := a_parent
		end

feature -- Status

	is_folder: BOOLEAN is True
			-- Is the current item a folder ?

	is_class: BOOLEAN is 
			-- Is the current item a class ?
		do
			Result := False
		end

	is_feature: BOOLEAN is False
			-- Is the current item a feature ?

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

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
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

end -- class EB_FAVORITES_FOLDER
