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
			build_interface
		end

	build_interface
		local
			cl: EV_CELL
			vb: EV_VERTICAL_BOX
			b: EV_HORIZONTAL_BOX
			tb: SD_TOOL_BAR
			tbb: SD_TOOL_BAR_BUTTON
			tbw: SD_TOOL_BAR_WIDGET_ITEM
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
		end

feature -- Access

	widget: EV_BOX

	logs_tool: CTR_LOGS_TOOL

	tool_bar: SD_TOOL_BAR
	button_submit: SD_TOOL_BAR_BUTTON
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

	filter: detachable REPOSITORY_LOG_MESSAGE_FILTER

	apply_filter (s: detachable STRING)
		local
			f: like filter
		do
			f := filter

			if s = Void or else s.is_empty then
				if f /= Void then
					logs_tool.remove_filter (f)
				end
				filter := Void
			else
				if f = Void then
					create {REPOSITORY_LOG_MESSAGE_FILTER} f.make (s)
					filter := f
					logs_tool.add_filter (f)
				end
				f.set_message (s)
			end
			logs_tool.custom_update (False)
		end

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
			filter_tf.set_focus
		end

	hide
		do
			widget.hide
			reset
			logs_tool.grid.set_focus
		end

end
