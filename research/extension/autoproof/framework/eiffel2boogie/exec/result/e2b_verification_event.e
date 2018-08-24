note
	description: "Summary description for {E2B_VERIFICATION_EVENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_VERIFICATION_EVENT

inherit

	EVENT_LIST_ITEM_I
		redefine
			data
		end

create
	make

feature {NONE} -- Initialization

	make (a_data: E2B_VERIFICATION_RESULT)
			-- Initialize event item.
		do
			data := a_data
			category := {ENVIRONMENT_CATEGORIES}.none
			priority := {PRIORITY_LEVELS}.normal
		ensure
			data_set: data = a_data
		end

feature -- Access

	data: E2B_VERIFICATION_RESULT
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		local
			l_string_formatter: YANK_STRING_WINDOW
		do
			if not attached internal_description then
				create l_string_formatter.make
				single_line_message (l_string_formatter)
				internal_description := l_string_formatter.stored_output
			end
			Result := internal_description
		end

	context_class: CLASS_C
			-- Class corresponding to event
		do
			Result := data.context_class
		end

	context_feature: FEATURE_I
			-- Feature corresponding to event
		do
			Result := data.context_feature
		end

	line_number: INTEGER
			-- Line number of event (if any)
		do
			if attached {E2B_FAILED_VERIFICATION} data as l_failed then
				if not l_failed.errors.is_empty then
					Result := l_failed.errors.first.context_line_number
				end
			elseif attached {E2B_AUTOPROOF_ERROR} data as l_error then
				Result := l_error.context_line_number
			end
		end

	milliseconds_used: REAL_32
			-- Milliseconds used for proof
		do
			Result := data.time
		end

	frozen type: NATURAL_8
			-- <Precursor>
		once
			Result := {EVENT_LIST_ITEM_TYPES}.unknown
		end

	frozen category: NATURAL_8
			-- <Precursor>

	frozen priority: INTEGER_8
			-- <Precursor>

feature -- Status report

	is_invalidated: BOOLEAN
			-- <Precursor>

	is_valid_data (a_data: ANY): BOOLEAN
			-- <Precursor>
		do
			Result := data /= Void
		end

feature -- Element change

--	set_milliseconds_used (a_value: NATURAL)
--			-- Set `milliseconds_used' to `a_value'.
--		do
--			milliseconds_used := a_value
--		ensure
--			milliseconds_used_set: milliseconds_used = a_value
--		end

	set_category (a_category: like category)
			-- <Precursor>
		do
			category := a_category
		end

	set_priority (a_priority: like priority)
			-- <Precursor>
		do
			priority := a_priority
		end

feature -- Basic operations

	invalidate
			-- <Precursor>
		do
			is_invalidated := True
		end

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- Single line description of result.
		do
			data.single_line_message (a_formatter)
		end

feature {NONE} -- Implementation

	internal_description: detachable STRING_32
			-- Internal buffer for description.

end
