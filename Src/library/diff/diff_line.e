indexing
	description: "Base class for diff line indices."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Patrick Ruckstuhl"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIFF_LINE

feature {NONE} -- Initialization

	feature make(a_src_index: INTEGER; a_dst_index: INTEGER) is
			-- Create a match index pair.
		do
			src := a_src_index
			dst := a_dst_index
		end


feature -- Access

	src: INTEGER
			-- The index in the source.

	dst: INTEGER;
			-- The index in the destination.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
