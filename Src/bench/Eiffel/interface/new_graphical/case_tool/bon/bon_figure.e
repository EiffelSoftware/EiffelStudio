indexing
	description: "Objects that is a common base class for bon figures."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BON_FIGURE
	
inherit
	BON_CONSTANTS

feature -- Status report

	is_high_quality: BOOLEAN
			-- Is `Current' rendered with high quality?

feature -- Status settings

	enable_high_quality is
			-- Enable high quality.
		do
			set_is_high_quality (True)
		ensure
			high_quality: is_high_quality
		end
		
	disable_high_quality is
			-- Disable high quality.
		do
			set_is_high_quality (False)
		ensure
			low_quality: not is_high_quality
		end
		
feature {NONE} -- Implementation

	set_is_high_quality (a_high_quality: like is_high_quality) is
			-- Set `is_high_quality' to `a_high_quality'.
		deferred
		ensure
			is_high_quality_assigned: is_high_quality = a_high_quality
		end

end -- class BON_FIGURE
