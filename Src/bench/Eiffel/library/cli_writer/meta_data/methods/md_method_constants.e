indexing
	description: "Constants used for creating a method body."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_CONSTANTS

feature -- Access

	tiny_format: INTEGER_8 is 0x02
	fat_format: INTEGER_8 is 0x03
			-- Type of method header.
			
	more_sections: INTEGER_8 is 0x08
	init_locals: INTEGER_8 is 0x10
			-- Flags on method header.
			
	section_ehtable: INTEGER_8 is 0x01
	section_fat_format: INTEGER_8 is 0x40
	section_more_sections: INTEGER_8 is 0x80
			-- Flags for method data section header.
			
	clause_exception: INTEGER_16 is 0x0000
			-- A typed exception clause.
	
	clause_filter: INTEGER_16 is 0x0001
			-- An exception filter and handler clause.
			
	clause_finally: INTEGER_16 is 0x0002
			-- A finally clause.
			
	clause_fault: INTEGER_16 is 0x0004
			-- A fault clause (finally that is called on exception
			-- only)
	
end -- class MD_METHOD_CONSTANTS
