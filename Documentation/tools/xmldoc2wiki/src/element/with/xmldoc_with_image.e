indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_IMAGE

feature -- Access

	image: XMLDOC_IMAGE
			-- Associated image element

feature -- Element change

	set_image (v: like image)
			-- Set `image' to `v'
		require
			v_attached: v /= Void
		do
			image := v
		end

end
