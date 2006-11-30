
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature -- Initialization

	make is
		local
			file : RAW_FILE
			manu: MANU [STRING]
			$LOCAL
		do
			create manu.make ("Fdsfds", 123)
			create file.make_open_write ("stored")
			file.independent_store (manu)
			file.close
			
			create file.make_open_read ("stored")
			manu := Void
			manu ?= file.retrieved
			file.close
		end 
		
end
