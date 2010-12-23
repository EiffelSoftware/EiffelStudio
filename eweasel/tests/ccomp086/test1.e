
class TEST1
feature
	try
		do
			create {ARRAYED_LIST [INTEGER]} list.make (0)
		ensure
			good: across list as weasel all (agent weasel.item).item ([]) /= Void end
		end

	list: LIST [INTEGER]
	
end
