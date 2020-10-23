note
	description: "Summary description for {GRAPHICAL_WIZARD_PAGE_LINK_TEXT_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_PAGE_LINK_TEXT_ITEM

inherit
	WIZARD_PAGE_LINK_TEXT_ITEM
		redefine
			make
		end

	GRAPHICAL_WIZARD_PAGE_ITEM

	GRAPHICAL_WIZARD_STYLER

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_GENERAL; a_uri: READABLE_STRING_8)
		do
			Precursor (a_text, a_uri)
			initialize
		end

feature {NONE} -- Implementation

	initialize
		local
			b: EV_VERTICAL_BOX
			lab: EV_LINK_LABEL
		do
			create b
			b.set_padding_width (5)
--			create {EV_HIGHLIGHT_LINK_LABEL} lab.make_with_text (text)
			create {EV_LINK_LABEL} lab.make_with_text (text)
			apply_link_style (lab)
			append_indented_widget (lab, b)
			widget := b
			lab.select_actions.force (agent on_label_link_click)
		end

	append_indented_widget (w: EV_WIDGET; a_container: EV_BOX)
		local
			hb: EV_HORIZONTAL_BOX
		do
			create hb
			append_cell_to (20, hb)

			hb.extend (w)
			hb.disable_item_expand (w)

			a_container.extend (hb)
			a_container.disable_item_expand (hb)
		end


	append_cell_to (a_size: INTEGER; a_container: EV_BOX)
		local
			cl: EV_CELL
		do
			create cl
			if attached {EV_HORIZONTAL_BOX} a_container then
				cl.set_minimum_width (a_size)
			else
				cl.set_minimum_height (a_size)
			end
			a_container.extend (cl)
			a_container.disable_item_expand (cl)
		end

	on_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch (uri).do_nothing
		end

feature -- Access: UI

	widget: EV_VERTICAL_BOX

end
