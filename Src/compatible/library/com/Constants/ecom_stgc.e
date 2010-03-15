note

	description: "SToraGe Commit mode flags"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STGC

feature -- Access

	Stgc_default: INTEGER
			-- OLE 2 default commit mode
		external
			"C [macro <wtypes.h>]"
		alias
			"STGC_DEFAULT"
		end

	Stgc_overwrite: INTEGER
			-- EOLE_STGC_OVERWRITE allows new data to overwrite the old data,
			-- reducing space requirements. EOLE_STGC_OVERWRITE is not recommended
			-- for usual operation, but it could be useful in the following
			-- situations:
			--    1. A commit was tried and EOLE_STG_E_MEDIUMFULL was returned.
			--    2. The user has somehow specified a willingness to risk
			--       overwriting the old data.
			--    3. A low-memory save sequence is being used to end up with a
			--       smaller file.
			-- The commit operation obtains all the disk space it needs before
			-- attempting to store the new data, whether or not EOLE_STGC_OVERWRITE
			-- is specified. If space requirements prohibit the save, the old
			-- data will be intact, including all uncommitted changes. However,
			-- if the commit fails due to reasons other than lack of disk space
			-- and EOLE_STGC_OVERWRITE was specified, it is possible that neither
			-- the old nor the new version of the data will be intact.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGC_OVERWRITE"
		end

	Stgc_onlyifcurrent: INTEGER
			-- EOLE_STGC_ONLYIFCURRENT prevents multiple users of an IStorage
			-- from overwriting the other's changes. EOLE_STGC_ONLYIFCURRENT
			-- commits changes only if no one else has made changes since the
			-- last time this user opened the IStorage or committed. If other
			-- changes have been made, EOLE_STG_E_NOTCURRENT is returned.
			-- If the caller chooses to overwrite the changes, IStorage.Commit
			-- can be called with commit mode set to EOLE_STGC_DEFAULT.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGC_ONLYIFCURRENT"
		end

	Stgc_dangerouslycommitmerelytodiskcache: INTEGER
			-- EOLE_STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE commits the changes,
			-- but does not save them to the disk cache.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE"
		end

	is_valid_stgc (stgc: INTEGER): BOOLEAN
			-- Is `stgc' a valid storage commit mode flag?
		do
			Result := stgc = Stgc_default or
						stgc = Stgc_overwrite or
						stgc = Stgc_onlyifcurrent or
						stgc = Stgc_dangerouslycommitmerelytodiskcache
		end
		
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EOLE_STGC

