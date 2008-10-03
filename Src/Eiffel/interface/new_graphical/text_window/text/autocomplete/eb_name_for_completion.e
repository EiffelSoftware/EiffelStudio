indexing
	description: "Name of a feature or a class to be inserted by autocomplete"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_FOR_COMPLETION

inherit

	NAME_FOR_COMPLETION
		export
			{NONE} set_icon
		redefine
			make,
			icon,
			child_type,
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

	QL_UTILITY
		undefine
			copy,
			is_equal,
			out
		end

	EB_SHARED_WRITER
		undefine
			copy,
			is_equal,
			out
		end

create
	make,
	make_token,
	make_tokens

create {EB_NAME_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Create feature name with value `name'
		do
			Precursor {NAME_FOR_COMPLETION} (a_name)
			has_dot := True
		ensure then
			name_set: name = a_name
		end

	make_token (a_token: EDITOR_TOKEN) is
			-- Create with single token.
		require
			a_token_not_void: a_token /= Void
		local
			l_list: ARRAYED_LIST [EDITOR_TOKEN]
		do
			create l_list.make (1)
			l_list.extend (a_token)
			set_tokens (l_list)
		ensure
			name_not_void: name /= Void
			token_exist: token_exist
		end

	make_tokens (a_tokens: like tokens) is
			-- Create with `a_tokens'
		require
			a_tokens_not_void: a_tokens /= Void
		do
			set_tokens (a_tokens)
		ensure
			name_not_void: name /= Void
			token_exist: token_exist
		end

feature -- Query

	is_class: BOOLEAN is
			-- Is a class?
		do
			Result := False
		end

	is_obsolete: BOOLEAN is
			-- Is item obsolete?
		do
			Result := False
		end

	icon: EV_PIXMAP is
			-- Icon
		do
			Result := pixmaps.icon_pixmaps.feature_local_variable_icon
		end

	grid_item : EB_GRID_EDITOR_TOKEN_ITEM is
			-- Corresponding grid item
		local
			l_style: like local_style
		do
			l_style := local_style
			create Result
			Result.set_overriden_fonts (label_font_table, label_font_height)
			if has_child then
				Result.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
			else
				Result.set_pixmap (icon)
			end
			if not token_exist then
				l_style.disable_type
				l_style.set_local (Current, Void, Void)
				if name.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.result_keyword) then
					l_style.set_keyword_local (Current, Void, Void)
				else
					l_style.set_local (Current, Void, Void)
				end
				Result.set_text_with_tokens (l_style.text)
			else
				Result.set_text_with_tokens (tokens)
			end
		end

	child_grid_items: ARRAYED_LIST [EB_GRID_EDITOR_TOKEN_ITEM] is
			-- Grid items of childrenS
		local
			i: INTEGER
		do
			create Result.make (children.count)
			from
				i := children.lower
			until
				i > children.upper
			loop
				Result.extend (children.item (i).grid_item)
				i := i + 1
			end
		end

	tokens: LIST [EDITOR_TOKEN]
			-- Tokens to display		

feature -- Status Report

	has_dot: BOOLEAN

	token_exist: BOOLEAN is
			-- Does `tokens' exist?
		do
			Result := tokens /= Void
		end

	show_signature: BOOLEAN is
			-- Should signature be displayed?
		do
		    Result := preferences.editor_data.show_completion_signature
		end

	show_type: BOOLEAN is
			-- Should feature return type be displayed?
		do
		    Result := preferences.editor_data.show_completion_type
		end

	show_disambiguated_name: BOOLEAN is
			-- Should disambiguated name be displayed?
		do
			Result := preferences.editor_data.show_completion_disambiguated_name
		end

	display_colorized_tooltip: BOOLEAN is
			-- Display colorized tooltip?
			-- We do not display this tooltip since focus issue.
		do
			Result := False
		end

feature -- Status setting

	set_has_dot (hd: BOOLEAN) is
			-- assign `hd' to `has_dot'
		do
			has_dot := hd
		end

	set_tokens (a_tokens: like tokens) is
			-- Set `tokens' with `a_tokens'.
		require
			a_tokens_not_void: a_tokens /= Void
		local
			l_string: STRING_32
		do
			tokens := a_tokens
			create l_string.make (50)
			from
				tokens.start
			until
				tokens.after
			loop
				l_string.append (tokens.item.wide_image)
				tokens.forth
			end
			make (l_string)
		ensure
			token_exist: token_exist
		end

feature {NONE} -- Implementation

	name_matcher: COMPLETION_NAME_MATCHER is
			-- Name matcher
		once
			create {WILD_COMPLETION_NAME_MATCHER}Result
		end

	return_type: TYPE_A
			-- Associated feature's return type

	child_type: EB_NAME_FOR_COMPLETION;
		-- Child type

	completion_type: STRING_32 is
			-- The type of the feature (for a function, attribute)
		local
			l_desc: STRING_32
		do
			if internal_completion_type = Void then
				if return_type /= Void then
					l_desc := return_type.dump
					create Result.make (2 + l_desc.count)
					Result.append (": ")
					Result.append (l_desc)
				else
					create Result.make_empty
				end
				internal_completion_type := Result
			else
				Result := internal_completion_type
			end
		ensure
			result_not_void: Result /= Void
		end

	internal_completion_type: STRING_32
			-- cache `completion_type'

	local_style: EB_LOCAL_EDITOR_TOKEN_STYLE is
			-- Local style to generate text of local
		once
			create Result
		ensure
			result_attached: Result /= Void
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

end -- class EB_NAME_FOR_COMPLETION
