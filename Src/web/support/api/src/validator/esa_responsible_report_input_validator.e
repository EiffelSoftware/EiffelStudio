note
	description: "[
				Provide input validations for responsible reports query parameters
				Example:
				?page=3&size=10&category=0&submitter=&severity=0&priority=0&responsible=0&status=0&
				status=1&status=2&status=3&status=4&orderBy=synopsis&dir=ASC&filter=&filter_content=0
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_RESPONSIBLE_REPORT_INPUT_VALIDATOR

inherit
	ESA_REPORT_INPUT_VALIDATOR
		redefine
			default_create,
			acceptable_query_parameters,
			accetpable_order_by,
			validate
		end

feature -- Initialization

	default_create
				-- Create a default instance.
			do
				Precursor
				set_submitter ("") -- Empty
				set_severity (0)
				set_priority (0)
				set_responsible (0)
			ensure then
				responsible_set: responsible = 0
				priority_set: priority = 0
				submitter_set: submitter.is_empty
				severity_set: severity = 0
			end

feature -- Access


	submitter: READABLE_STRING_32
		-- Report's submitter, default empty.

	severity: INTEGER
		-- Report's severity, default 0.
		-- Acceptable values 0,1,2,3.

	priority: INTEGER
		-- Report's priority, default 0.
		-- Acceptable values 0,1,2,3.

	responsible: INTEGER
		-- Report's responsible, default 0.

	acceptable_query_parameters: ARRAY [STRING]
			-- The paramers are optionals, more parameters is a bad request.
		once
			Result := <<"page", "size", "category", "submitter", "severity", "priority", "responsible", "status", "orderBy", "release", "dir", "filter", "filter_content">>
			Result.compare_objects
		end

	accetpable_order_by: ARRAY [STRING_32]
			-- acceptable values to sort the reports.	
		once
			Result := {ARRAY [STRING_32]} <<"number", "statusID", "priorityID", "severityID", "synopsis", "username", "submissionDate", "categorySynopsis", "release">>
			Result.compare_objects
		end


feature -- Request Input Parameters

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
						errors.force ("The parameter [" + l_keys.item.to_string_8 + "] is not valid", l_keys.item)
					end
				end
			end
				-- validate query parameters values.
			validate_page (l_current_keys, a_request)
				-- Validate size, should be a number
			validate_size (l_current_keys, a_request)
				-- Validate category, should be a number
			validate_category (l_current_keys, a_request)
				-- Validate status, should be a number
			validate_status (l_current_keys, a_request)
				--Validated orderby, should be a string, empty or an acceptable value.
			validate_orderby (l_current_keys, a_request)
				-- Filter, not validated at the moment.
			validate_filter (l_current_keys, a_request)
				-- Validate filter_content, should be a number between 0 and 1
			validate_filter_content (l_current_keys, a_request)
				--Validated dir, should be a string, empty or ASC|DESC
			validate_direction (l_current_keys, a_request)
				--Validated responsible, should be a value > 0
			validate_responsible (l_current_keys, a_request)
				--Validated priority, should be a value between 0 .. 3
			validate_priority (l_current_keys, a_request)
				-- No validation
			validate_submitter (l_current_keys, a_request)
				--Validated severity, should be a value between 0 .. 3
			validate_severity (l_current_keys, a_request)
		end


feature {NONE} -- Validations		

	validate_responsible (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `responsible' query parameter, if it's present should be a value greater than 0, update the value to `responsible'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ("responsible") and then
				attached {WSF_STRING} a_table_request.at ("responsible") as l_responsible
			then
				if
					not l_responsible.is_integer or else
					(l_responsible.is_integer and then
					 l_responsible.integer_value < 0 )
				then
					errors.force ("The parameter value for responsible should be greater than 0, the vale =[" + l_responsible.value.to_string_8 + "] is not valid", "responsible")
				else
					set_responsible (l_responsible.integer_value)
				end
			end
		end

	validate_priority (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `priority' query parameter, if it's present should be a value between 0..3, update the value to `priority'
			-- feature, if there is an error, add it to errors.
		do
				-- Validate priority, should be a number between 0 and 3
			if
				a_current_keys.has ("priority") and then
				attached {WSF_STRING} a_table_request.at ("priority") as l_priority
			then
				if not l_priority.is_integer then
					errors.force ("The parameter value for priority=[" + l_priority.value.to_string_8 + "] is not valid", "priority")
				elseif l_priority.is_integer and then
					( l_priority.integer_value > 3 or else l_priority.integer_value < 0 )
				then
					errors.force ("The parameter value for priority should be between 0 .. 3 the current value [" + l_priority.value.to_string_8 + "] is not valid", "priority")
				else
					set_priority (l_priority.integer_value)
				end
			end
		end

	validate_submitter (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `submitter' query parameter, if it's present no validation at the moment, update the value to `submitter'
			-- feature..
		do
			if
				a_current_keys.has ("submitter") and then
				attached {WSF_STRING} a_table_request.at ("submitter") as l_submitter
			then
				set_submitter (l_submitter.value)
			end
		end

	validate_severity (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `severity' query parameter, if it's present should be a value between 0..3, update the value to `severity'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ("severity") and then
				attached {WSF_STRING} a_table_request.at ("severity") as l_severity
			then
				if not l_severity.is_integer then
					errors.force ("The parameter value for severity=[" + l_severity.value.to_string_8 + "] is not valid", "severity")
				elseif l_severity.is_integer and then
				   ( l_severity.integer_value > 3 or else l_severity.integer_value < 0 )
				then
				  	errors.force ("The parameter value for severity should be between 0 .. 3 the current value [" + l_severity.value.to_string_8 + "] is not valid", "severity")
				else
					set_severity (l_severity.integer_value)
				end
			end
		end

feature -- Change Element


	set_submitter (a_submitter : like submitter)
			-- Set `submitter' to `a_submitter'.
		do
			submitter := a_submitter
		ensure
			submitter_set: submitter = a_submitter
		end

	set_severity (a_severity: INTEGER)
			-- Set `severity' to `a_severity'.
		do
			severity := a_severity
		ensure
			severity_set: severity = a_severity
		end

	set_priority (a_priority: INTEGER)
			-- Set `priority' to `a_priority'.
		do
			priority := a_priority
		ensure
			priority_set: priority = a_priority
		end

	set_responsible (a_responsible: INTEGER)
			-- Set `responsible' to `a_responsible'.
		do
			responsible := a_responsible
		ensure
			responsible_set: responsible = a_responsible
		end

end
