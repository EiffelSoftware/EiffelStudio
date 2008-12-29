note
	description: "Duration of dates and times"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class DATE_TIME_DURATION inherit

	DURATION
		undefine
			is_equal
		end

	DATE_TIME_MEASUREMENT
		undefine
			is_equal
		end

create

	make,
	make_definite,
	make_fine,
	make_by_date_time,
	make_by_date

feature -- Initialization

	make (y, mo, d, h, mi, s: INTEGER)
			-- Set `year', `month', `day' to `y', `mo', `d'.
			-- Set `hour', `minute', `second' to `h', `mi', `s'.
		do
			create date.make (y, mo, d)
			create time.make (h, mi, s)
		ensure
			date_exists: date /= Void
			time_exists: time /= Void
			year_set: year = y;
			month_set: month = mo;
			day_set: day = d;
			hour_set: hour = h
			minute_set: minute = mi
			second_set: second = s
		end

	make_definite (d, h, m, s: INTEGER)
			-- Set `day' to `d'.
			-- Set `hour', `minute', `second' to `h', `m', `s'.
		do
			create date.make_by_days (d)
			create time.make (h, m, s)
		ensure
			date_exists: date /= Void
			time_exists: time /= Void
			definite_result: definite
			day_set: day = d;
			hour_set: hour = h
			minute_set: minute = m
			second_set: second = s
		end

	make_fine (y, mo, d, h, mi: INTEGER; s: DOUBLE)
			-- set `year', `month', `day' to `y', `mo', `d'.
			-- set `hour', `minute', `second' to `h', `mi', `s'.
		do
			create date.make (y, mo, d)
			create time.make_fine (h, mi, s)
		ensure
			date_exists: date /= Void
			time_exists: time /= Void
			year_set: year = y;
			month_set: month = mo;
			day_set: day = d;
			hour_set: hour = h
			minute_set: minute = mi
			fine_second_set: fine_second = s
		end

	 make_by_date_time (d: DATE_DURATION; t: TIME_DURATION)
			-- Set `date' to `d' and `time' to `t'.
		require
			date_exists: d /= Void
			time_exists: t /= Void
		do
			date := d
			time := t
		ensure
			date_set: date = d
			time_set: time = t
		end

	make_by_date (d: DATE_DURATION)
			-- Set `date' to `d' and `time' to zero.
		require
			d_exists: d /= Void;
		do
			date := d
			create time.make (0, 0, 0);
		ensure
			date_set: date = d;
			time_exists: time /= Void
			time_set: time.is_equal (time.zero)
		end;

feature -- Access

	date: DATE_DURATION
			-- Date part of the current duration

	time: TIME_DURATION
			-- Time part of current duration

	origin_date_time: DATE_TIME
			-- Origin date time of duration

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make_by_date_time (date.zero, time.zero)
		end

	seconds_count: INTEGER_64
			-- Total number of seconds of current duration
		require
			has_origin: has_origin_date_time
		do
			Result := (date.days_count.to_integer_64 * Seconds_in_day.to_integer_64) + time.seconds_count.to_integer_64
		end

	fine_seconds_count: DOUBLE
			-- Total number of seconds of current duration
		require
			has_origin: has_origin_date_time
		do
			Result := (date.days_count.to_double * Seconds_in_day.to_double) +
				time.fine_seconds_count
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is the current duration smaller than `other'?
			-- False if either is not definite
		do
			if definite and then other.definite then
				Result := (day + time.to_days < other.day +
				other.time.to_days) or else (day + time.to_days = other.day +
				other.time.to_days) and then
					(time.time_modulo_day < other.time.time_modulo_day)
			end
		ensure then
			non_definite_result: not (definite and other.definite) implies
					Result = False
		end

	is_equal (other: like Current): BOOLEAN
			-- Are the current duration an `other' equal?
		do
			Result := year = other.year and then month = other.month and then
				(day + time.to_days = other.day + other.time.to_days) and then
				time.time_modulo_day.is_equal (other.time.time_modulo_day)
		end

feature -- Status report

	definite: BOOLEAN
			-- Is this duration date-independent?
			-- (True if it only uses `day', not `year' and `month')
		do
			Result:= date.definite
		ensure
			result_definition: Result = (year = 0 and then month = 0)
		end

	canonical (start_date: DATE_TIME): BOOLEAN
			-- Are the time and date parts of the same sign,
			-- and both canonical?
		local
			final_date: DATE_TIME
		do
			final_date := start_date + Current
			if final_date >= start_date then
				Result := (date.canonical (start_date.date) and then
						time.seconds_count >= 0 and then time.canonical and then
						hour < Hours_in_day)
			else
				Result := (date.canonical (start_date.date) and then
						time.seconds_count <= 0 and then time.canonical and then
						hour > -Hours_in_day)
			end
		end

	is_positive: BOOLEAN
			-- Is duration positive?
		do
			Result := (date.is_positive or date.is_zero) and (time.is_positive or time.is_zero) and
				not (date.is_zero and time.is_zero)
		end

	has_origin_date_time: BOOLEAN
			-- Has an `origin_date_time' been set?
		do
			Result := (origin_date_time /= Void)
		end

