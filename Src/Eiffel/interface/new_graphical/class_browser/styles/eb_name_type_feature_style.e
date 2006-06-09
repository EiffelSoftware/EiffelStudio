indexing
	description: "Objects that represent the feature style that only show full name and type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_TYPE_FEATURE_STYLE

inherit
	EB_GRID_FEATURE_ITEM_STYLE

feature -- Tooltip

	tooltip (a_item: EB_GRID_FEATURE_ITEM): EB_EDITOR_TOKEN_TOOLTIP is
			-- Setup related parameters for tooltip display.
		local
			l_tooltip: EB_FEATURE_COMMENT_TOOLTIP
		do
			if a_item.associated_feature.is_real_feature then
				create l_tooltip.make (a_item.associated_feature.e_feature, a_item.pointer_enter_actions, a_item.pointer_leave_actions, agent a_item.is_destroyed)
				initialize_tooltip (l_tooltip)
				Result := l_tooltip
			end
		end

feature -- Access

	text (a_item: EB_GRID_FEATURE_ITEM): LIST [EDITOR_TOKEN] is
			-- Text of current style for `a_item'
		do
			token_writer.new_line
			if a_item.associated_feature.is_real_feature then
				if is_overload_name_used and then a_item.overload_name /= Void then
					token_writer.process_feature_text (a_item.overload_name, a_item.associated_feature.e_feature, False)
				else
					a_item.associated_feature.e_feature.append_full_name (token_writer)
				end
				a_item.associated_feature.e_feature.append_just_type (token_writer)
			else
				token_writer.add (a_item.associated_feature.name)
			end
			Result := token_writer.last_line.content
		end

feature{NONE} -- Implementation

	setup_tooltip (a_item: EB_GRID_FEATURE_ITEM) is
			-- Setup tooltip for `a_item'.
		local
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
		do
			if a_item.general_tooltip /= Void then
				a_item.remove_general_tooltip
			end
			l_tooltip := tooltip (a_item)
			if l_tooltip /= Void then
				a_item.set_general_tooltip (l_tooltip)
				a_item.general_tooltip.veto_tooltip_display_functions.extend (agent a_item.should_tooltip_be_displayed)
			end
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
