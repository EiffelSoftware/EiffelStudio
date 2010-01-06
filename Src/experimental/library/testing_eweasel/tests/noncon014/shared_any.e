class
	SHARED_ANY

feature

	any_once: ANY is
		require
			any_once_set: any_once_cell.item /= Void
		do
			Result := any_once_cell.item
		end

	any_once_cell: CELL [ANY] is
		once
			create Result.put (Void)
		end

end
