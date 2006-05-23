indexing
	description: "Iterator to go through every node of a criterion and do nothing"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CRITERION_ITERATOR

inherit
	QL_CRITERION_VISITOR

feature -- Process

	process_criterion_item (a_item: QL_CRITERION) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.process (Current)
		end

feature{NONE} -- Process

	process_criterion (a_cri: QL_CRITERION) is
			-- Process `a_cri'.
		do
		end

	process_binary_criterion (a_cri: QL_BINARY_CRITERION) is
			-- Process `a_cri'.
		do
			a_cri.left.process (Current)
			a_cri.right.process (Current)
		end

	process_unary_criterion (a_cri: QL_UNARY_CRITERION) is
			-- Process `a_cri'.
		do
			a_cri.wrapped_criterion.process (Current)
		end

	process_not_criterion (a_cri: QL_NOT_CRITERION) is
			-- Process `a_cri'.
		do
			process_unary_criterion (a_cri)
		end

	process_and_criterion (a_cri: QL_AND_CRITERION) is
			-- Process `a_cri'.
		do
			process_binary_criterion (a_cri)
		end

	process_or_criterion (a_cri: QL_OR_CRITERION) is
			-- Process `a_cri'.
		do
			process_binary_criterion (a_cri)
		end

	process_criterion_adapter (a_cri: QL_CRITERION_ADAPTER) is
			-- Process `a_cri'.
		do
			a_cri.wrapped_criterion.process (Current)
		end

	process_compiled_imp_criterion (a_cri: QL_ITEM_IS_COMPILED_CRI_IMP) is
			-- Process `a_cri'.
		do
			process_criterion_adapter (a_cri)
		end

	process_true_criterion (a_cri: QL_TRUE_CRITERION) is
			-- Process `a_cri'.
		do
		end

	process_false_criterion (a_cri: QL_FALSE_CRITERION) is
			-- Process `a_cri'.
		do
		end

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
		end

end
