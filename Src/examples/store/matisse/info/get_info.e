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
		!!appl.login("TOKYO","testdb",0,0)
		appl.set_mode(OPENED_TRANSACTION,0)
		appl.set_base

		!!session.make
		session.connect

		!!one_class.make("Employee")
		one_object := one_class.new_instance

		!!info
		io.putstring("Max buffered objects = ") io.putint(info.max_buffered_objects) io.new_line
		
		io.putstring("Max Index Criteria Number = ") io.putint(info.max_index_criteria_number) io.new_line        
		
		io.putstring("Max Index Key Length = ") io.putint(info.max_index_key_length) io.new_line

		io.putstring("Total read bytes = ")  io.putint(info.total_read_bytes) io.new_line

		io.putstring("Total read bytes = ")  io.putint(info.total_read_bytes) io.new_line

		session.disconnect

	end -- make

end -- class GET_INFO

