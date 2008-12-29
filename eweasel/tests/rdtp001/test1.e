
class TEST1 [G -> {STRING, STRING, STRING, STRING} create make end]
feature
	try
		do
			create x.make (47)
			from
			variant
				True
			until
				False
			loop
			end
			from
			until
				False
			loop
			variant
				True
			end
		end

	x: G

	f (t: Tuple [Any])
		do
		end

	dynamic_boolean_type: INTEGER once Result := dynamic_type_from_string ((False).generating_type) end
	dynamic_character_8_type: INTEGER once Result := dynamic_type_from_string (({CHARACTER_8} '%U').generating_type) end
	dynamic_character_32_type: INTEGER once Result := dynamic_type_from_string (({CHARACTER_32} '%U').generating_type) end
	dynamic_integer_8_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_8} 0).generating_type) end
	dynamic_integer_16_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_16} 0).generating_type) end
	dynamic_integer_32_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_32} 0).generating_type) end
	dynamic_integer_64_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_64} 0).generating_type) end
	dynamic_natural_8_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_8} 0).generating_type) end
	dynamic_natural_16_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_16} 0).generating_type) end
	dynamic_natural_32_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_32} 0).generating_type) end
	dynamic_natural_64_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_64} 0).generating_type) end
	dynamic_real_32_type: INTEGER once Result := dynamic_type_from_string (({REAL_32} 0.0).generating_type) end
	dynamic_real_64_type: INTEGER once Result := dynamic_type_from_string (({REAL_64} 0.0).generating_type) end
	dynamic_pointer_type: INTEGER once Result := dynamic_type_from_string ((default_pointer).generating_type) end
	dynamic_string_8_type: INTEGER once Result := dynamic_type_from_string ((create {STRING_8}.make_empty).generating_type) end
	dynamic_string_32_type: INTEGER once Result := dynamic_type_from_string ((create {STRING_32}.make_empty).generating_type) end

end

end
