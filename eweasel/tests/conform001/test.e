class TEST

create
	make

feature {NONE} -- Creation

	make is
		do
			test_anchors
			test_single_generic
			test_double_generic
			test_same_types
		end

feature {NONE} -- Implementation

	test_anchors is
		local
			a_1: A [like x]
			a_2: A [?like x]
			a_3: A [!like x]

			a_4: A [like att_x]
			a_5: A [?like att_x]
			a_6: A [!like att_x]

			a_7: A [like det_x]
			a_8: A [?like det_x]
			a_9: A [!like det_x]

			b_1: A [like y]
			b_2: A [?like y]
			b_3: A [!like y]

			b_4: A [like att_y]
			b_5: A [?like att_y]
			b_6: A [!like att_y]

			b_7: A [like det_y]
			b_8: A [?like det_y]
			b_9: A [!like det_y]
		do
			create x
			check_for_true ("anchors - 1", is_same_type (x, create {C}))
			create att_x
			check_for_true ("anchors - 2", is_same_type (att_x, create {C}))
			create det_x
			check_for_true ("anchors - 3", is_same_type (det_x, create {C}))

			create y
			check_for_true ("anchors - 4", is_same_type (y, create {C}))
			create att_y
			check_for_true ("anchors - 5", is_same_type (att_y, create {C}))
			create det_y
			check_for_true ("anchors - 6", is_same_type (det_y, create {C}))

			create a_1
			check_for_true ("anchors - 7", is_same_type (a_1, create {A [?C]}))
			create a_2
			check_for_true ("anchors - 8", is_same_type (a_2, create {A [?C]}))
			create a_3
			check_for_true ("anchors - 9", is_same_type (a_3, create {A [!C]}))

			create a_4
			check_for_true ("anchors - 10", is_same_type (a_4, create {A [!C]}))
			create a_5
			check_for_true ("anchors - 11", is_same_type (a_5, create {A [?C]}))
			create a_6
			check_for_true ("anchors - 12", is_same_type (a_6, create {A [!C]}))

			create a_7
			check_for_true ("anchors - 13", is_same_type (a_7, create {A [?C]}))
			create a_8
			check_for_true ("anchors - 14", is_same_type (a_8, create {A [?C]}))
			create a_9
			check_for_true ("anchors - 15", is_same_type (a_9, create {A [!C]}))

			create b_1
			check_for_true ("anchors - 16", is_same_type (b_1, create {A [?C]}))
			create b_2
			check_for_true ("anchors - 17", is_same_type (b_2, create {A [?C]}))
			create b_3
			check_for_true ("anchors - 18", is_same_type (b_3, create {A [!C]}))

			create b_4
			check_for_true ("anchors - 19", is_same_type (b_4, create {A [!C]}))
			create b_5
			check_for_true ("anchors - 20", is_same_type (b_5, create {A [?C]}))
			create b_6
			check_for_true ("anchors - 21", is_same_type (b_6, create {A [!C]}))

			create b_7
			check_for_true ("anchors - 22", is_same_type (b_7, create {A [?C]}))
			create b_8
			check_for_true ("anchors - 23", is_same_type (b_8, create {A [?C]}))
			create b_9
			check_for_true ("anchors - 24", is_same_type (b_9, create {A [!C]}))
		end

	x: C
	att_x: !C
	det_x: ?C

	y: like x
	att_y: !like x
	det_y: ?like x

	test_single_generic is
		local
			a_att: A [!ANY]
			a_det: A [?ANY]
		do
			a_att ?= create {A [?ANY]}
			check_for_true ("single generic - 1", a_att = Void)
			a_att ?= create {A [!ANY]}
			check_for_true ("single generic - 2", a_att /= Void)

			a_att ?= create {A [?C]}
			check_for_true ("single generic - 3", a_att = Void)
			a_att ?= create {A [!C]}
			check_for_true ("single generic - 4", a_att /= Void)


			a_att ?= create {A [INTEGER]}
			check_for_true ("single generic - 5", a_att /= Void)
			a_att ?= create {A [?INTEGER]}
			check_for_true ("single generic - 6", a_att /= Void)
			a_att ?= create {A [!INTEGER]}
			check_for_true ("single generic - 7", a_att /= Void)

			a_att ?= create {A [?STRING]}
			check_for_true ("single generic - 8", a_att = Void)
			a_att ?= create {A [!STRING]}
			check_for_true ("single generic - 9", a_att /= Void)

			a_det ?= create {A [?ANY]}
			check_for_true ("single generic - 10", a_att /= Void)
			a_det ?= create {A [!ANY]}
			check_for_true ("single generic - 11", a_att /= Void)

			a_det ?= create {A [?C]}
			check_for_true ("single generic - 12", a_att /= Void)
			a_det ?= create {A [!C]}
			check_for_true ("single generic - 13", a_att /= Void)

			a_det ?= create {A [?INTEGER]}
			check_for_true ("single generic - 14", a_det /= Void)
			a_det ?= create {A [!INTEGER]}
			check_for_true ("single generic - 15", a_det /= Void)

			a_det ?= create {A [?STRING]}
			check_for_true ("single generic - 16", a_det /= Void)
			a_det ?= create {A [!STRING]}
			check_for_true ("single generic - 17", a_det /= Void)

				-- Case of anchors
			a_att ?= create {like anchor_1}
			check_for_true ("single generic - 18", a_att = Void)
			a_att ?= create {like anchor_2}
			check_for_true ("single generic - 19", a_att /= Void)

			a_det ?= create {like anchor_1}
			check_for_true ("single generic - 20", a_det /= Void)
			a_det ?= create {like anchor_2}
			check_for_true ("single generic - 21", a_det /= Void)

			a_att ?= create {like anchor_3}
			check_for_true ("single generic - 22", a_att = Void)
			a_att ?= create {like anchor_4}
			check_for_true ("single generic - 23", a_att /= Void)

			a_det ?= create {like anchor_3}
			check_for_true ("single generic - 24", a_det /= Void)
			a_det ?= create {like anchor_4}
			check_for_true ("single generic - 25", a_det /= Void)

			a_att ?= create {like anchor_5}
			check_for_true ("single generic - 26", a_att = Void)
			a_att ?= create {like anchor_6}
			check_for_true ("single generic - 27", a_att /= Void)

			a_det ?= create {like anchor_5}
			check_for_true ("single generic - 28", a_det /= Void)
			a_det ?= create {like anchor_6}
			check_for_true ("single generic - 29", a_det /= Void)
		end

	test_double_generic is
		local
			b_att_att: B [!ANY, !ANY]
			b_att_det: B [!ANY, ?ANY]
			b_det_det: B [?ANY, ?ANY]
			b_det_att: B [?ANY, !ANY]
		do
			b_att_att ?= create {B [!INTEGER, !INTEGER]}
			check_for_true ("double generic - 1", b_att_att /= Void)
			b_att_att ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true ("double generic - 2", b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, !INTEGER]}
			check_for_true ("double generic - 3", b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true ("double generic - 4", b_att_att /= Void)

			b_att_att ?= create {B [!STRING, !STRING]}
			check_for_true ("double generic - 5", b_att_att /= Void)
			b_att_att ?= create {B [!STRING, ?STRING]}
			check_for_true ("double generic - 6", b_att_att = Void)
			b_att_att ?= create {B [?STRING, !STRING]}
			check_for_true ("double generic - 7", b_att_att = Void)
			b_att_att ?= create {B [?STRING, ?STRING]}
			check_for_true ("double generic - 8", b_att_att = Void)

			b_att_att ?= create {B [!STRING, !INTEGER]}
			check_for_true ("double generic - 9", b_att_att /= Void)
			b_att_att ?= create {B [!STRING, ?INTEGER]}
			check_for_true ("double generic - 10", b_att_att /= Void)
			b_att_att ?= create {B [?STRING, !INTEGER]}
			check_for_true ("double generic - 11", b_att_att = Void)
			b_att_att ?= create {B [?STRING, ?INTEGER]}
			check_for_true ("double generic - 12", b_att_att = Void)

			b_att_att ?= create {B [!INTEGER, !STRING]}
			check_for_true ("double generic - 13", b_att_att /= Void)
			b_att_att ?= create {B [!INTEGER, ?STRING]}
			check_for_true ("double generic - 14", b_att_att = Void)
			b_att_att ?= create {B [?INTEGER, !STRING]}
			check_for_true ("double generic - 15", b_att_att /= Void)
			b_att_att ?= create {B [?INTEGER, ?STRING]}
			check_for_true ("double generic - 16", b_att_att = Void)

			b_att_det ?= create {B [!INTEGER, !INTEGER]}
			check_for_true ("double generic - 17", b_att_det /= Void)
			b_att_det ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true ("double generic - 18", b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, !INTEGER]}
			check_for_true ("double generic - 19", b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true ("double generic - 20", b_att_det /= Void)

			b_att_det ?= create {B [!STRING, !STRING]}
			check_for_true ("double generic - 21", b_att_det /= Void)
			b_att_det ?= create {B [!STRING, ?STRING]}
			check_for_true ("double generic - 22", b_att_det /= Void)
			b_att_det ?= create {B [?STRING, !STRING]}
			check_for_true ("double generic - 23", b_att_det = Void)
			b_att_det ?= create {B [?STRING, ?STRING]}
			check_for_true ("double generic - 24", b_att_det = Void)

			b_att_det ?= create {B [!STRING, !INTEGER]}
			check_for_true ("double generic - 25", b_att_det /= Void)
			b_att_det ?= create {B [!STRING, ?INTEGER]}
			check_for_true ("double generic - 26", b_att_det /= Void)
			b_att_det ?= create {B [?STRING, !INTEGER]}
			check_for_true ("double generic - 27", b_att_det = Void)
			b_att_det ?= create {B [?STRING, ?INTEGER]}
			check_for_true ("double generic - 28", b_att_det = Void)

			b_att_det ?= create {B [!INTEGER, !STRING]}
			check_for_true ("double generic - 29", b_att_det /= Void)
			b_att_det ?= create {B [!INTEGER, ?STRING]}
			check_for_true ("double generic - 30", b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, !STRING]}
			check_for_true ("double generic - 31", b_att_det /= Void)
			b_att_det ?= create {B [?INTEGER, ?STRING]}
			check_for_true ("double generic - 32", b_att_det /= Void)

			b_det_det ?= create {B [!INTEGER, !INTEGER]}
			check_for_true ("double generic - 33", b_det_det /= Void)
			b_det_det ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true ("double generic - 34", b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, !INTEGER]}
			check_for_true ("double generic - 35", b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true ("double generic - 36", b_det_det /= Void)

			b_det_det ?= create {B [!STRING, !STRING]}
			check_for_true ("double generic - 37", b_det_det /= Void)
			b_det_det ?= create {B [!STRING, ?STRING]}
			check_for_true ("double generic - 38", b_det_det /= Void)
			b_det_det ?= create {B [?STRING, !STRING]}
			check_for_true ("double generic - 39", b_det_det /= Void)
			b_det_det ?= create {B [?STRING, ?STRING]}
			check_for_true ("double generic - 40", b_det_det /= Void)

			b_det_det ?= create {B [!STRING, !INTEGER]}
			check_for_true ("double generic - 41", b_det_det /= Void)
			b_det_det ?= create {B [!STRING, ?INTEGER]}
			check_for_true ("double generic - 42", b_det_det /= Void)
			b_det_det ?= create {B [?STRING, !INTEGER]}
			check_for_true ("double generic - 43", b_det_det /= Void)
			b_det_det ?= create {B [?STRING, ?INTEGER]}
			check_for_true ("double generic - 44", b_det_det /= Void)

			b_det_det ?= create {B [!INTEGER, !STRING]}
			check_for_true ("double generic - 45", b_det_det /= Void)
			b_det_det ?= create {B [!INTEGER, ?STRING]}
			check_for_true ("double generic - 46", b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, !STRING]}
			check_for_true ("double generic - 47", b_det_det /= Void)
			b_det_det ?= create {B [?INTEGER, ?STRING]}
			check_for_true ("double generic - 48", b_det_det /= Void)

			b_det_att ?= create {B [!INTEGER, !INTEGER]}
			check_for_true ("double generic - 49", b_det_att /= Void)
			b_det_att ?= create {B [!INTEGER, ?INTEGER]}
			check_for_true ("double generic - 50", b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, !INTEGER]}
			check_for_true ("double generic - 51", b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, ?INTEGER]}
			check_for_true ("double generic - 52", b_det_att /= Void)

			b_det_att ?= create {B [!STRING, !STRING]}
			check_for_true ("double generic - 53", b_det_att /= Void)
			b_det_att ?= create {B [!STRING, ?STRING]}
			check_for_true ("double generic - 54", b_det_att = Void)
			b_det_att ?= create {B [?STRING, !STRING]}
			check_for_true ("double generic - 55", b_det_att /= Void)
			b_det_att ?= create {B [?STRING, ?STRING]}
			check_for_true ("double generic - 56", b_det_att = Void)

			b_det_att ?= create {B [!STRING, !INTEGER]}
			check_for_true ("double generic - 57", b_det_att /= Void)
			b_det_att ?= create {B [!STRING, ?INTEGER]}
			check_for_true ("double generic - 58", b_det_att /= Void)
			b_det_att ?= create {B [?STRING, !INTEGER]}
			check_for_true ("double generic - 59", b_det_att /= Void)
			b_det_att ?= create {B [?STRING, ?INTEGER]}
			check_for_true ("double generic - 60", b_det_att /= Void)

			b_det_att ?= create {B [!INTEGER, !STRING]}
			check_for_true ("double generic - 61", b_det_att /= Void)
			b_det_att ?= create {B [!INTEGER, ?STRING]}
			check_for_true ("double generic - 62", b_det_att = Void)
			b_det_att ?= create {B [?INTEGER, !STRING]}
			check_for_true ("double generic - 63", b_det_att /= Void)
			b_det_att ?= create {B [?INTEGER, ?STRING]}
			check_for_true ("double generic - 64", b_det_att = Void)
		end

	test_same_types is
			-- Ensure that various ways of creating a type yield to the same dynamic type.
		do
			check_for_true ("same_type - 1", is_same_type (create {A [?ANY]}, create {!A [?ANY]}))
			check_for_true ("same_type - 2", is_same_type (create {A [?ANY]}, create {?A [?ANY]}))
			check_for_true ("same_type - 3", is_same_type (create {!A [?ANY]}, create {?A [?ANY]}))

			check_for_true ("same_type - 4", is_same_type (create {A [!ANY]}, create {!A [!ANY]}))
			check_for_true ("same_type - 5", is_same_type (create {A [!ANY]}, create {?A [!ANY]}))
			check_for_true ("same_type - 6", is_same_type (create {!A [!ANY]}, create {?A [!ANY]}))

			check_for_true ("same_type - 7", is_same_type (create {like anchor_1}, create {A [?ANY]}))
			check_for_true ("same_type - 8", is_same_type (create {like anchor_2}, create {A [!ANY]}))
			check_for_true ("same_type - 9", is_same_type (create {like anchor_3}, create {A [?ANY]}))
			check_for_true ("same_type - 10", is_same_type (create {like anchor_4}, create {A [!ANY]}))
			check_for_true ("same_type - 11", is_same_type (create {like anchor_5}, create {A [?ANY]}))
			check_for_true ("same_type - 12", is_same_type (create {like anchor_6}, create {A [!ANY]}))
		end

	anchor_1: A [?ANY]
	anchor_2: A [!ANY]
	anchor_3: !A [?ANY]
	anchor_4: !A [!ANY]
	anchor_5: ?A [?ANY]
	anchor_6: ?A [!ANY]

feature {NONE} -- Implementation

	check_for_true (str: STRING; val: BOOLEAN) is
		require
			str_not_void: str /= Void
		do
			if not val then
				io.put_string ("Failure at " + str + "%N")
			end
		end

	is_same_type (obj1, obj2: ANY): BOOLEAN is
		require
			not_void: obj1 /= Void and obj2 /= Void
		do
			Result := obj1.same_type (obj2)
		end

end
