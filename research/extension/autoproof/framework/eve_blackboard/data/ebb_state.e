note
	description: "Definition of state constants."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_STATE

feature -- Work states

	compilation: INTEGER = 1
			-- In compilation state.

	analysis: INTEGER = 2
			-- In analysis state.

	static_verification: INTEGER = 3
			-- In static verification state.

	dynamic_verification: INTEGER = 4
			-- In dynamic verification state.

	contract_inference: INTEGER = 5
			-- In contract inference state.

	body_inference: INTEGER = 6
			-- In body inference state.

	done: INTEGER = 7
			-- In a state where no tool can be applied anymore.

feature -- Result states

	unknown: INTEGER = 101
			-- Result unknown or not yet set.

	statically_verified: INTEGER = 102
			-- Is statically verified.

	dynamically_verified: INTEGER = 103
			-- Is dynamically verified.

	manual_fix: INTEGER = 104
			-- Needs manual fix of bug.

	manual_proof: INTEGER = 105
			-- Needs manual proof.

feature -- Status report

	is_valid_work_state (a_state: INTEGER): BOOLEAN
			-- Is `a_state' a valid work state?
		do
			Result := compilation <= a_state and then a_state <= body_inference
		end

	is_valid_result_state (a_state: INTEGER): BOOLEAN
			-- Is `a_state' a valid work state?
		do
			Result := unknown <= a_state and then a_state <= manual_proof
		end

feature -- Helper

	name_of_state (a_state: INTEGER): STRING
			-- Name of state `a_state'.
		do
			inspect a_state
			when compilation then
				Result := "compilation"
			when analysis then
				Result := "analysis"
			when static_verification then
				Result := "static_verification"
			when dynamic_verification then
				Result := "dynamic_verification"
			when contract_inference then
				Result := "contract_inference"
			when body_inference then
				Result := "body_inference"
			when unknown then
				Result := "unknown"
			when statically_verified then
				Result := "statically_verified"
			when dynamically_verified then
				Result := "dynamically_verified"
			when manual_fix then
				Result := "manual_fix"
			when manual_proof then
				Result := "manual_proof"
			else
				Result := "-- ERROR --"
			end
		end

end
