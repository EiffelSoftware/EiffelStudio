--| FIXME Not for release
indexing
	description: 
		"Root class of EiffelVision Test Application."
	status: "See notice at end of class"
	keywords: "test"
	date: "$Date$"
	revision: "$Revision$"
	
class
	TEST

inherit
	EV_APPLICATION

	MEMORY
		undefine
			default_create
		end

creation
	default_create,
	make_and_launch

feature -- Initialization

	prepare is
			-- Nothing
		local
			s: LINKED_SET [INTEGER]
			b1: EV_BUTTON
			b2: EV_BUTTON
			b3, bb: EV_BUTTON
			b: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l: EV_LIST
			li1: EV_LIST_ITEM
			li2: EV_LIST_ITEM
			i: BOOLEAN
			agent: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			print_agent: PROCEDURE [ANY, TUPLE [ANY]]
			pnd_string: STRING
			scr: EV_SCREEN
			tt1, tt2: STRING
			a: PROCEDURE [ANY, TUPLE]
		do
			create hb
			create vb

			tt1 := "hello"
			tt2 := "goodbye"
			a := tt1~append (tt2)
			tt1 := Void
			tt2 := Void
			full_collect
			a.call ([])
			--print (tt1 + "%N")
			pnd_string := "hello I traveled through pnd!%N"
			create b.make_with_text ("temp button")
			b.set_focus
			b := Void
			full_collect
			create scr	
			create b1.make_with_text ("screen size: " + scr.width.out + "x" + scr.height.out)
			b1.set_pebble (pnd_string)
			--b1.set_drag_and_drop
			create b2.make_with_text ("push me !! b2")
			b2.set_background_color (create {EV_COLOR}.make_with_rgb (0.8, 0.8, 0.5))
			b2.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 0, 1))
			b2.press_actions.extend (~print ("hello%N"))
			agent := ~print_pointer_press
			--agent .set_filter ("<10,?,=2,?,?,?")
			b2.pointer_button_press_actions.extend (agent)
			
			create b3.make_with_text ("button goes in.. b3")
			b3.press_actions.extend (~print ("b3%N"))
			b2.press_actions.extend (~array_of_butts (vb))
			b2.press_actions.extend ((b2.press_actions)~extend (~print ("Fskkk%N")))
			print ((~print).generating_type)
			b3.drop_actions.extend (~my_print)
			b2.pointer_enter_actions.extend (~print ("ENTER%N"))
			b2.pointer_leave_actions.extend (~print ("LEAVE%N"))
			b2.focus_in_actions.extend (~print ("FOCUS IN%N"))
			b2.focus_out_actions.extend (~print ("FOCUS OUT%N"))
			
			vb.extend (hb)
			create bb.make_with_text ("Hasta la vista")
			vb.extend (bb)
			vb.disable_child_expand (bb)
			bb.set_background_color (create {EV_COLOR}.make_with_rgb (0.8, 0, 0))
			bb.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			bb.press_actions.extend (~destroy)
			create bb.make_with_text ("drop on me!!")
			vb.extend (bb)
			bb.drop_actions.extend (~extend_box (vb, ?))
			first_window.put (vb)
			hb.extend (b1)
			b1.parent.extend (b2)
			hb.disable_child_expand (b2)
			hb.extend (b3)
			hb.disable_child_expand (b3)
			b2.press_actions.extend  (~array_of_butts (vb))

			b1 := Void
			b2 := Void
			b3 := Void
			full_collect
			create bb.make_with_text ("pick me, pick me!")
			bb.set_pebble ("Yey, I got picked")
			hb.extend (bb)
			hb.extend (create {EV_BUTTON}.make_with_text ("me too button b4"))
			hb.go_i_th (4)
			b ?= hb.item
			b.drop_actions.extend (~my_print2)
			--hb.remove
			print ("TEXT FROM BUTTON: " + b.text + "%N")
			b := Void
			full_collect
			create l
			create li1
			li1.set_text ("Item1")
			create li2.make_with_text ("Item2")
			l.extend (li1)
			l.extend (li2)
			hb.extend (l)
			hb.disable_child_expand (l)
			hb.go_i_th (3)
			b ?= hb.item
			b.press_actions.extend (l~extend (create {EV_LIST_ITEM}.make_with_text ("b3 clicked!")))
			post_launch_actions.extend (~print ("POST LAUNCH TASK 1 WAS CALLED%N"))
			post_launch_actions.extend (~print ("POST LAUNCH TASK 2 WAS CALLED%N"))
		end

	my_print (s: STRING) is do print (s) end

	my_print2 (s: LIST [STRING]) is do print (s) end

	print_pointer_press (x, y, b: INTEGER; tx, ty, p: DOUBLE; sx, sy: INTEGER) is
		do
			print ("press: (" + x.out + "," + y.out + "):" + b.out + " [" + tx.out + "," + ty.out + "]:" + p.out + "%N") 
		end

	array_of_butts (cont: EV_CONTAINER) is
		local
			b:EV_BUTTON
			i, j: INTEGER
			v: EV_VERTICAL_BOX
			h: EV_HORIZONTAL_BOX
			app: EV_APPLICATION
		do
			app := (create {EV_ENVIRONMENT}).application
			create v
			v.enable_homogeneous
			cont.extend (v)

			from i := 0 until i > 20 loop
				create h
				h.enable_homogeneous
				v.extend (h)
				from j := 0 until j > 20 loop
					create b.make_with_text (i.out + ", " + j.out)
					if i \\ 2 = 0 then
						if j \\ 2 = 0 then
							b.drop_actions.extend (io~put_string)
						end
					else
						if j \\ 2 = 1 then
							b.drop_actions.extend (io~put_string)
						end
					end
					h.extend (b)
					j := j + 1
					app.process_events
					mem_info
				end
				i := i + 1
			end
		end

	mem_info is 
		do
			print (memory_statistics (Total_memory).out)
			print (memory_statistics (Eiffel_memory).out)
			print (memory_statistics (C_memory).out)
		end

	extend_box (c: EV_CONTAINER; text: STRING) is
		local
			b: EV_BUTTON
		do
			create b.make_with_text (text)
			c.extend (b)
			b.press_actions.extend (b~destroy)
		end

feature -- Access

	first_window: EV_TITLED_WINDOW is
			-- Main window for test
		once
			create Result
		end

end -- class TUTORIAL

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------



