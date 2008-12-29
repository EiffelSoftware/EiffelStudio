note
	description: "Gtk Implementation for EV_REGION"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_REGION_IMP

inherit
	EV_REGION_I

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (an_interface: EV_REGION)
			-- Creation method.
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize `Current'.
		do
			gdk_region := {EV_GTK_EXTERNALS}.gdk_region_new
			set_is_initialized (True)
		end

feature -- Element Change

	set_rectangle (a_rectangle: EV_RECTANGLE)
			-- Set region to area a_rectangle.
		local
			rectangle_struct: POINTER
		do
			rectangle_struct := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_x (rectangle_struct, a_rectangle.x)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_y (rectangle_struct, a_rectangle.y)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_width (rectangle_struct, a_rectangle.width)
			{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_rectangle_struct_height (rectangle_struct, a_rectangle.height)
			dispose
--			gdk_region := {EV_GTK_EXTERNALS}.gdk_region_rectangle (rectangle_struct)
			rectangle_struct.memory_free
		end

	offset (a_horizontal_offset, a_vertical_offset: INTEGER)
			-- Move `Current' a `a_horizontal_offset' horizontally and `a_vertical_offset' vertically.
		do
			{EV_GTK_EXTERNALS}.gdk_region_offset (gdk_region, a_horizontal_offset, a_vertical_offset)
		end

feature -- Access

	intersect (a_region: EV_REGION): EV_REGION
			-- Intersect `a_region' with `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			Result := interface.twin
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
--			{EV_GTK_EXTERNALS}.gdk_region_intersect (l_result_imp.gdk_region, l_region_imp.gdk_region)
		end

	union (a_region: EV_REGION): EV_REGION
			-- Create a union `a_region' with `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			Result := interface.twin
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
--			{EV_GTK_EXTERNALS}.gdk_region_union (l_result_imp.gdk_region, l_region_imp.gdk_region)
		end

	subtract (a_region: EV_REGION): EV_REGION
			-- Subtract `a_region' from `Current'.
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			Result := interface.twin
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
--			{EV_GTK_EXTERNALS}.gdk_region_subtract (l_result_imp.gdk_region, l_region_imp.gdk_region)
		end

	exclusive_or (a_region: EV_REGION): EV_REGION
			-- Exclusive or `a_region' with `Current'
		local
			l_result_imp, l_region_imp: EV_REGION_IMP
		do
			Result := interface.twin
			l_result_imp ?= Result.implementation
			l_region_imp ?= a_region.implementation
--			{EV_GTK_EXTERNALS}.gdk_region_xor (l_result_imp.gdk_region, l_region_imp.gdk_region)
		end

feature -- Duplication

	copy_region (other: EV_REGION)
			-- Update `Current' to be the same as `other'.
		local
			l_region_imp: EV_REGION_IMP
		do
			dispose
			l_region_imp ?= other.implementation
--			gdk_region := {EV_GTK_EXTERNALS}.gdk_region_copy (l_region_imp.gdk_region)
		end

feature {EV_DRAWABLE_IMP, EV_REGION_IMP} -- Access

	gdk_region: POINTER
		-- Pointer to the GdkRegion object.

feature {NONE} -- Implementation

	is_region_equal (other: EV_REGION): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		local
			l_region_imp: EV_REGION_IMP
		do
			if other /= Void then
				l_region_imp ?= other.implementation
				Result := {EV_GTK_EXTERNALS}.gdk_region_equal (gdk_region, l_region_imp.gdk_region)
			end
		end

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			dispose
			set_is_destroyed (True)
		end

	dispose
			-- Clean up `Current'.
		do
			if gdk_region /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_region_destroy (gdk_region)
				gdk_region := default_pointer
			end
		end

note
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
