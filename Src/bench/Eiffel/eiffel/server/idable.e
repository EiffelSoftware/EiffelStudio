-- Object identification used in server storage

deferred class IDABLE

inherit

	COMPILER_EXPORTER

feature

	id: COMPILER_ID is
			-- Object id
		deferred
		end

	set_id (i: like id) is
			-- Set `id' to `i'
		deferred
		end

end -- class IDABLE
