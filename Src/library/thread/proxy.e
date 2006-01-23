indexing
	description:
		"Indirection proxy allowing share of objects between threads, %
		%without having the garbage collectors intercollect each-other."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROXY [G]

obsolete
	"Not needed anymore since object does not need protection"

create
	make, put

feature {NONE} -- Initialization

	frozen make, frozen put (obj: G) is
			-- Make proxy denote `obj'.
		require
			not_void: obj /= Void
		do
			item := obj
		end

feature	-- Access

	item: G
			-- Object attached to proxy.

feature {NONE} -- Disposal

	dispose is
		do
		end

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




end -- class PROXY

