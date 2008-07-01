indexing
	description: "Objects that represent a precursor item in completion list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRECURSOR_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		rename
			make as make_old
		redefine
			insert_name,
			grid_item
		end
create
	make

feature {NONE} -- Initialization

	make (a_class_from: like class_from; a_type: like type; a_arguments: like arguments) is
			-- Initialization
		do
			make_old (precursor_string)
			class_from := a_class_from
			type := a_type
			arguments := a_arguments
			calculate_insert_name
		ensure
			name_not_void: name /= Void
			insert_name_not_void: insert_name /= Void
		end

feature -- Access

	class_from: like type
			-- Precursor class

	type: LIST [EDITOR_TOKEN]
			-- Return type

	arguments: like type
			-- Arguments

	insert_name: STRING_32
			-- Insert name

feature -- Status report

	has_class_from: BOOLEAN is
			-- Has `type'?
		do
			Result := class_from /= Void
		end

	has_type: BOOLEAN is
			-- Has `has_type'?
		do
			Result := type /= Void
		end

	has_arguments: BOOLEAN is
			-- Has `arguments'?
		do
			Result := arguments /= Void
		end

feature -- Query

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM is
			-- Grid item
		local
			l_items: ARRAYED_LIST [EDITOR_TOKEN]
			i: INTEGER
		do
			i := 2
			if has_class_from then
				i := i + class_from.count
			end
			if has_type then
				i := i + type.count
			end
			if has_arguments then
				i := i + arguments.count
			end
			create l_items.make (i)
			l_items.extend (create {EDITOR_TOKEN_KEYWORD}.make (precursor_string))
			if has_class_from then
				l_items.append (class_from)
			end
			if show_signature and then has_arguments then
				l_items.append (arguments)
			end
			if show_type and then has_type then
				l_items.append (type)
			end
			create Result
			Result.set_text_with_tokens (l_items)
			Result.set_pixmap (icon)
			Result.set_overriden_fonts (label_font_table, label_font_height)
		end

feature -- Element change

	set_class_from (a_class_from: like class_from) is
			-- Set `class_from' with `a_class_from'.
		require
			a_class_from_not_void: a_class_from /= Void
		do
			class_from := a_class_from
			calculate_insert_name
		ensure
			class_from_set: has_class_from
		end

	set_type (a_type: like type) is
			-- Set `type' with `a_type'.
		require
			a_type_from_not_void: a_type /= Void
		do
			type := a_type
			calculate_insert_name
		ensure
			has_type: has_type
		end

	set_arguments (a_arguments: like arguments) is
			-- Set `arguments' with `a_arguments'.
		require
			a_arguments_from_not_void: a_arguments /= Void
		do
			arguments := a_arguments
			calculate_insert_name
		ensure
			has_arguments: has_arguments
		end

feature {NONE} -- Implementation

	calculate_insert_name is
			-- Calculate insert name
		local
			l_string: STRING_32
		do
			create l_string.make (50)
			l_string.append_string (precursor_string)
			if has_class_from then
				l_string.append (image_of_list (class_from))
			end
			if has_arguments then
				l_string.append (image_of_list (arguments))
			end
			insert_name := l_string
		end

	image_of_list (a_list: LIST [EDITOR_TOKEN]): STRING_32 is
			-- Image of token list
		require
			a_list_not_void: a_list /= Void
		do
			create Result.make (20)
			from
				a_list.start
			until
				a_list.after
			loop
				Result.append (a_list.item.wide_image)
				a_list.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	precursor_string: STRING = "Precursor";

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

end
