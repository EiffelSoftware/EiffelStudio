indexing
	description: "Implmentation of DB_DYN_CHANGE"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DYN_CHANGE [G -> DATABASE create default_create end]

inherit
	DATABASE_CHANGE [G]
		rename
			put as normal_put
		redefine
			replacement_string
		end

creation
	make

feature

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
		local
			parsed_s: STRING
			parsed: BOOLEAN
			ArgNum, i, j, k: INTEGER
		do
			last := 1
			sql_string.wipe_out
			sql_string.append (s)

			s.wipe_out

			s.append (parse (sql_string))

			ArgNum := s.occurrences('?')

			descriptor := db_spec.new_descriptor
			if not db_spec.normal_parse then
				parsed := db_spec.parse (descriptor, ht, handle, s)	
			end
			if not parsed then
--				parsed_s := parse (s)
				parsed_s := s
				if is_ok then
					handle.status.set (db_spec.init_order (descriptor, parsed_s))
				end
				if is_ok then
					handle.status.set (db_spec.pre_immediate (descriptor, ArgNum))
				end

			end
		end

	bind_parameter is
			-- Bind of the prarameters of the sql statement 
		do
			db_spec.bind_parameter (parameters_value, parameters_value, descriptor, handle, "")	
		end

	execute is
			-- Execute the sql statement
		do
			if is_ok then
				handle.status.set (db_spec.unset_catalog_flag(descriptor))
			end
			if is_ok then
				handle.status.set (db_spec.start_order (descriptor))
			end
	
		end

	set_value (v: ANY) is
			-- Set the values of the parameters
		require
			value_exists: v /= Void
		do
			last := last + 1
			parameters_value.force (v, last)
		end

	put (table: ARRAY [ANY]) is
			-- Execute the sql statement with `table' as 
			-- the array of values for the parameters
		do
			parameters_value.copy (table)
			bind_parameter
			execute
		end


feature {NONE} -- Implementation

	sql_string: STRING is
		once
			!! Result.make (0)
		end

	parameters_value: ARRAY [ANY] is
			-- Values of the parameters of the sql statement
		once
			last := 1
			!! Result.make (1, 0)
		end
	
	replacement_string (key, destination: STRING) is
			-- Replace object associated with `key' by a '?' in `destination'.
			-- and, fill chronologically, the parameters_value array.
		local
			object: ANY
		do
			object := ht.item (key);
			if object /= void then
				destination.append ("?")
				parameters_value.force (object, last)
				last := last + 1
			else
				destination.append (null_string)
			end
		end;

	location_of_question_marks: LINKED_LIST [INTEGER]
			-- Location of the question marks

	last: INTEGER
			-- Last value added

	descriptor: INTEGER

end -- class DATABASE_DYN_CHANGE

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
