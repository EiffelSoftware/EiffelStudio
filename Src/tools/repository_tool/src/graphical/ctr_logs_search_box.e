note
	description: "Summary description for {CTR_LOGS_SEARCH_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_LOGS_SEARCH_BOX

inherit
	ANY

	CTR_SHARED_RESOURCES
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make (a_tool: CTR_LOGS_TOOL)
		do
			logs_tool := a_tool
			create show_hide_actions
			create filters.make (2)
			create filter_in
			filter_in.message := True
			build_interface
		end

	build_interface
		local
			cl: EV_CELL
			vb: EV_VERTICAL_BOX
			b: EV_HORIZONTAL_BOX
			tb: SD_TOOL_BAR
			tbb: SD_TOOL_BAR_BUTTON
			tbpb: SD_TOOL_BAR_POPUP_BUTTON -- SD_TOOL_BAR_DUAL_POPUP_BUTTON
			tf: EV_TEXT_FIELD
			lab: EV_LABEL
			c: EV_COLOR
		do
			create vb
			vb.set_background_color (colors.red)
			widget := vb


			create cl
			cl.set_background_color (colors.blue)
			cl.set_minimum_height (1)
			vb.extend (cl)
			vb.disable_item_expand (cl)

			create b
			vb.extend (b)
			b.set_border_width (2)

			create tb.make
			tool_bar := tb

			create tf
			tf.set_minimum_width_in_characters (10)
			filter_tf := tf

--			create tbw.make (tf)
--			tb.extend (tbw)

			create tbb.make
			tbb.set_text ("Submit")
			tbb.select_actions.extend (agent on_submit)
			tb.extend (tbb)
			button_submit := tbb

			create tbpb.make
			tbpb.set_text ("...")
			tbpb.set_popup_widget_function (agent on_filter_choice)
			tb.extend (tbpb)
			button_filter := tbpb


			create lab.make_with_text ("Filter ")
			b.extend (lab)
			b.disable_item_expand (lab)

			b.extend (create {EV_CELL})
			b.disable_item_expand (b.last)

			b.extend (tf)

			b.extend (tb)
			b.disable_item_expand (tb)

			tb.compute_minimum_size
			create c.make_with_8_bit_rgb (180, 216, 255)
			b.set_background_color (c)
			b.propagate_background_color
			tf.set_background_color (create {EV_COLOR}.make_with_rgb (
						c.red + (1 - c.red) / 3,
						c.green + (1 - c.green) / 3,
						c.blue + (1 - c.blue) / 3
				))

			tf.return_actions.extend (agent on_submit)
			tf.key_release_actions.extend (agent on_key_released)

			tf.set_tooltip ("[
				Tips: 
				- Click and Esc to discard search
				- you can filter by date using before:2010-11-01 after:2010-10-01
				- ...
				]")
		end

feature -- Access

	widget: EV_BOX

	logs_tool: CTR_LOGS_TOOL

	tool_bar: SD_TOOL_BAR
	button_submit: SD_TOOL_BAR_BUTTON
	button_filter: SD_TOOL_BAR_BUTTON
	filter_tf: EV_TEXT_FIELD

feature -- Event

	on_key_released (a_key: EV_KEY)
		do
			inspect a_key.code
			when {EV_KEY_CONSTANTS}.key_escape then
				hide
				apply_filter ("")
