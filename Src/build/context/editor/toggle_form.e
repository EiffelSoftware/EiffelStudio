indexing
	description: "Page representing the properties of a TOGGLE_B."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TOGGLE_FORM

inherit

	LABEL_TEXT_FORM
		rename
				create_widgets as label_text_form_create_widgets,
				attach_widgets as label_text_form_attach_widgets,
				reset as label_text_form_reset,
				apply as label_text_form_apply
		redefine
				context, form_number
		end
	LABEL_TEXT_FORM
		redefine
			create_widgets, attach_widgets, reset, apply, context, form_number
		select
			create_widgets, attach_widgets, reset, apply
		end

creation

	make

feature {NONE} -- Interface

	toggle_armed: EB_TOGGLE_B

	context: TOGGLE_B_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.toggle_att_form_nbr
		end

	Toggle_arm_cmd: TOGGLE_ARM_CMD is
		once
			!! Result
		end

feature -- Interface

	create_widgets is
		do
			label_text_form_create_widgets
			!! toggle_armed.make (Widget_names.toggle_armed_name, Current, Toggle_arm_cmd, editor)
		end

	attach_widgets is
		do
			label_text_form_attach_widgets
			attach_left (toggle_armed, 10)
			attach_top_widget (radio_box, toggle_armed, 10)
--			detach_bottom (toggle_armed)
		end

    reset is
        do
			label_text_form_reset
			toggle_armed.set_state (context.is_armed)
		end	

    apply is
        do
			label_text_form_apply
			if context.is_armed /= toggle_armed.state then
				context.set_is_armed (toggle_armed.state)
			end
        end

end
