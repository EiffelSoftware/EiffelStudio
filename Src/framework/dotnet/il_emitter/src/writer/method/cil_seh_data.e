note
	description: "Summary description for {CIL_SEH_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_SEH_DATA

create
	make

feature {NONE} -- Initialization

	make
		do
				-- by default flags its initialized with
				-- exception.
			create flags.exception
		end

feature -- Access

	try_offset: NATURAL_64 assign set_try_offset
	try_length: NATURAL_64 assign set_try_length
	handler_offset: NATURAL_64 assign set_handler_offset
	handler_length: NATURAL_64 assign set_handler_length

		-- Defined as a union
	filter_offset: NATURAL_64 assign set_filter_offset
	class_token: NATURAL_64 assign set_class_token

	flags: CIL_SEH_DATA_ENUM assign set_flags


feature -- Element change

	set_try_offset (a_offset: NATURAL_64)
			-- Set `try_offset` with `a_offset`.
		do
			try_offset := a_offset
		ensure
			try_offset_set: try_offset = a_offset
		end

	set_try_length (a_length: NATURAL_64)
			-- Set `try_length` with `a_length`
		do
			try_length := a_length
		ensure
			try_length_set: try_length = a_length
		end

	set_handler_offset (a_offset: NATURAL_64)
			-- Set `handler_offset` with `a_offset`
		do
			handler_offset := a_offset
		ensure
			handler_offset_set: handler_offset = a_offset
		end

	set_handler_length (a_length: NATURAL_64)
			-- Set `handler_length` with `a_length`
		do
			handler_length := a_length
		ensure
			handler_length_set: handler_length = a_length
		end

	set_filter_offset (a_offset: NATURAL_64)
			-- Set `filter_offset` with `a_offset`.
		do
			filter_offset := a_offset
		ensure
			filter_offset_set: filter_offset = a_offset
		end

	set_class_token (a_token: NATURAL_64)
			-- Set `class_token` with `a_token`
		do
			class_token := a_token
		ensure
			class_token_set: class_token = a_token
		end

	set_flags (a_flags: CIL_SEH_DATA_ENUM)
			-- `set_flags' with `a_flags`.
		do
			flags := a_flags
		ensure
			falgs_set: flags = a_flags
		end


feature -- Element Change




end
