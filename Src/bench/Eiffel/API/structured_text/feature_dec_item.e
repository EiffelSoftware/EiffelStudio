indexing

	description: 
		"Mark appearing before or after major syntactic constructs.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_DEC_ITEM

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

	make (a_f_name: STRING) is
			-- Initialize Current with `a_f_name'.
		require
			a_f_name_not_void: a_f_name /= Void
		do
			old_make (f_Feature_declaration)
			feature_name := a_f_name
		end

feature -- Access

	feature_name: STRING
			-- Feature this declaration defines.

feature {TEXT_FILTER} -- Access

	on_before_processing (f: TEXT_FILTER) is
			-- `Current' is about to be processed.
		do
			f.set_keyword (kw_Feature, feature_name)
		end

	on_after_processing (f: TEXT_FILTER) is
			-- `Current' has just been processed.
		do
			f.set_keyword (kw_Feature, Void)
		end

end -- class FILTER_ITEM

