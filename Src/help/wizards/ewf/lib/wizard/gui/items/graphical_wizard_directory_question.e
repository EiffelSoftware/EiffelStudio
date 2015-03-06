note
	description: "Summary description for {GRAPHICAL_WIZARD_DIRECTORY_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_DIRECTORY_QUESTION

inherit
	WIZARD_DIRECTORY_QUESTION
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

			create l_field.make
			l_field.set_browse_for_directory
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

	input_widget: EV_PATH_FIELD

	title_widget: detachable EV_LABEL

feature -- Conversion

	text: STRING_32
		do
			Result := input_widget.text
		end

	value: detachable PATH
		do
			Result := input_widget.file_path
		end

feature -- Element change

	set_text (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				set_value (Void)
			else
				set_value (create {PATH}.make_from_string (t))
			end
		end

	set_default_start_path (p: PATH)
		do
			input_widget.set_default_start_path (p)
		end

	set_value (p: like value)
		do
			if p = Void then
				input_widget.set_text ("")
			else
				input_widget.set_text (p.name)
			end
		end

end
