indexing
	description: "Object that represents a feature in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_FEATURE_ITEM

inherit
	EB_GRID_COMPILER_ITEM
		redefine
			style
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: like associated_feature; a_style: like style) is
			-- Initialize `associated_feature' with
		require
			a_feature_not_vid: a_feature /= Void
			a_style_attached: a_style /= Void
		do
			default_create
			associated_feature := a_feature
			set_spacing (3)
			enable_pixmap
			set_style (a_style)
		ensure
			associated_feature_set: associated_feature = a_feature
		end

feature -- Access

	associated_feature: QL_FEATURE
			-- Feature associated with current item.

feature{NONE} -- Pixmap

	item_pixmap: EV_PIXMAP is
			-- Pixmap associated to current compiler item
		do
			if associated_feature.is_real_feature then
				Result := pixmap_from_e_feature (associated_feature.e_feature)
			end
		end

	internal_replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		do
		end

feature -- Style type

	style: EB_GRID_FEATURE_ITEM_STYLE
			-- Style of current item

invariant
	associated_feature_not_void: associated_feature /= Void

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


end -- class EB_GRID_FEATURE_ITEM


