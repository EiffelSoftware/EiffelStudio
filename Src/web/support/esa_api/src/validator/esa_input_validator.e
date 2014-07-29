note
	description: "Provide input validation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_INPUT_VALIDATOR

feature -- Basic Operations

	input_from (a_request: ITERABLE [WSF_VALUE])
			-- Update current object using parameters extracted from QUERY_STRING.
			-- If there are errors they are set to the errors parameter.
		do
			if attached {STRING_TABLE[WSF_VALUE]} a_request as l_table_request then
				validate (l_table_request)
			end
		end

feature -- Validation

	validate (a_request: STRING_TABLE [WSF_VALUE])
			-- Validate input for control `a_request'.
		deferred
		end


feature -- Access

	acceptable_query_parameters: ARRAY[STRING]
			-- The parameters are optionals, more parameters is a bad request, the order is not important.
		deferred
		end

	accetpable_order_by: ARRAY[STRING]
			-- acceptable values to sort the reports.	
		deferred
		end



end -- class EFA_INPUT_VALIDATOR
