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

	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create
				-- Create a default instance.
			do
				set_page (1)
				set_size (30)
				set_submitter ("") -- Empty
				set_severity (0)
				set_priority (0)
				set_category (0)
				set_responsible (0)
				default_status
				set_orderby ("submissionDate")
				set_direction ("ASC")
				set_filter ("")
				set_filter_content (0)
				create errors.make (0)
			end

feature -- Access

	page: INTEGER
		-- Current page, optional parameter, has a default value 1.

	size: INTEGER
		-- Number of rows per page, optional parameter, has a default value 30.

	submitter: READABLE_STRING_32
		-- Report's submitter, default empty.

	category: INTEGER
		-- Report's category, default 0
		-- Integer value.

	severity: INTEGER
		-- Report's severity, default 0.
		-- Acceptable values 0,1,2,3.

	priority: INTEGER
		-- Report's priority, default 0.
		-- Acceptable values 0,1,2,3.

	responsible: INTEGER
		-- Report's responsible, default 0.

	status:	LIST[INTEGER]
		-- list of status, by default, 0,1,2,3,4.
		-- Acceptable values 0,1,2,3,4

	orderBy: STRING
		-- Report's ordering.
		-- Default, sort by submissionDate.
		-- [number, statusID, priorityID, severityID, synopsis, username, submissionDate, categorySynopsis, release ]

	direction: STRING
		-- Report's ordering direction "ASC|DESC".	

	filter: READABLE_STRING_32
		--	Search text by synopsis or content.

	filter_content: INTEGER
		-- Report's filter by content, default value 0
		-- acceptable values (0,1).	

	acceptable_query_parameters: ARRAY[STRING]
			-- The paramers are optionals, more parameters is a bad request.
		once
			Result := <<"page", "size", "category", "submitter", "severity", "priority", "responsible", "status", "orderBy", "release", "dir", "filter", "filter_content">>
			Result.compare_objects
		end

	accetpable_order_by: ARRAY[STRING]
			-- acceptable values to sort the reports.	
		once
			Result := <<"number", "statusID", "priorityID", "severityID", "synopsis", "username", "submissionDate", "categorySynopsis", "release">>
			Result.compare_objects
		end

feature -- Errors

	errors: STRING_TABLE[READABLE_STRING_32]
		-- Hash table with errors and descriptions.		

