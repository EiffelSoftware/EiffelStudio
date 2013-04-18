note
	description: "Summary description for {IRON_REPO_VERSION}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_VERSION

inherit
	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make,
	make_default

convert
	value: {READABLE_STRING_8}

feature {NONE} -- Initialization

	make (v: READABLE_STRING_8)
		do
			create value.make_from_string (v)
		end

	make_default
			-- Make Current as default
			-- the default version is known by the IRON server
		do
			make ("")
		end

feature -- Access

	value: IMMUTABLE_STRING_8

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := value
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := value.is_case_insensitive_equal (other.value)
		end

	is_default: BOOLEAN
		do
			Result := value.is_empty
		end

end
