indexing
	description: "Visitor to visit a criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION_VISITOR

feature -- Process

	process_criterion (a_cri: QL_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_binary_criterion (a_cri: QL_BINARY_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_unary_criterion (a_cri: QL_UNARY_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_not_criterion (a_cri: QL_NOT_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_and_criterion (a_cri: QL_AND_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_or_criterion (a_cri: QL_OR_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_criterion_adapter (a_cri: QL_CRITERION_ADAPTER) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_compiled_imp_criterion (a_cri: QL_ITEM_IS_COMPILED_CRI_IMP) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_true_criterion (a_cri: QL_TRUE_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_false_criterion (a_cri: QL_FALSE_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		deferred
		end

end
