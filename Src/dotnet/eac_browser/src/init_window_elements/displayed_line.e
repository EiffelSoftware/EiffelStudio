indexing
	description: "Print in lines the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAYED_LINE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialiaze `entities'.
		do
			create entities.make
		ensure
			non_void_entities: entities /= Void
		end

feature -- Access

	entities: LINKED_LIST [ENTITY_LINE]
			-- entities contained in line.

	selected: BOOLEAN
			-- Is line selected?

feature -- Status Setting

	set_selected (a_bool: BOOLEAN) is
			-- set `selected' wit `a_bool'.
		do
			selected := a_bool
		ensure
			selected_set: selected = a_bool
		end
		

feature -- Basic Operation

	clear is
			-- wipe out `entities'.
		do
			entities.wipe_out
		ensure
			entities_empty: entities.count = 0
		end

	number_characters: INTEGER is
			-- number of characters of line.
		local
			initial_cursor: CURSOR
		do
			initial_cursor := entities.cursor
			from
				entities.start
			until
				entities.after
			loop
				Result := Result + entities.item.image.count
				entities.forth
			end
			entities.go_to (initial_cursor)
		end
		
	number_pixels: INTEGER is
			-- number of pixels of line.
		local
			initial_cursor: CURSOR
		do
			initial_cursor := entities.cursor
			from
				entities.start
			until
				entities.after
			loop
				Result := Result + entities.item.font.string_width (entities.item.image)
				entities.forth
			end
			entities.go_to (initial_cursor)
		end
		
	
invariant
	non_void_entities: entities /= Void

end -- class DISPLAYED_LINE

