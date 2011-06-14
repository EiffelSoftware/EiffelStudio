
class TEST

create
	make

feature

	make
		do
			if is_empty then
			       print ("Weasel%N")
			end
		end

	is_empty: BOOLEAN
	      do
			Result := cell.item = Void
	      end

	cell: CELL [STRING]
		once ("PROCESS")
		     create Result.put (Void)
		end
end
