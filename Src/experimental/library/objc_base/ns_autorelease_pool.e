note
	description: "Summary description for {NS_AUTORELEASE_POOL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_AUTORELEASE_POOL

inherit
	NS_OBJECT

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_AUTORELEASE_POOL_API}.new)
		end

feature -- Managing a Pool

	release
			-- Releases and pops the receiver.
			-- In a reference-counted environment, since an autorelease pool cannot be retained (see retain), this method causes the receiver to be deallocated. When an autorelease pool is deallocated, it sends a release message to all its autoreleased objects. If an object is added several times to the same pool, when the pool is deallocated it receives a release message for each time it was added.
			-- In a garbage-collected environment, this method is a no-op.
			-- You should typically use drain instead of release.
		do
			{NS_AUTORELEASE_POOL_API}.release (item)
		end

end
