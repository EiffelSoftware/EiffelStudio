note
	description	: "Abstract Item for EB_FAVORITES"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	SHARED_LOCALE
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_name: like name; a_parent: EB_FAVORITES_ITEM_LIST)
			-- Initialize Current with `name' set to `a_name'.
		do
			if is_feature then
				name := string_general_as_lower (a_name)
			else
				name := string_general_as_upper (a_name)
			end
			parent := a_parent
		end

feature -- Access

	name: STRING_32
			-- Name of the "favorites" item (class name or folder name)
			-- or class_name.feature_name

	parent: EB_FAVORITES_ITEM_LIST
			-- Parent for the item.

	associated_stone: STONE
			-- FEATURE_STONE associated with favorite class, Void if none.
		deferred
		end

feature -- Status

	is_folder: BOOLEAN
			-- Is the current item a folder?
		deferred
		end

	is_class: BOOLEAN
			-- Is the current item a class?
		deferred
		end

	is_feature: BOOLEAN
			-- Is the current item a feature?
		deferred
		end

	is_equal (other: like Current): BOOLEAN
			-- Compare the names
		do
			Result := (other /= Void) and then
				(name.is_equal (other.name))
		end

feature -- Element change

	set_parent (a_parent: EB_FAVORITES_ITEM_LIST)
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		end

	refresh
			-- Refresh current item.
		deferred
		end

feature -- Interactivity

	add_item_to_parent (new_item: EB_FAVORITES_ITEM)
			-- Insert `new_item' in the parent list just after `Current'
		do
			parent.start
			parent.search (Current)
			parent.put_right (new_item)
		end

	mouse_cursor: EV_POINTER_STYLE
		deferred
		end

	Xmouse_cursor: EV_POINTER_STYLE
		deferred
		end

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING_32
			-- String representation for Current.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_FAVORITES_ITEM
