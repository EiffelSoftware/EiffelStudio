indexing
	description: "This class represents a Windows accelerator."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ACCELERATOR

inherit
	WEL_STRUCTURE
		rename
			make as structure_make,
			initialize as structure_initialize
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_key, a_command_id, a_flags: INTEGER) is
			-- Create a definition of an accelerator.
			-- See class WEL_ACCELERATOR_FLAG_CONSTANTS
			-- for `a_flags' values.
		require
			valid_command_id: a_command_id >= 0
		do
			structure_make
			set_key (a_key)
			set_command_id (a_command_id)
			set_flags (a_flags)
		ensure
			key_set: key = a_key
			command_id_set: command_id = a_command_id
			flags_set: flags = a_flags
		end

feature -- Access

	key: INTEGER is
			-- Key of accelerator
		do
			Result := cwel_accel_get_key (item)
		end

	flags: INTEGER is
			-- Flags of accelerator
		do
			Result := cwel_accel_get_fvirt (item)
		end

	command_id: INTEGER is
			-- Command id of accelerator
		do
			Result := cwel_accel_get_cmd (item)
		end

feature -- Element change

	set_key (a_key: INTEGER) is
			-- Set `key' to `a_key'.
		do
			cwel_accel_set_key (item, a_key)
		ensure
			key_set: key = a_key
		end

	set_flags (a_flags: INTEGER) is
			-- Set `flags' to `a_flags'.
		do
			cwel_accel_set_fvirt (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end			

	set_command_id (a_command_id: INTEGER) is
			-- Set `command_id' to `a_command_id'.
		require
			valid_command_id: a_command_id >= 0
		do
			cwel_accel_set_cmd (item, a_command_id)
		ensure
			command_id_set: command_id = a_command_id
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_accel
		end

feature {NONE} -- Externals

	c_size_of_accel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"sizeof (ACCEL)"
		end

	cwel_accel_set_fvirt (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <accel.h>]"
		end

	cwel_accel_set_key (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <accel.h>]"
		end

	cwel_accel_set_cmd (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <accel.h>]"
		end

	cwel_accel_get_fvirt (ptr: POINTER): INTEGER is
		external
			"C [macro <accel.h>]"
		end

	cwel_accel_get_key (ptr: POINTER): INTEGER is
		external
			"C [macro <accel.h>]"
		end

	cwel_accel_get_cmd (ptr: POINTER): INTEGER is
		external
			"C [macro <accel.h>]"
		end

invariant
	valid_command_id: command_id >= 0

end -- class WEL_ACCELERATOR


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

