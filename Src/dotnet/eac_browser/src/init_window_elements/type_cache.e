indexing
	description: "Last type printed in output"
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CACHE

--create
--	make
--	
--feature -- Initialization
--
--	make is
--			--
--		do
--		end

feature -- Access

	factory_display: DISPLAY_TYPE_FACTORY is 
			-- type currently displayed.
		do
			Result := internal_factory_display.item
		end

feature -- Status Setting
	
	set_factory_display (a_factory_display: DISPLAY_TYPE_FACTORY) is
			-- put `a_factory_display' in `internal_factory_display'.
		require
			non_void_a_factory_display: a_factory_display /= Void
		do
			internal_factory_display.put (a_factory_display)
		ensure
			factory_display_set: factory_display = a_factory_display
		end
		

feature {NONE} -- Initialization

	internal_factory_display: CELL [DISPLAY_TYPE_FACTORY] is
			-- Internal representation of `factory_display'.
		once
			create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		
invariant

end -- class TYPE_CACHE