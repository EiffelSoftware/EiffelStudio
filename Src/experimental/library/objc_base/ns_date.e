note
	description: "Summary description for {NS_DATE}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE

inherit
	NS_OBJECT

create
	make,
	make_with_time_interval_since_now,
	make_with_time_interval_since_reference_date,
	make_with_time_interval_since1970,
	distant_future,
	distant_past

create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creating Date Objects

	make
			-- Creates and returns a new date set to the current date and time.
		do
			make_from_pointer ({NS_DATE_API}.create_default)
		end

	make_with_time_interval_since_now (a_secs: REAL_64)
			-- Creates and returns an <code>NSDate</code> object set to a given number of seconds from the current date and time.
		do
			make_from_pointer ({NS_DATE_API}.create_with_time_interval_since_now (a_secs))
		end

	make_with_time_interval_since_reference_date (a_secs: REAL_64)
			-- Creates and returns an <code>NSDate</code> object set to a given number of seconds from the first instant of 1 January 2001, GMT.
		do
			make_from_pointer ({NS_DATE_API}.create_with_time_interval_since_reference_date (a_secs))
		end

	make_with_time_interval_since1970 (a_secs: REAL_64)
			-- Creates and returns an <code>NSDate</code> object set to the given number of seconds from the first instant of 1 January 1970, GMT.
		do
			make_from_pointer ({NS_DATE_API}.create_with_time_interval_since1970 (a_secs))
		end

feature -- Initializing Date Objects

	init_with_time_interval_since_now (a_secs_to_be_added_to_now: REAL_64)
			-- Returns an <code>NSDate</code> object initialized relative to the current date and time by a given number of seconds.
		do
			item := {NS_DATE_API}.init_with_time_interval_since_now (item, a_secs_to_be_added_to_now)
		end

	init_with_time_interval_since_date (a_secs_to_be_added: REAL_64; a_another_date: NS_DATE)
			-- Returns an <code>NSDate</code> object initialized relative to another given date by a given number of seconds.
		do
			item := {NS_DATE_API}.init_with_time_interval_since_date (item, a_secs_to_be_added, a_another_date.item)
		end

	init_with_time_interval_since_reference_date (a_secs_to_be_added: REAL_64)
			-- Returns an <code>NSDate</code> object initialized relative the first instant of 1 January 2001, GMT by a given number of seconds.
		do
			item := {NS_DATE_API}.init_with_time_interval_since_reference_date (item, a_secs_to_be_added)
		end

feature -- Getting Temporal Boundaries

	distant_future
			-- Creates and returns an <code>NSDate</code> object representing a date in the distant future.
		do
			make_from_pointer ({NS_DATE_API}.distant_future)
		end

	distant_past
			-- Creates and returns an <code>NSDate</code> object representing a date in the distant past.
		do
			make_from_pointer ({NS_DATE_API}.distant_past)
		end

feature -- Comparing Dates

	is_equal_to_date (a_other_date: NS_DATE): BOOLEAN
			-- Returns a Boolean value that indicates whether a given object is an <code>NSDate</code> object and exactly equal the receiver.
		do
			Result := {NS_DATE_API}.is_equal_to_date (item, a_other_date.item)
		end

	earlier_date (a_another_date: NS_DATE): NS_DATE
			-- Returns the earlier of the receiver and another given date.
		do
			create Result.share_from_pointer ({NS_DATE_API}.earlier_date (item, a_another_date.item))
		end

	later_date (a_another_date: NS_DATE): NS_DATE
			-- Returns the later of the receiver and another given date.
		do
			create Result.share_from_pointer ({NS_DATE_API}.later_date (item, a_another_date.item))
		end

	compare (a_other: NS_DATE): INTEGER
			-- Returns an NSComparisonResult value that indicates the temporal ordering of the receiver and another given date.
		do
			Result := {NS_DATE_API}.compare (item, a_other.item)
		end

feature -- Getting Time Intervals

	time_interval_since_date (a_another_date: NS_DATE): REAL_64
			-- Returns the interval between the receiver and another given date.
		do
			Result := {NS_DATE_API}.time_interval_since_date (item, a_another_date.item)
		end

	time_interval_since_now: REAL_64
			-- Returns the interval between the receiver and the current date and time.
		do
			Result := {NS_DATE_API}.time_interval_since_now (item)
		end

	time_interval_since_reference_date: REAL_64
			-- Returns the interval between the first instant of 1 January 2001, GMT and the current date and time.
		do
			Result := {NS_DATE_API}.time_interval_since_reference_date
		end

	time_interval_since1970: REAL_64
			-- Returns the interval between the receiver and the first instant of 1 January 1970, GMT.
		do
			Result := {NS_DATE_API}.time_interval_since1970 (item)
		end

feature -- Representing Dates as Strings

	description: NS_STRING_BASE
			-- Returns a string representation of the receiver.
		do
			create Result.share_from_pointer ({NS_DATE_API}.description (item))
		end

feature -- Converting to an NSCalendarDate Object

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
