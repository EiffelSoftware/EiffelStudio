note
	description:
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_PENS

inherit
	EV_GDI_ALLOCATED_OBJECTS [EV_GDI_PEN, WEL_PEN]

	WEL_PS_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature -- Access

	get (a_style: INTEGER; a_width: INTEGER; a_brush: WEL_LOG_BRUSH): WEL_PEN
			-- `Result' is WEL_PEN with `a_dashed_mode' as mode, `a_width' as
			-- width, and `a_brush' as brush.
			--| If an identical pen exists in our system then we return that
			--| pen, otherwise we create a new pen and return that.
			--| This stops multiple instances of the same WEL_PEN being
			--| created.
		local
			l_search_object: EV_GDI_PEN
		do
			debug("VISION2_WINDOWS_GDI")
				io.put_string ("getting a pen...")
			end
			cache_time := cache_time + 1

				-- Set reusable search object with the same hash values as the pen we wish to receive.
			l_search_object := reusable_search_object
			l_search_object.set_values (a_style, a_width, a_brush)

			if has_object (l_search_object) then
				Result := get_previously_allocated_object (found_object_index)
			else
					-- New pen, not already in our table. So we create it...
				create Result.make_from_brush (a_style, a_width, a_brush)
				Result.enable_reference_tracking
					-- Twin search object as it already has the correct values set.
				l_search_object := l_search_object.twin
				l_search_object.set_item (Result)
				l_search_object.update (cache_time)

					-- Add container object to hash table.
				add_to_allocated_objects (l_search_object)
			end
			debug("VISION2_WINDOWS_GDI")
				io.put_string (" / Cache Stat: "
					+(100.0*successful_cache/cache_time).out+"%% %N")
			end
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

feature {NONE} -- Implementation

	reusable_search_object: EV_GDI_PEN
			-- Reusable pen object for hash table lookup
		local
			l_color_ref: WEL_COLOR_REF
			l_log_brush: WEL_LOG_BRUSH
		once
			create l_color_ref.make
			create l_log_brush.make (0, l_color_ref, 0)
			create Result.make_with_values (0, 1, l_log_brush)
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




end -- class EV_GDI_ALLOCATED_PENS












