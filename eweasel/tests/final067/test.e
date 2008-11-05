class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			f: FUNCTION [ANY, TUPLE, ANY]
		do
			f := agent : INTEGER do Result := -1 end
			io.put_string (f.item (Void).out)
			io.put_string (f.item ([]).out)
			io.put_new_line
		end

end
