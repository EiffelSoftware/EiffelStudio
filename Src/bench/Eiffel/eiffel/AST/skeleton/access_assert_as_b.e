indexing

	description:
		"Abstract description of an access (argument or feature) in a %
		%precondition or a postcondition. It is necessary the first call %
		%in a nested expression. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ACCESS_ASSERT_AS_B

inherit

	ACCESS_ASSERT_AS
		rename
			feature_name as old_assert_feature_name,
			parameters as old_assert_parameters
		end;

	ACCESS_INV_AS_B
		rename
			access_type as feature_access_type
		end;

	ACCESS_INV_AS_B
		redefine
			access_type
		select
			access_type, parameters, feature_name
		end

feature

	access_type: TYPE_A is
			-- Type check an the access to an id
		local
			argument_position: INTEGER;
			last_type: TYPE_A;
				-- Type onto the stack
			last_id: INTEGER;
				-- Id of the class correponding to `last_type'
			local_b: LOCAL_B;
			argument_b: ARGUMENT_B;
			local_info: LOCAL_INFO;
			a_feature: FEATURE_I;
			vuar1: VUAR1;
			veen2b: VEEN2B
		do
			a_feature := context.a_feature;
				-- Look for an argument
			argument_position := a_feature.argument_position (feature_name);
			if argument_position /= 0 then
					-- Found argument
				last_type := context.item;
				last_id := context.last_class.id;
				Result ?= a_feature.arguments.i_th (argument_position);
				Result := Result.actual_type.instantiation_in
												(last_type, last_id);
				if parameters /= Void then
					!!vuar1;
					context.init_error (vuar1);
					vuar1.set_arg_name (feature_name);
					Error_handler.insert_error (vuar1);
				end;
				!!argument_b;
				argument_b.set_position (argument_position);
				context.access_line.insert (argument_b);
			else
					-- Look for a local if in a pre- or postcondition
				local_info := context.locals.item (feature_name);
				if local_info /= Void then
						-- Local found
					!!veen2B;
					context.init_error (veen2B);
					veen2B.set_identifier (feature_name);
					Error_handler.insert_error (veen2B);
				else
						-- Look for a feature
					Result := feature_access_type;
				end;
			end;
		end;
		
end -- class ACCESS_ASSERT_AS_B
