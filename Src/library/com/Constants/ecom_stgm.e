indexing

	description: "SToraGe Mode flags"
	note: 	"Priority mode not supported"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STGM

feature -- Access

	Stgm_create: INTEGER is
			-- Stgm_create indicates an existing IStorage or IStream object
			-- should be removed before the new one replaces it. A new object
			-- is created when this flag is specified only if the existing
			-- IStorage or IStream has been successfully removed.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_CREATE"
		end
		
	Stgm_convert: INTEGER is
			-- This flag is applicable only to the creation of IStorage objects.
			-- Stgm_convert allows the creation to proceed while preserving
			-- existing data. The old data is saved to a stream named CONTENTS
			-- containing the same data that was in the old IStorage or IStream
			-- instance. In the IStorage case, the data is flattened to a
			-- stream regardless of whether the existing file currently contains
			-- a layered storage object.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_CONVERT"
		end
		
	Stgm_failifthere: INTEGER is
			-- Stgm_failifthere causes the create operation to fail if an
			-- existing object with the specified name exists. In this case,
			-- Stg_e_filealreadyexists is returned. Stgm_failifthere
			-- applies to both IStorage and IStream objects.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_FAILIFTHERE"
		end
		
	Stgm_deleteonrelease: INTEGER is
			-- The Stgm_deleteonrelease flag indicates that the underlying
			-- file is to be automatically destroyed when the root IStorage
			-- object is released. This capability is most useful for
			-- creating temporary files.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_DELETEONRELEASE"
		end
		
	Stgm_direct: INTEGER is
			-- Stgm_DIrect is always specified for IStream objects.
			-- Stgm_transacted is not supported in the compound file
			-- implementation of IStream. Other implementations can choose
			-- to support it.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_DIRECT"
		end
		
	Stgm_transacted: INTEGER is
			-- The transaction for each open object is nested in the transaction
			-- for its parent storage object. Therefore, committing changes at the
			-- child level is dependent on committing changes in the parent and
			-- a commit of the root storage object (top-level parent) is necessary
			-- before changes to an object are actually written to disk.
			-- The changes percolate upward: inner objects publish changes to the
			-- transaction of the next object outwards. Outermost objects publish
			-- changes permanently into the file system. Transacted mode is not
			-- required on the parent storage object in order to use transacted
			-- mode on a contained object.The scope of changes that are buffered
			-- in transacted mode is very broad. A storage or stream object can
			-- be opened, have arbitrary changes made to it, and then have the
			-- changes reverted, preserving the object as it was when it was
			-- first opened. The creation and destruction of elements within a
			-- storage object are scoped by its transaction.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_TRANSACTED"
		end
		
	Stgm_read: INTEGER is
			-- When applied to an IStream object, Stgm_READ enables
			-- applications to successfully call IStream.Read. If Stgm_read
			-- is omitted, IStream.Read will return an error. When applied to an
			-- IStorage, Stgm_READ allows the enumeration of the storage
			-- object's elements and enables applications to open these elements
			-- in read mode. Parents of storage objects to be opened in read mode
			-- must also have been opened in read mode otherwise, an error is
			-- returned.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_READ"
		end
		
	Stgm_write: INTEGER is
			-- Stgm_write lets an object commit changes to the storage.
			-- Specifically, unless this flag has been given, IStorage.Commit
			-- and IStream.Commit will fail. An open object whose changes cannot
			-- be committed can save its changes by copying the storage or stream
			-- with IStorage.CopyTo or IStream.CopyTo. In direct mode,
			-- changes are committed after every change operation. Thus, write
			-- permissions are needed to call any function that causes a change.
			-- On streams, this includes IStream.Write and IStream.SetSize.
			-- If a parent storage is opened in direct mode without write
			-- permission, any attempt to open a child stream within it in direct
			-- mode with write permission will fail, because it causes an implicit
			-- commit to be made on the storage. Similarly, trying to create or
			-- destroy a contained element in this storage object also causes an
			-- implicit commit, resulting in an error.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_WRITE"
		end
		
	Stgm_readwrite: INTEGER is
			-- Stgm_readwrite is the logical combination of the
			-- Stgm_read and Stgm_write. However, the defined value
			-- of Stgm_readwrite is not equal to
			-- (Stgm_read or Stgm_write).
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_READWRITE"
		end
		
	Stgm_share_deny_none: INTEGER is
			-- 0x00000040L
			-- Stgm_SHARE_DENY_NONE indicates that neither read access nor
			-- write access should be denied to subsequent openings. This is the
			-- default sharing mode and if no Stgm_SHARE_* flag is explicitly
			-- given, Stgm_SHARE_DENY_NONE is implied.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_SHARE_DENY_NONE"
		end
		
	Stgm_share_deny_read: INTEGER is
			-- 0x00000030L
			-- When successfully applied to a root IStorage, the
			-- Stgm_SHARE_DENY_READ flag prevents others from opening the
			-- object in read mode. The open call fails and returns an error if
			-- the object is presently open in deny-read mode.
			-- Stgm_SHARE_DENY_READ is most useful when opening root storage
			-- objects. Deny modes on inner elements are still useful if some
			-- component is coordinating the opening of these inner elements, as
			-- might happen in a Copy/Paste operation. However, inner elements
			-- always require Stgm_SHARE_EXCLUSIVE. Opening a parent storage
			-- object with Stgm_SHARE_DENY_READ applies only to that opening,
			-- not the network-wide set of openings of the parent.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_SHARE_DENY_READ"
		end
		
	Stgm_share_deny_write: INTEGER is
			-- When successfully applied the Stgm_share_deny_write flag
			-- prevents subsequent openings of either a storage or a stream from
			-- specifying write mode. The open call fails and returns an error
			-- if the storage or stream is presently open in write mode.
			-- For information about the interaction of this flag with nested
			-- openings, see the earlier discussion about Stgm_share_deny_read.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_SHARE_DENY_WRITE"
		end
		
	Stgm_share_exclusive: INTEGER is
			-- The compound files implementation requires that all inner elements
			-- be opened Stgm_share_exclusive. It is the logical combination
			-- of the Stgm_share_deny_read and Stgm_share_deny_write.
			-- All root storage objects, as well as child storage and stream
			-- objects must be opened with Stgm_share_exclusive.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_SHARE_EXCLUSIVE"
		end
		
	Stgm_priority: INTEGER is
			-- The Stgm_priority flag allows an IStorage object to be opened
			-- so that a subsequent copy operation can be done at reduced cost.
			-- Stgm_priority allows an application to read certain streams
			-- from storage before opening the storage object in a mode that would
			-- require a snapshot copy to be made. Priority mode has exclusive
			-- access to the committed version of the IStorage object.
			-- While a compound file is open in priority mode, no other opening
			-- of the compound file can commit changes even one that was opened
			-- before the priority mode opening. Therefore, applications should
			-- keep IStorage objects open in priority mode for as short a time
			-- as possible.
		external
			"C [macro <objbase.h>]"
		alias
			"STGM_PRIORITY"
		end

	is_valid_stgm (stgm: INTEGER): BOOLEAN is
			-- Is `stgm' a valid storage mode flag?
		do
			Result := stgm = Stgm_create or
						stgm = Stgm_convert or
						stgm = Stgm_failifthere or
						stgm = Stgm_deleteonrelease or
						stgm = Stgm_direct or
						stgm = Stgm_transacted or
						stgm = Stgm_read or
						stgm = Stgm_write or
						stgm = Stgm_readwrite or
						stgm = Stgm_share_deny_none or
						stgm = Stgm_share_deny_read or
						stgm = Stgm_share_deny_write or
						stgm = Stgm_share_exclusive -- or
						-- stgm = Stgm_priority
		end
		
end -- class STGM

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

