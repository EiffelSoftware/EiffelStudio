indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Bitmap_resource -> "BITMAP" Load_and_mem filename

class BITMAP_RESOURCE

inherit
	S_BITMAP_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			bitmap: TDS_BITMAP
		do     
			!! bitmap.make
			bitmap.set_id (tds.last_token)
			tds.insert_resource (bitmap)

			tds.set_current_resource (bitmap)
		end

	post_action is
		local
			bitmap: TDS_BITMAP
		do
			bitmap ?= tds.current_resource
			bitmap.set_filename (tds.last_token)
		end

end -- class BITMAP_RESOURCE
