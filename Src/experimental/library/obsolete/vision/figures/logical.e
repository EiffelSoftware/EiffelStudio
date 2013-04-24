note

	description: "Logical functions"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	LOGICAL 

feature -- Element change 

	set_and_inverted_mode
			-- Set drawing logical function to
			-- (NOT source) AND destination.
		do
			logical_function_mode := GXandInverted;
		end;

	set_and_mode
			-- Set drawing logical function to
			-- source AND destination
		do
			logical_function_mode := GXand;
		end;

	set_and_reverse_mode
			-- Set drawing logical function to
			-- source AND (NOT destination)
		do
			logical_function_mode := GXandReverse;
		end;

	set_clear_mode
			-- Set drawing logical function to
			-- 0.
		do
			logical_function_mode := GXclear;
		end;

	set_copy_inverted_mode
			-- Set drawing logical function to
			-- (NOT source).
		do
			logical_function_mode := GXcopyInverted;
		end;

	set_copy_mode
			-- Set drawing logical function to
			-- source.
		do
			logical_function_mode := GXcopy;
		end;

	set_equiv_mode
			-- Set drawing logical function to
			-- (NOT source) XOR destination.
		do
			logical_function_mode := GXequiv;
		end;

	set_invert_mode
			-- Set drawing logical function to
			-- (NOT destination).
		do
			logical_function_mode := GXinvert;
		end;

	set_nand_mode
			-- Set drawing logical function to
			-- (NOT source) OR (NOT destination).
		do
			logical_function_mode := GXnand;
		end;

	set_no_op_mode
			-- Set drawing logical function to
			-- destination.
		do
			logical_function_mode := GXnoop;
		end;

	set_nor_mode
			-- Set drawing logical function to
			-- (NOT source) AND (NOT destination).
		do
			logical_function_mode := GXnor;
		end;

	set_one_mode
			-- Set drawing logical function to
			-- 1.
		do
			logical_function_mode := GXset;
		end;

	set_or_inverted_mode
			-- Set drawing logical function to
			-- (NOT source) OR destination.
		do
			logical_function_mode := GXorInverted;
		end;

	set_or_mode
			-- Set drawing logical function to
			-- source OR destination.
		do
			logical_function_mode := GXor;
		end;

	set_or_reverse_mode
			-- Set drawing logical function to
			-- source OR (NOT destination).
		do
			logical_function_mode := GXorReverse;
		end;

	set_xor_mode
			-- Set drawing logical function to
			-- source XOR destination.
		do
			logical_function_mode := GXxor;
		end;

feature {NONE} -- Access

	GXand: INTEGER = 1;
			-- X code to define logical function
			-- source AND destination for drawing

	GXandInverted: INTEGER = 4;
			-- X code to define logical function
			-- (NOTsource) AND destination for drawing

	GXandReverse: INTEGER = 2;
			-- X code to define logical function
			-- source AND (NOTdestination) for drawing

	GXclear: INTEGER = 0;
			-- X code to clear drawing

	GXcopy: INTEGER = 3;
			-- X code to define logical function
			-- source  for drawing

	GXcopyInverted: INTEGER = 12;
			-- X code to define logical function
			-- (NOTsource) for drawing

	GXequiv: INTEGER = 9;
			-- X code to define logical function
			-- (NOTsource) XOR destination for drawing

	GXinvert: INTEGER = 10;
			-- X code to define logical function
			-- (NOTdestination) for drawing

	GXnand: INTEGER = 14;
			-- X code to define logical function
			-- (NOTsource OR NOTdestination) for drawing

	GXnoop: INTEGER = 5;
			-- X code to define logical function
			-- destination for drawing

	GXnor: INTEGER = 8;
			-- X code to define logical function
			-- (NOTsource) AND (NOTdestination) for drawing

	GXor: INTEGER = 7;
			-- X code to define logical function
			-- source OR destination for drawing

	GXorInverted: INTEGER = 13;
			-- X code to define logical function
			-- (NOTsource) OR destination for drawing

	GXorReverse: INTEGER = 11;
			-- X code to define logical function
			-- source OR NOT (destination) for drawing

	GXset: INTEGER = 15;
			-- X code to define logical function
			-- to set drawing

	GXxor: INTEGER = 6;
			-- X code to define logical function
			-- source XOR destination for drawing

	logical_function_mode: INTEGER;;
			-- Logical function to be used in Graphic Context.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class LOGICAL

