
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A

create
	make

feature

	make is
		do 
			value := 'B'
		end

feature

	value: CHARACTER

	is_value_required: BOOLEAN is
		do
			Result := value = 'D'
		end
	
	memory_collection: BOOLEAN is
		local
			mem: MEMORY
		do
			if value = 'C' then
				create mem
				mem.collect
			end
			Result := True
			value := (value.code + 1).to_character_8
		end
		
invariant
	memory: memory_collection
	
end
