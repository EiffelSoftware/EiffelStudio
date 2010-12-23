
class TEST2
inherit
	TEST1
		redefine
			try
		end
create
	make
feature

	make
		do
			try
		end

	try
		do
			precursor
			create z
			z.try
		ensure then
			good: across list as d all d.item /= Void end
			good: across list as e all across list as y all e.item /= Void end  end
		end

	z: TEST1
end
