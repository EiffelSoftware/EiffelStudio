indexing
	description: "figure"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_FIGURE

feature -- Drawings

	draw_border is
		deferred
		end

feature {NONE} -- Implementation

	image: GD_IMAGE

invariant
	image_exists: image /=Void	
end -- class GD_FIGURE
