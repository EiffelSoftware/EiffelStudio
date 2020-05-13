note
	description: "[
					Provides input validations for a Motion List
					Example:
					?page=1&size=5&category=0&orderBy=date&dir=DESC&status=0&status=1&status=2&status=3&status=4&filter=&filter_content=0
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_INPUT_VALIDATOR

inherit

	ANY
		redefine
			default_create
		select
			default_create
		end
	CMS_INPUT_VALIDATOR
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
				set_page (1)
				set_size (30)
				set_category (0)
				default_status
				set_orderby ("changed")
				set_direction ("DESC")
				set_filter ("")
				set_filter_content (0)
				create errors.make (0)
			ensure then
				page_set: page = 1
				size_set: size = 30
				orderby_set: orderby.same_string ("changed")
				direction_set: direction.same_string ("DESC")
				filter_set: filter.is_empty
				filter_content_set: filter_content = 0
				errors_set: errors.is_empty
			end

feature -- Access

	page: INTEGER
		-- Current page, optional parameter, has a default value 1.

	size: INTEGER
		-- Number of rows per page, optional parameter, has a default value 30.

	category: INTEGER
		-- Wishlist's category, default 0
		-- Integer value.

	status:	LIST [INTEGER]
		-- list of status, by default, 0,1,2,3,4.
		-- Acceptable values 0,1,2,3,4

	orderBy: STRING
		-- Wish List's ordering.
		-- Default, sort by Date.
		-- [number, statusID, synopsis, Date, Category]

	direction: STRING
		-- Report's ordering direction "ASC|DESC".	

	filter: READABLE_STRING_32
		--	Search text by synopsis or content.

	filter_content: INTEGER
		-- Wishlist's filter by content, default value 0
		-- acceptable values (0,1).	

	acceptable_query_parameters: ARRAY [STRING]
			-- The paramers are optionals, more parameters is a bad request.
		once
			Result := <<"page", "size", "category", "status", "orderBy", "dir", "filter", "filter_content">>
			Result.compare_objects
		end

	accetpable_order_by: ARRAY [STRING]
			-- acceptable values to sort the motion.	
		once
			Result := <<"wid", "status", "synopsis", "changed", "category", "votes">>
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
						errors.force ({STRING_32} "The parameter [" + l_keys.item.to_string_32 + "] is not valid", l_keys.item)
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
		end

