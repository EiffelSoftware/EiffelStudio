indexing
	description: "Region modifier for prepending text to AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PREPEND_REGION_MODIFIER

inherit
	ERT_ADDITION_REGION_MODIFIER

	COMPARABLE

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

feature -- Status reporting

	is_prepended_to (a_index: INTEGER): BOOLEAN is
			-- Dose current modifier prepend to `a_index'?
		do
			Result := start_index = a_index
		end

	is_appended_to (a_index: INTEGER): BOOLEAN is
			-- Dose current modifier append to `a_index'?
		do
			Result := False
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			check
				not region.is_overlap_region (other.region)
			end

			if region.is_equivalent (other.region) then
				Result := index > other.index
			else
				Result := region.start_index < other.region.end_index
			end
		end

feature{LEAF_AS_LIST} -- Modify

	apply (a_list: LEAF_AS_LIST) is
			-- Apply current modifier.
		do
			a_list.active_modifier_list.extend (Current)
			a_list.active_prepend_modifier_list.extend (Current)
			applied := True
		end

end
