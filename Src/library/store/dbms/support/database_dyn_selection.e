indexing
	description: "Implementation of DB_DYN_SELECTION"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DYN_SELECTION [G -> DATABASE]

inherit
	DATABASE_SELECTION [G]

creation

	make

feature

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		local
			parsed_s: STRING
			parsed: BOOLEAN
			i, j, k: INTEGER
		do
			sql_string := s
			if s.has(':') then
				from
					i := 0
					k := 1
				until
					i=s.count
				loop
					i := s.index_of (':', i)					
					j := s.index_of (',', i)
					if j=0 then
						j := s.count
					end
					parameters.put(s.substring (i+1, j-1), k)
					i := j
					k := k + 1
				end
			end
			descriptor := db_spec.new_descriptor
			if not db_spec.normal_parse then
				parsed := db_spec.parse (descriptor, ht, handle, s)	
			end
			if not parsed then
				parsed_s := parse (s)
				handle.status.set (db_spec.init_order (descriptor, parsed_s))
			end
		end

	bind_parameter is
			-- Bind of the prarameters of the sql statement 
		do
			db_spec.bind_parameter (parameters_value, parameters, descriptor, handle, sql_string)	
		end

	execute is
			-- Execute the sql statement
		do
			if is_ok then
				handle.status.set (db_spec.start_order (descriptor))
			end	
		end

	set_value (v: ANY) is
			-- Set the values of the parameters
		do
			last := last + 1
			parameters_value.force (v, last)
		end

	retrieve (table: ARRAY [ANY]) is
			-- Execute the sql statement with `table' as 
			-- the array of values for the parameters
		do
			parameters_value.copy (table)
			bind_parameter
			execute
		end

feature {NONE} -- Implementation

	parameters_value: ARRAY [ANY] is
			-- Values of the parameters of the sql statement
		once
			last := 0
			!! Result.make (1, 0)
		end
	
	parameters: ARRAY [ANY] is
			-- Parameters of the sql statement
		once
			!! Result.make (1, 0)
		end
		
	location_of_question_marks: LINKED_LIST [INTEGER]
			-- Location of the question marks

	last: INTEGER
			-- Last value added

	sql_string: STRING

end -- class DATABASE_DYN_SELECTION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
