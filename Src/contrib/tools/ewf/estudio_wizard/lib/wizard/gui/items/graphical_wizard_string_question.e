note
	description: "Summary description for {GWIZARD_STRING_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_STRING_QUESTION

inherit
	WIZARD_STRING_QUESTION
		undefine
			make
		end

	GRAPHICAL_WIZARD_QUESTION

create
	make

convert
	text: {STRING_32},
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	initialize
		local
			b: EV_VERTICAL_BOX
			lab: EV_LABEL
			l_field: like input_widget
		do
			create b
			b.set_padding_width (5)
			create lab.make_with_text (title)
			title_widget := lab
			apply_text_style (lab)
			b.extend (lab)
			b.disable_item_expand (lab)

			create l_field
			input_widget := l_field
			b.extend (l_field)
			b.disable_item_expand (l_field)

			if attached description as desc then
				create lab.make_with_text (desc)
				apply_field_description_style (lab)

				append_indented_widget (lab, b)
			end

			widget := b
		end

feature -- Access: UI

	widget: EV_VERTICAL_BOX

	input_widget: EV_TEXT_FIELD

	title_widget: detachable EV_LABEL

feature -- Conversion

	text: STRING_32
		do
			Result := input_widget.text
		end

	value: detachable STRING_32
		do
			Result := text
		end

feature -- Element change

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			set_value (t)
		end

	set_value (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				input_widget.set_text ("")
			else
				input_widget.set_text (v)
			end
		end

end
