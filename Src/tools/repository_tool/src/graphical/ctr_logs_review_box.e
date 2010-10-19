note
	description: "Summary description for {CTR_LOGS_REVIEW_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_LOGS_REVIEW_BOX

inherit
	ANY

	CTR_SHARED_RESOURCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: CTR_LOGS_TOOL)
		do
			logs_tool := a_tool
			create user_name.make_empty
			build_interface
		end

	build_interface
		local
			b: EV_HORIZONTAL_BOX
			tb: SD_TOOL_BAR
			tbb: SD_TOOL_BAR_BUTTON
			tbtb: SD_TOOL_BAR_TOGGLE_BUTTON
			tbdpb: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			lab: EV_LABEL
		do
			create b
			widget := b
			b.set_minimum_height (32)
			b.set_border_width (2)

			create tb.make
			tool_bar := tb
			create tbtb.make
			tbtb.set_text ("Approve")
			tb.extend (tbtb)
			button_approve := tbtb
			tbtb.select_actions.extend (agent on_approve)

			create tbtb.make
			tbtb.set_text ("Refuse")
			tb.extend (tbtb)
			button_refuse := tbtb
			tbtb.select_actions.extend (agent on_refuse)

			create tbdpb.make
			tbdpb.set_text ("Questions")
			tb.extend (tbdpb)
--			tbdpb.set_dropdown_pixel_buffer (icons.dropdown_pixel_buffer)
			tbdpb.set_popup_widget_function (agent on_questions_popup_widget (True))
--			tbdpb.select_actions.extend (agent on_questions_popup_widget (False))
			button_questions := tbdpb

--			create tbtb.make
--			tbtb.set_text ("Comment")
--			tb.extend (tbtb)
--			tbtb.select_actions.extend (agent on_question)
--			button_question := tbtb

			create tbb.make
			tbb.set_text ("Submit")
			tbb.select_actions.extend (agent on_submit)
			tb.extend (tbb)
			button_submit := tbb

			create lab.make_with_text ("Review #")
			lab.pointer_double_press_actions.extend (agent on_review_hack)
			b.extend (lab)
			b.disable_item_expand (lab)
			create log_id_lab.make_with_text ("...")
			b.extend (log_id_lab)
			b.disable_item_expand (log_id_lab)

			b.extend (create {EV_CELL})
			b.extend (tb)
			b.disable_item_expand (tb)

			tb.compute_minimum_size

			b.set_background_color (colors.yellow)
			b.propagate_background_color
		end

feature -- Access

	widget: EV_BOX

	logs_tool: CTR_LOGS_TOOL

	current_log: detachable REPOSITORY_LOG

	user_name: STRING


	tool_bar: SD_TOOL_BAR
	log_id_lab: EV_LABEL
	button_approve: SD_TOOL_BAR_TOGGLE_BUTTON
	button_refuse: SD_TOOL_BAR_TOGGLE_BUTTON
--	button_question: SD_TOOL_BAR_TOGGLE_BUTTON
	button_questions: SD_TOOL_BAR_DUAL_POPUP_BUTTON
	button_submit: SD_TOOL_BAR_BUTTON

feature -- Event

--	review: detachable REPOSITORY_LOG_REVIEW

	on_review_hack (ax, ay, abut: INTEGER; r1,r2,r3: REAL_64; i1,i2:INTEGER_32)
		local
			pop: EV_DIALOG
			vb: EV_VERTICAL_BOX
			but: EV_BUTTON
			evs: EVS_HELPERS
		do
			if
				attached current_log as l_log and then
				attached l_log.parent.review_client as l_client
			then
				-- Remote call !!!
