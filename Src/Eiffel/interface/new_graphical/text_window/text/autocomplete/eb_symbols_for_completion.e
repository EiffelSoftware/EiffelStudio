note
	description: "Name of unicode symbol to be inserted by autocomplete"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYMBOLS_FOR_COMPLETION

inherit

	WILD_NAME_FOR_COMPLETION
		rename
			make as make_with_name
		export
			{NONE} set_icon
		redefine
			icon,
			child_type,
			tooltip_text,
			insert_name,
			full_insert_name,
			grid_item,
			child_grid_items,
			name_matcher
		end

	EB_SHARED_PREFERENCES
		undefine
		    copy,
		    out,
		    is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			copy,
			is_equal,
			out
		end

create
	make,
	make_parent

create {NAME_FOR_COMPLETION}
	make_with_name

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; a_symbol: CHARACTER_32)
			-- Create feature name with value `name'
		local
			n: STRING_32
		do
			create title.make_from_string_general (a_name)
			symbol := a_symbol
			create n.make_from_string_general (a_name)
			n.prune_all (' ') -- easier for completion .. to check!
			make_with_name (n)
		end

	make_parent (a_name: READABLE_STRING_GENERAL)
		do
			make (a_name, '%U')
		end

feature -- Access

	symbol: CHARACTER_32

	title: IMMUTABLE_STRING_32

feature -- Access	

	insert_name: STRING_32
			-- Name to insert in editor
		do
			if symbol = '%U' then
				create Result.make_empty
			else
				create Result.make (1)
				Result.append_character (symbol)
			end
		end

	full_insert_name: STRING_32
			-- Full name to insert in editor
		do
			Result := insert_name
		end

feature -- Query

	is_class: BOOLEAN = False
			-- Is a class?

	is_obsolete: BOOLEAN = False
			-- Is item obsolete?

	icon: EV_PIXMAP
			-- Icon
		do
			Result := pixmaps.icon_pixmaps.general_edit_icon
		end

	grid_item: EV_GRID_LABEL_ITEM
			-- Corresponding grid item
		local
			s: STRING_32
		do
			create s.make_from_string (title)
			if symbol /= '%U' then
				s.append_character (':')
				s.append_character (' ')
				s.append_character (symbol)
			end

			create Result.make_with_text (s)
			Result.set_pixmap (icon)
		end

	tooltip_text: STRING_32
			-- <Precursor>
		do
			create Result.make (title.count)
			if symbol /= '%U' then
				Result.append_character (symbol)
				Result.append_character (' ')
				Result.append_character (':')
				Result.append_character (' ')
				Result.append (title)
				if not title.is_case_insensitive_equal_general (name) then
					Result.append_character (' ')
					Result.append_character ('(')
					Result.append (name.as_lower)
					Result.append_character (')')
				end
				Result.append_character ('%N')
				Result.append ("Eiffel code: %'%%/")
				Result.append (symbol.natural_32_code.out)
				Result.append ("/%'%N")
			else
				Result.append ("%NList of unicode symbols...")
			end
		end

	child_grid_items: ARRAYED_LIST [EV_GRID_ITEM]
			-- Grid items of childrens
		do
			create Result.make (children.count)
			across
				children as ic
			loop
				Result.extend (ic.item.grid_item)
			end
		end

feature -- Status Report

	display_colorized_tooltip: BOOLEAN
			-- Display colorized tooltip?
			-- We do not display this tooltip since focus issue.
		do
			Result := False
		end

feature {NONE} -- Implementation

	name_matcher: COMPLETION_NAME_MATCHER
			-- Name matcher
		once
			create {WILD_COMPLETION_NAME_MATCHER} Result
		end

	child_type: EB_SYMBOLS_FOR_COMPLETION
			-- Child type

invariant

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

end
