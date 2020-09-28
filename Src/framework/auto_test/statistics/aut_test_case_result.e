note
	description:

		"Test case result"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_RESULT

create

	make

feature {NONE} -- Initialization

	make (a_witness: like witness; a_class: like class_; a_feature: like feature_)
			-- Create new classification of feature `a_feature' from class `a_class' based on
			-- witness `a_witness'.
		require
			a_witness_not_void: a_witness /= Void
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			witness := a_witness
			class_ := a_class
			feature_ := a_feature
		ensure
			witness_set: witness = a_witness
			class_set: class_ = a_class
			feature_set: feature_ = a_feature
		end

feature -- Status Report

	is_pass: BOOLEAN
			-- Did test case pass?
		do
			Result := witness.is_pass
		end

	is_fail: BOOLEAN
			-- Did test case fail? This means a bug was found.
		do
			Result := witness.is_fail
		end

	is_invalid: BOOLEAN
			-- Was test case not executable because a prerequisite was not
			-- established? Most often this means a precondition was violated.
		do
			Result := witness.is_invalid
		end

	is_bad_response: BOOLEAN
			-- Did an unknown error occure that made the interpreter respond
			-- in an unexpected way?
		do
			Result := witness.is_bad_response
		end

feature -- Access

	class_: CLASS_C
			-- Class of `feature_'

	feature_: FEATURE_I
			-- Feature that was called

	witness: AUT_WITNESS
			-- Witness for this classification

invariant

	witness_not_void: witness /= Void
	class_not_void: class_ /= Void
	feature_not_void: feature_ /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
