indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class GET_INFO

inherit

	MATISSE_CONST

create
 
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GET_INFO


