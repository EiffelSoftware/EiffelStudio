indexing
	description: "Creation of a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CONTEXT_CREATE_CMD 

inherit
	CONTEXT_CMD
		redefine
			redo, undo
		end

	WINDOWS

	SHARED_CONTEXT

create
	make

feature {NONE} -- History element

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_create_cmd_name
		end

feature -- Command

	destroy_widgets is
		do
			if not context.gui_object.destroyed then
				context.gui_object.destroy
			end
		end

	work is
			-- Do not record into history.
		do
			context.select_tree_element_if_parent_selected
		end

	undo is
		local
			group: LINKED_LIST [CONTEXT]
			a_parent: CONTEXT
		do
			if (command = Void) then
					-- First call
				if context.grouped then
						-- Cut only on context even if it is
						-- grouped with other contexts
					context.set_grouped (False)
					group := context.group
					group.start
					group.search (context)
					group.remove
				end
				a_parent := context.parent
				create command.make (context)
					-- work does not put the command in the history list
				command.work
-- 				if (a_parent = Void) then
-- 					if not Shared_window_list.empty then
-- 						tree.display (Shared_window_list.first)
-- 					else
-- 						tree.display (context)
-- 					end
-- 				else
-- 					tree.display (a_parent)
-- 				end
			else
				command.redo
			end
		end

	redo is
		do
			command.undo
		end

feature {NONE} -- Implementation

	command: CONTEXT_CUT_CMD

end -- class CONTEXT_CREATE_CMD