feature {NONE} -- Validations

	validate_page (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `page' query parameter, if it's present should be greater than 0, update the value to `page'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "page") and then
				attached {WSF_STRING} a_table_request.at ("page") as l_page
			then
				if
					not l_page.is_integer or else
					(l_page.is_integer and then l_page.integer_value <= 0)
				then
					errors.force ("The parameter value for page should be greater then 0, the value " + l_page.value + " is not valid", "page")
				else
					set_page (l_page.integer_value)
				end
			end
		end

	validate_size (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `size' query parameter, if it's present should be greater than 0, update the value to `size'
			-- feature, if there is an error, add it to errors.
		do
				-- Validate size, should be a number
			if
				a_current_keys.has ({STRING_32} "size") and then
				attached {WSF_STRING} a_table_request.at ("size") as l_size
			then
				if
					not l_size.is_integer or else
					(l_size.is_integer and then l_size.integer_value <= 0)
				then
					errors.force ("The parameter value for size should be greater than 0, the value " + l_size.value + " is not valid", "size")
				else
					set_size (l_size.integer_value)
				end
			end
		end

	validate_category (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `category' query parameter, if it's present should be greater or equal than 0, update the value to `category'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "category") and then
				attached {WSF_STRING} a_table_request.at ("category") as l_category
			then
				if
					not l_category.is_integer or else
					(l_category.is_integer and then l_category.integer_value < 0)
				then
					errors.force ("The parameter value for category should be greater than or equal 0, the value " + l_category.value + " is not valid", "category")
				else
					set_category (l_category.integer_value)
				end
			end
		end

	validate_status (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `status' query parameter, if it's present should be a value between 0..5, update the value to `status'
			-- feature, if there is an error, add it to errors.
		local
			ll_status: LIST [READABLE_STRING_32]
			ll_string_status: STRING_32
		do
			if a_current_keys.has ({STRING_32} "status") then
				if attached {WSF_MULTIPLE_STRING} a_table_request.at ("status") as l_status
				then
					status.wipe_out
					across l_status.values as c loop
				   		if
				   			c.item.is_integer and then
				   			(c.item.integer_value >= 0 and then c.item.integer_value < 6)
				   		then
				   			status.force (c.item.integer_value)
				   		else
				   			errors.force ("The parameter value for status " + c.item.value + " is not valid", "status_" + c.item.value )
				   		end
				   end
				elseif attached {WSF_STRING} a_table_request.at ("status") as l_status  then
					ll_string_status := l_status.value
					ll_string_status.replace_substring_all ("status=", "")
					ll_status := ll_string_status.split ('&')
					status.wipe_out
					across ll_status as c loop
						if
							 c.item.is_integer and then
							(c.item.to_integer >= 0 and then c.item.to_integer < 6)
						then
							status.force (c.item.to_integer)
						else
							errors.force ("The parameter value for status " + c.item + " is not valid", "status_" + c.item )
						end
					end
				end
			end
		end

	validate_orderby (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `orderBy' query parameter, if it's present should be a value present in `accetpable_order_by', update the value to `orderBy'
			-- feature, if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "orderBy") and then
				attached {WSF_STRING} a_table_request.at ("orderBy") as l_orderBy and then
				l_orderBy.is_string and then
				not l_orderBy.is_empty
			then
				if
					accetpable_order_by.has (l_orderBy.value)
				then
					set_orderby (l_orderBy.value)
				else
					errors.force ("The parameter value for orderBy " + l_orderBy.value + " is not valid", "orderBy")
				end
			end
		end

	validate_filter (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `filter' query parameter, if it's present not validation at the moment, update the value to `filter'
			-- feature.
		do
			if
				a_current_keys.has ({STRING_32} "filter") and then
				attached {WSF_STRING} a_table_request.at ("filter") as l_filter
			then
				set_filter (l_filter.value)
			end
		end

	validate_filter_content (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `filter_content' query parameter, if it's present should be 0 or 1, update the value to `filter_content'
			-- feature,if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "filter_content") and  then
				attached {WSF_STRING} a_table_request.at ("filter_content") as l_content
			then
				if not l_content.is_integer then
					errors.force ("The parameter value for filter_content=[" + l_content.value + "] is not valid", "content")
				elseif l_content.is_integer and then
				   ( l_content.integer_value > 1 or else l_content.integer_value < 0 )
				then
				   	errors.force ("The parameter value for filter_content should be between 0 and 1 the current value " + l_content.value + " is not valid", "content")
				else
					set_filter_content (l_content.integer_value)
				end
			end
		end

	validate_direction (a_current_keys: ARRAY [READABLE_STRING_GENERAL]; a_table_request: STRING_TABLE [WSF_VALUE])
			-- Validate `direction' query parameter, if it's present should be  `ASC|DESC' update the value to `direction'
			-- feature,if there is an error, add it to errors.
		do
			if
				a_current_keys.has ({STRING_32} "dir") and then
				attached {WSF_STRING} a_table_request.at ("dir") as l_dir and then
				l_dir.is_string and then
			   	not l_dir.is_empty
			then
				if
					l_dir.value.same_string ("ASC") or	l_dir.value.same_string ("DESC")
				then
					set_direction (l_dir.value)
				else
					errors.force ("The parameter value for dir " + l_dir.value + " is not valid", "dir")
				end
			end
		end

feature --Status Report

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
				create {ARRAYED_LIST [INTEGER]} status.make (3)
				put_status (1)
				put_status (2)
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

	set_category (a_category: INTEGER)
			-- Set `category' to `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
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
