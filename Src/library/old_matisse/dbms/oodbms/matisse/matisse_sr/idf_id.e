class IDF_ID 

feature -- Access

	id_cell : CELL[INTEGER] is
		-- Internal use
		once
			!!Result.put(0)
		end -- id_cell

end -- class IDF_ID
