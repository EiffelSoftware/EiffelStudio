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

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.7  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.2.9  2001/02/25 18:20:24  pichery
--| Renammed debug clause
--|
--| Revision 1.5.2.8  2000/10/24 15:27:25  pichery
--| Improved the cache system for caching GDI objects. It now
--| takes into account the date of the last access to the object.
--|
--| Revision 1.5.2.7  2000/10/16 14:27:35  pichery
--| Improved WEL_BRUSH and WEL_PEN caching
--|
--| Revision 1.5.2.6  2000/10/12 18:52:05  manus
--| Cosmetics
--|
--| Revision 1.5.2.5  2000/10/12 15:50:24  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.5.2.4  2000/09/13 00:15:25  manus
--| Improved debugging output to include number of items in cache.
--|
--| Revision 1.5.2.3  2000/08/11 19:12:43  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.5.2.2  2000/08/03 17:28:32  rogers
--| Removed FIXME NOT_REVIEWED. Added comments. Added copyright clause and
--| CVS log at end of file.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
