indexing
	description: "Box containing a list of strings for reporting summary of%
		%sequentially provided information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SUMMARY_BOX

inherit
	LINKED_LIST [STRING]
		rename
			make as make_list
		end

create
	make

feature -- Creation

	make (a_dialog: EV_DIALOG; a_title: STRING) is
			-- Make with `a_title'
		require
			a_dialog_not_void: a_dialog /= Void
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do
			make_list
			title := a_title			
		ensure
			title_set: title /= Void
		end

feature -- Access

	title: STRING
			-- Title

feature -- Query

	frame: EV_FRAME is
			-- Current represented as EV_FRAME
		local
			l_label: EV_LABEL
			l_box: EV_VERTICAL_BOX
		do
			create l_box
			create l_label.make_with_text ("%N")
			l_box.extend (l_label)
			l_box.disable_item_expand (l_label)
			create Result.make_with_text (title)
			Result.extend (l_box)
			from
				start
			until
				after
			loop
				create l_label.make_with_text (item)
				l_box.extend (l_label)
				l_box.disable_item_expand (l_label)
				l_label.align_text_left
				forth
			end
		end		

invariant
	has_title: title /= Void

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
end -- class SUMMARY_BOX
