indexing
	description: "Object that represents a style for group displayed in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_QUERY_LANGUAGE_ITEM_STYLE

inherit
	EB_GRID_COMPILER_ITEM_STYLE

	EB_SHARED_EDITOR_TOKEN_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_full_path_enabled: BOOLEAN; a_self_included: BOOLEAN) is
			-- Initialize `is_full_path_enabled' with `a_full_path_enabled' and
			-- `is_self_included' with `a_self_include'.
		do
			if a_full_path_enabled then
				enable_full_path
			else
				disable_full_path
			end
			if a_self_included then
				enable_self_inclusion
			else
				disable_self_inclusion
			end
		ensure
			is_full_path_enabled_set: is_full_path_enabled = a_full_path_enabled
			is_self_included_set: is_self_included = a_self_included
		end

feature -- Status report

	is_full_path_enabled: BOOLEAN
			-- Should full path of given query language item be displayed?
			-- If True, display full path in form of "name.name.name",
			-- otherwise, only display name of that query language (if `is_self_included' is Tre).

	is_self_included: BOOLEAN
			-- Should `item' itself be displayed?

feature -- Setting

	enable_full_path is
			-- Set `is_full_path_enabled' to True.
		do
			is_full_path_enabled := True
		ensure
			full_path_enabled: is_full_path_enabled
		end

	disable_full_path is
			-- Set `is_full_path_enabled' to False.
		do
			is_full_path_enabled := False
		ensure
			full_path_disabled: not is_full_path_enabled
		end

	enable_self_inclusion is
			-- Set `is_self_included' to True.
		do
			is_self_included := True
		ensure
			self_inclusion_enabled: is_self_included
		end

	disable_self_inclusion is
			-- Set `is_self_included' to False.
		do
			is_self_included := False
		ensure
			self_inclusion_disabled: not is_self_included
		end

	apply (a_item: EB_GRID_QUERY_LANGUAGE_ITEM) is
			-- Apply current style to `a_item'.
		do
			setup_text (a_item)
			setup_tooltip (a_item)
			if a_item.is_parented then
				a_item.redraw
			end
		end

feature -- Access

	image (a_item: EB_GRID_QUERY_LANGUAGE_ITEM): STRING is
			-- Image of current style used in search
		local
			l_list: LIST [EDITOR_TOKEN]
		do
			l_list := text (a_item)
			if l_list.is_empty then
				Result := ""
			else
				create Result.make (128)
				from
					l_list.start
				until
					l_list.after
				loop
					Result.append (l_list.item.image)
					l_list.forth
				end
			end
		end

	text (a_item: EB_GRID_QUERY_LANGUAGE_ITEM): LIST [EDITOR_TOKEN] is
			-- Text of current style for `a_item'
		do
			Result := editor_tokens_of_query_item_path (a_item.item, Void, True, False, False)
		end

feature -- Tooltip

	tooltip (a_item: EB_GRID_QUERY_LANGUAGE_ITEM): EB_EDITOR_TOKEN_TOOLTIP is
			-- Setup related parameters for tooltip display.
		do
		end

feature{NONE} -- Implementation

	setup_text (a_item: EB_GRID_QUERY_LANGUAGE_ITEM) is
			-- Setup text for `a_item'.
		do
			a_item.set_text_with_tokens (text (a_item))
		end

	setup_tooltip (a_item: EB_GRID_QUERY_LANGUAGE_ITEM) is
			-- Setup tooltip for `a_item'.
		do
			a_item.remove_general_tooltip
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

end
