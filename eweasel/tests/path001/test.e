class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			p: PATH
			d: DIRECTORY
		do
			p := env.current_working_path
			create d.make_with_path (p)
		end

	test_linux
		local
			p: PATH
			l_components: ARRAYED_LIST [PATH]
		do
			create p.make_from_string ("/usr/local/home/manus/")
			check_equal ("is_relative", not p.is_relative)
			check_equal ("is_absolute", p.is_absolute)
			check_equal ("is_empty", not p.is_empty)
			check_equal ("is_simple", not p.is_simple)

			check attached p.entry as l_entry then
				check_equal ("entry1", l_entry.string_representation.same_string_general ("manus"))
			end
			check attached p.parent as l_parent then
				check_equal ("parent1", l_parent.string_representation.same_string_general ("/usr/local/home"))
				check attached l_parent.entry as l_entry then
					check_equal ("entry", l_entry.string_representation.same_string_general ("home"))
				end
				check attached l_parent.parent as l_parent2 then
					check_equal ("parent2", l_parent2.string_representation.same_string_general ("/usr/local"))
					check attached l_parent2.entry as l_entry then
						check_equal ("entry", l_entry.string_representation.same_string_general ("local"))
					end
					check attached l_parent2.parent as l_parent3 then
						check_equal ("parent3", l_parent3.string_representation.same_string_general ("/usr"))
						check attached l_parent3.entry as l_entry then
							check_equal ("entry", l_entry.string_representation.same_string_general ("usr"))
						end
						check attached l_parent3.parent as l_parent4 then
							check_equal ("parent4", l_parent4.string_representation.same_string_general ("/"))
							check_equal ("entry", l_parent4.entry = Void)
							check attached l_parent4.parent as l_parent5 then
								check_equal ("parent5", l_parent5.string_representation.same_string_general ("/"))
								check_equal ("entry", l_parent5.entry = Void)
							end
						end
					end
				end
			end
			check attached p.root as l_root then
				check_equal ("root1", l_root.string_representation.same_string_general ("/"))
			end

			l_components := p.components
			check_equal ("components", l_components.i_th (1).string_representation.same_string_general ("/"))
			check_equal ("components", l_components.i_th (2).string_representation.same_string_general ("usr"))
			check_equal ("components", l_components.i_th (3).string_representation.same_string_general ("local"))
			check_equal ("components", l_components.i_th (4).string_representation.same_string_general ("home"))


			create p.make_from_string ("/usr//////local////////home/manus")
			check_equal ("is_relative", not p.is_relative)
			check_equal ("is_absolute", p.is_absolute)
			check_equal ("is_empty", not p.is_empty)
			check_equal ("is_simple", not p.is_simple)
			check attached p.entry as l_entry then
				check_equal ("entry1", l_entry.string_representation.same_string_general ("manus"))
			end
			check attached p.parent as l_parent then
				check_equal ("parent1", l_parent.string_representation.same_string_general ("/usr//////local////////home"))
				check attached l_parent.entry as l_entry then
					check_equal ("entry", l_entry.string_representation.same_string_general ("home"))
				end
				check attached l_parent.parent as l_parent2 then
					check_equal ("parent2", l_parent2.string_representation.same_string_general ("/usr//////local"))
					check attached l_parent2.entry as l_entry then
						check_equal ("entry", l_entry.string_representation.same_string_general ("local"))
					end
					check attached l_parent2.parent as l_parent3 then
						check_equal ("parent3", l_parent3.string_representation.same_string_general ("/usr"))
						check attached l_parent3.entry as l_entry then
							check_equal ("entry", l_entry.string_representation.same_string_general ("usr"))
						end
						check attached l_parent3.parent as l_parent4 then
							check_equal ("parent4", l_parent4.string_representation.same_string_general ("/"))
							check_equal ("entry", l_parent4.entry = Void)
							check attached l_parent4.parent as l_parent5 then
								check_equal ("parent5", l_parent5.string_representation.same_string_general ("/"))
								check_equal ("entry", l_parent5.entry = Void)
							end
						end
					end
				end
			end
			check attached p.root as l_root then
				check_equal ("root1", l_root.string_representation.same_string_general ("/"))
			end

			create p.make_from_string("abc")
			check_equal ("is_relative", p.is_relative)
			check_equal ("is_absolute", not p.is_absolute)
			check_equal ("is_empty", not p.is_empty)
			check_equal ("is_simple", p.is_simple)
			check_equal ("entry", p.entry ~ p)
			check_equal ("parent", p.parent = Void)
			check_equal ("components", p.components.count = 1 and then p.components.first ~ p)

			create p.make_from_string("abc/def")
			check_equal ("is_relative", p.is_relative)
			check_equal ("is_absolute", not p.is_absolute)
			check_equal ("is_empty", not p.is_empty)
			check_equal ("is_simple", not p.is_simple)
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))
			check_equal ("parent", p.parent ~ create {PATH}.make_from_string ("abc"))
			check_equal ("components", p.components.count = 2 and then
				p.components.i_th (1) ~  create {PATH}.make_from_string ("abc") and then
				p.components.i_th (2) ~ create {PATH}.make_from_string ("def"))


			create p.make_from_string ("/abc/./toto/titi/tutu/../../tata")
			check_equal ("canonical", p.canonical_path.string_representation.same_string_general ("/abc/toto/tata"))
		end

	check_equal (tag: STRING; b: BOOLEAN)
		do
			if not b then
				io.put_string ("Error in " + tag + "%N")
			end
		end

	env: EXECUTION_ENVIRONMENT
			--
		once
			create Result
		end

end
