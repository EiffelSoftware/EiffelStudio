note
	description: "Summary description for {IMAGE_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Init
		do
			create my_image.make_empty
		end

feature -- Access

	id: INTEGER
			-- ID of the image

	my_image: STRING
			-- Binarary data of the image

end
