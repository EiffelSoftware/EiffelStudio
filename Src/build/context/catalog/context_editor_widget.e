indexing
	description: "Context editor that is displayed on the %
				% main panel."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_EDITOR_WIDGET

inherit
	EV_VERTICAL_BOX
		redefine
			make, destroy--, raise
		end

	CONTEXT_EDITOR
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			hbox: EV_HORIZONTAL_BOX
			tbar: EV_TOOL_BAR
		do
			{EV_VERTICAL_BOX} Precursor (par)
			create hbox.make (Current)
			hbox.set_expand (False)
			create tbar.make (hbox)
			create context_hole.make (tbar)
			create context_editor_label.make_with_text (hbox, "Context editor")
			{CONTEXT_EDITOR} Precursor (Current)
		end

	set_values is
		do
			update_title
		end

feature -- Access

--	raise is
--		do
--			main_window.raise
--		end

	destroy is
		do
			clear
			{EV_VERTICAL_BOX} Precursor
		end

	set_icon_name (a_name: STRING) is
		do
		end

	set_title (a_title: STRING) is
		do
			context_editor_label.set_text (a_title)
		end

	update_title is
		local
			tmp: STRING
		do
			if edited_context = Void then
				set_title ("Empty context editor")
			else
				create tmp.make (15)
				tmp.append (edited_context.label)
				set_title (tmp)
			end
		end

feature {NONE} -- Attribute

	context_editor_label: EV_LABEL
		-- Label displaying the name of `edited_context'

end -- class CONTEXT_EDITOR_WIDGET

