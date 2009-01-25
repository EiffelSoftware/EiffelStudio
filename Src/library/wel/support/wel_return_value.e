note
	description: "Manages nested window-procedure-return-values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RETURN_VALUE

feature -- Access

	has_return_value: BOOLEAN
			-- Should the window procedure return a value?
		local
			l_has_return_value_area: like has_return_value_area
		do
			l_has_return_value_area := has_return_value_area
			if l_has_return_value_area = Void then
				Result := False
			elseif l_has_return_value_area.count >= level_count then
					-- Value has already been set
				check
					valid_level_count: level_count > 0
				end
				Result := l_has_return_value_area.item (level_count - 1)
			else
					-- Value has not yet been set -> `has_return_value' = False
				Result := False
			end
		end

	message_return_value: POINTER
			-- Return value of the window procedure.
		require
			has_return_value: has_return_value
		local
			l_message_return_value_area: like message_return_value_area
		do
			l_message_return_value_area := message_return_value_area
			check
				not_void: l_message_return_value_area /= Void
				good_area: l_message_return_value_area.count >= level_count
			end

			check
				valid_level_count: level_count > 0
			end
			Result := l_message_return_value_area.item (level_count - 1)
		end

	default_processing: BOOLEAN
		local
			l_default_processing_area: like default_processing_area
		do
			l_default_processing_area := default_processing_area
			if l_default_processing_area = Void then
				Result := True
			elseif l_default_processing_area.count >= level_count then
					-- Value has already been set
				check
					valid_level_count: level_count > 0
				end
				Result := l_default_processing_area.item (level_count - 1)
			else
					-- Value has not yet been set -> `default_processing' = True
				Result := True
			end
		end

feature -- Element Change

	set_message_return_value (value: POINTER)
			-- Set the window-procedure-return-value.
		local
			l_has_return_value_area: like has_return_value_area
			l_message_return_value_area: like message_return_value_area
		do
			l_has_return_value_area := has_return_value_area
			l_message_return_value_area := message_return_value_area
			if l_has_return_value_area = Void then
					-- Areas need to be created first.
				create l_has_return_value_area.make (Initial_area_size)
				create l_message_return_value_area.make (Initial_area_size)
				has_return_value_area := l_has_return_value_area
				message_return_value_area := l_message_return_value_area
			end

			check
				message_return_value_area_not_void: l_message_return_value_area /= Void
			end

			if l_has_return_value_area.count < level_count then
					-- Areas need to be resized.
				l_has_return_value_area := l_has_return_value_area.resized_area (
					level_count + Area_resize_increment)
				l_message_return_value_area := l_message_return_value_area.resized_area (
					level_count + Area_resize_increment)
				has_return_value_area := l_has_return_value_area
				message_return_value_area := l_message_return_value_area
			end

			check
				valid_level_count: level_count > 0
			end
			l_message_return_value_area.put (value, level_count - 1)
			l_has_return_value_area.put (True, level_count - 1)
		ensure
			has_return_value: has_return_value
			value_set: message_return_value = value
		end

	set_default_processing (value: BOOLEAN)
			-- Enable or disable default processing of window messages.
		local
			l_default_processing_area: like default_processing_area
		do
			l_default_processing_area := default_processing_area
			if l_default_processing_area = Void then
				create l_default_processing_area.make (Initial_area_size)
				default_processing_area := l_default_processing_area
			end

			if l_default_processing_area.count < level_count then
				l_default_processing_area := l_default_processing_area.aliased_resized_area (
					level_count + Area_resize_increment)
				default_processing_area := l_default_processing_area
			end

			check
				valid_level_count: level_count > 0
			end
			l_default_processing_area.put (value, level_count - 1)
		ensure
			value_set: default_processing = value
		end

feature {WEL_ABSTRACT_DISPATCHER, WEL_WINDOW}

	increment_level
			-- Called from WEL_DISPATCHER when the window-procedure
			-- is called.
		local
			l_has_return_value_area: like has_return_value_area
		do
			level_count := level_count + 1

			if has_return_value then
				l_has_return_value_area := has_return_value_area
				check l_has_return_value_area_attached: l_has_return_value_area /= Void end
				l_has_return_value_area.put (False, level_count - 1)
			end

			if not default_processing then
				set_default_processing (True)
			end
		ensure
			level_count_increased: level_count = old level_count + 1
			default_processing_true: default_processing = True
			has_return_value_false: has_return_value = False
		end

	decrement_level
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

	has_return_value_area: ?SPECIAL [BOOLEAN]
	message_return_value_area: ?SPECIAL [POINTER]
	default_processing_area: ?SPECIAL [BOOLEAN]

	Initial_area_size: INTEGER = 2
	Area_resize_increment: INTEGER = 2;

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




end -- class WEL_RETURN_VALUE

