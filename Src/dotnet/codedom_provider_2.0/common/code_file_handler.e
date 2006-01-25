indexing
	description: "File copy and other file related operations"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_FILE_HANDLER

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Status Report

	last_copy_successful: BOOLEAN
			--	Was last call to `copy_file' successful?

	has_extension (a_file_name, a_extension: STRING): BOOLEAN is
			-- Does `a_file_name' has extension `a_extension'?
		require
			non_void_file_name: a_file_name /= Void
			non_void_extension: a_extension /= Void
		local
			i, l_count, l_ext_count: INTEGER
		do
			from
				l_ext_count := a_extension.count
				l_count := a_file_name.count
				Result := l_count > l_ext_count + 1
			until
				i = l_ext_count or not Result
			loop
				Result := a_file_name.item (l_count - i) = a_extension.item (l_ext_count - i)
				i := i + 1
			end
			Result := Result and then a_file_name.item (l_count - l_ext_count) = '.'
		end
		
feature -- Basic Operations

	copy_file (a_source, a_dest: STRING) is
			-- Copy file `a_source' into `a_dest'.
		require
			non_void_source: a_source /= Void
			non_void_dest: a_dest /= Void
		local
			l_source, l_dest: RAW_FILE
			l_retried: BOOLEAN
		do
			last_copy_successful := False
			if l_retried then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Could_not_copy, [a_source, a_dest])
			else
				create l_source.make (a_source)
				if not l_source.exists then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_file, [l_source])
				else
					create l_dest.make (a_dest)
					if l_dest.exists then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.File_exists, [a_dest])
						l_dest.delete
					end
					l_source.open_read
					l_dest.open_write
					l_source.copy_to (l_dest)
					l_source.close
					l_dest.close
					last_copy_successful := True
				end
			end
		rescue
			l_retried := True
			retry
		end

end -- class CODE_FILE_HANDLER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------