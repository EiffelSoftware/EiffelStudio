indexing
	description:	
		"Window to enter arguments."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_COMMAND
		undefine
			default_create
		end
	EV_DIALOG
	EB_SHARED_INTERFACE_TOOLS
		undefine
			default_create
		end
	NEW_EB_CONSTANTS
		undefine
			default_create
		end

creation
	make_default
	
feature -- Initialization

	make_default (cmd: PROCEDURE [ANY, TUPLE]) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
			--| Use this in conjunction with `make_plain' to
			--| create a shared argument window.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			b: EV_BUTTON
			f: EV_FRAME
		do
			default_create

			create vb

			set_title (Interface_names.t_Argument_w)
			create f.make_with_text (Interface_names.l_Specify_arguments)
			vb.extend (f)
			create selection_text.make_with_text (Argument_list)
			f.extend (selection_text)

			create hb

			run := cmd
			if run /= Void then
				create b.make_with_text (Interface_names.b_Run)
				hb.extend (b)
				b.select_actions.extend (~execute (apply_and_run_it))
			end
			create b.make_with_text (Interface_names.b_Apply)
			hb.extend (b)
			b.select_actions.extend (~execute (apply_it))
			create b.make_with_text (Interface_names.b_Cancel)
			hb.extend (b)
			b.select_actions.extend (~execute (Void))
--			set_composite_attributes (Current)

			vb.extend (hb)
			extend (vb)

			show
		end

feature -- Properties

--	argument_list: STRING is
--		once
--			create Result.make (0)
--		end

	-- moved in EB_SHARED_INTERFACE_TOOLS

feature {NONE} -- Properties

	selection_text: EV_TEXT_FIELD

	apply_it, apply_and_run_it: ANY is
			-- Arguments for the command
		once
			create Result
		end

	run: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	execute (arg: ANY) is
		local
			arg_list: STRING
		do
			hide
			if arg /= Void then
					--| User selected "Run" or "Apply".
				arg_list := Argument_list
				arg_list.wipe_out
				arg_list.append (clone (selection_text.text))
					--| Trick for changing `Argument_list'
				if arg = Apply_and_run_it then
					run.call ([])
				end
			end
		end

end -- class EB_ARGUMENT_DIALOG
