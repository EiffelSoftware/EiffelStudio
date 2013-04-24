note
	description: "Summary description for {NS_DATE_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE_API

feature -- Creating and Initializing Date Objects

	frozen create_default: POINTER
			-- - (id)init
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [[NSDate alloc] init];"
		end

	frozen create_with_time_interval_since_now (a_secs_to_be_added_to_now: REAL_64): POINTER
			-- - (id)initWithTimeIntervalSinceNow: (NSTimeInterval) secsToBeAddedToNow
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [[NSDate alloc] initWithTimeIntervalSinceNow: $a_secs_to_be_added_to_now];"
		end

	frozen create_with_time_interval_since_date (a_secs_to_be_added: REAL_64; a_another_date: POINTER): POINTER
			-- - (id)initWithTimeInterval: (NSTimeInterval) secsToBeAdded sinceDate: (NSTimeInterval) anotherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [[NSDate alloc] initWithTimeInterval: $a_secs_to_be_added sinceDate: $a_another_date];"
		end

	frozen create_with_time_interval_since_reference_date (a_secs_to_be_added: REAL_64): POINTER
			-- - (id)initWithTimeIntervalSinceReferenceDate: (NSTimeInterval) secsToBeAdded
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: $a_secs_to_be_added];"
		end

	frozen create_with_time_interval_since1970 (a_secs: REAL_64): POINTER
			-- - (id)initWithTimeIntervalSince1970: (NSTimeInterval) secs
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [[NSDate alloc] dateWithTimeIntervalSince1970: $a_secs];"
		end

	frozen init (a_ns_date: POINTER): POINTER
			-- - (id)init
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date init];"
		end

	frozen init_with_time_interval_since_now (a_ns_date: POINTER; a_secs_to_be_added_to_now: REAL_64): POINTER
			-- - (id)initWithTimeIntervalSinceNow: (NSTimeInterval) secsToBeAddedToNow
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date initWithTimeIntervalSinceNow: $a_secs_to_be_added_to_now];"
		end

	frozen init_with_time_interval_since_date (a_ns_date: POINTER; a_secs_to_be_added: REAL_64; a_another_date: POINTER): POINTER
			-- - (id)initWithTimeInterval: (NSTimeInterval) secsToBeAdded sinceDate: (NSTimeInterval) anotherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date initWithTimeInterval: $a_secs_to_be_added sinceDate: $a_another_date];"
		end

	frozen init_with_time_interval_since_reference_date (a_ns_date: POINTER; a_secs_to_be_added: REAL_64): POINTER
			-- - (id)initWithTimeIntervalSinceReferenceDate: (NSTimeInterval) secsToBeAdded
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date initWithTimeIntervalSinceReferenceDate: $a_secs_to_be_added];"
		end

feature -- Getting Temporal Boundaries

	frozen distant_future : POINTER
			-- + (id)distantFuture
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [NSDate distantFuture];"
		end

	frozen distant_past : POINTER
			-- + (id)distantPast
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [NSDate distantPast];"
		end

feature -- Comparing Dates

	frozen is_equal_to_date (a_ns_date: POINTER; a_other_date: POINTER): BOOLEAN
			-- - (BOOL)isEqualToDate: (NSDate *) otherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date isEqualToDate: $a_other_date];"
		end

	frozen earlier_date (a_ns_date: POINTER; a_another_date: POINTER): POINTER
			-- - (NSDate *)earlierDate: (NSDate *) anotherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date earlierDate: $a_another_date];"
		end

	frozen later_date (a_ns_date: POINTER; a_another_date: POINTER): POINTER
			-- - (NSDate *)laterDate: (NSDate *) anotherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date laterDate: $a_another_date];"
		end

	frozen compare (a_ns_date: POINTER; a_other: POINTER): INTEGER
			-- - (NSComparisonResult)compare: (NSDate *) other
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date compare: $a_other];"
		end

feature -- Getting Time Intervals

	frozen time_interval_since_date (a_ns_date: POINTER; a_another_date: POINTER): REAL_64
			-- - (NSTimeInterval)timeIntervalSinceDate: (NSDate *) anotherDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date timeIntervalSinceDate: $a_another_date];"
		end

	frozen time_interval_since_now (a_ns_date: POINTER): REAL_64
			-- - (NSTimeInterval)timeIntervalSinceNow
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date timeIntervalSinceNow];"
		end

	frozen time_interval_since_reference_date : REAL_64
			-- + (NSTimeInterval)timeIntervalSinceReferenceDate
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [NSDate timeIntervalSinceReferenceDate];"
		end

	frozen time_interval_since1970 (a_ns_date: POINTER): REAL_64
			-- - (NSTimeInterval)timeIntervalSince1970
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date timeIntervalSince1970];"
		end

feature -- Representing Dates as Strings

	frozen description (a_ns_date: POINTER): POINTER
			-- - (NSString *)description
		external
			"C inline use <Foundation/NSDate.h>"
		alias
			"return [(NSDate*)$a_ns_date description];"
		end

feature -- Converting to an NSCalendarDate Object

end
