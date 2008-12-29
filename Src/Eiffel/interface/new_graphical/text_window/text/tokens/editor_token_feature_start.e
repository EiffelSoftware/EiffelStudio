note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_FEATURE_START

inherit
	EDITOR_TOKEN_FEATURE
		redefine
			is_feature_start,
			text_color_id,
			process
		end

create
	make, make_with_pos

feature {NONE} -- Initialize

	make_with_pos (a_text: like wide_image; a_start_pos, a_end_pos: INTEGER)
			-- Create a new token for feature starting at `a_start_pos'.
		require
			a_text_not_void: a_text /= Void
			no_eal_in_text: not a_text.has ('%N')
			a_start_pos_positive: a_start_pos > 0
			a_end_pos_positive: a_end_pos > 0
			a_end_pos_greater_than_a_start_pos: a_start_pos <= a_end_pos
		do
			make (a_text)
			start_position := a_start_pos
			end_position := a_end_pos
		ensure
			start_position_set: start_position = a_start_pos
			end_position_set: end_position = a_end_pos
		end

feature -- Access

	feature_index_in_table: INTEGER
			-- Index of FEATURE_AS node matching start of feature.

	start_position, end_position: INTEGER
			-- Position in text file where feature really starts and ends.
			-- `start_position' might be less than `pos_in_text'.

feature -- Status report

	is_feature_start: BOOLEAN = True

feature -- Color

	text_color_id: INTEGER
		do
			if text_color_id_internal = 0 then
				Result := normal_text_color_id
			else
				Result := text_color_id_internal
			end
		end

feature -- Element change

	set_feature_index_in_table (index: INTEGER)
		do
			feature_index_in_table := index
		end

	set_text_color_feature
			-- Set text color with normal color.
		do
			text_color_id_internal := feature_text_color_id
		end

	set_text_color_normal
			-- Set text color with feature text color
		do
			text_color_id_internal := normal_text_color_id
		end

	set_text_color_operator
			-- Set text color with operator color
		do
			text_color_id_internal := operator_text_color_id
		end

	set_text_color_string
			-- Set text color with string color
		do
			text_color_id_internal := string_text_color_id
		end

feature -- Visitor

	process (a_visitor: EIFFEL_TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_feature_start (Current)
		end

feature {NONE} -- Implementation

	text_color_id_internal: INTEGER;

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class EDITOR_TOKEN_FEATURE_START
