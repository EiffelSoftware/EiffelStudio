--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Priority queues,
-- without commitment to a particular representation

indexing

	names: priority_queue, dispenser;
	access: fixed, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class PRIORITY_QUEUE [G -> PART_COMPARABLE] inherit

	DISPENSER [G]

end
