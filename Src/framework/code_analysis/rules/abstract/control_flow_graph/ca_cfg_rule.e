note
	description: "A rule that operates on the Control Flow Graphs of features."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_CFG_RULE

inherit
	CA_RULE

	CA_CFG_ITERATOR

feature -- Status report

	is_empty: BOOLEAN
			-- Is there no data collected?
		deferred
		end

feature -- Status setting

	wipe_out
			-- Remove any previously collected data.
		deferred
		ensure
			is_empty: is_empty
		end

feature -- Rule Checking

	check_class (a_class: attached CLASS_C)
			-- Checks `a_class'.
		do
			across a_class.written_in_features as l_features loop
				check_feature (a_class, l_features)
			end
		end

feature {NONE} -- Implementation

	check_feature (a_class: attached CLASS_C; a_feature: attached E_FEATURE)
			-- Checks feature `a_feature' of class `a_class'.
		local
			l_cfg_builder: CA_CFG_BUILDER
		do
				-- Clean any previously collected data.
			wipe_out
				-- Check only features with an internal body.
			if
				a_feature.ast.body.is_routine and then
				attached {INTERNAL_AS} a_feature.ast.body.as_routine.routine_body
			then
				current_feature := a_feature
				create l_cfg_builder.make_with_feature (a_feature.ast)
				l_cfg_builder.build_cfg
				process_cfg (l_cfg_builder.cfg)
			end
		end

	current_feature: E_FEATURE
			-- The feature that is being checked.

end
