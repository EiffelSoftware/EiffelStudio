note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	GRAPHICAL_WIZARD_APPLICATION

inherit
	WIZARD_APPLICATION
		redefine
			initialize, on_generate, set_page
		end

	GRAPHICAL_WIZARD_STYLER

	EV_SHARED_APPLICATION

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create main
		end

	build_interface (a_container: EV_CONTAINER)
		do
			set_title (wizard.title)
			set_size (default_width, default_height)

			main.put (create {EV_LABEL}.make_with_text ("Loading ..."))
			a_container.extend (main)

			on_start
		end

feature -- UI change

	set_title (a_title: separate READABLE_STRING_GENERAL)
		deferred
		end

	set_size (w,h: INTEGER)
		deferred
		end

feature {NONE} -- Widget

	main: EV_CELL

feature -- Factory	

	new_page (a_page_id: READABLE_STRING_8): GRAPHICAL_WIZARD_PAGE
		local
			lab: EV_LABEL
		do
			create Result.make (a_page_id)
		end

	side_bar_items (a_page: WIZARD_PAGE): ARRAYED_LIST [WIZARD_PAGE_ITEM]
			-- Items to put on side bar for page `a_page'.
			-- None by default.
		do
			create Result.make (0)
		end

feature -- Change

	set_page (a_page: WIZARD_PAGE)
		local
			b: EV_VERTICAL_BOX
		do
			Precursor (a_page)
			create b
			append_page_to (a_page, b)
			b.set_data (a_page)
			main.replace (b)
		end

feature {NONE} -- Implementation: UI		

	append_page_to (a_page: WIZARD_PAGE; a_container: EV_CONTAINER)
		require
			a_container.extendible
		local
			box: EV_VERTICAL_BOX
			hb,hb2: EV_HORIZONTAL_BOX
			mb, vb, headerb: EV_VERTICAL_BOX
			lab: EV_LABEL
			but: EV_BUTTON
			cl: EV_CELL
			fr: detachable EV_FRAME
		do
			a_page.apply_data

			create box

				-- Main
			create hb
			box.extend (hb)

			if attached side_bar_items (a_page) as lst and then not lst.is_empty then
					-- ./Left sidebar
				create vb
				vb.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 180))
				vb.set_minimum_width (150)
				vb.set_border_width (10)
				vb.set_padding_width (5)
				across
					lst as ic
				loop
					if not vb.is_empty then
						vb.disable_item_expand (vb.last)
					end
					if attached {GRAPHICAL_WIZARD_PAGE_ITEM} ic.item as gpi then
						vb.extend (gpi.widget)
					end
				end
				vb.propagate_background_color
				hb.extend (vb)
				hb.disable_item_expand (vb)
			end

				-- Main part
			create mb
			hb.extend (mb)

			mb.set_background_color (colors.white)

			if a_page.has_header then
				create fr
				fr.set_background_color (colors.white)
				create headerb
				fr.extend (headerb)

				create vb
				headerb.extend (vb)
				vb.set_border_width (10)

				if attached a_page.title as l_title then
					create lab.make_with_text (l_title)
					apply_title_style (lab)
					vb.extend (lab)
					vb.disable_item_expand (lab)
					if attached a_page.subtitle as l_subtitle then
						create hb2
						create lab.make_with_text (l_subtitle)
						apply_subtitle_style (lab)
						create cl
						cl.set_minimum_width (vb.border_width)
						hb2.extend (cl)
						hb2.disable_item_expand (cl)
						hb2.extend (lab)
						vb.extend (hb2)
						vb.disable_item_expand (hb2)
					end
				end
				fr.propagate_background_color

				if attached a_page.reports as lst and then not lst.is_empty then
					create vb
					headerb.extend (vb)
					across
						lst as ic
					loop
						create lab.make_with_text (" - " + ic.item.message)
						if ic.item.type = {WIZARD_PAGE}.error_report_type then
							lab.set_background_color (color_light_red)
							lab.set_foreground_color (colors.red)
						elseif ic.item.type = {WIZARD_PAGE}.warning_report_type then
							lab.set_background_color (color_light_orange)
						else
							lab.set_background_color (color_light_green)
						end
						apply_report_style (lab)
						vb.extend (lab)
						vb.disable_item_expand (lab)
					end
				end

				mb.extend (fr)
				mb.disable_item_expand (fr)
				fr := Void
			end

				-- ./Text part
			create vb
			mb.extend (vb)
			vb.set_background_color (colors.default_background_color)
			vb.set_border_width (10)
			vb.set_padding (5)


			across
				a_page.items as ic
			loop
				if not vb.is_empty then
					vb.disable_item_expand (vb.last)
				end
				if attached page_item_to_widget (ic.item) as w then
					vb.extend (w)
				end
			end
			if a_page = wizard.first_page then
				create lab.make_with_text ("To continue, click [Next].")
				apply_text_style (lab)
				vb.extend (lab)
			end
			if a_page = wizard.final_page then
				create lab.make_with_text ("Click [Finish] to generate the project.")
				apply_text_style (lab)
				vb.extend (lab)
			end

				-- Buttons bar
			create fr
			box.extend (fr)
			box.disable_item_expand (fr)
			create hb
			fr.extend (hb)

			hb.set_border_width (10)
			hb.set_background_color (colors.default_background_color)
			hb.extend (create {EV_CELL})

			if a_page.previous_page /= Void then
				add_button_action_to ("< Back", agent on_back, hb)
			end
			if a_page = wizard.final_page then
				add_button_action_to ("Finish", agent on_finish, hb)
			else
				add_button_action_to ("Next >", agent on_next, hb)
			end


			create cl
			cl.set_minimum_width (hb.border_width)
			hb.extend (cl)
			hb.disable_item_expand (cl)

			add_button_action_to ("Cancel", agent on_cancel, hb)

			hb.propagate_background_color

			a_container.extend (box)

			a_page.reset_reports
		end

	page_item_to_widget (a_item: WIZARD_PAGE_ITEM): detachable EV_WIDGET
		local
			lab: EV_LABEL
		do
			if attached {GRAPHICAL_WIZARD_PAGE_ITEM} a_item as gpi then
				Result := gpi.widget
			elseif attached {WIZARD_PAGE_TEXT_ITEM} a_item as txt then
				create lab.make_with_text (txt.text)
				if txt.is_fixed_size then
					apply_fixed_size_text_style (lab)
				else
					apply_text_style (lab)
				end
				Result := lab
			elseif attached {WIZARD_PAGE_SECTION_ITEM} a_item as sect then
				create lab.make_with_text (sect.text)
				apply_section_style (lab)
				Result := lab
			end
		end

	add_button_actions_to (a_text: READABLE_STRING_GENERAL; a_sequence: ACTION_SEQUENCE [TUPLE]; a_box: EV_BOX)
		do
			if a_sequence.is_empty then
				add_button_action_to (a_text, Void, a_box)
			else
				add_button_action_to (a_text, agent a_sequence.call (Void), a_box)
			end
		end

	add_button_action_to (a_text: READABLE_STRING_GENERAL; a_action: detachable PROCEDURE; a_box: EV_BOX)
		local
			but: EV_BUTTON
		do
			create but.make_with_text (a_text)
			apply_button_style (but)
			a_box.extend (but)
			a_box.disable_item_expand (but)
			if a_action = Void then
				but.disable_sensitive
			else
				but.select_actions.extend (a_action)
			end
		end

--feature -- State		

--	current_page: detachable WIZARD_PAGE
--		do
--			if not page_history.is_empty then
--				Result := page_history.item
--			end
--		end

--	next_page (a_current_page: detachable WIZARD_PAGE): detachable WIZARD_PAGE
--		deferred
--		end

--	page_history: ARRAYED_STACK [WIZARD_PAGE]

feature -- Events

--	on_refresh
--		do
--			if attached current_page as pg then
--				pg.validate
--				data.record_page_data (pg.data, pg.page_id)
--				set_page (pg)
--			else
--				check refresh_expected: False end
--			end
--		end

--	on_back
--		do
--			if
--				attached current_page as pg and then
--				attached pg.previous_page as l_prev
--			then
--				pg.validate
--				data.record_page_data (pg.data, pg.page_id)
--				page_history.remove
--				page_history.remove
--				set_page (l_prev)
--			end
--		end

--	on_next
--		do
--			if attached current_page as pg then
--				pg.validate
--				if pg.has_error then
--					on_refresh
--				else
--					data.record_page_data (pg.data, pg.page_id)
--					if attached next_page (pg) as l_next_page then
--						set_page (l_next_page)
--					else
--						set_page (notfound_page)
--					end
--				end
--			else
--				set_page (notfound_page)
--			end
--		end

--	on_cancel
--		do
--			quit (Void) --"Cancelled")
--		end

	on_generate
		do
			Precursor
			ev_application.destroy
		end

--	on_finish
--		do
--			if attached current_page as pg then
--				if pg.has_error then
--					on_refresh
--				else
--					on_generate
----					ev_application.destroy
--				end
--			else
--				on_refresh
--			end
--		end

end
