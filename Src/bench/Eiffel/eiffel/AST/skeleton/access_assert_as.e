indexing
	description:
		"Abstract description of an access (argument or feature) in a %
		%precondition or a postcondition. It is necessary the first call %
		%in a nested expression. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_ASSERT_AS

inherit
	ACCESS_INV_AS
		redefine
			process,
			access_type, is_argument
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_assert_as (Current)
		end

feature -- Access

    is_argument: BOOLEAN is
            -- Is this an access to an argument
        do
            Result := context.current_feature.argument_position (feature_name) /= 0
        end

	access_type: TYPE_A is
			-- Type check an the access to an id
		local
			argument_position: INTEGER
			last_type: TYPE_A
				-- Type onto the stack
			last_id: INTEGER
				-- Id of the class correponding to `last_type'
			argument_b: ARGUMENT_B
			local_info: LOCAL_INFO
			a_feature: FEATURE_I
			vuar1: VUAR1
			veen2b: VEEN2B
		do
			a_feature := context.current_feature
				-- Look for an argument
			argument_position := a_feature.argument_position (feature_name)
			if argument_position /= 0 then
					-- Found argument
				last_type := context.item
				last_id := context.last_class.class_id
				Result ?= a_feature.arguments.i_th (argument_position)
				Result := Result.actual_type.instantiation_in
												(last_type, last_id)
				if parameters /= Void then
					create vuar1
					context.init_error (vuar1)
					vuar1.set_arg_name (feature_name)
					vuar1.set_location (feature_name)
					Error_handler.insert_error (vuar1)
				end
				create argument_b
				argument_b.set_position (argument_position)
				context.access_line.insert (argument_b)
			else
					-- Look for a local if in a pre- or postcondition
				local_info := context.locals.item (feature_name)
				if local_info /= Void then
						-- Local found
					create veen2b
					context.init_error (veen2b)
					veen2b.set_identifier (feature_name)
					veen2b.set_location (feature_name)
					Error_handler.insert_error (veen2b)
				else
						-- Look for a feature
					Result := Precursor {ACCESS_INV_AS}
				end
			end
		end
		
end -- class ACCESS_ASSERT_AS
