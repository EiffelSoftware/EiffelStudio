class ROUT_BODY_MERGER

feature

	merge3 (r1, r2, r3: ROUT_BODY_AS) is
			-- Merge routine bodies `r1', `r2' and `r3'.
		local
			r1_internal, r2_internal, r3_internal: INTERNAL_AS
			internal_merger: INTERNAL_MERGER
		do
			if r1 /= Void then
				r1_internal ?= r1
			end

			if r2 /= Void then
				r2_internal ?= r2
			end
	
			if r3 /= Void then
				r3_internal ?= r3
			end

			if r3_internal /= Void then
				!! internal_merger;
				internal_merger.merge3 (r1_internal, r2_internal, r3_internal)
				merge_result := internal_merger.merge_result
			else
				-- External or deferred routine body.
				merge_result := r3
			end
		end;

	merge_result: ROUT_BODY_AS

end -- class ROUT_BODY_MERGER
