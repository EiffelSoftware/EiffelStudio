indexing
	description: "Dialog to choose or build a dynamic library file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOOSE_DYNAMIC_LIB_DIALOG

inherit
	EV_DIALOG

	EV_COMMAND
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

creation
	make_default

feature {NONE} -- Initialization

	make_default (a_caller: like caller; t: STRING; msg: STRING) is
		local
			i: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create vb
			create hb
			hb.set_padding (4)
			hb.enable_homogeneous
			caller := a_caller
			default_create
			set_title (t)
			create label.make_with_text (msg)
			vb.extend (label)
			create i.make_with_text (Interface_names.b_Browse)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (~execute (Browse_it))
			create i.make_with_text (Interface_names.b_Default)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (~execute (Build_it))
			create i.make_with_text (Interface_names.b_Cancel)
			hb.extend (i)
			hb.disable_item_expand (i)
			i.select_actions.extend (~execute (Void))
			vb.extend (hb)
			extend (vb)
			disable_user_resize
			show_modal
		end

feature {NONE} -- Execution

	execute (arg: ANY) is
		do
			destroy
			if arg = Browse_it then
				caller.load_chosen
			elseif arg = Build_it then
				caller.load_default
			end
		end

feature {NONE} -- Implementation

	Browse_it: ANY is
		once
			create Result
		end

	Build_it: ANY is
		once
			create Result
		end

	label: EV_LABEL

	caller: EB_SHOW_DYNAMIC_LIB_WINDOW_COMMAND

end -- class EB_CHOOSE_DYNAMIC_LIB_DIALOG
