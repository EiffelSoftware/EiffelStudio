note
	description: "A class to be inserted into the auto-complete list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_CLASS_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		rename
			make as make_old
		redefine
			icon,
			tooltip_text,
			is_class,
			insert_name,
			grid_item,
			is_obsolete
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
		undefine
			out,
			copy,
			is_equal
		end

create
	make

create {EB_CLASS_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_class: like associated_class; a_viewable_name: detachable STRING_32)
			-- Creates and initializes a new class completion item
		require
			a_class_not_void: a_class /= Void
		do
			if a_viewable_name = Void then
				token_writer.new_line
				a_class.append_name (token_writer)
				insert_name := token_writer.last_line.wide_image
			else
				insert_name := a_viewable_name
				viewable_name := a_viewable_name
			end
			make_old (insert_name)
			associated_class := a_class
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Access

	is_class: BOOLEAN
			-- Is completion item a class?
		do
			Result := True
		end

	insert_name: STRING_32
			-- Name to insert in editor

	viewable_name: detachable STRING_32
			-- Name to display.

	icon: EV_PIXMAP
			-- Associated icon based on data
		do
			Result := pixmap_from_class_i (associated_class)
		end

	tooltip_text: STRING_32
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		local
			l_comments: EIFFEL_COMMENTS
			l_text: STRING_32
			l_nls: INTEGER
		do
			create Result.make_empty

			l_comments := (create {COMMENT_EXTRACTOR}).class_comments (associated_class)
			if attached l_comments then
				from l_comments.start until l_comments.after loop
					if attached l_comments.item as l_comment_line then
						l_text := l_comment_line.content
						l_text.left_adjust
						l_text.right_adjust

						if not l_text.is_empty then
							Result.append_string_general (l_text)
							Result.append_character (' ')
							l_nls := 0
						else
							if l_nls >= 2 and then not l_comments.islast then
								Result.append ("%N%N")
							end
						end
						l_nls := l_nls + 1
					end
					l_comments.forth
				end
			end

			if Result.is_empty then
				Result := string
			end
		end

	grid_item : EB_GRID_EDITOR_TOKEN_ITEM
			-- Corresponding grid item
		local
			l_class: CLASS_C
			l_style: like just_class_name_style
		do
			l_class := associated_class.compiled_representation
			l_style := just_custom_class_name_style
			if l_class /= Void then
				l_style.set_class_c (l_class)
			else
				l_style.set_class_i (associated_class)
			end
			if viewable_name /= Void then
				l_style.enable_custom_name (viewable_name)
			else
				l_style.disable_custom_name
			end
			create Result
			Result.set_overriden_fonts (label_font_table, label_font_height)
			Result.set_pixmap (icon)
			Result.set_text_with_tokens (l_style.text)
		end

feature -- Status report

	is_obsolete: BOOLEAN
			-- Is item obsolete?
		local
			l_class: like associated_class
		do
			l_class := associated_class
			if l_class.is_compiled then
				Result := l_class.compiled_class.is_obsolete
			end
		end

feature {NONE} -- Implementation

	just_custom_class_name_style: EB_CLASS_EDITOR_TOKEN_STYLE
			-- Just class name style with possible custom names.
		once
			Result := just_class_name_style.twin
		end

	associated_class: CLASS_I;
			-- Corresponding class

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EB_CLASS_FOR_COMPLETION
