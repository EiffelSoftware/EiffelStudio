indexing
	description: "Manages nested window-procedure-return-values."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RETURN_VALUE

feature -- Access

	has_return_value: BOOLEAN is
			-- Should the window procedure return a value?
		do
			if
				has_return_value_area = Void
			then
				Result := False
			elseif
				has_return_value_area.count >= level_count
			then
					-- Value has already been set
				check
					valid_level_count: level_count > 0
				end
				Result := has_return_value_area.item (level_count - 1)
			else
					-- Value has not yet been set -> `has_return_value' = False
				Result := False
			end
		end

	message_return_value: INTEGER is
			-- Return value of the window procedure.
		require
			has_return_value: has_return_value
		do
	
			check
				not_void: message_return_value_area /= Void
				good_area: message_return_value_area.count >= level_count
			end

			check
				valid_level_count: level_count > 0
			end
			Result := message_return_value_area.item (level_count - 1)
		end

	default_processing: BOOLEAN is
		do
			if
				default_processing_area = Void
			then
				Result := True
			elseif
				default_processing_area.count >= level_count
			then
					-- Value has already been set
				check
					valid_level_count: level_count > 0
				end
				Result := default_processing_area.item (level_count - 1)
			else
					-- Value has not yet been set -> `default_processing' = True
				Result := True
			end
		end
		
feature -- Element Change

	set_message_return_value (value: INTEGER) is
			-- Set the window-procedure-return-value.
		do
			if
				has_return_value_area = Void
			then
					-- Areas need to be created first.
				create_has_return_value_area (Initial_area_size)
				create_message_return_value_area (Initial_area_size)
			end

			check
				has_return_value_area_not_void: has_return_value_area /= Void
				message_return_value_area_not_void: message_return_value_area /= Void
			end
							
			if
				has_return_value_area.count < level_count
			then
					-- Areas need to be resized.
				resize_has_return_value_area (level_count + Area_resize_increment)
				resize_message_return_value_area (level_count + Area_resize_increment)
			end
			
			check
				valid_level_count: level_count > 0
			end
			message_return_value_area.put (value, level_count - 1)
			has_return_value_area.put (True, level_count - 1)

		ensure
			has_return_value: has_return_value
			value_set: message_return_value = value
		end

	set_default_processing (value: BOOLEAN) is
			-- Enable or disable default processing of window messages.
		do
			if
				default_processing_area = Void
			then
				create_default_processing_area (Initial_area_size)
			end

			check
				default_processing_not_void: default_processing_area /= Void
			end
							
			if
				default_processing_area.count < level_count
			then
				resize_default_processing_area (level_count + Area_resize_increment)
			end

			check
				valid_level_count: level_count > 0
			end
			default_processing_area.put (value, level_count - 1)
		ensure
			value_set: default_processing = value
		end

feature {WEL_DISPATCHER, WEL_WINDOW}

	increment_level is
			-- Called from WEL_DISPATCHER when the window-procedure
			-- is called.
		do
			level_count := level_count + 1
			
			if
				has_return_value
			then
				set_has_return_value (False)
			end
			
			if
				not default_processing
			then
				set_default_processing (True)
			end
		ensure
			level_count_increased: level_count = old level_count + 1			
			default_processing_true: default_processing = True
			has_return_value_false: has_return_value = False
		end

	decrement_level is
			-- Called from WEL_DISPATCHER when the window-procedure
			-- is about to exit.
		require
			level_count_greater_than_one: level_count >= 1
		do
			level_count := level_count - 1
		ensure
			level_count_equal_or_greater_than_zero: level_count >= 0
			level_count_decreased: level_count = old level_count - 1
		end

	level_count: INTEGER
			-- Index for areas
	
feature {NONE} -- Implementation

	has_return_value_area: SPECIAL [BOOLEAN]
	message_return_value_area: SPECIAL [INTEGER]
	default_processing_area: SPECIAL [BOOLEAN]


	create_has_return_value_area (n: INTEGER) is
			-- Create `has_return_value_area'
		local
			fake_array: ARRAY [BOOLEAN]	
		do
			create fake_array.make (0, n - 1)
			has_return_value_area := fake_array.area
		ensure
			has_return_value_area_not_void: has_return_value_area /= Void
			correct_size:	has_return_value_area.count = n
		end

	create_message_return_value_area (n: INTEGER) is
			-- Create `return_value_area'.
		local
			fake_array: ARRAY [INTEGER]	
		do
			create fake_array.make (0, n - 1)
			message_return_value_area := fake_array.area
		ensure
			message_return_value_area_not_void: message_return_value_area /= Void
			correct_size:	message_return_value_area.count = n
		end

	create_default_processing_area (n: INTEGER) is
			-- Create `default_processing_area'.
		local
			fake_array: ARRAY [BOOLEAN]	
		do
			create fake_array.make (0, n - 1)
			default_processing_area := fake_array.area
		ensure
			default_processing_area_not_void: default_processing_area /= Void
			correct_size:	default_processing_area.count = n
		end

	resize_has_return_value_area (new_count: INTEGER) is
			-- Resize `has_return_value_area'.
		require
			new_cound_greater: new_count > has_return_value_area.count
		local
			fake_array: ARRAY [BOOLEAN]
			i: INTEGER
		do
			create fake_array.make (0, new_count - 1)
			
			from
				i := 0
			until
				i >= has_return_value_area.count
			loop
				fake_array.area.put (has_return_value_area.item (i), i)
				i := i + 1
			end
			
			has_return_value_area := fake_array.area
		end

	resize_message_return_value_area (new_count: INTEGER) is
			-- Resize `return_value_area'.
		require
			new_count_greater: new_count > message_return_value_area.count
		local
			fake_array: ARRAY [INTEGER]
			i: INTEGER
		do
			create fake_array.make (0, new_count - 1)
			
			from
				i := 0
			until
				i >= message_return_value_area.count
			loop
				fake_array.area.put (message_return_value_area.item (i), i)
				i := i + 1
			end
			
			message_return_value_area := fake_array.area
		end

	resize_default_processing_area (new_count: INTEGER) is
			-- Resize `default_processing_area'.
		require
			new_count_greater: new_count > default_processing_area.count
		local
			fake_array: ARRAY [BOOLEAN]
			i: INTEGER
		do
			create fake_array.make (0, new_count - 1)
			
			from
				i := 0
			until
				i >= default_processing_area.count
			loop
				fake_array.area.put (default_processing_area.item (i), i)
				i := i + 1
			end
			
			default_processing_area := fake_array.area
		end


	set_has_return_value (value: BOOLEAN) is
			-- Sets whether the current `has_return_value' is
			-- True or False.
		do
			has_return_value_area.put (value, level_count - 1)
		ensure
			value_set: has_return_value = value
		end

	Initial_area_size: INTEGER is 2
	Area_resize_increment: INTEGER is 2

end -- class WEL_RETURN_VALUE


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

