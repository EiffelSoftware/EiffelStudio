indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_REGION_IMP

inherit
	EV_REGION_I
		undefine
			is_equal
		end

	WEL_REGION

create
	make

feature {NONE} -- Initialization

	make (an_interface: EV_REGION)
			-- Creation method.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			make_empty
			set_is_initialized (True)
		end

feature -- Element Change

	set_rectangle (a_rectangle: EV_RECTANGLE)
			-- Set region to use area `a_rectangle'.
		do
			set_rect (a_rectangle.left, a_rectangle.top, a_rectangle.right, a_rectangle.bottom)
		end

	intersect (a_region: EV_REGION): EV_REGION
			-- Intersect `a_region' with `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			create Result
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
			cwin_combine_rgn (l_result_imp.item, item, l_region_imp.item, {WEL_RGN_CONSTANTS}.rgn_and)
		end

	union (a_region: EV_REGION): EV_REGION
			-- Create a union `a_region' with `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			create Result
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
			cwin_combine_rgn (l_result_imp.item, item, l_region_imp.item, {WEL_RGN_CONSTANTS}.rgn_or)
		end

	subtract (a_region: EV_REGION): EV_REGION
			-- Subtract `a_region' from `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			create Result
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
			cwin_combine_rgn (l_result_imp.item, item, l_region_imp.item, {WEL_RGN_CONSTANTS}.rgn_diff)
		end

	exclusive_or (a_region: EV_REGION): EV_REGION
			-- Exclusive or `a_region' with `Current'
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			create Result
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
			cwin_combine_rgn (l_result_imp.item, item, l_region_imp.item, {WEL_RGN_CONSTANTS}.rgn_xor)
		end

feature -- Duplication

	copy_region (a_region: EV_REGION)
			-- Copy region `a_region' into `Current'.
		local
			l_region_imp: EV_REGION_IMP
		do
			l_region_imp ?= a_region.implementation
			cwin_combine_rgn (item, l_region_imp.item, default_pointer, {WEL_RGN_CONSTANTS}.rgn_xor)
		end

feature {NONE} -- Implementation

	is_region_equal (other: EV_REGION): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		local
			l_region_imp: EV_REGION_IMP
		do
			if other /= Void then
				l_region_imp ?= other.implementation
				Result := is_equal (l_region_imp)
			end
		end

	destroy is
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
