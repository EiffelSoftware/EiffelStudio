--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		" EiffelVision utility used to retrieve an allocated WEL item. %
		% This class has been created in order to decrease the number of %
		% GDI object allocated "
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

class
	EV_GDI_ALLOCATED_PENS

inherit
	EV_GDI_ALLOCATED_OBJECTS[EV_GDI_PEN]

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
		local
			fake_object: EV_GDI_PEN
		do
			debug("GDIObjectsCreation")
				io.putstring("getting a pen...")
				total_cache := total_cache + 1
			end

				-- Create a fake pen with the same hash code as the one we
				-- want to retrieve.
			create fake_object.make_with_values(a_dashed_mode, a_width, a_color)

			if allocated_objects.has(fake_object) then
					-- Requested pen has been already allocated. We return the
					-- item found in our table.
				Result := allocated_objects.item(fake_object).item
				debug("GDIObjectsCreation")
					successful_cache := successful_cache + 1
					io.putstring("retrieved cached version %
						%("+successful_cache.out+"/"+total_cache.out+")%N")
				end
			else
					-- New pen, not already in our table. So we create it...
				create Result.make(a_dashed_mode, a_width, a_color)

					-- ..and we add it in our table.
				fake_object.set_item(Result)
				allocated_objects.extend(fake_object, fake_object)
				debug("GDIObjectsCreation")
					io.putstring("created %
						%("+successful_cache.out+"/"+total_cache.out+")%N")
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class EV_GDI_ALLOCATED_PENS
