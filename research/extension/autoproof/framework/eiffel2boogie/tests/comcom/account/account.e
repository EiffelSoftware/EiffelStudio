-- Simple bank account class.
-- Try to fix it and make the verification go through.

class
	ACCOUNT

feature -- Access

	balance: INTEGER
			-- Balance of account.

feature -- Element change

	deposit (amount: INTEGER)
			-- Deposit `amount' on account.
		require
			amount_not_negative: amount >= 0
		do
			balance := balance + amount
		ensure
			balance_increased: balance = old balance + amount
		end

	withdraw (amount: INTEGER)
			-- Withdraw `amount' from account.
		require
			amount_not_too_large: amount <= balance
		do
			balance := balance + amount
		ensure
			balance_decreased: balance = old balance - amount
		end

	transfer (amount: INTEGER; other: ACCOUNT)
			-- Transfer `amount' from `Current' to `other'.
		note
			explicit: wrapping
		require
			other_not_void: other /= Void
			amount_not_negative: amount >= 0
			amount_not_too_large: amount <= balance				
				-- Allowed to modify the state of `Current' and `other'
				-- (by default a procedure can only modify `Current'):
			modify (Current, other)
		do
			withdraw (amount)
			other.deposit (amount)
		ensure
			balance_decreased: balance = old balance - amount
			other_balance_increased: other.balance = old other.balance + amount
		end

end