indexing
	description: "Page in the context catalog representing the %
				% group category."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class GROUP_PAGE 

inherit
	CONTEXT_CAT_PAGE
		redefine
			make
		end

	EV_COMMAND

	WINDOWS

	ERROR_POPUPER

creation
	make


feature {NONE} -- Initialization

	make (par: CONTEXT_CATALOG) is
		local
			hbox: EV_HORIZONTAL_BOX
 			group_hole: EV_BUTTON -- GROUP_HOLE
 			group_name: EV_LABEL
 			text: EV_TEXT_FIELD
			arrow_button: EV_BUTTON
			rout_cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_TEXT_FIELD]
		do
			create hbox.make (par)
 			create group_hole.make (hbox)
			group_hole.set_pixmap (Pixmaps.context_pixmap)
			group_hole.set_minimum_width (group_hole.pixmap.width + 10)
			group_hole.set_minimum_height (group_hole.pixmap.height + 10)
			group_hole.set_expand (False)
			group_hole.set_vertical_resize (False)
--			group_hole.set_background_color (background_color)
--
--			create group_name.make_with_text (vbox, Widget_names.group_name)
--			group_name.set_background_color (background_color)	
--			group_name.set_foreground_color (foreground_color)
 			create text.make (hbox)
			text.set_minimum_width (100)
			text.set_expand (False)

			create arrow_button.make_with_text (hbox, "<")
			arrow_button.set_expand (False)

			create toolbar.make_with_size (hbox, 30, 30)

			create arrow_button.make_with_text (hbox, ">")
			arrow_button.set_expand (False)

			par.append_page (hbox, tab_label)

				--| Callbacks
			create rout_cmd.make (~process_context)
			create arg.make (text)
			group_hole.add_pnd_command (Pnd_types.context_type, rout_cmd, arg)

 			text.add_return_command (Current, arg)

--			button.set_focus_string (Focus_labels.groups_label)
		end

feature -- Access

	clear is
			-- Clear the group page
		do
--			toolbar.destroy
		end

feature {NONE} -- Implementation

	build_interface is
		do
        end

	tab_label: STRING is
		do
			Result := Context_const.groups_name
		end

feature {GROUP_PAGE} -- Pick and Drop

	dropped_context: CONTEXT

	process_context (arg: EV_ARGUMENT1 [EV_TEXT_FIELD]; ev_data: EV_PND_EVENT_DATA) is
		local
			ctxt: CONTEXT
		do
			ctxt ?= ev_data.data
			if ctxt.is_able_to_be_grouped then
				dropped_context := ctxt
				arg.first.set_text (dropped_context.label)
			end
		end

	execute (arg: EV_ARGUMENT1 [EV_TEXT_FIELD]; ev_data: EV_PND_EVENT_DATA) is
		local
--			context_group: LINKED_LIST [CONTEXT]
--			new_group: GROUP
--			found: BOOLEAN
--			a_name: STRING
----			mp: MOUSE_PTR
--			a_group_c: GROUP_C
--			e_name: STRING
--			id: IDENTIFIER
		do
--			a_name := arg.first.text
--			a_name.to_upper
--			if not a_name.empty and then dropped_context /= Void then
--				if dropped_context.deleted then
--					set_label (" ")
--					dropped_context := Void
--				elseif not Context_catalog.has_group_name (a_name) then
--					create id.make (a_name.count)
--					id.append (a_name)
--					if id.is_valid then
----						!!mp
----						mp.set_watch_shape
--						if dropped_context.grouped then
--							create context_group.make
--							context_group.append (dropped_context.group)
--						else
--							create context_group.make
--							context_group.put_right (dropped_context)
--						end
--						a_group_c ?= dropped_context
--						if a_group_c = Void or else context_group.count /= 1 then
--							create new_group.make (a_name, context_group)
--							set_label (" ")
--						end
--						arg.first.set_text ("")
--						dropped_stone := Void
----						mp.restore
--					else
--						error_dialog.popup (Current,
--							Messages.invalid_group_class_name_er, a_name)
--					end
--				else
--					error_box.popup (Current,
--							Messages.group_name_exists_er, a_name)
--				end
--			end
		end

--feature {NONE} -- Error popuper
--
--	popuper_parent: EV_CONTAINER is
--		do
--			Result := main_window.context_catalog
--		end

end -- class GROUP_PAGE

