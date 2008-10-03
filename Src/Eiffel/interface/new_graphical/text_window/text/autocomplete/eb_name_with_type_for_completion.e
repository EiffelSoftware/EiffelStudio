indexing
	description: "'name: TYPE' as one of completion possiblities."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_WITH_TYPE_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		rename
			make as old_make,
			make_token as old_make_token
		redefine
			grid_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_type: TYPE_A; a_feature: like feature_i) is
			-- Create feature name with value name.
		require
			a_name_not_void: a_name /= Void
			a_type_not_void: a_type /= Void
		do
			old_make (a_name)
			init (a_type, a_feature)
		end

	init (a_type: TYPE_A; a_feature: like feature_i)
			-- Common initialization
		require
			a_type_not_void: a_type /= Void
		do
			return_type := a_type
			feature_i := a_feature
			if show_type then
				append (completion_type)
			end
		end

feature -- Access

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM is
			-- Grid item
		local
			l_style: like local_style
		do
			l_style := local_style
			if show_type then
				l_style.enable_type
			else
				l_style.disable_type
			end

			create Result
			Result.set_overriden_fonts (label_font_table, label_font_height)
			if has_child then
				Result.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
			else
				Result.set_pixmap (pixmaps.icon_pixmaps.feature_local_variable_icon)
			end
			if name.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.result_keyword) then
				l_style.set_keyword_local (name, return_type, feature_i)
			else
				l_style.set_local (name, return_type, feature_i)
			end
			Result.set_text_with_tokens (l_style.text)
		end

	feature_i: FEATURE_I;
			-- Feature used to print types

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
