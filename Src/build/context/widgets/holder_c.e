indexing
	description: "Context that can hold children inside it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HOLDER_C

inherit
	CONTEXT
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags,
			is_able_to_be_grouped
		end
			
feature -- EB Tree access

	append (a_child: CONTEXT) is
		do
			child_finish
			put_child_right (a_child)
		end

feature {HOLDER_C}-- Pick and drop target

	process_type (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Create a new child context for the current container.
		local
--			group_stone: GROUP_ICON_STONE
--			type_data: TYPE_DATA
			ctxt_type: CONTEXT_TYPE [CONTEXT]
			ctxt: CONTEXT
		do
			if not is_in_a_group and then not is_a_group then
--				type_stone ?= dropped
--				group_stone ?= type_stone
--				if group_stone /= Void then
--					type_stone := group_stone.data
--				end
				ctxt_type ?= ev_data.data
				check
					valid_context_type: ctxt_type /= Void
				end
				if ctxt_type.is_valid_parent (Current) then
					ctxt := ctxt_type.create_context (Current)
					if ctxt /= Void then
						ctxt.show
					end
				end
			end
		end

	process_created_context (a_context: CONTEXT; lx, ly: INTEGER) is
		do
			if a_context /= Void then
				if a_context.parent /= Void
				and then a_context.parent.is_fixed
				then
					a_context.set_position (lx, ly)
				end
--				tree.display (a_context)
			end
		end

	process_context (arg: EV_ARGUMENT; event_data: EV_PND_EVENT_DATA) is
		local
			ctxt: CONTEXT
			dropped_ctxt: CONTEXT
			window_c: WINDOW_C
		do
			if not is_in_a_group and then not is_a_group then
				dropped_ctxt ?= event_data.data
				if not dropped_ctxt.is_perm_window then
					ctxt := dropped_ctxt.create_context (Current)
				end
				process_created_context (ctxt, event_data.x, event_data.y)
			end
		end

end -- class HOLDER_C

