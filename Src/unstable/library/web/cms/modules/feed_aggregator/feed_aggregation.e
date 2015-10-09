note
	description: "Feed aggregation parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_AGGREGATION

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
			create {ARRAYED_LIST [READABLE_STRING_8]} locations.make (0)
			expiration := 60*60
			description_enabled := True
			size := 10
		end

feature -- Access

	name: IMMUTABLE_STRING_32
			-- Associated name.

	expiration: INTEGER
			-- Suggested expiration time in seconds (default: 1 hour).
			-- If negative then never expires.

	size: INTEGER
			-- Number of entries to display per page.

	description: detachable IMMUTABLE_STRING_32
			-- Optional description.

	locations: LIST [READABLE_STRING_8]
			-- List of feed location aggregated into current.

	included_categories: detachable LIST [READABLE_STRING_32]
			-- Optional categories to filter.
			-- If Void, include any.

	description_enabled: BOOLEAN
			-- Display description?

feature -- Element change

	set_description (a_desc: detachable READABLE_STRING_GENERAL)
		do
			if a_desc = Void then
				description := Void
			else
				create description.make_from_string_general (a_desc)
			end
		end

	set_expiration (nb_seconds: INTEGER)
			-- Set `expiration' to `nb_seconds'.
		do
			expiration := nb_seconds
		end

	set_size (nb: INTEGER)
			-- Set `size' to `nb'.
		do
			size := nb
		end

	set_description_enabled (b: BOOLEAN)
			-- Set `description_enabled' to `b'.
		do
			description_enabled := b
		end

	reset_categories
		do
			included_categories := Void
		end

	include_category (a_cat: READABLE_STRING_GENERAL)
		local
			lst: like included_categories
			s32: STRING_32
		do
			lst := included_categories
			if lst = Void then
				create {ARRAYED_LIST [READABLE_STRING_32]} lst.make (1)
				included_categories := lst
				lst.compare_objects
			end
			s32 := a_cat.to_string_32
			if not lst.has (s32) then
				lst.force (s32)
			end
		end

feature -- Status report

	is_included (e: FEED_ITEM): BOOLEAN
		do
			Result := True
			if attached e.categories as e_cats then
				if attached included_categories as lst then
					Result := across lst as ic some
							across e_cats as e_ic some
								e_ic.item.same_string (ic.item)
							end
						end
				end
			end
		end

end