feature -- Request Input Parameters

	input_from (a_request: ITERABLE [WSF_VALUE])
			-- Update current object using parameters extracted from QUERY_STRING.
			-- If there are errors they are set to the errors parameter.
		local
			l_current_keys: ARRAY[READABLE_STRING_GENERAL]
		do
				-- validate query parameters names
			if attached {STRING_TABLE[WSF_VALUE]} a_request as l_table_request then
				l_current_keys := l_table_request.current_keys
				l_current_keys.compare_objects
				if not l_current_keys.is_empty then
					across l_current_keys as l_keys loop
						if not acceptable_query_parameters.has (l_keys.item.to_string_8) then
							errors.force ("The parameter [" + l_keys.item + "] is not valid", l_keys.item)
						end
					end
				end

				-- validate query parameters values.

					-- Validate page, should be a number
				if l_current_keys.has ({STRING_32}"page") then
					if
						attached {WSF_STRING} l_table_request.at ("page") as l_page
					then
						if not l_page.is_integer then
							errors.force ("The parameter value for page=[" + l_page.value + "] is not valid", "page")
						else
							set_page (l_page.integer_value)
						end
					end
				end

					-- Validate size, should be a number
				if l_current_keys.has ({STRING_32}"size") then
					if
						attached {WSF_STRING} l_table_request.at ("size") as l_size
					then
						if not l_size.is_integer then
							errors.force ("The parameter value for size=[" + l_size.value + "] is not valid", "size")
						else
							set_size (l_size.integer_value)
						end
					end
				end

					-- Submitter, not validated at the moment.
				if l_current_keys.has ({STRING_32}"submitter") then
					if
						attached {WSF_STRING} l_table_request.at ("submitter") as l_submitter
					then
						set_submitter (l_submitter.value)
					end
				end

					-- Validate category, should be a number
				if l_current_keys.has ({STRING_32}"category") then
					if
						attached {WSF_STRING} l_table_request.at ("category") as l_category
					then
						if not l_category.is_integer then
							errors.force ("The parameter value for category=[" + l_category.value + "] is not valid", "category")
						else
							set_category (l_category.integer_value)
						end
					end
				end


					-- Validate severity, should be a number between 0 and 3
				if l_current_keys.has ({STRING_32}"severity") then
					if
						attached {WSF_STRING} l_table_request.at ("severity") as l_severity
					then
						if not l_severity.is_integer then
							errors.force ("The parameter value for severity=[" + l_severity.value + "] is not valid", "severity")
						elseif l_severity.is_integer and then
							   ( l_severity.integer_value > 3 or else l_severity.integer_value < 0 )
							   then
							   	errors.force ("The parameter value for severity should be between 0 .. 3 the current value [" + l_severity.value + "] is not valid", "severity")
						else
							set_severity (l_severity.integer_value)
						end
					end
				end

					-- Validate priority, should be a number between 0 and 3
				if l_current_keys.has ({STRING_32}"priority") then
					if
						attached {WSF_STRING} l_table_request.at ("priority") as l_priority
					then
						if not l_priority.is_integer then
							errors.force ("The parameter value for priority=[" + l_priority.value + "] is not valid", "priority")
						elseif l_priority.is_integer and then
							   ( l_priority.integer_value > 3 or else l_priority.integer_value < 0 )
							   then
							   	errors.force ("The parameter value for priority should be between 0 .. 3 the current value [" + l_priority.value + "] is not valid", "priority")
						else
							set_priority (l_priority.integer_value)
						end
					end
				end

					-- Validate responsible, should be a number
				if l_current_keys.has ({STRING_32}"responsible") then
					if
						attached {WSF_STRING} l_table_request.at ("responsible") as l_responsible
					then
						if not l_responsible.is_integer then
							errors.force ("The parameter value for responsible=[" + l_responsible.value + "] is not valid", "responsible")
						else
							set_responsible (l_responsible.integer_value)
						end
					end
				end

					-- Validate responsible, should be a number
				if l_current_keys.has ({STRING_32}"status") then
					if
						attached {WSF_MULTIPLE_STRING} l_table_request.at ("status") as l_status
					then
						status.wipe_out
						across l_status.values as c loop
					   		if c.item.integer_value > 0 and then c.item.integer_value < 6 then
					   			status.force (c.item.integer_value)
					   		else
					   			errors.force ("The parameter value for status=[" + c.item.value + "] is not valid", "status_" + c.item.value )
					   		end
					   end
					end
				end

					--Validated orderby, should be a string, empty or an acceptable value.
				if l_current_keys.has ({STRING_32}"orderBy") then
					if
						attached {WSF_STRING} l_table_request.at ("orderBy") as l_orderBy
					then
						if l_orderBy.is_string then
							if
								not l_orderBy.value.is_empty and then
								accetpable_order_by.has (l_orderBy.value)
							then
								set_orderby (l_orderBy.value)
							else
								errors.force ("The parameter value for orderBy=[" + l_orderBy.value + "] is not valid", "orderBy")
							end
						end
					end
				end

					-- Filter, not validated at the moment.
				if l_current_keys.has ({STRING_32}"filter") then
					if
						attached {WSF_STRING} l_table_request.at ("filter") as l_filter
					then
						set_filter (l_filter.value)
					end
				end

					-- Validate filter_content, should be a number between 0 and 1
				if l_current_keys.has ({STRING_32}"priority") then
					if
						attached {WSF_STRING} l_table_request.at ("filter_content") as l_content
					then
						if not l_content.is_integer then
							errors.force ("The parameter value for filter_content=[" + l_content.value + "] is not valid", "content")
						elseif l_content.is_integer and then
							   ( l_content.integer_value > 1 or else l_content.integer_value < 0 )
							   then
							   	errors.force ("The parameter value for filter_content should be between 0 .. 1 the current value [" + l_content.value + "] is not valid", "content")
						else
							set_filter_content (l_content.integer_value)
						end
					end
				end

					--Validated dir, should be a string, empty or ASC|DESC
				if l_current_keys.has ({STRING_32}"dir") then
					if
						attached {WSF_STRING} l_table_request.at ("dir") as l_dir
					then
						if l_dir.is_string then
							if
								l_dir.value.same_string ("ASC") or	l_dir.value.same_string ("DESC")
							then
								set_direction (l_dir.value)
							else
								errors.force ("The parameter value for dir=[" + l_dir.value + "] is not valid", "dir")
							end
						end
					end
				end
			end
		end

	status_selected: STRING
			-- Return selected status as string separated by comman.
		do
			create Result.make_empty
		   	across status as c loop
			 			Result.append_string (c.item.out)
			  			Result.append_character (',')
			end
			if Result.is_empty then
				Result := "0"
			else
				Result.remove_tail (1) -- remove the last ','
			end
		end

	dir_selected: INTEGER
			-- Direction selected ASC=1
			-- DESC = 0.
		do
			if direction.same_string ("ASC") then
				Result := 1
			end
		end


feature -- Set element

	default_status
				-- Set default status available.
			do
				create {ARRAYED_LIST[INTEGER]} status.make (4)
				put_status (1)
				put_status (2)
				put_status (3)
				put_status (4)
			end

feature -- Change Element


	set_page (a_page: INTEGER)
			-- Set `page' to `a_page'.
		do
			page := a_page
		ensure
			page_set: page = a_page
		end

	set_size (a_size: INTEGER)
			-- Set `size' to `a_size'.
		do
			size := a_size
		ensure
			size_set: size = a_size
		end

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

	set_category (a_category: INTEGER)
			-- Set `category' to `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_responsible (a_responsible: INTEGER)
			-- Set `responsible' to `a_responsible'.
		do
			responsible := a_responsible
		ensure
			responsible_set: responsible = a_responsible
		end

	put_status (a_status: INTEGER)
			-- Add `a_status' element to status list.
		do
			status.force (a_status)
		end

	set_orderBy (a_order_by: like orderby)
			-- Set `order_by' to `a_order_by'.
		do
			orderBy := a_order_by
		ensure
			order_by_set: orderBy = a_order_by
		end

	set_direction (a_dir: like direction)
			-- Set `direction' to `a_dir'.
		do
			direction := a_dir
		ensure
			direction_set: direction = a_dir
		end

	set_filter (a_filter: like filter)
			--	Set `filter' to `a_filter'.
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
		end

	set_filter_content (a_content: INTEGER)
			-- Set `filer_content' to `a_content'.
		do
			filter_content := a_content
		ensure
			filter_content_set: filter_content = a_content
		end

end
