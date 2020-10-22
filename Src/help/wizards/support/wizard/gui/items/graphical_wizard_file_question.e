note
	description: "Summary description for {GRAPHICAL_WIZARD_FILE_QUESTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_FILE_QUESTION


inherit
	GRAPHICAL_WIZARD_DIRECTORY_QUESTION
		redefine
			initialize
		end

create
	make

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
			l_field.set_browse_for_open_file ("")
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

end
