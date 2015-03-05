note
	description: "Summary description for {GRAPHICAL_WIZARD_BOOLEAN_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_BOOLEAN_QUESTION

inherit
	WIZARD_BOOLEAN_QUESTION
		undefine
			make
		end

	GRAPHICAL_WIZARD_QUESTION

create
	make

convert
	text: {STRING_32},
	widget: {EV_WIDGET}

feature {NONE} -- Implementation

	initialize
		local
			b: EV_VERTICAL_BOX
			l_field: like input_widget
			lab: EV_LABEL
		do
			create b
			b.set_padding_width (5)
			create l_field.make_with_text (title)
			b.extend (l_field)
			b.disable_item_expand (l_field)

			if attached description as desc then
				create lab.make_with_text (desc)
				apply_field_description_style (lab)

				append_indented_widget (lab, b)
			end


			input_widget := l_field
			widget := b
		end

feature -- Access: UI

	widget: EV_VERTICAL_BOX

	input_widget: EV_CHECK_BUTTON

feature -- Conversion

	text: STRING_32
		do
			if input_widget.is_selected then
				Result := "yes"
			else
				Result := "no"
			end
		end

	value: BOOLEAN
		do
			Result := input_widget.is_selected
		end

feature -- Element change

	set_title (t: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (t)
			input_widget.set_text (t)
		end

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (False)
			else
				set_value (t.is_case_insensitive_equal ("yes"))
			end
		end

	set_value (b: BOOLEAN)
		do
			if b then
				input_widget.enable_select
			else
				input_widget.disable_select
			end
		end


end
