indexing

	description: 
		"Text figure used to draw some text (names, labels).";
	date: "$Date$";
	revision: "$Revision $"

class EC_TEXT_FIG

inherit

	EC_TEXT_GEN

	EC_INTERIOR	
		rename
			make as interior_make
		end

	OBSERVER

creation

	make

feature -- Initialization

	make is
		do
			!! words.make;
			!! text.make (1)
			interior_make
			!! base_left
			!! closure.make
		end -- make

feature -- Output


	update is
		do
		--	erase
		--	set_text("pouet")
		--	draw
		end

	draw is
			-- Draw the current text
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing)
				drawing.set_font (font)
				draw_on (drawing, base_left, False)
			end
		end
							
	erase is
			-- Erase current figure
		do
			if drawing.is_drawable then
			--	set_clear_mode;
				draw;
		--		set_copy_mode;
			end
		end; 

	draw_on (a_drawing: like drawing; base_l: like base_left;  while_moving:BOOLEAN) is
			-- Draw text in `a_drawing' with base_left `base_l'.
		require
			has_drawing: a_drawing /= Void
		local
			a_center: EC_COORD_XY
			h,w: INTEGER
			a_closure: EC_CLOSURE
		do
			if not while_moving then
				if vertical then
					draw_words (drawing, base_l)
				else
					draw_text (drawing, base_l)
				end
			else
				a_closure := closure
				h := a_closure.down_right_y - a_closure.up_left_y
				w := a_closure.down_right_x - a_closure.up_left_x
				!! a_center
				a_center.set (base_l.x + w // 2, base_l.y + h // 2)
				a_drawing.draw_rectangle (a_center, w, h, 0)
			end
		end;

feature -- Update

	recompute_closure is
			-- Recalculate figure's closure.
		do
		end 

feature {NONE} -- Implementation

	draw_text (a_drawing: like drawing; base_l: EC_COORD_XY) is
		require
			has_drawing: a_drawing /= Void
		local
			txt: like text
		do
			txt := clone (text);
			a_drawing.draw_text (base_l, txt)
		end;

	draw_words (a_drawing: like drawing; base_l: EC_COORD_XY) is
		require
			has_drawing: drawing /= Void
		local
			word: STRING
			word_base_left: like base_left
			y: INTEGER
		do
			from
				words.start
				word_base_left := clone (base_l)
				y := word_base_left.y
			until
				words.after
			loop
				word := clone (words.item)
				words.forth
				drawing.draw_text (word_base_left, word)
				y := y + line_space
				word_base_left.set_y (y)
			end
		end

	is_motif:BOOLEAN is FALSE

feature -- Access

	contains (p : EC_COORD_XY) : BOOLEAN is
			-- Is p in figure?
		require else
			points_exists : not (p = Void)
		do
		end -- contains
			
end -- class EC_TEXT_FIG
