indexing
	description: "Query lanaguage criterion checker to check if a givn criterion has certain characteristics"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CRITERION_CHECKER

inherit
	QL_CRITERION_ITERATOR
		export
			{NONE} all
		redefine
			process_intrinsic_domain_criterion,
			process_domain_criterion
		end

feature -- Checking

	check_criterion (a_criterion: QL_CRITERION) is
			-- Check `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			init
			process_criterion_item (a_criterion)
		end

feature -- Status report

	has_delayed_domain: BOOLEAN
			-- Does given criterion use delayed domain?

feature{NONE} -- Implementation

	init is
			-- Initialize before checking.
		do
			has_delayed_domain := False
		end

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
			process_domain_criterion (a_cri)
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		local
			l_criterion_domain: QL_DOMAIN
		do
			l_criterion_domain := a_cri.criterion_domain
			if l_criterion_domain /= Void and then l_criterion_domain.is_delayed then
				has_delayed_domain := True
			end
		end

end
