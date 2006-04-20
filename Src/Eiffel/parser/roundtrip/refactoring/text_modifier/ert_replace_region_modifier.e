indexing
	description: "Region modifier for replace text of AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_REPLACE_REGION_MODIFIER

inherit
	ERT_REGION_MODIFIER

create
	make

feature{NONE} -- Initialization

	make (a_index: INTEGER; a_region: ERT_TOKEN_REGION; a_text: STRING) is
			-- Initialize instance.
		require
			a_region_not_void: a_region /= Void
			a_text_not_void: a_text /= Void
		do
			initialize (a_index, a_region)
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

feature{LEAF_AS_LIST} -- Modify

	apply (a_list: LEAF_AS_LIST) is
			-- Apply current modifier.
		local
			i: INTEGER
			l_end: INTEGER
		do
			deactivate_modifier (a_list)
			a_list.active_modifier_list.extend (Current)
			a_list.set_token_text (region.start_index, text)
			from
				i := region.start_index + 1
				l_end := region.end_index
			until
				i > l_end
			loop
				a_list.set_token_text (i, once "")
				i := i + 1
			end
			applied := True
		end


feature -- Vadility

	can_prepend (other_region: like region): BOOLEAN is
			-- Can `other_region' be prepended by some text according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or region.is_sub_region (other_region)
		end

	can_append (other_region: like region): BOOLEAN is
			-- Can `other_region' be appended by some text according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or region.is_sub_region (other_region)
		end

	can_replace (other_region: like region): BOOLEAN is
			-- Can `other_region' be replaced by some text according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or region.is_sub_region (other_region)
		end

	can_remove (other_region: like region): BOOLEAN is
			-- Can `other_region' be removed according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or region.is_sub_region (other_region)
		end

	is_text_available (other_region: like region): BOOLEAN is
			-- Is text of `other_region' available according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or region.is_sub_region (other_region)
		end

feature

	text: STRING
			-- Text to be prepended/appended

invariant

	text_not_void: text /= Void

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
