indexing
	description: "Class c stone containing the favorite item it stems from"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FAVORITES_CLASSC_STONE

inherit
	CLASSC_STONE
		rename
			make as old_make
		select
			classi_make
		end

	EB_FAVORITES_CLASS_STONE
		undefine
			header,
			is_valid,
			class_i,
			stone_signature,
			class_name,
			file_name,
			history_name,
			synchronized_stone,
			group
		redefine
			make_from_favorite
		end

create
	make_from_favorite

feature -- Initialization

	make_from_favorite (an_item: EB_FAVORITES_CLASS) is
			-- Create a class stone and save the attached favorite item
		require else
			class_exists_in_universe: an_item.associated_class_stone /= Void
			real_class_c: an_item.associated_class_c /= Void
		do
			default_create
			old_make (an_item.associated_class_c)
			origin := an_item
		end
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_FAVORITES_CLASSC_STONE

