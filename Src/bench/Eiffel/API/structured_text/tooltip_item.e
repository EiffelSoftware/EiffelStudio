indexing
	description: 
		"Mark appearing before or after major syntactic constructs."
	date: "$Date$";
	revision: "$Revision $"

class
	TOOLTIP_ITEM

inherit
	FILTER_ITEM
		rename
			make as old_make
		redefine
			on_after_processing,
			on_before_processing
		end

	SHARED_FILTER

create
	make

feature -- Initialize

	make (a_tooltip: STRING) is
			-- Initialize Current with `a_f_name'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			old_make (f_Tooltip)
			tooltip := a_tooltip
		end

feature -- Access

	tooltip: STRING
			-- Text applying to this construct.

feature {TEXT_FILTER} -- Access

	on_before_processing (f: TEXT_FILTER) is
			-- `Current' is about to be processed.
		do
			f.set_keyword (kw_Tooltip, tooltip)
		end

	on_after_processing (f: TEXT_FILTER) is
			-- `Current' has just been processed.
		do
			f.set_keyword (kw_Tooltip, Void)
		end

end -- class TOOLTIP_ITEM


