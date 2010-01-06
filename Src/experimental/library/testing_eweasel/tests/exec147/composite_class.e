
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

indexing
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSITE_CLASS

inherit
	ANY
		export
			{ANY} default_create
		end

create
	default_create

feature
	
	c: CLASS_A


end -- class COMPOSITE_CLASS
