note
	description: "[
			Using SED facilities, {CP_SED_CONTAINER} allows to import a copy of 
			an object from separate processor into current scoop processor.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_SED_CONTAINER [G]

inherit
	CELL [detachable G]
		redefine
			default_create
		end

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		redefine
			default_create
		end

create
	default_create,
	put,
	import

feature {NONE} -- Initialization

	default_create
		local
			g: detachable G
		do
			put (g)
		end

feature -- Element change

	import (obj: separate CP_SED_CONTAINER [G])
			-- Import separate container data into current container.
		local
			sp: separate MANAGED_POINTER
			p: MANAGED_POINTER
			buf: SED_MEMORY_READER_WRITER
		do
			sp := obj.sed_data
			separate sp as l_data do
				create p.make_from_pointer (l_data.item, l_data.count)
				create buf.make_with_buffer (p)
				buf.set_for_reading
				if attached {G} retrieved (buf, True) as g then
					put (g)
				end
			end
		end

feature {CP_SED_CONTAINER} -- Conversion		

	sed_data: MANAGED_POINTER
			-- SED-serialized `ìtem`.
		local
			buf: SED_MEMORY_READER_WRITER
		do
			create buf.make
			if attached {ANY} item as l_item then
				buf.set_for_writing
				basic_store (l_item, buf, True)
			end
			Result := buf.data
		end

end
