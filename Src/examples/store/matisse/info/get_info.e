class GET_INFO

inherit

	MATISSE_CONST

Creation
 
    make

feature {NONE} -- Initialization

	make is
		-- Prints various information
	local
		one_class : MT_CLASS
		one_object : MT_OBJECT
		appl : MATISSE_APPL
		session : DB_CONTROL
		info : MT_INFO
	do
		create appl.login("TOKYO","testdb",0,0)
		appl.set_mode(OPENED_TRANSACTION,0)
		appl.set_base

		create session.make
		session.connect

		create one_class.make("Employee")
		one_object := one_class.new_instance

		create info
		io.putstring("Max buffered objects = ") io.putint(info.max_buffered_objects) io.new_line
		
		io.putstring("Max Index Criteria Number = ") io.putint(info.max_index_criteria_number) io.new_line        
		
		io.putstring("Max Index Key Length = ") io.putint(info.max_index_key_length) io.new_line

		io.putstring("Total read bytes = ")  io.putint(info.total_read_bytes) io.new_line

		io.putstring("Total read bytes = ")  io.putint(info.total_read_bytes) io.new_line

		session.disconnect

	end -- make

end -- class GET_INFO


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

