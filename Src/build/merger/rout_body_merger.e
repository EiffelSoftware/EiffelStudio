class ROUT_BODY_MERGER

feature

	merge3 (old_rb, user_rb, new_rb: ROUT_BODY_AS) is
			-- Merge routine bodies `old_rb', `user_rb' and `new_rb'.
		local
			old_rb_internal, user_rb_internal, new_rb_internal: INTERNAL_AS
			internal_merger: INTERNAL_MERGER
		do
			if old_rb /= Void then
				old_rb_internal ?= old_rb
			end

			if user_rb /= Void then
				user_rb_internal ?= user_rb
			end
	
			if new_rb /= Void then
				new_rb_internal ?= new_rb
			end

			if new_rb_internal /= Void then
				!! internal_merger;
				internal_merger.merge3 (old_rb_internal, user_rb_internal, new_rb_internal)
				merge_result := internal_merger.merge_result
			else
				-- External or deferred routine body.
				merge_result := new_rb
			end
		end;

	merge_result: ROUT_BODY_AS

end -- class ROUT_BODY_MERGER
