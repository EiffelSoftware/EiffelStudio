indexing
	description: "Manages nested window-procedure-return-values."
	legal: "See notice at end of class."
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

	message_return_value: POINTER is
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

	set_message_return_value (value: POINTER) is
			-- Set the window-procedure-return-value.
		do
			if
				has_return_value_area = Void
			then
					-- Areas need to be created first.
				create has_return_value_area.make (Initial_area_size)
				create message_return_value_area.make (Initial_area_size)
			end

			check
				has_return_value_area_not_void: has_return_value_area /= Void
				message_return_value_area_not_void: message_return_value_area /= Void
			end
							
			if
				has_return_value_area.count < level_count
			then
					-- Areas need to be resized.
				has_return_value_area := has_return_value_area.resized_area (
					level_count + Area_resize_increment)
				message_return_value_area := message_return_value_area.resized_area (
					level_count + Area_resize_increment)
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
				create default_processing_area.make (Initial_area_size)
			end

			check
				default_processing_not_void: default_processing_area /= Void
			end
							
			if
				default_processing_area.count < level_count
			then
				default_processing_area := default_processing_area.resized_area (
					level_count + Area_resize_increment)
			end

			check
				valid_level_count: level_count > 0
			end
			default_processing_area.put (value, level_count - 1)
		ensure
			value_set: default_processing = value
		end

feature {WEL_ABSTRACT_DISPATCHER, WEL_WINDOW}

	increment_level is
			-- Called from WEL_DISPATCHER when the window-procedure
			-- is called.
		do
			level_count := level_count + 1
			
			if
				has_return_value
			then
				has_return_value_area.put (False, level_count - 1)
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
	message_return_value_area: SPECIAL [POINTER]
	default_processing_area: SPECIAL [BOOLEAN]

	Initial_area_size: INTEGER is 2
	Area_resize_increment: INTEGER is 2;

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




end -- class WEL_RETURN_VALUE

