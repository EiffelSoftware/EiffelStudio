note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CV_SMPTE_TIME

inherit
	MEMORY_STRUCTURE
		redefine
			out,
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			out,
			is_equal
		end


create
	make,
	make_by_pointer

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := item.memory_compare (other.item, structure_size)
		end

feature -- Settings

	set_subframes (a_subframes: INTEGER_16)
			-- Set `subframes' with 'a_subframes'.
		do
			c_set_subframes (item, a_subframes)
		ensure
			subframes_set: subframes ~ a_subframes
		end

	set_subframe_divisor (a_subframe_divisor: INTEGER_16)
			-- Set `subframe_divisor' with 'a_subframe_divisor'.
		do
			c_set_subframe_divisor (item, a_subframe_divisor)
		ensure
			subframe_divisor_set: subframe_divisor ~ a_subframe_divisor
		end

	set_counter (a_counter: NATURAL_32)
			-- Set `counter' with 'a_counter'.
		do
			c_set_counter (item, a_counter)
		ensure
			counter_set: counter ~ a_counter
		end

	set_type (a_type: NATURAL_32)
			-- Set `type' with 'a_type'.
		do
			c_set_type (item, a_type)
		ensure
			type_set: type ~ a_type
		end

	set_flags (a_flags: NATURAL_32)
			-- Set `flags' with 'a_flags'.
		do
			c_set_flags (item, a_flags)
		ensure
			flags_set: flags ~ a_flags
		end

	set_hours (a_hours: INTEGER_16)
			-- Set `hours' with 'a_hours'.
		do
			c_set_hours (item, a_hours)
		ensure
			hours_set: hours ~ a_hours
		end

	set_minutes (a_minutes: INTEGER_16)
			-- Set `minutes' with 'a_minutes'.
		do
			c_set_minutes (item, a_minutes)
		ensure
			minutes_set: minutes ~ a_minutes
		end

	set_seconds (a_seconds: INTEGER_16)
			-- Set `seconds' with 'a_seconds'.
		do
			c_set_seconds (item, a_seconds)
		ensure
			seconds_set: seconds ~ a_seconds
		end

	set_frames (a_frames: INTEGER_16)
			-- Set `frames' with 'a_frames'.
		do
			c_set_frames (item, a_frames)
		ensure
			frames_set: frames ~ a_frames
		end

feature -- Access

	subframes: INTEGER_16 assign set_subframes
			-- Return the struct field.
		do
			Result := c_subframes (item)
		end

	subframe_divisor: INTEGER_16 assign set_subframe_divisor
			-- Return the struct field.
		do
			Result := c_subframe_divisor (item)
		end

	counter: NATURAL_32 assign set_counter
			-- Return the struct field.
		do
			Result := c_counter (item)
		end

	type: NATURAL_32 assign set_type
			-- Return the struct field.
		do
			Result := c_type (item)
		end

	flags: NATURAL_32 assign set_flags
			-- Return the struct field.
		do
			Result := c_flags (item)
		end

	hours: INTEGER_16 assign set_hours
			-- Return the struct field.
		do
			Result := c_hours (item)
		end

	minutes: INTEGER_16 assign set_minutes
			-- Return the struct field.
		do
			Result := c_minutes (item)
		end

	seconds: INTEGER_16 assign set_seconds
			-- Return the struct field.
		do
			Result := c_seconds (item)
		end

	frames: INTEGER_16 assign set_frames
			-- Return the struct field.
		do
			Result := c_frames (item)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(CVSMPTETime);"
		end

	c_subframes (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->subframes);"
		end

	c_subframe_divisor (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->subframeDivisor);"
		end

	c_counter (a_struct_pointer: POINTER): NATURAL_32
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->counter);"
		end

	c_type (a_struct_pointer: POINTER): NATURAL_32
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->type);"
		end

	c_flags (a_struct_pointer: POINTER): NATURAL_32
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->flags);"
		end

	c_hours (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->hours);"
		end

	c_minutes (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->minutes);"
		end

	c_seconds (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->seconds);"
		end

	c_frames (a_struct_pointer: POINTER): INTEGER_16
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((CVSMPTETime *) $a_struct_pointer)->frames);"
		end

	c_set_subframes (a_struct_pointer: POINTER; a_c_subframes: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_subframes'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->subframes = $a_c_subframes;"
		end

	c_set_subframe_divisor (a_struct_pointer: POINTER; a_c_subframe_divisor: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_subframe_divisor'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->subframeDivisor = $a_c_subframe_divisor;"
		end

	c_set_counter (a_struct_pointer: POINTER; a_c_counter: NATURAL_32)
			-- Set the corresponding C struct field with `a_c_counter'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->counter = $a_c_counter;"
		end

	c_set_type (a_struct_pointer: POINTER; a_c_type: NATURAL_32)
			-- Set the corresponding C struct field with `a_c_type'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->type = $a_c_type;"
		end

	c_set_flags (a_struct_pointer: POINTER; a_c_flags: NATURAL_32)
			-- Set the corresponding C struct field with `a_c_flags'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->flags = $a_c_flags;"
		end

	c_set_hours (a_struct_pointer: POINTER; a_c_hours: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_hours'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->hours = $a_c_hours;"
		end

	c_set_minutes (a_struct_pointer: POINTER; a_c_minutes: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_minutes'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->minutes = $a_c_minutes;"
		end

	c_set_seconds (a_struct_pointer: POINTER; a_c_seconds: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_seconds'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->seconds = $a_c_seconds;"
		end

	c_set_frames (a_struct_pointer: POINTER; a_c_frames: INTEGER_16)
			-- Set the corresponding C struct field with `a_c_frames'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((CVSMPTETime *) $a_struct_pointer)->frames = $a_c_frames;"
		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"subframes: " + subframes.out + ", " +
					"subframe_divisor: " + subframe_divisor.out + ", " +
					"counter: " + counter.out + ", " +
					"type: " + type.out + ", " +
					"flags: " + flags.out + ", " +
					"hours: " + hours.out + ", " +
					"minutes: " + minutes.out + ", " +
					"seconds: " + seconds.out + ", " +
					"frames: " + frames.out +
				"}"
		end

end
