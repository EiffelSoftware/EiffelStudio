class TEST

create
	make

feature {NONE} -- Creation

	make is
		do
			test_single_generic
			test_double_generic
			test_same_types
		end

feature {NONE} -- Implementation

	test_single_generic is
		local
			a_att: A [!ANY]
			a_det: A [?ANY]
		do
			a_att ?= create {A [?ANY]}
			check_for_true (a_att = Void)
			a_att ?= create {A [!ANY]}
			check_for_true (a_att /= Void)

			a_att ?= create {A [?C]}
			check_for_true (a_att = Void)
			a_att ?= create {A [!C]}
			check_for_true (a_att /= Void)


			a_att ?= create {A [INTEGER]}
			check_for_true (a_att /= Void)
			a_att ?= create {A [?INTEGER]}
			check_for_true (a_att /= Void)
			a_att ?= create {A [!INTEGER]}
			check_for_true (a_att /= Void)

			a_att ?= create {A [?STRING]}
			check_for_true (a_att = Void)
			a_att ?= create {A [!STRING]}
			check_for_true (a_att /= Void)

			a_det ?= create {A [?ANY]}
			check_for_true (a_att /= Void)
			a_det ?= create {A [!ANY]}
			check_for_true (a_att /= Void)

			a_det ?= create {A [?C]}
			check_for_true (a_att /= Void)
			a_det ?= create {A [!C]}
			check_for_true (a_att /= Void)

			a_det ?= create {A [?INTEGER]}
			check_for_true (a_det /= Void)
			a_det ?= create {A [!INTEGER]}
			check_for_true (a_det /= Void)

			a_det ?= create {A [?STRING]}
			check_for_true (a_det /= Void)
			a_det ?= create {A [!STRING]}
			check_for_true (a_det /= Void)
		end

	test_double_generic is
		local
			b_att_att: B [!ANY, !ANY]
			b_att_det: B [!ANY, ?ANY]
			b_det_det: B [?ANY, ?ANY]
			b_det_att: B [?ANY, !ANY]
		do
			b_att_att ?= create {B [!INTEGER, !INTEGER]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, !INTEGER]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true (b_att_att /= Void)

			b_att_att ?= create {B [!STRING, !STRING]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [!STRING, ?STRING]}
			check_for_true (b_att_att = Void)
			b_att_att ?= create {B [?STRING, !STRING]}
			check_for_true (b_att_att = Void)
			b_att_att ?= create {B [?STRING, ?STRING]}
			check_for_true (b_att_att = Void)

			b_att_att ?= create {B [!STRING, !INTEGER]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [!STRING, ?INTEGER]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [?STRING, !INTEGER]}
			check_for_true (b_att_att = Void)
			b_att_att ?= create {B [?STRING, ?INTEGER]}
			check_for_true (b_att_att = Void)

			b_att_att ?= create {B [!INTEGER, !STRING]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [!INTEGER, ?STRING]}
			check_for_true (b_att_att = Void)
			b_att_att ?= create {B [?INTEGER, !STRING]}
			check_for_true (b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, ?STRING]}
			check_for_true (b_att_att = Void)

			b_att_det ?= create {B [!INTEGER, !INTEGER]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, !INTEGER]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true (b_att_det /= Void)

			b_att_det ?= create {B [!STRING, !STRING]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [!STRING, ?STRING]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?STRING, !STRING]}
			check_for_true (b_att_det = Void)
			b_att_det ?= create {B [?STRING, ?STRING]}
			check_for_true (b_att_det = Void)

			b_att_det ?= create {B [!STRING, !INTEGER]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [!STRING, ?INTEGER]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?STRING, !INTEGER]}
			check_for_true (b_att_det = Void)
			b_att_det ?= create {B [?STRING, ?INTEGER]}
			check_for_true (b_att_det = Void)

			b_att_det ?= create {B [!INTEGER, !STRING]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [!INTEGER, ?STRING]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, !STRING]}
			check_for_true (b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, ?STRING]}
			check_for_true (b_att_det /= Void)

			b_det_det ?= create {B [!INTEGER, !INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, !INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true (b_det_det /= Void)

			b_det_det ?= create {B [!STRING, !STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [!STRING, ?STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?STRING, !STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?STRING, ?STRING]}
			check_for_true (b_det_det /= Void)

			b_det_det ?= create {B [!STRING, !INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [!STRING, ?INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?STRING, !INTEGER]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?STRING, ?INTEGER]}
			check_for_true (b_det_det /= Void)

			b_det_det ?= create {B [!INTEGER, !STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [!INTEGER, ?STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, !STRING]}
			check_for_true (b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, ?STRING]}
			check_for_true (b_det_det /= Void)

			b_det_att ?= create {B [!INTEGER, !INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, !INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true (b_det_att /= Void)

			b_det_att ?= create {B [!STRING, !STRING]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [!STRING, ?STRING]}
			check_for_true (b_det_att = Void)
			b_det_att ?= create {B [?STRING, !STRING]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?STRING, ?STRING]}
			check_for_true (b_det_att = Void)

			b_det_att ?= create {B [!STRING, !INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [!STRING, ?INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?STRING, !INTEGER]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?STRING, ?INTEGER]}
			check_for_true (b_det_att /= Void)

			b_det_att ?= create {B [!INTEGER, !STRING]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [!INTEGER, ?STRING]}
			check_for_true (b_det_att = Void)
			b_det_att ?= create {B [?INTEGER, !STRING]}
			check_for_true (b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, ?STRING]}
			check_for_true (b_det_att = Void)
		end

	test_same_types is
			-- Ensure that various ways of creating a type yield to the same dynamic type.
		do
			check_for_true (is_same_type (create {A [?ANY]}, create {!A [?ANY]}))
			check_for_true (is_same_type (create {A [?ANY]}, create {?A [?ANY]}))
			check_for_true (is_same_type (create {!A [?ANY]}, create {?A [?ANY]}))

			check_for_true (is_same_type (create {A [!ANY]}, create {!A [!ANY]}))
			check_for_true (is_same_type (create {A [!ANY]}, create {?A [!ANY]}))
			check_for_true (is_same_type (create {!A [!ANY]}, create {?A [!ANY]}))
		end

feature {NONE} -- Implementation

	check_for_true (val: BOOLEAN) is
		do
			if not val then
				io.put_string ("Failure%N")
			end
		end

	is_same_type (obj1, obj2: ANY): BOOLEAN is
		require
			not_void: obj1 /= Void and obj2 /= Void
		do
			Result := obj1.same_type (obj2)
		end


end
