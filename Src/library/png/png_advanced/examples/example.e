class EXAMPLE

creation
	make

feature -- Init
	make is 
		local
			fn: FILE_NAME	
		do 
			Create im.make(400,400)
			im.set_background_color(200,30,100)

			Create txt.make(im,50,50,2,"Hello")
			txt.set_color(0,0,255)
			txt.draw_text

			Create ellipse.make(im,200,50,80,30)
			ellipse.set_color(0,255,0)
			ellipse.draw_plain_ellipse (255,0,0)

			Create poly.make(im,<<[300,200],[40,250],[370,290]>>)
			poly.set_color(0,255,0)
			poly.draw_lines

			Create fn.make_from_string("d:\PNG\att.png")
			im.save_to_file(fn)
			
		end

feature -- Access

	im: GD_IMAGE

	txt: GD_TEXT	

	ellipse: GD_ELLIPSE

	poly: GD_POLYLINE

end -- EXAMPLE