note
	description: "Wizard linked text item"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PAGE_LINK_TEXT_ITEM

inherit
	GRAPHICAL_WIZARD_PAGE_ITEM


create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_GENERAL; a_uri: READABLE_STRING_8)
		do
			set_text (a_text)
			set_uri (a_uri)
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
			create lab.make_with_text (text)
			append_indented_widget (lab, b)
			--lab.select_actions.force (agent on_label_link_click)
			--lab.set_tooltip ("Command Line Options Help - see full-header option")
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

feature -- Access

	text: IMMUTABLE_STRING_32

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.
		do
			Result := text.to_string_8
		end

	uri: IMMUTABLE_STRING_8


feature -- Element change


	set_text (a_text: READABLE_STRING_GENERAL)
		do
			create text.make_from_string_general (a_text)
		end


	set_uri (a_uri: READABLE_STRING_8)
		do
			create uri.make_from_string (a_uri)
		end



end
