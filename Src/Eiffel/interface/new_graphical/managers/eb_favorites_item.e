indexing
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

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: EB_FAVORITES_ITEM_LIST) is
			-- Initialize Current with `name' set to `a_name'.
		do
			if is_feature then
				name := a_name.as_lower
			else
				name := a_name.as_upper				
			end
			parent := a_parent
		end

feature -- Access

	name: STRING
			-- Name of the "favorites" item (class name or folder name)
			-- or class_name.feature_name

	parent: EB_FAVORITES_ITEM_LIST
			-- Parent for the item.

feature -- Status

	is_folder: BOOLEAN is
			-- Is the current item a folder?
		deferred
		end
		
	is_class: BOOLEAN is
			-- Is the current item a class?
		deferred
		end

	is_feature: BOOLEAN is
			-- Is the current item a feature?
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

end -- class EB_FAVORITES_ITEM
