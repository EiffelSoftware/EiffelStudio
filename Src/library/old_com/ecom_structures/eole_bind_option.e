indexing

	description: "Result structure of EOLE_TYPE_COMP.bind"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_BIND_OPTIONS
	
inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
	EOLE_STGM
	
	EOLE_BIND_OPTIONS_FLAGS
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure.
			-- To be redefined by descendant if needed.
		do
			ole2_bind_options_allocate
		end
		
	set_flags (flg: INTEGER)
			-- Set `flags' with `flg'.
			-- See class EOLE_BIND_OPTIONS_FLAGS for `flg' value.
		require
			valid_structure: ole_ptr /= default_pointer
			valid_flag: is_valid_bind_options_flag (flg)
		is
			ole2_bind_options_set_flag (ole_ptr, flg)
		end
		
	set_mode (m: INTEGER): INTEGER
			-- Set `mode' with `m'.
			-- See class EOLE_STGM for possible values for `m'.
		require
			valid_structure: ole_ptr /= default_pointer
			valid_mode: is_valid_stgm (m)
		is
			ole2_bind_options_set_mode (ole_ptr, m)
		end
	
	set_tick_count_deadline (count: INTEGER)
			-- set `tick_count_deadline' with `count'.
		require
			valid_structure: ole_ptr /= default_pointer
		is
			ole2_bind_options_set_tick_count_deadline (ole_ptr, count)
		end

feature -- Access

	flags: INTEGER is
			-- See class EOLE_BIND_OPTIONS_FLAGS for
			-- possible values and explanations.
		require
			valid_structure: ole_ptr /= default_pointer
		do
			Result := ole2_bind_options_flags (ole_ptr)
		end
	
	mode: INTEGER is
			-- Caller's intended use for object received
			-- from associated moniker binding operation.
			-- See class EOLE_STGM for possible values.
		require
			valid_structure: ole_ptr /= default_pointer
		do
			Result := ole2_bind_options_mode (ole_ptr)
		end
	
	tick_count_deadline: INTEGER is
			-- Value in milliseconds on local clock that
			-- indicates when caller wants the operation 
			-- to be completed.
		require
			valid_structure: ole_ptr /= default_pointer
		do
			Result := ole2_bind_options_tick_count_deadline (ole_ptr)
		end
		
feature {NONE} -- Externals

	ole2_bind_options_allocate: POINTER is
		external
			"C"
		alias
			"eole2_bind_options_allocate"
		end
		
	ole2_bind_options_set_flag (ptr: POINTER; flg: INTEGER) is
		external
			"C"
		alias
			"eole2_bind_options_set_flag"
		end

	ole2_bind_options_set_mode (ptr: POINTER; m: INTEGER) is
		external
			"C"
		alias
			"eole2_bind_options_set_mode"
		end
		
	ole2_bind_options_set_tick_count_deadline (ptr: POINTER; count: INTEGER)
		external
			"C"
		alias
			"eole2_bind_options_set_tick_count_deadline"
		end
		
	ole2_bind_options_flags (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_bind_options_flags"
		end
		
	ole2_bind_options_mode (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_bind_options_mode"
		end
		
	ole2_bind_options_tick_count_deadline (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_bind_options_tick_count_deadline"
		end
		
end -- class EOLE_BIND_OPTIONS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

