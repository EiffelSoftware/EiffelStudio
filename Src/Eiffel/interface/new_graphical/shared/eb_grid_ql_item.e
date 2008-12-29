note
	description: "Grid item to display a query language item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_QL_ITEM

inherit
	EB_GRID_EDITOR_TOKEN_ITEM
		redefine
			column_index,
			row_index
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
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

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature -- Initialization

	make (a_item: QL_ITEM; a_column_index: INTEGER; a_row_index: INTEGER; a_path: BOOLEAN)
			-- Initialize current with `a_item' `column_index' with `a_column_index' and `row_index' with `a_row_index'
			-- `a_path' is True indicates that current is path item.
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		local
			l_path_style: like item_path_style
			l_feature: QL_FEATURE
		do
			image_internal := ""
			default_create
			column_index := a_column_index
			row_index := a_row_index
			if not a_path then
					-- Initialize current as a query language item.
				if a_item.is_feature then
					l_feature ?= a_item
					feature_with_class_style.set_ql_feature (l_feature)
					set_text_with_tokens (feature_with_class_style.text)
				else
					ql_name_style.set_item (a_item)
					set_text_with_tokens (ql_name_style.text)
				end
				set_pixmap (pixmap_for_query_lanaguage_item (a_item))
				set_image (a_item.name)
			else
					-- Initialize current as a path item.
				l_path_style := item_path_style
				l_path_style.set_item (a_item)
				l_path_style.set_is_folder_displayed (True)
				set_text_with_tokens (l_path_style.text)
				set_image (text)
			end
		ensure
			column_index_set: column_index = a_column_index
			row_index_set: row_index = a_row_index
			image_internal_attached: image_internal /= Void
		end

feature -- Access

	column_index: INTEGER
			-- Column index

	row_index: INTEGER
			-- Row index

feature{NONE} -- Implementation

	item_path_style: EB_PATH_EDITOR_TOKEN_STYLE
			-- Path style used to diplay path for query item
		once
			create Result
			Result.disable_target
			Result.disable_self
			Result.enable_parent
			Result.enable_indirect_parent
		ensure
			result_attached: Result /= Void
		end

invariant
	image_intarnal_attached: image_internal /= Void

note
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
