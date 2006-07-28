indexing
	description: "[
					Delayed domain replacer.
					It can replace all delayed domains in a given criterion with a new domain.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_DELAYED_DOMAIN_REPLACER

inherit
	QL_CRITERION_ITERATOR
		export
			{NONE} all
		redefine
			process_intrinsic_domain_criterion,
			process_domain_criterion
		end

feature -- Access

	new_domain: QL_DOMAIN
			-- New domain which will replace all delayed domains in given criterion

feature -- Setting

	set_new_domain (a_domain: like new_domain) is
			-- Set `new_domain' with `a_domain'.
		do
			new_domain := a_domain
		ensure
			new_domain_set: new_domain = a_domain
		end

feature -- Replacement

	replace (a_criterion: QL_CRITERION) is
			-- Replace all delayed domains in `a_criterion' by `new_domain'.
		do
			process_criterion_item (a_criterion)
		end

feature{NONE} -- Implementation

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
			process_domain_criterion (a_cri)
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		local
			l_old_domain: QL_DOMAIN
		do
			l_old_domain := a_cri.criterion_domain
			if l_old_domain /= Void and then l_old_domain.is_delayed then
				a_cri.set_criterion_domain (new_domain)
			end
		end

end