--					console_log ("Submit review [" + l_log.id + "]")
--					l_client.submit (l_log, l_review)
--					if l_client.last_error_occurred then
--						console_log_error ("Error during review submission [" + l_log.id + "]: " + l_client.last_error_to_string)
----						print (l_client.last_error_to_string + "%N")
--					end
--				end


				create pop.make_with_title ("Review Hack")
				create vb
				pop.extend (vb)
				create but.make_with_text_and_action ("Close", agent pop.destroy)
				pop.set_default_cancel_button (but)
				create but.make_with_text_and_action ("get_logs_range", agent (cl: CTR_LOG_REVIEW_CLIENT_PROXY)
						do
							console_log ("get_logs_range")
							if attached cl.get_logs_range as l_range then
								console_log ("get_logs_range -> " + l_range.lower_revision.out + " .. " + l_range.upper_revision.out)
							end
						end(l_client)
					)
				vb.extend (but)

				create but.make_with_text_and_action ("get_missing_logs", agent (cl: CTR_LOG_REVIEW_CLIENT_PROXY)
						do
							console_log ("get_missing_logs")
						end(l_client)
					)
				vb.extend (but)

				create but.make_with_text_and_action ("post_logs", agent (cl: CTR_LOG_REVIEW_CLIENT_PROXY)
						do
							console_log ("post_logs")
						end(l_client)
					)
				vb.extend (but)
				create evs
				if attached evs.widget_top_level_window (widget, False) as w then
					pop.show_relative_to_window (w)
				else
					pop.show
				end
			end
		end

	on_approve
		local
			r: detachable REPOSITORY_LOG_REVIEW
		do
			if attached current_log as l_log then
				if l_log.has_review then
					r := l_log.review
				end
				if r = Void then
					create r.make
				end
				if button_approve.is_selected then
					r.approve (user_name)
				else
					r.unapprove (user_name)
				end
				apply (l_log, r)
			end
		end

	on_refuse
		local
			r: detachable REPOSITORY_LOG_REVIEW
		do
			if attached current_log as l_log then
				if l_log.has_review then
					r := l_log.review
				end
				if r = Void then
					create r.make
				end
				if button_refuse.is_selected then
					r.refuse (user_name)
				else
					r.unrefuse (user_name)
				end
				apply (l_log, r)
			end
		end

--	on_question
--		local
--			r: detachable REPOSITORY_LOG_REVIEW
--		do
--			if attached current_log as l_log then
--				if l_log.has_review then
--					r := l_log.review
--				end
--				if r = Void then
--					create r.make
--				end
--				if button_question.is_selected then
--					r.question (user_name, "???")
--				else
--					r.unquestion (user_name)
--				end
--				apply (l_log, r)
--			end
--		end

	on_questions_popup_widget (a_full: BOOLEAN): EV_WIDGET
		local
			fr: EV_FRAME
			vb: EV_VERTICAL_BOX
			tf: EV_TEXT
			g: EV_GRID
			but: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			r: detachable REPOSITORY_LOG_REVIEW
			i: INTEGER
			glab: EV_GRID_LABEL_ITEM
		do
			create fr
			create vb
			fr.extend (vb)

			create g
			g.hide_header
			vb.extend (g)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			vb.set_background_color ((create {EV_STOCK_COLORS}).red)
			hb.set_background_color ((create {EV_STOCK_COLORS}).blue)

			create tf
			hb.extend (tf)
			create but.make_with_text ("Apply")
			but.select_actions.extend (agent apply_question (tf))
			hb.extend (but)
			hb.disable_item_expand (but)
