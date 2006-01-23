indexing
	description: 
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_BRUSHES

inherit
	EV_GDI_ALLOCATED_OBJECTS [EV_GDI_BRUSH]

	WEL_PS_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature -- Access

	get (a_pattern: WEL_BITMAP; a_color: WEL_COLOR_REF): WEL_BRUSH is
			-- `Result' is WEL_BRUSH with `a_pattern' as pattern
			-- and `a_color' as color.
			--| If an identical brush exists in our system then we return that
			--| brush, otherwise we create a new brush and return that.
			--| This stops multiple instances of the same WEL_BRUSH being
			--| created.

		local
			fake_object: EV_GDI_BRUSH
		do
			debug("VISION2_WINDOWS_GDI")
				io.put_string ("getting a brush...")
			end
			cache_time := cache_time + 1

				-- Create a fake brush with the same hash code as the one we
				-- want to retrieve.
			create fake_object.make_with_values(a_pattern, a_color)

			if has_object (fake_object) then
				Result ?= get_previously_allocated_object (found_object_index)
			else
					-- New object, not already in our table. So we create it...
				if a_pattern /= Void then
					create Result.make_by_pattern(a_pattern)
				else
					create Result.make_solid(a_color)
				end
				Result.enable_reference_tracking
				fake_object.set_item (Result)
				fake_object.update (cache_time)

				add_to_allocated_objects (fake_object)
			end
			debug("VISION2_WINDOWS_GDI")
				io.put_string ("Cache Stat: "
					+(100.0*successful_cache/cache_time).out+"%% %N")
			end
		ensure
			Result_exists: Result /= Void and then Result.exists
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




end -- class EV_GDI_ALLOCATED_BRUSHES

