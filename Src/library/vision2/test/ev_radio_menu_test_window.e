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
			mh: EV_MENU
			mb: EV_MENU_BAR
			th: EV_TOOL_BAR
			v: EV_VERTICAL_BOX
		do
			default_create

			create bh
			create mh
			create th
			from
				i := 1
			until
				i > 3
			loop
				create m.make_with_text (i.out)
				create b.make_with_text (i.out)
				create t.make_with_text (i.out)
				mh.extend (m)
				bh.extend (b)
				th.extend (t)
				m.select_actions.extend (~action (b, t))
				b.select_actions.extend (~action (m, t))
				t.select_actions.extend (~action (b, m))
				i := i + 1
			end

			create v
			create mb
			mb.extend (mh)
			mh.set_text ("Radio menu")
			set_menu_bar (mb)
			v.extend (th)
			v.extend (bh)
			extend (v)
		end

	number: INTEGER

	action (rp1, rp2: EV_RADIO_PEER) is
			-- The other radio peer has been selected.
		do
			number := number +1
			if number > 100 then
		--		io.put_string ("Problem occured%N")
		--		destroy
			else
				if not (rp1.is_selected) then
					rp1.enable_select
				end
				if not (rp2.is_selected) then
					rp2.enable_select
				end
			end
		end
		
end -- class MAIN_WINDOW
