indexing

    Product: EiffelStore
    Database: Matisse

class STRING_MAT inherit 

	STRING

creation -- Creation procedure

	make

feature -- Element change

	mat_get_select_name (index: INTEGER; no_descriptor: INTEGER) is
            -- Do nothing
		do
		ensure
			not_change_capacity: capacity = old capacity
			not_change_area: area = old area
		end -- mat_get_select_name

	mat_get_value (index: INTEGER; no_descriptor: INTEGER) is
 		-- Do nothing
		do
		ensure
			not_change_capacity: capacity = old capacity
			not_change_area: area = old area
		end -- mat_get_value

end -- class STRING_MAT
