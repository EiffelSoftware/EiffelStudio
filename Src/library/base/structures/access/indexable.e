--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Indexable tables. Tables with keys constrained
-- to enumerable types

indexing

	names: indexable, access;
	access: index, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class INDEXABLE [G, H -> INTEGER] inherit

	TABLE [G, H]
		rename
			valid_key as valid_index
		end

end -- class INDEXABLE
