class TEST

inherit
	A

create
	make

feature

	make
			-- Run test.
		do
			test (Current)
		end

feature -- Test

	$(COMMENT_OUT_CHILD)ca: detachable ANY
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
															if attached twin as pa then end -- VUOT(1): parent
															if attached twin as ca then end -- VUOT(1): child
															across <<>> as pa loop end -- VOIT(2): parent
															across <<>> as ca loop end -- VOIT(2): child
															separate (create {separate ANY}) as pa do end -- FRESH_IDENTIFIER: parent
															separate (create {separate ANY}) as ca do end -- FRESH_IDENTIFIER: child
															;(agent (pa: ANY) do end).call (Current) -- VRFA: parent
															;(agent (ca: ANY) do end).call (Current) -- VRFA: child
															;(agent local pa: ANY do end).call -- VRLE(1): parent
															;(agent local ca: ANY do end).call -- VRLE(1): child
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
