note
	description:
		"[
		Importer for agent objects.
		
		Note: Due to the use of reflection, the agent has tu fulfill 
		some requiremets:

		1)  Every closed argument has to be either truly separate or a basic
			expanded type. It is NOT sufficient to just declare the argument
			as separate, as this cannot	be checked due to a runtime limitation.

		2)  The target must be open. A target always has to be non-separate,
			and we can't import arbitrary reference objects.

		3)  There must not be any leftovers from a previous call,
			i.e. `operands' and {FUNCTION}.last_result must be Void.
		
		The creation procedure `make_unsafe' does not check rule (1). If you 
		use it, make sure that every closed argument is declared as separate.
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_AGENT_IMPORTER

inherit

	CP_IMPORTER [ROUTINE]
		undefine
			is_importable
		end

	CP_IMPORT_VALIDATOR
		rename
			is_agent_importable as is_importable,
			is_agent_unsafe_importable as is_unsafe_importable
		end

	REFLECTOR_CONSTANTS

feature -- Basic operations

	import (routine: separate ROUTINE): ROUTINE
			-- Import `routine' by creating a copy on the local processor.
		do
			Result := do_import (routine)
		end

	unsafe_import (routine: separate ROUTINE): ROUTINE
			-- Import `routine' by creating a copy on the local processor.
			-- Note: This function is dangerous, as it may introduce traitors or Void calls.
			-- Make sure you follow these two rules:
			--- All closed arguments are either expanded or declared as separate.
			--- The agent must never access its target (i.e. no implicit or explicit use of Current).
		require
			unsafe_importable: is_unsafe_importable (routine)
		do
			Result := do_import (routine)
		end


feature {NONE} -- Implementation

	do_import (routine: separate ROUTINE): ROUTINE
			-- Import `routine'.
		require
			unsafe_importable: is_unsafe_importable (routine)
		local
			reflected_agent: REFLECTED_REFERENCE_OBJECT
			tuple_importer: CP_TUPLE_IMPORTER

			type_id: INTEGER
			i: INTEGER

			integer_field: INTEGER
			boolean_field: BOOLEAN
			pointer_field: POINTER
			reference_field: detachable separate ANY

			l_closed_operands: TUPLE
		do
			fixme ("It may be possible to weaken the harsh precondition a bit: %
				% {ROUTINE}.operands and {FUNCTION}.last_result may be attached - we can just ignore them. %
				% However, this implies that we need to compare attribute names (i.e. strings) here.")

			type_id := {ISE_RUNTIME}.dynamic_type (routine)

				-- Should succeed because `type_id' is a valid type.
			check attached {ROUTINE [ANY]} reflector.new_instance_of (type_id) as res then
				Result := res
			end

			from
				create reflected_agent.make (Result)
				create tuple_importer
				i := 1
			until
				i > reflector.field_count_of_type (type_id)
			loop

				inspect
					reflector.field_type_of_type (i, type_id)

					-- Copy `open_count', `routine_id' and `written_type_id_inline_agent'.
				when integer_32_type then
					integer_field := {ISE_RUNTIME}.integer_32_field (i, $routine, 0)
					reflected_agent.set_integer_32_field (i, integer_field)

					-- Copy `is_basic' and `is_target_closed'.
				when boolean_type then
					boolean_field := {ISE_RUNTIME}.boolean_field (i, $routine, 0)
					reflected_agent.set_boolean_field (i, boolean_field)

					-- Copy `calc_rout_addr', `encaps_rout_disp' and `rout_disp'.
				when pointer_type then
					pointer_field := {ISE_RUNTIME}.pointer_field (i, $routine, 0)
					reflected_agent.set_pointer_field (i, pointer_field)

					-- Import `open_map', `open_types' and `closed_operands'.
				when reference_type then
					reference_field := {ISE_RUNTIME}.reference_field (i, $routine, 0)

						-- Import `open_map' and `open_types'.
					if attached {separate ARRAY[INTEGER]} reference_field as array then
						reflected_agent.set_reference_field (i, import_array (array))

						-- Import `closed_operands'.
						-- The attribute `operands' cannot fall into this branch - it is
						-- Void because of the precondition.
					elseif attached {separate TUPLE} reference_field as tuple then
						l_closed_operands := tuple_importer.unsafe_import (tuple)
						reflected_agent.set_reference_field (i, l_closed_operands)

					else
							-- The remaining items could be `operands' and `{FUNCTION}.last_result'.
							-- Both of them must be Void.
						check no_more_items: reference_field = Void end
					end
				else
						-- The above inspect statement should cover all attributes, except maybe `{FUNCTION}.last_result'.
						-- If this check fails, something in ROUTINE or its descendants has changed.
					check only_last_result: reflected_agent.field_name (i) ~ "last_result" end
				end
				i := i + 1
			end
		end

	import_array (array: separate ARRAY [INTEGER]): ARRAY [INTEGER]
			-- Import an integer array.
		local
			min, max: INTEGER
			i: INTEGER
		do
			min := array.lower
			max := array.upper
			create Result.make_filled (-1, min, max)

			from
				i := min
			until
				i > max
			loop
				Result [i] := array [i]
				i := i + 1
			end
		end

end
