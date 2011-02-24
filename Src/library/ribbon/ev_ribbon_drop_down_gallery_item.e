note
	description: "Summary description for {EV_RIBBON_DROP_DOWN_GALLERY_ITEM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_DROP_DOWN_GALLERY_ITEM

feature -- Query

	image: detachable EV_PIXEL_BUFFER
			-- String label

	label: detachable STRING_32
			-- String label

feature -- Command

	set_image (a_image: like image)
			-- Set `image' with `a_image'
		do
			image := a_image
		ensure
			set: image = a_image
		end

	set_label (a_label: like label)
			-- Set `label' with `a_label'
		do
			label := a_label
		ensure
			set: label = a_label
		end
end
