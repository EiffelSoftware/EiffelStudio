note
	description: "Helper class for projecting functions over pairs on their first component."

class
	V_TUPLE_PROJECTOR [K, V, RES]

feature -- Access

	project_one (f: FUNCTION [K, RES]): FUNCTION [TUPLE [TUPLE[K, V]], RES]
			-- Projected function with one argument.
		do
			Result := agent (kv: TUPLE [key: K; value: V]; kf: FUNCTION [K, RES]): RES
					do
						Result := kf.item ([kv.key])
					end (?, f)
		end

	project_one_predicate (f: PREDICATE [K]): PREDICATE [TUPLE [TUPLE[K, V]]]
			-- Projected predicate with one argument.
		do
			Result := agent (kv: TUPLE [key: K; value: V]; kf: PREDICATE [K]): BOOLEAN
					do
						Result := kf.item ([kv.key])
					end (?, f)
		end

	project_two (f: FUNCTION [K, K, RES]): FUNCTION [TUPLE[K, V], TUPLE[K, V], RES]
			-- Projected function with two arguments.
		do
			Result := agent (kv1, kv2: TUPLE [key: K; value: V]; kf: FUNCTION [K, K, RES]): RES
					do
						Result := kf.item ([kv1.key, kv2.key])
					end (?, ?, f)
		end

	project_two_predicate (f: PREDICATE [K, K]): PREDICATE [TUPLE[K, V], TUPLE[K, V]]
			-- Projected predicate with two arguments.
		do
			Result := agent (kv1, kv2: TUPLE [key: K; value: V]; kf: PREDICATE [K, K]): BOOLEAN
					do
						Result := kf.item ([kv1.key, kv2.key])
					end (?, ?, f)
		end
end