--			when {EV_KEY_CONSTANTS}.key_f then
--				if ev_application.ctrl_pressed then
--					hide
--					apply_filter ("")
--				end
			else
			end
		end

	on_submit
		local
			s: STRING_32
		do
			s := filter_tf.text
			s.left_adjust
			apply_filter (s)
		end

	on_filter_changed
		local
			s: STRING_32
		do
			s := filter_tf.text
			s.left_adjust
			update_filter (s)
		end

	update_filter (a_filter: detachable STRING)
		local
			s: detachable STRING
			flst: like filters
			f: like filters.item
			d_before, d_after: detachable STRING
			p,e: INTEGER
		do
			s := a_filter
			flst := filters
			from
				flst.start
			until
				flst.after
			loop
				logs_tool.remove_filter (flst.item)
				flst.forth
			end
			flst.wipe_out
			if s = Void or else s.is_empty then
				--| nothing
			else
				p := s.substring_index ("before:", 1)
				if p > 0 then
					e := s.index_of (' ', p + 1)
					if e > 0 then
						e := e - 1
					else
						e := s.count
					end
					d_before := s.substring (p + 7, e)
					s.remove_substring (p, e)
					s.left_adjust
				end
				p := s.substring_index ("after:", 1)
				if p > 0 then
					e := s.index_of (' ', p + 1)
					if e > 0 then
						e := e - 1
					else
						e := s.count
					end
					d_after := s.substring (p + 6, e)
					s.remove_substring (p, e)
					s.left_adjust
				end
				if d_before /= Void or d_after /= Void then
					p := s.index_of ('"', 1)
					if p > 0 then
						e := s.index_of ('"', p + 1)
						if e > 0 then
							s := out.substring (p + 1, e - 1)
						end
					end
					create {REPOSITORY_LOG_DATE_FILTER} f.make (d_after, d_before)
					flst.extend (f)
				end
				if s.count > 0 then
					if filter_in.message then
						create {REPOSITORY_LOG_MESSAGE_FILTER} f.make (s)
						flst.extend (f)
					end
					if filter_in.path then
						create {REPOSITORY_LOG_PATH_FILTER} f.make (s)
						flst.extend (f)
					end
				end
				from
					flst.start
				until
					flst.after
				loop
					logs_tool.add_filter (flst.item)
					flst.forth
				end
			end
		end

	apply_filter (s: detachable STRING)
		do
			update_filter (s)
			logs_tool.custom_update (False)
		end

	on_filter_choice: detachable EV_WIDGET
		local
			b: EV_VERTICAL_BOX
--			bb: EV_VERTICAL_BOX
			lab: EV_LABEL
			cb: EV_CHECK_BUTTON
		do
			create b
			create lab.make_with_text ("Search in ...")
			b.extend (lab)
			b.extend (create {EV_HORIZONTAL_SEPARATOR})
			create cb.make_with_text ("Message")
			if filter_in.message then
				cb.enable_select
			end
			cb.select_actions.extend (agent (iacb: EV_CHECK_BUTTON)
				do
					filter_in.message := iacb.is_selected
					on_filter_changed
				end(cb))
			b.extend (cb)

			create cb.make_with_text ("Path")
			if filter_in.path then
				cb.enable_select
			end
			cb.select_actions.extend (agent (iacb: EV_CHECK_BUTTON)
				do
					filter_in.path := iacb.is_selected
					on_filter_changed
				end(cb))
			b.extend (cb)

--			create cb.make_with_text ("Dates")
--			if filter_in.dates then
--				cb.enable_select
--			end
--			cb.select_actions.extend (agent (iacb: EV_CHECK_BUTTON)
--				do
--					filter_in.dates := iacb.is_selected
--					on_filter_changed
--				end(cb))
--			b.extend (cb)

			Result := b
		end

feature -- Filter

	filters: ARRAYED_LIST [REPOSITORY_LOG_FILTER]

	filter_in: TUPLE [message: BOOLEAN; path: BOOLEAN; dates: BOOLEAN]

feature -- GUI events

	reset
		do
			filter_tf.remove_text
			apply_filter ("")
		end

	shown: BOOLEAN
		do
			Result := widget.is_show_requested
		end

	show
		do
			widget.show
			show_hide_actions.call ([True])
			filter_tf.set_focus
		end

	hide
		do
			widget.hide
			reset
			show_hide_actions.call ([False])
			logs_tool.grid.set_focus
		end

	show_hide_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN]]

end
