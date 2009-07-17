note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_DATE

inherit
	C_DATE

create
	default_create,
	make_utc

feature -- Access

	unix_time_stamp: NATURAL
			-- Compute the seconds since EPOC (January 1st 1970)
		do
			Result := (year_now.to_natural_32 - 1970)* 12 * 30 * 24 * 60 * 60
			Result := Result + month_now.to_natural_32 * 30 * 24 * 60 * 60
			Result := Result + day_now.to_natural_32 * 24 * 60 * 60
			Result := Result + hour_now.to_natural_32 * 60 * 60
			Result := Result + minute_now.to_natural_32 * 60
			Result := Result + second_now.to_natural_32
		end

	time_stamp_milliseconds: NATURAL
			-- Compute the milliseconds since EPOC (January 1st 1970)
		do
			Result := unix_time_stamp * 1000
			Result := Result + millisecond_now.to_natural_32
		end

feature -- Basic Operations

end
