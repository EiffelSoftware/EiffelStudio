--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Queues (first-in, first out dispensers),
-- without commitment to a particular representation

indexing

	names: queue, dispenser;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class QUEUE [G] inherit

	DISPENSER [G]

end
