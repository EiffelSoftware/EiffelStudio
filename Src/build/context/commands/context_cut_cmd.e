indexing
	description: "Destroy a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CONTEXT_CUT_CMD 

inherit

	WINDOWS

	CONTEXT_CMD
		redefine
			undo, redo
		end

	SHARED_APPLICATION

create
	make

feature {GROUP_CMD, HISTORY_WINDOW}

	destroy_widgets is
			-- This is called by the history mechanism 
			-- before it is removed from the list so 
			-- the contexts can free the external widgets.
		do
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.gui_object.destroy
				context_list.forth
			end
		end

feature {GROUP_CMD}

	context_list: LINKED_LIST [CONTEXT]

feature {NONE}

	set_parent_contexts: LINKED_LIST [CONTEXT]
		-- Contexts deleted

--	behavior_cut_list: LINKED_LIST [FUNC_CUT]
--		-- List of commands to remove behavior from state
--		-- for `context'

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_cut_cmd_name
		end

	parent: HOLDER_C

feature 

	work is
			-- Do not record into history.
		local
--			state: BUILD_STATE
--			func_cut: FUNC_CUT
		do
			parent ?= context.parent
			if context.parent = Void or else not context.is_in_a_group then
					-- a group can be destroyed but not its content
				create context_list.make
				create set_parent_contexts.make
				if context.grouped then
					set_parent_contexts.merge_right (context.group)
					from
						set_parent_contexts.start
					until
						set_parent_contexts.after
					loop
						context_list.merge_right 
								(set_parent_contexts.item.cut_list)
						set_parent_contexts.forth
					end
				else
					context_list.merge_right (context.cut_list)
					set_parent_contexts.put_front (context)
				end
--				!! behavior_cut_list.make
--				from
--					Shared_app_graph.start
--				until
--					Shared_app_graph.after
--				loop
--					state ?= Shared_app_graph.key_for_iteration
--					func_cut ?= state.remove_line_command_for_context (context)
--					if func_cut /= Void then
--						behavior_cut_list.put_front (func_cut)
--						func_cut.execute (state)
--					end
--					Shared_app_graph.forth
--				end
				redo
			else
				failed := True
			end
		end

	undo is
		do
			from
				set_parent_contexts.start
			until
				set_parent_contexts.after
			loop
				set_parent_contexts.item.set_parent (parent)
				set_parent_contexts.forth
			end
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.undo_cut
				context_list.forth
			end
--			from
--				behavior_cut_list.start
--			until
--				behavior_cut_list.after
--			loop
--				behavior_cut_list.item.undo
--				behavior_cut_list.forth
--			end
--			tree.display (context)
		end

	redo is
			-- Used for redo	
		do
--			from
--				behavior_cut_list.start
--			until
--				behavior_cut_list.after
--			loop
--				behavior_cut_list.item.redo
--				behavior_cut_list.forth
--			end
				-- Start from the children
			from
				context_list.finish
			until
				context_list.before
			loop
				context_list.item.cut
				context_list.back
			end
			from
				set_parent_contexts.start
			until
				set_parent_contexts.after
			loop
				set_parent_contexts.item.set_parent (Void)
				set_parent_contexts.forth
			end
--			if parent = Void then
--				tree.display (context)
--			else
--				tree.display (parent)
--			end
		end

end -- class CONTEXT_CUT_CMD

