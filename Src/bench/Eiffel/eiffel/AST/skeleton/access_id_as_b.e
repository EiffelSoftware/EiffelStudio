-- Abstract description of an access (local, argument or feature). It is
-- necessary the first call in a nested expression.

class ACCESS_ID_AS

inherit

	ACCESS_INV_AS
		rename
			access_type as feature_access_type
		end;
	ACCESS_INV_AS
		redefine
			access_type
		select 
			access_type
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
			error_found: BOOLEAN;
			vuex1: VUEX1;
			veen2B: VEEN2B;
		do
			last_type := context.item;
			last_id := context.last_class.id;

			a_feature := context.a_feature;
				-- Look for an argument
			argument_position := a_feature.argument_position (feature_name);
			if argument_position /= 0 then
					-- Found argument
				Result ?= a_feature.arguments.i_th (argument_position);
				Result := Result.actual_type.instantiation_in
													(last_type, last_id);
				error_found := parameters /= Void;
				!!argument_b;
				argument_b.set_position (argument_position);
				context.access_line.insert (argument_b);
			else
					-- Look for a local if not in a pre- or postcondition
				local_info := context.locals.item (feature_name);
				if local_info /= Void then
						-- Local found
					error_found := parameters /= Void;
					Result := local_info.actual_type;
					Result := Result.actual_type.instantiation_in
													(last_type, last_id);
					!!local_b;
					local_b.set_position (local_info.position);
					context.access_line.insert (local_b);
		
					if context.level1 or else context.level4 then
							-- Local in post- or precondition
						!!veen2B;
						context.init_error (veen2B);
						veen2B.set_identifier (feature_name);
						Error_handler.insert_error (veen2B);
					end;
				else
						-- Look for a feature
					Result := feature_access_type;
				end;
			end;
			if error_found then
				!!vuex1;
				context.init_error (vuex1);
				vuex1.set_access (Current);
				Error_handler.insert_error (vuex1);
			end;
		end;
		
end
