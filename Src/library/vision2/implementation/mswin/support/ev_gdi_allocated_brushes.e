note
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
	EV_GDI_ALLOCATED_OBJECTS [EV_GDI_BRUSH, WEL_BRUSH]

	WEL_PS_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature -- Access

	get (a_pattern: detachable WEL_BITMAP; a_color: detachable WEL_COLOR_REF): WEL_BRUSH
			-- `Result' is WEL_BRUSH with `a_pattern' as pattern
			-- and `a_color' as color.
			--| If an identical brush exists in our system then we return that
			--| brush, otherwise we create a new brush and return that.
			--| This stops multiple instances of the same WEL_BRUSH being
			--| created.

		local
			l_search_object: EV_GDI_BRUSH
			l_color: detachable WEL_COLOR_REF
		do
			debug("VISION2_WINDOWS_GDI")
				io.put_string ("getting a brush...")
			end
			cache_time := cache_time + 1

				-- Update searcher object with the same hash values as the brush we want to retrieve.
			l_search_object := reusable_search_object
			l_search_object.set_values (a_pattern, a_color)

			if has_object (l_search_object) then
				Result := get_previously_allocated_object (found_object_index)
			else
					-- Brush is not found so we need to create a new one and add to the hash table.

					-- Twin search object as it already has the correct values set.
				l_search_object := l_search_object.twin
				if a_pattern /= Void then
					create Result.make_by_pattern(a_pattern)
				else
					l_color := a_color
					if l_color /= Void then
						create Result.make_solid(l_color)
					else
						check color_not_void: False then end
					end
				end
				Result.enable_reference_tracking
				l_search_object.set_item (Result)
				l_search_object.update (cache_time)

				add_to_allocated_objects (l_search_object)
			end
			debug("VISION2_WINDOWS_GDI")
				io.put_string ("Cache Stat: "
					+(100.0*successful_cache/cache_time).out+"%% %N")
			end
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

feature {NONE} -- Implementation

	reusable_search_object: EV_GDI_BRUSH
			-- Reusable brush object for hash table lookup.
		once
			create Result.make_with_values (Void, Void)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_GDI_ALLOCATED_BRUSHES












