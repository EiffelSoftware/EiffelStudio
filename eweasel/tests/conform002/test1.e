class TEST1 [G -> ANY create default_create end]

create
	make

feature {NONE} -- Creation

	make (is_attached: BOOLEAN) is
		do
			io.put_string ((create {A [?G]}).generating_type)
			io.put_new_line
			io.put_string ((create {A [!G]}).generating_type)
			io.put_new_line
			io.put_string ((create {A [G]}).generating_type)
			io.put_new_line
			test_anchors
			test_single_generic (is_attached)
			test_same_types (is_attached)
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
			check_for_true ("anchors - 1", is_same_type (x, create {G}))
			create att_x
			check_for_true ("anchors - 2", is_same_type (att_x, create {G}))
			create det_x
			check_for_true ("anchors - 3", is_same_type (det_x, create {G}))

			create y
			check_for_true ("anchors - 4", is_same_type (y, create {G}))
			create att_y
			check_for_true ("anchors - 5", is_same_type (att_y, create {G}))
			create det_y
			check_for_true ("anchors - 6", is_same_type (det_y, create {G}))

			create a_1
			check_for_true ("anchors - 7", is_same_type (a_1, create {A [G]}))
			create a_2
			check_for_true ("anchors - 8", is_same_type (a_2, create {A [?G]}))
			create a_3
			check_for_true ("anchors - 9", is_same_type (a_3, create {A [!G]}))

			create a_4
			check_for_true ("anchors - 10", is_same_type (a_4, create {A [!G]}))
			create a_5
			check_for_true ("anchors - 11", is_same_type (a_5, create {A [?G]}))
			create a_6
			check_for_true ("anchors - 12", is_same_type (a_6, create {A [!G]}))

			create a_7
			check_for_true ("anchors - 13", is_same_type (a_7, create {A [?G]}))
			create a_8
			check_for_true ("anchors - 14", is_same_type (a_8, create {A [?G]}))
			create a_9
			check_for_true ("anchors - 15", is_same_type (a_9, create {A [!G]}))

			create b_1
			check_for_true ("anchors - 16", is_same_type (b_1, create {A [G]}))
			create b_2
			check_for_true ("anchors - 17", is_same_type (b_2, create {A [?G]}))
			create b_3
			check_for_true ("anchors - 18", is_same_type (b_3, create {A [!G]}))

			create b_4
			check_for_true ("anchors - 19", is_same_type (b_4, create {A [!G]}))
			create b_5
			check_for_true ("anchors - 20", is_same_type (b_5, create {A [?G]}))
			create b_6
			check_for_true ("anchors - 21", is_same_type (b_6, create {A [!G]}))

			create b_7
			check_for_true ("anchors - 22", is_same_type (b_7, create {A [?G]}))
			create b_8
			check_for_true ("anchors - 23", is_same_type (b_8, create {A [?G]}))
			create b_9
			check_for_true ("anchors - 24", is_same_type (b_9, create {A [!G]}))
		end

	x: G
	att_x: !G
	det_x: ?G

	y: like x
	att_y: !like x
	det_y: ?like x

	test_single_generic (is_attached: BOOLEAN) is
		local
			a_att: A [!G]
			a_det: A [?G]
			a_neutral: A [G]
		do
			a_att ?= create {A [?G]}
			check_for_true ("single generic - 1", a_att = Void)
			a_att ?= create {A [!G]}
			check_for_true ("single generic - 2", a_att /= Void)
			a_att ?= create {A [G]}
			if is_attached then
				check_for_true ("single generic - 3", a_att /= Void)
			else
				check_for_true ("single generic - 4", a_att = Void)
			end

			a_det ?= create {A [?G]}
			check_for_true ("single generic - 5", a_det /= Void)
			a_det ?= create {A [!G]}
			check_for_true ("single generic - 6", a_det /= Void)
			a_det ?= create {A [G]}
			check_for_true ("single generic - 7", a_det /= Void)

			a_neutral ?= create {A [?G]}
			if is_attached then
				check_for_true ("single generic - 8", a_neutral = Void)
			else
				check_for_true ("single generic - 9", a_neutral /= Void)
			end
			a_neutral ?= create {A [!G]}
			check_for_true ("single generic - 10", a_neutral /= Void)
			a_neutral ?= create {A [G]}
			check_for_true ("single generic - 11", a_neutral /= Void)

				-- Case of anchors
			a_att ?= create {like anchor_1}
			check_for_true ("single generic - 12", a_att = Void)
			a_att ?= create {like anchor_2}
			check_for_true ("single generic - 13", a_att /= Void)
			a_att ?= create {like anchor_7}
			if is_attached then
				check_for_true ("single generic - 14", a_att /= Void)
			else
				check_for_true ("single generic - 15", a_att = Void)
			end

			a_det ?= create {like anchor_1}
			check_for_true ("single generic - 16", a_det /= Void)
			a_det ?= create {like anchor_2}
			check_for_true ("single generic - 17", a_det /= Void)
			a_det ?= create {like anchor_7}
			check_for_true ("single generic - 18", a_det /= Void)

			a_att ?= create {like anchor_3}
			check_for_true ("single generic - 19", a_att = Void)
			a_att ?= create {like anchor_4}
			check_for_true ("single generic - 20", a_att /= Void)
			a_att ?= create {like anchor_8}
			if is_attached then
				check_for_true ("single generic - 21", a_att /= Void)
			else
				check_for_true ("single generic - 22", a_att = Void)
			end

			a_det ?= create {like anchor_3}
			check_for_true ("single generic - 23", a_det /= Void)
			a_det ?= create {like anchor_4}
			check_for_true ("single generic - 24", a_det /= Void)
			a_det ?= create {like anchor_8}
			check_for_true ("single generic - 25", a_det /= Void)

			a_att ?= create {like anchor_5}
			check_for_true ("single generic - 26", a_att = Void)
			a_att ?= create {like anchor_6}
			check_for_true ("single generic - 27", a_att /= Void)
			a_att ?= create {like anchor_9}
			if is_attached then
				check_for_true ("single generic - 28", a_att /= Void)
			else
				check_for_true ("single generic - 29", a_att = Void)
			end

			a_det ?= create {like anchor_5}
			check_for_true ("single generic - 30", a_det /= Void)
			a_det ?= create {like anchor_6}
			check_for_true ("single generic - 31", a_det /= Void)
			a_det ?= create {like anchor_9}
			check_for_true ("single generic - 32", a_det /= Void)
		end

	test_same_types (is_attached: BOOLEAN) is
			-- Ensure that various ways of creating a type yield to the same dynamic type.
		do
			check_for_true ("same_type - 1", is_same_type (create {A [?G]}, create {!A [?G]}))
			check_for_true ("same_type - 2", is_same_type (create {A [?G]}, create {?A [?G]}))
			check_for_true ("same_type - 3", is_same_type (create {!A [?G]}, create {?A [?G]}))

			check_for_true ("same_type - 5", is_same_type (create {A [!G]}, create {?A [!G]}))
			check_for_true ("same_type - 6", is_same_type (create {!A [!G]}, create {?A [!G]}))

			check_for_true ("same_type - 7", is_same_type (create {like anchor_1}, create {A [?G]}))
			check_for_true ("same_type - 8", is_same_type (create {like anchor_2}, create {A [!G]}))
			check_for_true ("same_type - 9", is_same_type (create {like anchor_3}, create {A [?G]}))
			check_for_true ("same_type - 10", is_same_type (create {like anchor_4}, create {A [!G]}))
			check_for_true ("same_type - 11", is_same_type (create {like anchor_5}, create {A [?G]}))
			check_for_true ("same_type - 12", is_same_type (create {like anchor_6}, create {A [!G]}))
			check_for_true ("same_type - 13", is_same_type (create {like anchor_7}, create {A [G]}))
			check_for_true ("same_type - 14", is_same_type (create {like anchor_8}, create {A [G]}))
			check_for_true ("same_type - 15", is_same_type (create {like anchor_9}, create {A [G]}))

			check_for_true ("same_type - 16", is_same_type (create {A [G]}, create {!A [G]}))
			check_for_true ("same_type - 17", is_same_type (create {A [G]}, create {?A [G]}))
			check_for_true ("same_type - 18", is_same_type (create {!A [G]}, create {?A [G]}))

			if is_attached then
				check_for_true ("same_type - 19", is_same_type (create {A [!G]}, create {A [G]}))
				check_for_true ("same_type - 20", not is_same_type (create {A [?G]}, create {A [G]}))
			else
				check_for_true ("same_type - 21", not is_same_type (create {A [!G]}, create {A [G]}))
				check_for_true ("same_type - 22", is_same_type (create {A [?G]}, create {A [G]}))
			end
		end

	anchor_1: A [?G]
	anchor_2: A [!G]
	anchor_3: !A [?G]
	anchor_4: !A [!G]
	anchor_5: ?A [?G]
	anchor_6: ?A [!G]
	anchor_7: A [G]
	anchor_8: !A [G]
	anchor_9: ?A [G]


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
