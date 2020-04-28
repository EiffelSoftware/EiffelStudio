note

	description:

		"Post process main C AST"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_POST_PARSER_PROCESSOR

inherit

	ANY

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

create

	make

feature {NONE}

	make (a_error_handler: EWG_ERROR_HANDLER)
		require
			a_error_handler_not_void: a_error_handler /= Void
		do
			error_handler := a_error_handler
		ensure
			error_handler_set: error_handler = a_error_handler
		end

feature {ANY} -- Basic Routines

	post_process
			-- Post process main C AST
		do
			if c_system.types.alias_types_count > 0 then
				error_handler.start_task ("phase 2: resolving aliases for anonymous types")
				error_handler.set_current_task_total_ticks (c_system.types.alias_types_count)
				resolve_aliases_for_anonymous_types
				error_handler.stop_task
			end
		end

feature {NONE}

	resolve_aliases_for_anonymous_types
			-- For all anonymous types find an alias
		local
			cs: DS_HASH_TABLE_CURSOR [EWG_C_AST_ALIAS_TYPE, STRING]
		do
			from
				cs := c_system.types.new_alias_cursor
				cs.start
			until
				cs.off
			loop
				if
					not c_system.builtin_types.has (cs.item) and
						not c_system.builtin_types.has (cs.item.base)
				then
					-- Now walk down the base-chain and set `cs.item' to be the closest alias
					-- unless the type in question has a better alias already.
					set_closest_alias (cs.item, cs.item.base)
				end
				cs.forth
				error_handler.tick
			end
		end

	set_closest_alias (a_top_alias_type: EWG_C_AST_ALIAS_TYPE; a_base: EWG_C_AST_TYPE)
		require
			a_top_alias_type_not_void: a_top_alias_type /= Void
			a_base_not_void: a_base /= Void
			a_top_alias_type_has_base_indirect: a_top_alias_type.has_type_as_base_indirect (a_base)
		do
			if attached {EWG_C_AST_BASED_TYPE} a_base as closer_based_type then
				set_closest_alias (a_top_alias_type, closer_based_type.base)
			end

			if a_base.closest_alias_type = Void or else
				a_top_alias_type.number_of_pointer_or_arrays_between_current_and_type (a_base) < a_base.closest_alias_type_quality
			then
				a_base.set_closest_alias_type (a_top_alias_type)
			end
		end

feature {NONE} -- Implementation

	error_handler: EWG_ERROR_HANDLER

invariant

	error_handler_not_void: error_handler /= Void

end
