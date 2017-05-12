note
	description: "Determines if ROUTINE and TUPLE objects are valid for import."
	author: "Roman Schmocker"
	updated_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_IMPORT_VALIDATOR

inherit
	REFACTORING_HELPER

feature -- Status report

	is_tuple_importable (tuple: separate TUPLE): BOOLEAN
			-- Is `tuple' importable?
			-- A tuple is safely importable if it only contains
			-- basic types or truly separate references.
		local
			l_index: INTEGER
			l_count: INTEGER
		do
			from
				l_index := 1
				l_count := tuple.count
				Result := True
			until
				l_index > l_count or not Result
			loop
				if tuple.is_reference_item (l_index) then
					Result := Result and c_is_tuple_item_separate (tuple, l_index)
				end
				l_index := l_index + 1
			variant
				l_count + 2 - l_index
			end
		end

	is_agent_importable (a_routine: separate ROUTINE): BOOLEAN
			-- Is `a_routine' importable?
		local
			routine_access: CP_ROUTINE_ACCESS
		do
				-- First check if the basic requirements hold.			
			if is_agent_unsafe_importable (a_routine) then

					-- Workaround for restricted export in ROUTINE...
				create routine_access

					-- All closed arguments must be either of a basic type or truly separate.
				if attached routine_access.get_closed_operands (a_routine) as l_operands then
					Result := is_tuple_importable (l_operands)
				else
						-- No closed arguments means nothing can go wrong.
					Result := True
				end
			end
		ensure then
			correct_relation: Result implies is_agent_unsafe_importable (a_routine)
		end

	is_agent_unsafe_importable (a_routine: separate ROUTINE): BOOLEAN
			-- Is `a_routine' ready for an unsafe import?
		local
			l_operands_void: BOOLEAN
			l_target_open: BOOLEAN
			l_no_result: BOOLEAN
		do
				-- There should not be any open operands from a previous invocation.
			l_operands_void := not attached a_routine.operands

				-- The target must be open.
			l_target_open := not a_routine.is_target_closed

				-- There should not be a result from a previous invocation.
			if attached {separate FUNCTION [ANY]} a_routine as a_function then
				l_no_result := is_function_result_void (a_function)
			else
				l_no_result := True
			end

			Result := l_operands_void and l_target_open and l_no_result
		ensure
			no_open_operands: Result implies a_routine.operands = Void
			open_target: Result implies not a_routine.is_target_closed
		end

feature {NONE} -- Implementation

	reflector: REFLECTOR
			-- A reflector instance.
		attribute create Result	end

	is_function_result_void (a_function: separate FUNCTION [ANY]): BOOLEAN
			-- Is `a_function.last_result' Void?
		do
			if attached a_function.last_result as res then
					-- It may be an expanded type.
				Result := reflector.type_of_type ({ISE_RUNTIME}.dynamic_type (res)).is_expanded
			else
				Result := True
			end
		end

	c_is_tuple_item_separate (a_tuple: separate TUPLE; a_index: INTEGER): BOOLEAN
			-- Is `a_tuple[a_index]' truly separate from  `a_tuple'?
		require
			valid_index: 1 <= a_index and a_index <= a_tuple.count
			reference_item: a_tuple.is_reference_item (a_index)
		external
			"C inline use  %"eif_rout_obj.h%", %"eif_macros.h%""
		alias
			"[
				EIF_REFERENCE l_tuple;
				EIF_REFERENCE l_item;
				EIF_BOOLEAN l_result;
				
					/* Get the unprotected reference to `a_tuple' */
				l_tuple = eif_access ($a_tuple);
				
					/* Load the Eiffel object at `a_tuple[index]' */
				l_item = eif_reference_item(l_tuple, $a_index);

					/* l_item may be Void */
				if (l_item) {
						/* Check if the processor ID is different. */
					l_result = RTS_OS (l_tuple, l_item);
				}
				else {
					l_result = EIF_FALSE;
				}
				return l_result;
			]"
		end

end
