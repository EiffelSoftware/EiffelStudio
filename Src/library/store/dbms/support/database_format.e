indexing
	description: "Implementation of DB_FORMAT";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_FORMAT [G -> DATABASE create default_create end]

inherit

	HANDLE_SPEC [G]

feature -- Conversion

	boolean_format (object: BOOLEAN): STRING is
			-- String representation in SQL of `object'
		do
			if object.item then
				Result := db_spec.True_representation
			else
				Result := db_spec.False_representation
			end		
		end

	date_format (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		local
			d_str: STRING
		do
			create d_str.make(20) 
			d_str := db_spec.date_to_str (object)
			date_buffer.wipe_out
			date_buffer.append (d_str)
			Result := date_buffer
		ensure then
			Result = date_buffer
		end
	
	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'
		do
			Result := db_spec.string_format (object)
		end

feature {NONE} -- Status report

	date_buffer: STRING is
			-- String constant
		once
			create Result.make (20)
		end

end -- class DATABASE_FORMAT

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
