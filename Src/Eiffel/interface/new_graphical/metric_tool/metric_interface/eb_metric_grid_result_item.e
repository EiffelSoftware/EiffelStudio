indexing
	description: "Grid to display metric result item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_RESULT_ITEM

inherit
	EB_GRID_EDITOR_TOKEN_ITEM

	EVS_GRID_SEARCHABLE_ITEM
		undefine
			default_create,
			copy,
			is_equal
		redefine
			column_index,
			row_index
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			default_create,
			copy,
			is_equal
		end

	QL_UTILITY
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature -- Initialization

	make (a_item: QL_ITEM; a_column_index: INTEGER; a_row_index: INTEGER; a_path: BOOLEAN) is
			-- Initialize current with `a_item' `column_index' with `a_column_index' and `row_index' with `a_row_index'
			-- `a_path' is True indicates that current is path item.
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_writer: like token_writer
			l_full_signature: BOOLEAN
		do
			default_create
			column_index := a_column_index
			row_index := a_row_index
			set_overriden_fonts (label_font_table)
			if not a_path then
					-- Initialize current as a query language tem.
				l_writer := token_writer
				l_writer.new_line
				l_writer.set_context_group (Void)
				l_full_signature := not a_item.is_feature
				add_editor_token_representation (a_item, l_full_signature, True, l_writer)
				set_pixmap (pixmap_for_query_lanaguage_item (a_item))
				set_spacing (3)
				set_text_with_tokens (l_writer.last_line.content)
				image_internal := a_item.name
			else
					-- Initialize current as a path item.
				set_text_with_tokens (editor_tokens_of_query_item_path (a_item, Void, True, False, False))
				image_internal := text
			end
		ensure
			column_index_set: column_index = a_column_index
			row_index_set: row_index = a_row_index
			image_internal_attached: image_internal /= Void
		end

feature -- Access

	grid_item: EV_GRID_ITEM is
			-- EV_GRID item associated with current
		do
			Result := Current
		end

	column_index: INTEGER
			-- Column index

	row_index: INTEGER
			-- Row index

	image: STRING is
			-- Image used in search
		do
			Result := image_internal
		end

feature{NONE} -- Implementation

	internal_replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		do
		end

	image_internal: like image
			-- Implementation of `image'

invariant
	image_intarnal_attached: image_internal /= Void

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
