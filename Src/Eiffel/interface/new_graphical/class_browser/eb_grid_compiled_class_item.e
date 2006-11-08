indexing
	description: "Object that represents a compiled class in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_COMPILED_CLASS_ITEM

inherit
	EB_GRID_CLASS_ITEM
		redefine
			style
		end

create
	make

feature{NONE} -- Initialization

	make (a_class: like associated_class; a_style: like style) is
			-- Initialize `associated_class' with `a_class'.
			-- Display `associated_class' with `a_style'.
		require
			a_class_not_void: a_class /= Void
			a_style_attached: a_style /= Void
		do
			default_create
			associated_class := a_class
			set_spacing (layout_constants.Tiny_padding_size)
			set_style (a_style)
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Access

	associated_class_i: CLASS_I is
			-- CLASS_I associated with current item
		do
			Result := associated_class.original_class
		end

	associated_class: CLASS_C
			-- Compiled class associated with current item

	style: EB_GRID_CLASS_ITEM_STYLE
			-- Style of current item

invariant
	associated_class_not_void: associated_class /= Void
	style_attached: style /= Void

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
