note
	description: "Helper class for projecting functions over pairs on their first component."

class
	V_TUPLE_PROJECTOR [K, V, RES]

feature -- Access

	project_one (f: FUNCTION [ANY, TUPLE [K], RES]): FUNCTION [ANY, TUPLE [TUPLE[K, V]], RES]
			-- Projected function with one argument.
		do
			Result := agent (kv: TUPLE [key: K; value: V]; kf: FUNCTION [ANY, TUPLE [K], RES]): RES
					do
						Result := kf.item ([kv.key])
					end (?, f)
		end

	project_one_predicate (f: PREDICATE [ANY, TUPLE [K]]): PREDICATE [ANY, TUPLE [TUPLE[K, V]]]
			-- Projected predicate with one argument.
		do
			Result := agent (kv: TUPLE [key: K; value: V]; kf: PREDICATE [ANY, TUPLE [K]]): BOOLEAN
					do
						Result := kf.item ([kv.key])
					end (?, f)
		end

	project_two (f: FUNCTION [ANY, TUPLE [K, K], RES]): FUNCTION [ANY, TUPLE [TUPLE[K, V], TUPLE[K, V]], RES]
			-- Projected function with two arguments.
		do
			Result := agent (kv1, kv2: TUPLE [key: K; value: V]; kf: FUNCTION [ANY, TUPLE [K, K], RES]): RES
					do
						Result := kf.item ([kv1.key, kv2.key])
					end (?, ?, f)
		end

	project_two_predicate (f: PREDICATE [ANY, TUPLE [K, K]]): PREDICATE [ANY, TUPLE [TUPLE[K, V], TUPLE[K, V]]]
			-- Projected predicate with two arguments.
		do
			Result := agent (kv1, kv2: TUPLE [key: K; value: V]; kf: PREDICATE [ANY, TUPLE [K, K]]): BOOLEAN
					do
						Result := kf.item ([kv1.key, kv2.key])
					end (?, ?, f)
		end
end
