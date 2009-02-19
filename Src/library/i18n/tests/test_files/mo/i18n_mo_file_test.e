note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_MO_FILE_TEST

create
	make

feature	-- creation
    make(m:I18N_MO_FILE)
    		-- initialize `mo_file' with `m'
    		-- and open `mo_file'
    	do
    		mo_file := m
    		m.open
		end

feature -- access test

	valid_index_test
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

	mo_file: I18N_MO_FILE;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
