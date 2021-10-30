note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE

create
	make

feature {NONE} -- Initialization

	make (ctx: detachable LIBRARY_DATABASE_CONTEXT)
		do
			context := ctx
			create items.make (0)
			create ecf_files.make (0)
		end

feature -- Access

	context: detachable LIBRARY_DATABASE_CONTEXT
			-- Associated context

	items: STRING_TABLE [LIBRARY_INFO]
			-- Info indexed by UUID

	ecf_files: ARRAYED_LIST [PATH]
			-- Indexed ecf files

	item_by_location (a_ecf: PATH): detachable LIBRARY_INFO
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if ic.location.is_same_file_as (a_ecf) then
					Result := ic
				end
			end
		end

feature -- Change

	update_context (ctx: like context)
		do
			context := ctx
		end

	wipe_out
		do
			items.wipe_out
			ecf_files.wipe_out
		end

feature -- Status report

	has (i: LIBRARY_INFO): BOOLEAN
		do
			Result := items.has (key (i))
		end

	has_ecf_file (p: PATH): BOOLEAN
		do
			Result := ∃ ic: ecf_files ¦ p.same_as (ic)
		end

feature -- Modification

	put (i: LIBRARY_INFO)
		do
			items.put (i, key (i))
			ecf_files.force (i.location)
		end

	force (i: LIBRARY_INFO)
		do
			items.force (i, key (i))
			ecf_files.force (i.location)
		end

feature {NONE} -- Key

	key (i: LIBRARY_INFO): STRING
		do
			Result := i.uuid.out
			if attached i.void_safety_option as vs then
				Result.append_character ('-')
				Result.append (vs)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
