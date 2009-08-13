
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

$HEADER
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature

	t: LINKED_LIST [like Current]
		do
			create Result.make
		end

	t2: LINKED_LIST [like Current]

	default_create is
		do
		end

	$FEATURE
end