--			but.set_minimum_width (but.font.string_width (but.text) + 5)
			tf.set_minimum_height (40)

			if attached current_log as l_log then
				if l_log.has_review then
					r := l_log.review
				end
			end
			if a_full and then r /= Void and then attached r.reviews as rws and then rws.count > 0 then
				from
					i := 0
					g.insert_new_rows (rws.count, i + 1)
					rws.start
				until
					rws.after
				loop
					if attached rws.item.comment as c then

						i := i + 1
						g.set_item (1, i, create {EV_GRID_LABEL_ITEM}.make_with_text (c))
						if rws.item.user ~ user_name then
							create glab
							glab.set_pixmap (icons.delete_icon)
							g.set_item (2, i, glab)
							glab.select_actions.extend (agent delete_user_review (r, rws.item))
						end
					end
					rws.forth
				end
				if i = 0 then
					vb.prune (g)
				else
					g.set_minimum_height (g.row_count.min (3) * g.row_height)
					g.column (1).resize_to_content
				end
			else
				vb.prune (g)
			end
			tf.set_minimum_width_in_characters (30)

			Result := fr
		end

	apply_question (a_tf: EV_TEXTABLE)
		local
			r: detachable REPOSITORY_LOG_REVIEW
		do
			if attached current_log as l_log then
				if l_log.has_review then
					r := l_log.review
				end
				if r = Void then
					create r.make
				end
				if attached a_tf.text as s and then s.count > 0 then
					r.question (user_name, s)
				end
				apply (l_log, r)
			end
		end

	apply (a_log: REPOSITORY_LOG; r: REPOSITORY_LOG_REVIEW)
		do
			a_log.parent.store_log_review (a_log, r)
--			update_current_log (current_log)
			logs_tool.update_log (a_log)
		end

	on_submit
		do
			if
				attached current_log as l_log and then
				attached l_log.review as l_review
			then
				-- Remote call !!!
				if attached l_log.parent.review_client as l_client then
					console_log ("Submit review [" + l_log.id + "]")
					l_client.submit (l_log, l_review)
					if l_client.last_error_occurred then
						console_log_error ("Error during review submission [" + l_log.id + "]: " + l_client.last_error_to_string)
--						print (l_client.last_error_to_string + "%N")
					end
				end
				apply (l_log, l_review)
			end
		end

feature -- Basic operation

	delete_user_review (r: REPOSITORY_LOG_REVIEW; a_entry: REPOSITORY_LOG_REVIEW_ENTRY)
		do
			r.delete_user_review (a_entry)
		end

	update_current_log (a_log: like current_log)
		local
			l_rdata: detachable like {REPOSITORY_LOG_REVIEW}.user_review
			r: detachable REPOSITORY_LOG_REVIEW
			l_state: INTEGER --| -1: disabled 0: no user review; 1: local user review; 2: remote user review
		do
			if current_log /= a_log then
				user_name.wipe_out
				if
					a_log /= Void and then
					attached a_log.parent.review_username as u
				then
					user_name.append_string (u)
				end
			end
			current_log := a_log
			if a_log /= Void then
				log_id_lab.set_text (a_log.id)
				log_id_lab.refresh_now
			else
				log_id_lab.set_text ("...")
				log_id_lab.refresh_now
			end
			if a_log /= Void and then a_log.has_review then
				r := a_log.review
				if r /= Void then
					l_rdata := r.user_review (user_name, Void)
				end
			end
			if a_log = Void then
				l_state := -1
				widget.disable_sensitive
			else
				widget.enable_sensitive
				if r = Void or l_rdata = Void then
					button_approve.disable_select
					button_refuse.disable_select
--					button_question.disable_select
					button_submit.disable_sensitive
				else
					l_state := 1
					if l_rdata.is_approved_status then
						button_approve.enable_select
					else
						button_approve.disable_select
					end
					if l_rdata.is_refused_status then
						button_refuse.enable_select
					else
						button_refuse.disable_select
					end
--					if l_rdata.is_question_status then
--						button_question.enable_select
--					else
--						button_question.disable_select
--					end
					if not l_rdata.is_remote then
						button_submit.enable_sensitive
						button_submit.set_tooltip ("You have local modification to submit")
					else
						l_state := 2
						button_submit.disable_sensitive
						button_submit.set_tooltip ("No modification to submit")
					end
				end
			end
			inspect l_state
			when -1 then
				widget.set_background_color (colors.grey) -- disabled			
			when 1 then
				widget.set_background_color (colors.cyan) -- local			
			when 2 then
				widget.set_background_color (colors.white)	-- remote			
			else
				widget.set_background_color (colors.yellow) -- unknown
			end
			widget.propagate_background_color
		end

	reset
		do
			update_current_log (Void)
		end

	show
		do
			widget.show
		end

	hide
		do
			widget.hide
		end

end
