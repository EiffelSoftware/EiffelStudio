
$(EXPANDED) class TEST1 [G -> ANY create default_create end]
inherit
	TEST2 [TEST1 [G]]
feature
	$(FEATURE)

end

