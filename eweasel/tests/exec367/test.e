class
	TEST

inherit
	REFLECTOR

create
	make

feature
	make
		local
			l_type: TYPE [detachable ANY]
			l_attached_any_type, l_detachable_any_type: INTEGER
			l_reflected: REFLECTED_REFERENCE_OBJECT
		do
			l_type := {ANY}
			l_attached_any_type := l_type.type_id
			test_for_attached (l_type, l_type.type_id)

			l_type := {detachable ANY}
			l_detachable_any_type := l_type.type_id
			test_for_detachable (l_type, l_type.type_id)

			l_type := {attached ANY}
			assert ("Same attached ANY type", l_type, l_attached_any_type = l_type.type_id)
			test_for_attached (l_type, l_type.type_id)

			l_type := {INTEGER}
			test_for_attached (l_type, l_type.type_id)

			l_type := {detachable INTEGER}
			test_for_detachable (l_type, l_type.type_id)

			l_type := {attached INTEGER}
			test_for_attached (l_type, l_type.type_id)

			l_type := {TEST1}
			test_for_attached (l_type, l_type.type_id)

			l_type := {detachable TEST1}
			test_for_detachable (l_type, l_type.type_id)

			l_type := {attached TEST1}
			test_for_attached (l_type, l_type.type_id)

			l_type := {ARRAY [ANY]}
			l_type := l_type.generic_parameter_type (1)
			assert ("Same attached ID", l_type, l_type.type_id = l_attached_any_type)
			test_for_attached (l_type, l_type.type_id)

			l_type := {ARRAY [detachable ANY]}
			l_type := l_type.generic_parameter_type (1)
			assert ("Same detachable ID", l_type, l_type.type_id = l_detachable_any_type)
			test_for_detachable (l_type, l_type.type_id)

			create l_reflected.make (create {ARRAY [ANY]}.make_empty)
			assert ("Same attached ID", l_type, l_reflected.generic_dynamic_type (1) = l_attached_any_type)
			create l_reflected.make (create {ARRAY [detachable ANY]}.make_empty)
			assert ("Same detachable ID", l_type, l_reflected.generic_dynamic_type (1) = l_detachable_any_type)
		end

	assert (tag: STRING; type: TYPE [detachable ANY]; b: BOOLEAN)
		do
			if not b then
				io.put_string (tag)
				io.put_string (": ")
				io.put_string (type.name)
				io.put_new_line
			end
		end

	test_for_detachable (a_type: TYPE [detachable ANY]; a_type_id: INTEGER)
		do
			assert ("Detachable - Same query should yield same result", a_type, is_attached_type (a_type_id) = a_type.is_attached)

			assert ("Detachable - detachable type should not be attached", a_type, not is_attached_type (a_type_id) or a_type.is_expanded)

			assert ("Detachable - detachable type has a default", a_type, a_type.has_default)

			if not a_type.is_expanded then
				assert ("Detachable - The detachable version of detachable type is detachable type", a_type, a_type_id = detachable_type (a_type_id))
				assert ("Detachable - The attached version of detachable type is not detachable type", a_type, a_type_id /= attached_type (a_type_id))
			else
				assert ("Detachable - expanded type is not detachable", a_type, is_attached_type(a_type_id))
				assert ("Detachable - The detachable version of an expanded type is still the same", a_type, a_type_id = detachable_type (a_type_id))
				assert ("Detachable - The attached version of an expanded type is still the same", a_type, a_type_id = attached_type (a_type_id))
			end
		end

	test_for_attached (a_type: TYPE [detachable ANY]; a_type_id: INTEGER)
		do
			assert ("Attached - Same query should yield same result", a_type, is_attached_type (a_type_id) = a_type.is_attached)

			assert ("Attached - attached type should be attached", a_type, is_attached_type (a_type_id))

			assert ("Attached - attached type has no default", a_type, not a_type.has_default or a_type.is_expanded)

			if not a_type.is_expanded then
				assert ("Attached - The detachable version of attached type is detachable type", a_type, a_type_id /= detachable_type (a_type_id))
				assert ("Attached - The attached version of attached type is attached type", a_type, a_type_id = attached_type (a_type_id))
			else
				assert ("Attached - expanded type should be attached", a_type, is_attached_type (a_type_id))
				assert ("Attached - The detachable version of an expanded type is still the same", a_type, a_type_id = detachable_type (a_type_id))
				assert ("Attached - The attached version of an expanded type is still the same", a_type, a_type_id = attached_type (a_type_id))
			end
		end

end
