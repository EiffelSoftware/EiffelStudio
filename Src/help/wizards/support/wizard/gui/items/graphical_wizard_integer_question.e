note
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_INTEGER_QUESTION

inherit
	WIZARD_INTEGER_QUESTION
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

			set_validation (agent (pg: WIZARD_PAGE)
					do
						if not text.is_integer then
							pg.report_error ("Invalid value for field ["+ id +"]: must be an integer!")
						end
					end
				)

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

	value: INTEGER
		do
			if
				attached text as l_text and then
				l_text.is_integer
			then
				Result := l_text.to_integer
			end
		end

feature -- Element change

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (0)
			elseif t.is_integer then
				set_value (t.to_integer)
			end
		end

	set_value (v: INTEGER)
		do
			input_widget.set_text (v.out)
		end

end
