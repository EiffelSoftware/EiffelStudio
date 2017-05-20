note
	description: "Information related to sitemap entry."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SITEMAP_ITEM

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (lnk: CMS_LOCAL_LINK; a_date_time: DATE_TIME)
		do
			link := lnk
			date := a_date_time
			set_change_frequency_to_weekly
			priority := 1
		end

feature -- Access

	link: CMS_LOCAL_LINK
			-- Local link associated with the resource.

	date: DATE_TIME
			-- Last modification.

	change_frequency: READABLE_STRING_8
			-- Frequency of changes
			-- monthly, daily, ...

	priority: NATURAL_8
			-- Priority

feature -- Element change

	set_change_frequency_to_monthly
		do
			set_change_frequency ("monthly")
		end

	set_change_frequency_to_weekly
		do
			set_change_frequency ("weekly")
		end

	set_change_frequency_to_daily
		do
			set_change_frequency ("daily")
		end

	set_change_frequency (freq: like change_frequency)
			-- Set `change_frequency' to `freq'.
		do
			change_frequency := freq
		end

	set_priority (p: like priority)
			-- Set `priority' to `p'.
		do
			priority := p
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := date < other.date
		end

end