feature -- Status setting

	set_origin_date_time (dt: ?DATE_TIME)
			-- Set `origin_date_time' to `dt'.
		do
			origin_date_time := dt
			if origin_date_time /= Void then
				date.set_origin_date (origin_date_time.date)
			else
				date.set_origin_date (Void)
			end
		ensure
			origin_date_time_set: origin_date_time = dt
			origin_date_set: origin_date_time /= Void implies (origin_date_time.date = date.origin_date)
		end

feature -- Element Change

	set_date (d: DATE_DURATION)
			-- Set `date' to `d'.
		require
			d_exists: d /= Void
		do
			date := d
		ensure
			date_set: date = d
		end

	set_time (t: TIME_DURATION)
			-- Set `time' to `t'.
		require
			t_exists: time /= Void
		do
			time := t
		ensure
			time_set: time = t
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current
			-- Sum with `other' (commutative)
		do
			create Result.make_by_date_time (date + other.date,
				time + other.time)
			if origin_date_time /= Void then
				Result.set_origin_date_time (origin_date_time.twin)
			else
				Result.set_origin_date_time (Void)
			end
		ensure then
			origin_date_time: equal (origin_date_time, Result.origin_date_time)
		end

	prefix "-": like Current
			-- Unary minus
		do
			create Result.make_by_date_time (-date, -time)
			if origin_date_time /= Void then
				Result.set_origin_date_time (origin_date_time.twin)
			else
				Result.set_origin_date_time (Void)
			end
		ensure then
			origin_date_time: equal (origin_date_time, Result.origin_date_time)
		end

	day_add (d: INTEGER)
			-- Add `d' days to the current duration.
		do
			date.set_day (day + d)
		ensure
			Result_definition: day = old day + d
		end

feature -- Conversion

	to_canonical (start_date: DATE_TIME): like Current
			-- A new duration, equivalent to current one
			-- and canonical for `start_date'
		local
			final_date: DATE_TIME
			date_part_of_result: DATE_DURATION
			time_part_of_result: TIME_DURATION
		do
			if canonical (start_date) then
				Result := deep_twin
			else
				final_date := start_date + Current
				create time_part_of_result.make_fine (final_date.hour -
					start_date.hour,
					final_date.minute - start_date.minute,
					final_date.fine_second - start_date.fine_second)
				if (final_date >= start_date) and then
					(final_date.time < start_date.time) then
					time_part_of_result.hour_add (24)
					final_date.day_add (-1)
				elseif (final_date < start_date) and then
					(final_date.time > start_date.time) then
					time_part_of_result.hour_add (-24)
					final_date.day_add (1)
				end
				create date_part_of_result.make_by_days (final_date.days -
					start_date.days)
				create Result.make_by_date_time
					(date_part_of_result.to_canonical (start_date.date),
					time_part_of_result.to_canonical)
			end
		ensure
			canonical_set: Result.canonical (start_date)
			duration_not_changed:
				equal (start_date + Current, start_date + Result)
		end

	time_to_canonical: like Current
			-- A new duration, equivalent to current one
			-- but `time' is canonical and has the same sign as `date'
		require
			definite_duration: definite
		do
			Result := deep_twin
			if Current >= zero then
				if time < time.zero then
					Result.time.hour_add (-time.to_days * Hours_in_day)
				end
				Result.day_add (time.to_days)
				Result.set_time (Result.time.time_modulo_day)
			else
				Result := -(-Result).time_to_canonical
			end
		ensure
			time_canonical: Result.time.canonical
			same_sign: ((Result.date > date.zero) implies
				(Result.time >= time.zero)) and then
				((Result.date < date.zero) implies (Result.time <= time.zero))
		end

invariant

	date_exists: date /= Void
	time_exists: time /= Void
	origin_constraint: (origin_date_time = Void and
			date.origin_date = Void) or else
			origin_date_time.date = date.origin_date
	same_signs: (has_origin_date_time and then
				canonical (origin_date_time)) implies
				((date.is_positive or date.is_zero) and
				(time.is_positive or time.is_zero)) or else
				((date.is_negative or date.is_zero) and
				(time.is_negative or time.is_zero))

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




end -- class DATE_TIME_DURATION


