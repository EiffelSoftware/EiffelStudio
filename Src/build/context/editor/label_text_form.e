indexing
	description: "Page representing the properties of a LABEL."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class LABEL_TEXT_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation
	
	make

feature {NONE} -- Interface

	text: EB_TEXT_FIELD

	forbid_recomp: EB_TOGGLE_B

	center_alignment, left_alignment: EB_TOGGLE_B

	context: LABEL_TEXT_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.label_text_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	Label_alignment_cmd: LABEL_ALIGNMENT_CMD is
		once
			!!Result
		end

	Label_resize_cmd: LABEL_RESIZE_CMD is
		once
			!!Result
		end

	Label_text_cmd: LABEL_TEXT_CMD is
		once
			!!Result
		end

feature -- Interface
	
	label: LABEL
	radio_box: RADIO_BOX

	create_widgets is
		do
            !!label.make (Widget_names.text_label_name, Current)
            !!text.make (Widget_names.textfield, Current, Label_text_cmd,
                        editor)
            !!forbid_recomp.make (Widget_names.forbid_recomp_size_name,
                        Current, Label_resize_cmd, editor)
            !!radio_box.make (Widget_names.radio_box, Current)
            !!left_alignment.make (Widget_names.left_alignment_name,
                        radio_box, Label_alignment_cmd, editor)
            !!center_alignment.make (Widget_names.center_alignment_name,
                        radio_box, Label_alignment_cmd, editor)
		end

	set_values is
		do
			left_alignment.arm
			radio_box.set_always_one (True)
		end

	attach_widgets is 
		do
            attach_left (label, 10)
            attach_right (text, 10)
			attach_right_widget (text, label, 5)
--            attach_left (text, 100)

            attach_left (forbid_recomp, 10)
            attach_left (radio_box, 10)

            attach_top (text, 10)
            attach_top (label, 10)
            attach_top_widget (text, forbid_recomp, 10)
            attach_top_widget (forbid_recomp, radio_box, 10)
			attach_bottom (radio_box, 0)
--            detach_bottom (radio_box)
		end

	make_visible (a_parent: COMPOSITE) is
		do
			initialize (Widget_names.label_text_form_name, a_parent)
			create_widgets
			set_values
			attach_widgets
			show_current
		end

	reset is
		do
			text.set_text (context.text)
			forbid_recomp.set_state (context.resize_policy_disabled)
			left_alignment.set_state (context.left_alignment)
			center_alignment.set_state (not context.left_alignment)
		end

	apply is
		do
			if context.resize_policy_disabled /= forbid_recomp.state then
				context.disable_resize_policy (forbid_recomp.state)
			end
			if context.left_alignment /= left_alignment.state then
				context.set_left_alignment (left_alignment.state)
			end
			if context.text = Void 
				or else not equal (text.text, context.text) then
				context.set_text (text.text)
			end
		end

end
