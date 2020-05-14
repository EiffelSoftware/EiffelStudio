note
	description: "[
					Provides input validations for report details searchs
					Example:
					?search=1
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_DETAIL_INPUT_VALIDATOR

inherit
	ANY
		redefine
			default_create
		select
			default_create
		end
	ESA_INPUT_VALIDATOR
		rename
			default_create as default_create_iv
		end
	REFACTORING_HELPER
		rename
			default_create as default_create_rh
		end

feature -- Initialization

	default_create
				-- Create a default instance.
			do
				create errors.make (0)
			ensure then
				errors_set: errors.is_empty
			end


feature -- Access

	search: INTEGER
		-- Current search parameter, should be a value greather than 0.

	acceptable_query_parameters: ARRAY [STRING]
			-- The paramers are optionals, more parameters is a bad request.
		once
			Result := <<"search">>
			Result.compare_objects
		end

feature -- Validation

	validate (a_request: STRING_TABLE [WSF_VALUE])
			-- <Precursor>
		local
			l_current_keys: ARRAY [READABLE_STRING_GENERAL]
		do
			l_current_keys := a_request.current_keys
			l_current_keys.compare_objects
			if not l_current_keys.is_empty then
				across l_current_keys as l_keys loop
					if not acceptable_query_parameters.has (l_keys.item.to_string_8) then
						errors.force ("The parameter [" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8  (l_keys.item) + "] is not valid", l_keys.item)
					end
				end
			end
				-- validate query parameters values.
			validate_search (l_current_keys, a_request)
		end


feature {NONE} -- Validations

	validate_search (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `search' query parameter, if it's present should be greater than 0, update the value to `search'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "search") and then
				attached {WSF_STRING} a_table_request.at ("search") as l_page
			then
				if
					not l_page.is_integer or else
					(l_page.is_integer and then l_page.integer_value <= 0)
				then
					errors.force ("The parameter value for search should be > 0, the value [" + l_page.value + "] is not valid", "page")
				else
					set_search (l_page.integer_value)
				end
			end
		end

feature -- Change Element

	set_search (a_report_number: INTEGER)
			-- Set `search' to `a_report_number'.
		do
			search := a_report_number
		ensure
			search_set: search = a_report_number
		end

end
