indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_MO_FILE_TEST

create
	make

feature	-- creation
    make(m:I18N_MO_FILE) is
    		-- initialize `mo_file' with `m'
    		-- and open `mo_file'
    	do
    		mo_file := m
    		m.open
		end

feature -- access test

	valid_index_test is
			-- test valid_index feature in class `I18N_MO_FILE'
		local
			i:INTEGER
		do
			if mo_file.opened then
				from
					i:=1
				until
					i>100
				loop
					if mo_file.valid_index (20) then
						io.put_string ("index"+i.out+"is valid")
					else
						io.put_string ("index"+i.out+"is not valid")
					end
				end
			else
				io.put_string ("NOT OPENED!!")
			end
		end

feature -- access

	mo_file: I18N_MO_FILE

end
