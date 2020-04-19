class TEST

create
	make

feature

	make
			-- Run test.
		do
			ca := Current
			test (Current)
		end

feature -- Test

	ca: ANY
			-- A class feature for testing.

	test (fa: ANY)
			-- Go over all test cases.
		local
			fl: ANY
		do
			if attached twin as fo then
				across <<>> as fc loop
					separate (create {separate ANY}) as ft do
						(agent (aa: ANY)
							local
								al: ANY
							do
								if attached twin as ao then
									across <<>> as ac loop
										separate (create {separate ANY}) as at do
											(agent
												do
													(agent
														do
															if attached twin as ca then end -- VUOT(1)
															if attached twin as fa then end -- VUOT(1)
															if attached twin as fl then end -- VUOT(1)
															if attached twin as fo then end -- VUOT(1)
															if attached twin as fc then end -- VUOT(1)
															if attached twin as ft then end -- VUOT(1)
															if attached twin as aa then end -- VUOT(1)
															if attached twin as al then end -- VUOT(1)
															if attached twin as ao then end -- VUOT(1)
															if attached twin as ac then end -- VUOT(1)
															if attached twin as at then end -- VUOT(1)
															across <<>> as ca loop end -- VOIT(2)
															across <<>> as fa loop end -- VOIT(2)
															across <<>> as fl loop end -- VOIT(2)
															across <<>> as fo loop end -- VOIT(2)
															across <<>> as fc loop end -- VOIT(2)
															across <<>> as ft loop end -- VOIT(2)
															across <<>> as aa loop end -- VOIT(2)
															across <<>> as al loop end -- VOIT(2)
															across <<>> as ao loop end -- VOIT(2)
															across <<>> as ac loop end -- VOIT(2)
															across <<>> as at loop end -- VOIT(2)
															separate (create {separate ANY}) as ca do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as fa do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as fl do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as fo do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as fc do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as ft do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as aa do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as al do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as ao do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as ac do end -- FRESH_IDENTIFIER
															separate (create {separate ANY}) as at do end -- FRESH_IDENTIFIER
															;(agent (ca: ANY) do end).call (Current) -- VRFA
															;(agent (fa: ANY) do end).call (Current) -- VPIR(1)
															;(agent (fl: ANY) do end).call (Current) -- VPIR(1)
															;(agent (fo: ANY) do end).call (Current) -- VPIR(1)
															;(agent (fc: ANY) do end).call (Current) -- VPIR(1)
															;(agent (ft: ANY) do end).call (Current) -- VPIR(1)
															;(agent (aa: ANY) do end).call (Current) -- VPIR(1)
															;(agent (al: ANY) do end).call (Current) -- VPIR(1)
															;(agent (ao: ANY) do end).call (Current) -- VPIR(1)
															;(agent (ac: ANY) do end).call (Current) -- VPIR(1)
															;(agent (at: ANY) do end).call (Current) -- VPIR(1)
															;(agent local ca: ANY do end).call -- VRLE(1)
															;(agent local fa: ANY do end).call -- VPIR(1)
															;(agent local fl: ANY do end).call -- VPIR(1)
															;(agent local fo: ANY do end).call -- VPIR(1)
															;(agent local fc: ANY do end).call -- VPIR(1)
															;(agent local ft: ANY do end).call -- VPIR(1)
															;(agent local aa: ANY do end).call -- VPIR(1)
															;(agent local al: ANY do end).call -- VPIR(1)
															;(agent local ao: ANY do end).call -- VPIR(1)
															;(agent local ac: ANY do end).call -- VPIR(1)
															;(agent local at: ANY do end).call -- VPIR(1)
														end).call
												end).call
										end
									end
								end
							end).call (Current)
					end
				end
			end
		end

end
