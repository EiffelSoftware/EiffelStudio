indexing
	description: "Region modifier for remove text of AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_REMOVE_REGION_MODIFIER

inherit
	ERT_REGION_MODIFIER

create
	make

feature{NONE} -- Initialization

	make (a_index: INTEGER; a_region: ERT_TOKEN_REGION) is
			-- Initialize instance.
		require
			a_index_non_negative: a_index > 0
			a_region_not_void: a_region /= Void
		do
			initialize (a_index, a_region)
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
			from
				i := region.start_index
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
			Result := region.is_disjoint_region (other_region) or (region.is_sub_region (other_region) and not region.is_equivalent (other_region))
		end

	can_append (other_region: like region): BOOLEAN is
			-- Can `other_region' be appended by some text according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or (region.is_sub_region (other_region) and not region.is_equivalent (other_region))
		end

	can_replace (other_region: like region): BOOLEAN is
			-- Can `other_region' be replaced by some text according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or (region.is_sub_region (other_region) and not region.is_equivalent (other_region))
		end

	can_remove (other_region: like region): BOOLEAN is
			-- Can `other_region' be removed according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or (region.is_sub_region (other_region) and not region.is_equivalent (other_region))
		end

	is_text_available (other_region: ERT_TOKEN_REGION): BOOLEAN is
			-- Is text of `other_region' available according to current modifier?
		do
			Result := region.is_disjoint_region (other_region) or (region.is_sub_region (other_region) and not region.is_equivalent (other_region))
		end

end
