indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	EV_RADIO_MENU_TEST_WINDOW

inherit
	EV_TITLED_WINDOW

creation
	make


feature -- Access

	make is
		local
			b: EV_RADIO_BUTTON
			m: EV_RADIO_MENU_ITEM
			t: EV_TOOL_BAR_RADIO_BUTTON
			i: INTEGER
			bh: EV_HORIZONTAL_BOX
			mh: EV_MENU_BAR
			th: EV_TOOL_BAR
			v: EV_VERTICAL_BOX
		do
			create bh
			create mh
			create th
			from
				i := 1
			until
				i = 3
			loop
				create m.make_with_text (i.out)
				create b.make_with_text (i.out)
				create t.make_with_text (i.out)
				m.press_actions.extend (~action (b, m, t))
				b.press_actions.extend (~action (b, m, t))
				t.press_actions.extend (~action (b, m, t))
				mh.extend (m)
				bh.extend (b)
				th.extend (t)
			end

			default_create
			create v
			set_menu_bar (mh)
			v.extend (th)
			v.extend (bh)
			extend (v)
		end

	number: INTEGER

	action (b: EV_RADIO_BUTTON; m: EV_RADIO_MENU_ITEM;
			t: EV_TOOL_BAR_RADIO_BUTTON) is
		do
			number := number +1
			if number > 10 then
				io.put_string ("Problem occured%N")
				destroy
			end
			if not (b.is_selected) then
				b.enable_select
			end
			if not (m.is_selected) then
				m.enable_select
			end
			if not (t.is_selected) then
				t.enable_select
			end
		end
		
end -- class MAIN_WINDOW
