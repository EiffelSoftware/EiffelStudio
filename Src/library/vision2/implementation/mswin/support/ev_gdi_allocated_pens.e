indexing
	description: 
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated."
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_PENS

inherit
	EV_GDI_ALLOCATED_OBJECTS [EV_GDI_PEN]

	WEL_PS_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

creation
	default_create

feature -- Access

	get (a_dashed_mode: INTEGER; a_width: INTEGER;
			a_color: WEL_COLOR_REF): WEL_PEN is
			-- `Result' is WEL_PEN with `a_dashed_mode' as mode, `a_width' as
			-- width, and `a_color' as color.
			--| If an identical pen exists in our system then we return that
			--| pen, otherwise we create a new pen and return that.
			--| This stops multiple instances of the same WEL_PEN being
			--| created.
		local
			fake_object: EV_GDI_PEN
		do
			debug("VISION2_WINDOWS_GDI")
				io.putstring("getting a pen...")
			end
			cache_time := cache_time + 1

				-- Create a fake pen with the same hash code as the one we
				-- want to retrieve.
			create fake_object.make_with_values (a_dashed_mode, a_width, a_color)

			if has_object (fake_object) then
				Result ?= get_previously_allocated_object (found_object_index)
			else
					-- New pen, not already in our table. So we create it...
				create Result.make(a_dashed_mode, a_width, a_color)
				Result.enable_reference_tracking
				fake_object.set_item (Result)
				fake_object.update (cache_time)

				add_to_allocated_objects (fake_object)
			end
			debug("VISION2_WINDOWS_GDI")
				io.putstring(" / Cache Stat: "
					+(100.0*successful_cache/cache_time).out+"%% %N")
			end
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

end -- class EV_GDI_ALLOCATED_PENS

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

