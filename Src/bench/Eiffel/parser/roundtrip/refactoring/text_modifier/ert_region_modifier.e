indexing
	description: "Region modifier for changing text of an AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_REGION_MODIFIER

feature{NONE} -- Initialization

	initialize (a_index: INTEGER; a_region: ERT_TOKEN_REGION) is
			-- Initialize `index' and `region'
		require
			a_index_non_negative: a_index > 0
			a_region_not_void: a_region /= Void
		do
			index := a_index
			create region.make (a_region.start_index, a_region.end_index)
		ensure
			index_set: index = a_index
			region_initialized: region /= Void and then region.is_equivalent (a_region)
		end

feature{LEAF_AS_LIST} -- Modify

	apply (a_list: LEAF_AS_LIST) is
			-- Apply current modifier.
		require
			a_list_not_void: a_list /= Void
			modifier_registered: a_list.is_modifier_registered (Current)
			modifier_not_applied: not applied
		deferred
		ensure
			modifier_applied: applied
		end

	reset_applied is
			-- Reset `applied' to False.
		do
			applied := False
		ensure
			applied_set: not applied
		end

	applied: BOOLEAN
			-- Has current modifier been applied?

feature -- Vadility

	can_prepend (other_region: like region): BOOLEAN is
			-- Can `other_region' be prepended by some text according to current modifier?
		require
			other_not_void: other_region /= Void
		deferred
		end

	can_append (other_region: like region): BOOLEAN is
			-- Can `other_region' be appended by some text according to current modifier?
		require
			other_not_void: other_region /= Void
		deferred
		end

	can_replace (other_region: like region): BOOLEAN is
			-- Can `other_region' be replaced by some text according to current modifier?
		require
			other_not_void: other_region /= Void
		deferred
		end

	can_remove (other_region: like region): BOOLEAN is
			-- Can `other_region' be removed according to current modifier?
		require
			other_not_void: other_region /= Void
		deferred
		end

	is_text_available (other_region: like region): BOOLEAN is
			-- Is text of `other_region' available according to current modifier?
		require
			a_region_not_void: other_region /= Void
		deferred
		end

feature -- Access

	start_index: INTEGER is
			-- Start index of current modifier
		do
			Result := region.start_index
		ensure
			result_set: Result = region.start_index
		end

	end_index: INTEGER is
			-- End index of current modifier
		do
			Result := region.end_index
		ensure
			result_set: Result = region.end_index
		end

	is_region_disjoint (other_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Is `other_region' disjoint from `region' of Current?
		require
			other_region_not_void: other_region /= Void
		do
			Result := region.is_disjoint_region (other_region)
		end

feature

	index: INTEGER
			-- Index of current modifier

	region: ERT_TOKEN_REGION
			-- Region on which current modifier applies

feature{NONE} -- Implementation

	deactivate_modifier (a_list: LEAF_AS_LIST) is
			-- Deactivate modifiers which apply on sub region of current modifier.
		do
			delete_active_modifier (a_list.active_modifier_list)
			delete_active_modifier (a_list.active_prepend_modifier_list)
			delete_active_modifier (a_list.active_append_modifier_list)
		end

	delete_active_modifier (a_list: LIST [ERT_REGION_MODIFIER]) is
			-- Delete active modifier whose operation region is sub region of current,
			-- because current's modification will override it.
		require
			a_list_not_void: a_list /= Void
		do
			from
				a_list.start
			until
				a_list.after
			loop
				if a_list.item.region.is_sub_region (region) then
					a_list.remove
				else
					a_list.forth
				end
			end
		end

invariant
	region_not_void: region /= Void
	index_non_negative: index > 0

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
